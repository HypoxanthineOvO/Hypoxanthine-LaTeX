#!/usr/bin/env python3

from __future__ import annotations

import argparse
import os
import platform
import shutil
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
TEMPLATES_DIR = REPO_ROOT / "templates"
SNIPPETS_FILE = REPO_ROOT / "snippets" / "hypoxanthine-latex.code-snippets"


@dataclass(frozen=True)
class CheckResult:
    ok: bool
    message: str


def _run(cmd: list[str]) -> subprocess.CompletedProcess[str]:
    return subprocess.run(cmd, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)


def _which(cmd: str) -> str | None:
    return shutil.which(cmd)


def _check_command(cmd: str, version_args: list[str] | None = None) -> CheckResult:
    path = _which(cmd)
    if not path:
        return CheckResult(False, f"missing: {cmd}")

    if version_args is None:
        return CheckResult(True, f"ok: {cmd} ({path})")

    cp = _run([cmd, *version_args])
    if cp.returncode != 0:
        return CheckResult(False, f"bad: {cmd} exists but failed to run version: {cp.stdout.strip()}")
    first_line = (cp.stdout or "").strip().splitlines()[:1]
    suffix = first_line[0] if first_line else ""
    return CheckResult(True, f"ok: {cmd} ({path}) {suffix}")



def cmd_doctor(_args: argparse.Namespace) -> int:
    print("Hypoxanthine doctor")
    print(f"- repo: {REPO_ROOT}")
    print(f"- os: {platform.platform()}")
    print("")

    checks: list[CheckResult] = []
    checks.append(_check_command("latexmk", ["-v"]))
    checks.append(_check_command("xelatex", ["--version"]))
    checks.append(_check_command("kpsewhich", ["--version"]))

    # Optional: minted + Pygments
    minted = _which("kpsewhich") and _run(["kpsewhich", "minted.sty"]).returncode == 0
    if minted:
        checks.append(_check_command("pygmentize", ["-V"]))
    else:
        checks.append(CheckResult(True, "info: minted.sty not found (minted will not be used; Hypo-Code falls back to listings)"))

    # Font Checks using fc-list (Linux/macOS) or just skipping on Windows for now (complex)
    if shutil.which("fc-list"):
        fonts_to_check = ["LXGW WenKai", "FandolSong", "DejaVu Sans"]
        for font in fonts_to_check:
            res = _run(["fc-list", f":family={font}"])
            if res.returncode == 0 and res.stdout.strip():
                checks.append(CheckResult(True, f"ok: Font '{font}' found"))
            else:
                checks.append(CheckResult(True, f"warn: Font '{font}' not found (latex might substitute/fail)"))

    ok = True
    for c in checks:
        if c.ok and c.message.startswith("warn:"):
            print(f"[WARN] {c.message}")
        elif c.ok:
            print(f"[OK]   {c.message}")
        else:
            print(f"[FAIL] {c.message}")
            ok = False

    if ok:
        print("\nAll required tools look OK.")
        print("Tip: to enable minted, build with `make SHELL_ESCAPE=1` and ensure `pygmentize` is available.")
        return 0

    print("\nSome required tools are missing.")
    print("Install hints (pick the one matching your distro):")
    print("- Debian/Ubuntu: sudo apt-get install texlive-xetex texlive-latex-extra latexmk python3-pygments fonts-noto-cjk")
    print("- Fedora: sudo dnf install texlive-scheme-full latexmk")
    print("- Arch: sudo pacman -S texlive-most texlive-langchinese latexmk")
    print("- Fonts: Install LXGW WenKai for best experience.")
    return 1


