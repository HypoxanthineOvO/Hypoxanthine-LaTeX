# Hypoxanthine-LaTeX Quick Start Guide

This guide helps you get started with the Hypoxanthine-LaTeX framework quickly.

---

## Installation

### 1. Use as a Standalone Project

```bash
# Clone the repository
git clone https://github.com/HypoxanthineOvO/Hypoxanthine-LaTeX.git
cd Hypoxanthine-LaTeX

# Check environment
./scripts/hypo doctor

# Create a new project
./scripts/hypo template note --dest ./my-note

# Build
cd my-note
make
```

### 2. Use as a Submodule

```bash
# Add as a submodule in your project
git submodule add git@github.com:HypoxanthineOvO/Hypoxanthine-LaTeX.git Hypoxanthine-LaTeX
git submodule update --init --recursive

# Create Makefile
cat > Makefile << 'EOF'
HYPO_PATH := $(PWD)/Hypoxanthine-LaTeX
export TEXINPUTS := .:$(HYPO_PATH)/sty//:
include $(HYPO_PATH)/make/Hypoxanthine.mk
EOF

# Build
make
```

---

## Requirements

### Required Tools

- **TeX Live**: With `xelatex` and `latexmk`
- **Python 3**: For scripts and code highlighting
- **Pygments**: `pip install Pygments` (for minted code highlighting)

### Optional Tools

- **VS Code**: LaTeX Workshop extension recommended
- **Fonts**:
  - Noto Sans/Serif CJK SC
  - LXGW WenKai

### Environment Check

```bash
./Hypoxanthine-LaTeX/scripts/hypo doctor
```

**What it checks**:
- xelatex availability
- latexmk availability
- pygmentize installation
- Font availability

---

## Choose Document Type

### Technical Notes → Hypo-Note

Best for:
- Course notes
- Technical documentation
- Tutorials

```bash
./scripts/hypo template note --dest ./my-note
```

### Literature Notes → Hypo-LitNote

Best for:
- Reading notes
- Literature analysis
- Poetry writing

```bash
./scripts/hypo template litnote --dest ./my-litnote
```

### Cheatsheets → Hypo-CHSH

Best for:
- Syntax quick reference
- Command reference
- High-density information

```bash
./scripts/hypo template chsh --dest ./my-chsh
```

### Slides → Hypo-Slide

Best for:
- Presentations
- Academic reports
- Technical talks

```bash
./scripts/hypo template slide --dest ./my-slide
```

---

## Building Documents

### Using Makefile

```bash
# Default build (with minted)
make

# Without minted
make SHELL_ESCAPE=0

# Clean intermediate files
make clean

# Specify Python interpreter
make PYTHON_BIN=/usr/bin/python3
```

### Using latexmk

```bash
latexmk -xelatex -shell-escape main.tex
```

---

## Color Schemes

| Scheme | Style | Use Case |
|--------|-------|----------|
| `Base` | General | General documents |
| `CN` | Chinese style (Morandi) | Humanities, arts |
| `Tech` | Technology (deep blue) | Technical, engineering |
| `Simple` | Minimalist (grayscale) | Clean style documents |

### Usage Example

```latex
\HypoNoteSetup{
  title={Document Title},
  author={Author},
  colorscheme=Tech  % Choose color scheme
}
```

---

## Slide Themes

| Theme | Style | Use Case |
|-------|-------|----------|
| `school` | Academic style | Courses, academic reports |
| `lab` | Geek style | Tech talks, lab reports |
| `lit` | Humanities style | Literature, history, arts |
| `business` | Business style | Business reports, demos |

### Usage Example

```latex
\documentclass[theme=school]{Hypo-Slide}
```

---

## Font Modes

| Mode | Main Font | Emphasis Font | Use Case |
|------|-----------|----------------|----------|
| `lit` | Noto Serif CJK SC | LXGW WenKai | Literature, notes |
| `tech` | Noto Sans CJK SC | - | Technical, slides |

### Usage Example

```latex
\documentclass[fontset=lit]{Hypo-Note}
\documentclass[fontset=tech]{Hypo-Slide}
```

---

## Quick Reference

### Common Commands

| Command | Purpose |
|---------|---------|
| `\img[...]{path}{caption}` | Insert image |
| `\HypoIcon{key}` | Insert icon |
| `\cref{label}` | Smart reference |

### Common Environments

| Environment | Purpose |
|-------------|---------|
| `definition` | Definitions |
| `example` | Examples |
| `note` | Notes |
| `hypocode` | Code blocks |

### Math Shorthand

| Command | Output |
|---------|--------|
| `\R` | ℝ |
| `\N` | ℕ |
| `\Z` | ℤ |
| `\Set{x}` | {x} |
| `\Paren{x}` | (x) |
| `\Abs{x}` | |x| |

---

## Project Structure

```
my-project/
├── main.tex              # Main file
├── Makefile             # Build file
├── assets/              # Asset files
│   ├── logo.png
│   └── images/
├── build/               # Build output (auto-created)
└── Hypoxanthine-LaTeX/  # As submodule
    ├── sty/
    ├── make/
    └── scripts/
```

---

## VS Code Configuration

### Recommended Extensions

- **LaTeX Workshop**: LaTeX editing support
- **LaTeX Utilities**: Auxiliary tools

### Configuration Example

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "xelatex",
      "command": "xelatex",
      "args": [
        "-shell-escape",
        "-output-directory=build",
        "%DOC%"
      ]
    }
  ]
}
```

### Using Snippets

The repository provides VS Code snippets:

```bash
# Copy snippets to VS Code directory
cp Hypoxanthine-LaTeX/snippets/hypoxanthine-latex.code-snippets \
   ~/.config/Code/User/snippets/
```

---

## Common Questions

### Q: Cannot find .sty files during compilation

**A**: Ensure `TEXINPUTS` is set correctly:

```bash
export TEXINPUTS:=.:$(PWD)/Hypoxanthine-LaTeX/sty//:
```

Or set it in Makefile.

### Q: minted errors

**A**: Install Pygments and ensure `-shell-escape` is used:

```bash
pip install Pygments
make  # Makefile enables -shell-escape by default
```

### Q: Chinese characters not displaying correctly

**A**: Compile with `xelatex` and ensure fonts are installed:

```bash
./Hypoxanthine-LaTeX/scripts/hypo doctor
```

### Q: Code errors in slides

**A**: Use `[fragile]` option:

```latex
\begin{frame}[fragile]{Title}
  \begin{hypocode}{python}
    ...
  \end{hypocode}
\end{frame}
```

---

## Next Steps

- Read complete syntax: `references/syntax-en.md`
- Check architecture: `references/architecture.md`
- Explore workflow examples: `references/workflows/`
