# Scripts

本目录提供面向“子模块(submodule)/子目录引入”的辅助脚本。

## hypo

路径：`scripts/hypo.py`

### 1) 依赖自检

```bash
./scripts/hypo.py doctor
```

会检查：`latexmk`、`xelatex`、`kpsewhich`；并在检测到 `minted.sty` 时检查 `pygmentize`。

### 2) 生成模板项目

```bash
# 生成 Hypo-Note 模板到 ./demo-note
./scripts/hypo.py template note --dest ./demo-note --hypo-path ./Hypoxanthine-LaTeX

# 生成 Hypo-LitNote 模板到 ./demo-note
./scripts/hypo.py template litnote --dest ./demo-litnote --hypo-path ./Hypoxanthine-LaTeX

# 生成 Hypo-CHSH 模板到 ./demo-note
./scripts/hypo.py template chsh --dest ./demo-chsh --hypo-path ./Hypoxanthine-LaTeX
```

进入目录后直接 `make` 构建；如需启用 minted：`make SHELL_ESCAPE=1`。

说明：该命令会直接复制仓库里的 `templates/*.tex` 与 `templates/Makefile`（并按参数替换 Makefile 中的变量），避免在脚本里 hardcode 模板内容。

### 3) 安装 VS Code snippets（推荐）

把仓库自带的 snippets 安装到当前项目的工作区级别：

```bash
# 安装到 ./.vscode/hypoxanthine-latex.code-snippets
./scripts/hypo.py snippets install

# 或指定目标目录/文件
./scripts/hypo.py snippets install --dest ./somewhere
./scripts/hypo.py snippets install --dest ./.vscode/my-snippets.code-snippets
```

你也可以在生成模板时一并安装：

```bash
./scripts/hypo.py template note --dest ./demo-note --hypo-path ./Hypoxanthine-LaTeX --with-snippets
```