def _read_template(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def _write_file(path: Path, content: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def _copy_file(src: Path, dest: Path, *, force: bool = False) -> None:
    if not src.exists():
        raise FileNotFoundError(src)

    if dest.exists() and not force:
        raise FileExistsError(dest)

    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(src, dest)


def _render_makefile(*, name: str, main_file: str, hypo_path: str) -> str:
    tpl = _read_template(TEMPLATES_DIR / "Makefile")

    def _replace_line(src: str, key: str, value: str) -> str:
        out_lines: list[str] = []
        replaced = False
        for line in src.splitlines():
            if line.strip().startswith(key):
                out_lines.append(f"{key} {value}")
                replaced = True
            else:
                out_lines.append(line)
        if not replaced:
            out_lines.insert(0, f"{key} {value}")
        return "\n".join(out_lines) + "\n"

    tpl = _replace_line(tpl, "NAME", f"= {name}")
    tpl = _replace_line(tpl, "MAIN_FILE", f"= {main_file}")
    tpl = _replace_line(tpl, "HYPO_PATH", f"= {hypo_path}")
    return tpl


def _template_tex_path(kind: str) -> Path:
    mapping = {
        "note": TEMPLATES_DIR / "Note.tex",
        "litnote": TEMPLATES_DIR / "LitNote.tex",
        "chsh": TEMPLATES_DIR / "CHSH.tex",
    }
    try:
        return mapping[kind]
    except KeyError as e:
        raise ValueError(f"unknown template kind: {kind}") from e


def _snippets_dest_file(dest: Path) -> Path:
    if dest.suffix == ".code-snippets":
        return dest
    return dest / "hypoxanthine-latex.code-snippets"


def cmd_snippets_install(args: argparse.Namespace) -> int:
    dest = Path(args.dest).expanduser().resolve()
    dest_file = _snippets_dest_file(dest)

    try:
        _copy_file(SNIPPETS_FILE, dest_file, force=bool(args.force))
    except FileExistsError:
        print(f"Refusing to overwrite existing file: {dest_file}")
        print("Use --force to overwrite.")
        return 2

    print(f"Installed snippets: {dest_file}")
    print("Tip: VS Code will pick up workspace snippets from .vscode/*.code-snippets")
    return 0


def cmd_template(args: argparse.Namespace) -> int:
    dest = Path(args.dest).expanduser().resolve()
    if dest.exists() and any(dest.iterdir()) and not args.force:
        print(f"Refusing to write into non-empty directory: {dest}")
        print("Use --force to overwrite existing files.")
        return 2

    dest.mkdir(parents=True, exist_ok=True)

    # Files
    main_file = args.main
    name = args.name
    hypo_path = args.hypo_path

    makefile_content = _render_makefile(name=name, main_file=main_file, hypo_path=hypo_path)
    tex_content = _read_template(_template_tex_path(args.kind))

    _write_file(dest / "Makefile", makefile_content)
    _write_file(dest / main_file, tex_content)

    print(f"Wrote: {(dest / 'Makefile')}")
    print(f"Wrote: {(dest / main_file)}")
    print("\nNext:")
    print(f"- cd {dest}")
    print("- make")
    print("- make SHELL_ESCAPE=1   # enable minted (optional)")

    if getattr(args, "with_snippets", False):
        vscode_dir = dest / ".vscode"
        _copy_file(SNIPPETS_FILE, _snippets_dest_file(vscode_dir), force=True)
        print("- snippets installed to .vscode/")
    return 0


def cmd_clean(args: argparse.Namespace) -> int:
    # Basic clean: remove 'build' directory in current path
    # or specified targets.
    target_dir = Path("build").resolve()
    if not target_dir.exists():
        print("Nothing to clean (build directory not found).")
        return 0
    
    print(f"Removing {target_dir}...")
    try:
        shutil.rmtree(target_dir)
        print("Done.")
    except Exception as e:
        print(f"Error cleaning: {e}")
        return 1
    return 0


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(prog="hypo", description="Hypoxanthine helper commands")
    sub = p.add_subparsers(dest="cmd", required=True)

    p_doctor = sub.add_parser("doctor", help="Check toolchain availability")
    p_doctor.set_defaults(func=cmd_doctor)
    
    p_clean = sub.add_parser("clean", help="Clean build directory")
    p_clean.set_defaults(func=cmd_clean)

    p_tpl = sub.add_parser("template", help="Generate a starter project")
    p_tpl.add_argument("kind", choices=["note", "litnote", "chsh"], help="Template kind")
    p_tpl.add_argument("--dest", default=".", help="Output directory (default: .)")
    p_tpl.add_argument("--name", default="Main", help="PDF name (Makefile NAME)")
    p_tpl.add_argument("--main", default="main.tex", help="Main TeX file name")
    p_tpl.add_argument("--hypo-path", default="./Hypoxanthine-LaTeX", help="Path to Hypoxanthine-LaTeX (for Makefile HYPO_PATH)")
    p_tpl.add_argument("--force", action="store_true", help="Allow writing into a non-empty directory")
    p_tpl.add_argument("--with-snippets", action="store_true", help="Also install VS Code snippets into .vscode/")
    p_tpl.set_defaults(func=cmd_template)

    p_snip = sub.add_parser("snippets", help="Manage VS Code snippets")
    snip_sub = p_snip.add_subparsers(dest="snippets_cmd", required=True)

    p_snip_install = snip_sub.add_parser("install", help="Install workspace snippets")
    p_snip_install.add_argument(
        "--dest",
        default=".vscode",
        help="Destination directory (default: .vscode) or a .code-snippets file path",
    )
    p_snip_install.add_argument("--force", action="store_true", help="Overwrite existing file")
    p_snip_install.set_defaults(func=cmd_snippets_install)

    return p


def main(argv: list[str]) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    return int(args.func(args))


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))

