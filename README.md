# Hypoxanthine-LaTeX

![License](https://img.shields.io/badge/license-MIT-blue) ![Version](https://img.shields.io/badge/version-v1.2.2-brightgreen) ![Tests](https://img.shields.io/badge/tests-passing-brightgreen)

**Hypoxanthine-LaTeX** is a modular, engineering-oriented LaTeX framework for efficient document creation.
**Hypoxanthine-LaTeX** 是一个模块化、工程化维护的个人 LaTeX 生态。

> **For AI Agents:** Please read [FEATURES.md](FEATURES.md) for context and syntax rules.

## 🏗 Architecture / 架构

本项目采用 **Core-Module-Class** 分层架构：

- **Core (内核层)**: `sty/core/` - 提供数学符号、字体策略、品牌色等原子能力。
- **Modules (组件层)**: `sty/modules/` - 按需加载的代码高亮、伪代码、绘图插件（Beamer Compatible）。
- **Classes (场景层)**: `sty/classes/` - 针对不同场景的预设基底。
  - **Hypo-Note**: 笔记 (based on `ctexbook`)
  - **Hypo-CHSH**: 速查表 (based on `ctexart`)
  - **Hypo-LitNote**: 文学内容 (based on `ctexbook`)
  - **Hypo-Slide**: 幻灯片 (based on `ctexbeamer`)

## 🚀 Quick Start / 快速上手

### 1. Requirements
- TeX Live (XeLaTeX recommended)
- Python 3 (for scripts and plotting)

### 2. Installation
Add as a submodule:
```bash
git submodule add git@github.com:HypoxanthineOvO/Hypoxanthine-LaTeX.git Hypoxanthine-LaTeX
git submodule update --init --recursive
```

### 3. Create a Project
Use the included script (Windows/Linux/macOS):

```bash
# Linux / macOS
./Hypoxanthine-LaTeX/scripts/hypo template slide --dest ./my-deck

# Windows
.\Hypoxanthine-LaTeX\scripts\hypo.bat template slide --dest .\my-deck
```

### 4. Build
```bash
cd my-deck
make
# Note: SHELL_ESCAPE is enabled by default to support minted & plots.
```

## 📚 Documentation / 文档
- **User Manual**: [manual/Manual.pdf](manual/Manual.pdf) (Self-compiled demonstration)
- **AI Context**: [FEATURES.md](FEATURES.md) (Syntax guide for AI)
- **Development Plan**: [DEVELOPMENT_PLAN.md](DEVELOPMENT_PLAN.md)

## 🧩 Key Features (Highlights)

- **Semantic Colors**: Built-in schemes (`Base`, `CN`, `Tech`) with easy switching.
- **5 Slide Themes**: Professional Beamer themes (School, Lab, Lit, Business, + Instructor Module).
- **Robust Code**: `Hypo-Code` environment works in `beamer` frames.
- **Auto-Layout Cheatsheets**: `Hypo-CHSH` handles multi-column layouts automatically.
- **Integrated Plotting**: Write Python code in LaTeX to generate plots (`Hypo-Plot`).

## 🤝 Contribution

This is a personal project, but PRs are welcome.
Please follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.