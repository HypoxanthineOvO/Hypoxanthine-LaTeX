# Hypoxanthine-LaTeX

![License](https://img.shields.io/badge/license-MIT-blue) ![Version](https://img.shields.io/badge/version-v0.1.0-orange) ![Status](https://img.shields.io/badge/status-Alpha-yellow)

**Hypoxanthine-LaTeX** 是一个高度模块化、工程化的个人 LaTeX 排版生态系统。
它不仅仅是一组样式包，更包含了一整套构建系统与效率工具，旨在统一 **笔记 (Notes)**、**速查表 (Cheatsheets)** 与 **技术文档 (Docs)** 的排版体验。


## 🏗 Architecture / 架构

本项目采用 **Core-Module-Class** 分层架构，告别臃肿的单一文件：

- **Core (内核层)**: `sty/core/` - 提供数学符号、字体策略、品牌色等原子能力。
- **Modules (组件层)**: `sty/modules/` - 按需加载的代码高亮、伪代码、绘图插件。
- **Classes (场景层)**: `sty/classes/` - 针对不同场景的预设基底（如 `note`, `sheet`）。

## 🚀 Quick Start / 快速上手

### 1. Installation
推荐将本仓库作为 `submodule`，或直接克隆到你的笔记项目根目录：

```bash
# 在你的笔记项目里
git clone git@gitlab.vsplab.cn:heyx/hypoxanthine-latex.git

```

### 2. Setup Tools (Recommended)

为了获得极致的输入效率，请运行以下脚本将预设的 **VS Code Snippets** 注入到当前项目：

```bash
chmod +x Hypoxanthine-LaTeX/scripts/install_snippets.sh
./Hypoxanthine-LaTeX/scripts/install_snippets.sh

```

### 3. Create a Note

新建 `main.tex`，并使用相对路径引用：

```latex
\documentclass{article}
% 引用 Hypoxanthine 
\usepackage{Hypoxanthine-LaTeX/sty/classes/note/hypo-note}

\begin{document}
    \section{Introduction}
    This is a \tbf{Hypoxanthine} powered note.
    Let $x \in \R$ be a variable...
\end{document}

```

### 4. Build with Makefile

复制标准 Makefile 到你的项目根目录：

```bash
cp Hypoxanthine-LaTeX/templates/Makefile ./
make
```

## 🗺 Roadmap / 开发计划

| Version | Status | Focus | Features |
| --- | --- | --- | --- |
| **v0.1** | 🟢 Done | **Core Split** | 拆分 Math, Colors, Fonts 内核 |
| **v0.2** | 🟡 In Progress | **Note Class** | 复刻并增强标准笔记样式 |
| **v0.5** | ⚪ Planned | **Tools** | Makefile 构建流 & Snippets 注入 |
| **v1.0** | ⚪ Planned | **Release** | 完整支持 Note + Cheatsheet，发布说明书 |
| **v2.0** | ⚪ Planned | **Expansion** | 支持 Technical Docs 与 Slides (Beamer) |

## 🤝 Contribution

这是一个个人维护项目，但也欢迎提交 Issue 或 PR 来改进公共模块。

---

© 2026 Hypoxanthine-LaTeX Project.