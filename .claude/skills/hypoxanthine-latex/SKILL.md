---
name: hypoxanthine-latex
description: |
  Hypoxanthine-LaTeX framework for creating modular LaTeX documents.
  支持笔记(Hypo-Note)、文学(Hypo-LitNote)、速查表(Hypo-CHSH)、幻灯片(Hypo-Slide)。

  Supports: 中文文档, English documents, 双语混合
  文档类型: Notes, Literature, Cheatsheets, Slides/Beamer
  Triggers: latex, hypo, beamer, 幻灯片, 速查表, 笔记, ctex, xelatex
license: MIT
---

# Hypoxanthine-LaTeX / 蕤嘌呤-LaTeX

A modular, engineering-oriented LaTeX framework for efficient document creation.
模块化、工程化的 LaTeX 文档框架。

---

## 🚀 快速开始 / Quick Start

### 中文快速指南

根据你的需求选择文档类型：

| 需求 | 推荐类 | 说明 |
|------|--------|------|
| 技术笔记、教程、课程笔记 | `Hypo-Note` | 基于 ctexbook，支持章节结构 |
| 文学笔记、读书笔记、诗歌 | `Hypo-LitNote` | 中文编号样式，文学盒子 |
| 高密度参考表、速查 | `Hypo-CHSH` | 多栏布局，紧凑排版 |
| 演示文稿、学术报告 | `Hypo-Slide` | 4种主题风格 |

### English Quick Guide

Choose the right class based on your needs:

| Need | Recommended Class | Description |
|------|-------------------|-------------|
| Technical notes, tutorials, course notes | `Hypo-Note` | Based on ctexbook, chapter support |
| Literature notes, reading notes, poetry | `Hypo-LitNote` | Chinese numbering, literary boxes |
| High-density reference, cheatsheets | `Hypo-CHSH` | Multi-column, compact layout |
| Presentations, academic reports | `Hypo-Slide` | 4 theme styles |

---

## 📤 输出模式 / Output Modes

根据用户请求的上下文，自动选择合适的输出模式：

### 模式判断 / Mode Detection

| 用户请求类型 User Request Pattern | 输出模式 Output Mode | 生成内容 Output |
|--------------------------------|---------------------|-----------------|
| "创建/制作/新建 Slides/文档/笔记"<br>"Create a new document/slides" | **FULL** | 完整的 .tex 文件（含导言区 preamble） |
| "添加/写一页/这段内容"<br>"Add a slide about..."<br>"Write content for..." | **CONTENT** | 仅内容片段（不含导言区） |
| "从...生成/转换..."<br>"Convert these notes to..."<br>"Make slides from this paper..." | **WORKFLOW** | 结构化输出，便于集成到其他任务 |

### FULL_MODE 示例

```latex
\documentclass[outputdir=build, code=true]{Hypo-Note}
\HypoNoteSetup{
    title={机器学习基础},
    author={作者名},
    colorscheme=Tech
}
\begin{document}
\makecover
\tableofcontents
\chapter{简介}
内容...
\end{document}
```

### CONTENT_MODE 示例

```latex
\section{线性回归}
\begin{definition}{线性回归}{lin_reg}
线性回归是一种...
\end{definition}

\begin{hypocode}{python}
from sklearn.linear_model import LinearRegression
model = LinearRegression()
\end{hypocode}
```

### WORKFLOW_MODE 示例

当集成到其他工作流时，输出结构化的内容规划：
- 标题页信息
- 大纲结构
- 每页的核心要点
- 便于后续转换为完整 LaTeX 代码

---

## 🎨 核心语法 / Core Syntax

### 1. 入口类 / Entry Classes

#### Hypo-Note (技术笔记)

```latex
\documentclass[outputdir=build, code=true, boxes=true]{Hypo-Note}

\HypoNoteSetup{
    title={文档标题},
    author={作者名},
    email={email@example.com},
    date={\today},
    colorscheme=Tech  % 选项: Base, CN, Tech, Simple
}

\begin{document}
\makecover
\tableofcontents

\chapter{第一章}
\section{第一节}
...
\end{document}
```

#### Hypo-LitNote (文学笔记)

```latex
\documentclass[outputdir=build]{Hypo-LitNote}

\HypoNoteSetup{
    title={读书笔记},
    author={作者},
    colorscheme=CN  % 国风配色
}

\begin{document}
\chapter{第一章 读后感}

\begin{poem}{春江花月夜}{春江}
春江潮水连海平...
\end{poem}

\begin{quotepara}
引用段落...
\end{quotepara}
\end{document}
```

#### Hypo-CHSH (速查表)

```latex
\documentclass[columns=3]{Hypo-CHSH}
% CHSH 通常不需要 \makecover 或 \tableofcontents
% 直接开始多栏内容

\begin{document}
\section{Python 基础}
\subsection{数据类型}
...
\end{document}
```

#### Hypo-Slide (幻灯片)

```latex
\documentclass[theme=school, aspectratio=169]{Hypo-Slide}
\HypoSlideSetup{
    title={演示标题},
    author={演讲者},
    logo={assets/logo.png}
}
\begin{document}
\frame{\titlepage}

\begin{frame}{页面标题}
内容...
\end{frame}
\end{document}
```

**可用主题 / Available Themes:**
- `school`: 学术/教学风格，清爽专业
- `lab`: 极客/实验室风格，深色系
- `lit`: 人文/文学风格，柔和配色
- `business`: 商业风格，正式简洁

**字体选项 / Font Options:**
- `fontset=tech`: 思源黑体 (默认，适合技术文档)
- `fontset=lit`: 思源宋体 + 霞鹜文楷 (适合文学内容)

### 2. 盒子环境 / Box Environments

使用基于 `tcolorbox` 的环境，签名：`\begin{env}{标题}{标签}`

```latex
\begin{definition}{质能方程}{mass_energy}
    $E = mc^2$
\end{definition}

参见 \cref{def:mass_energy}。  % 智能引用
```

**可用环境 / Available Environments:**
- `definition`: 定义环境（主色）
- `example`: 示例环境（绿色）
- `note`: 注意环境（橙色）

### 3. 代码块 / Code Blocks

使用 `hypocode` 环境（推荐，比 minted/listings 更可靠）

```latex
\begin{hypocode}[linenos=false]{python}
def hello():
    print("Hello AI")
\end{hypocode}
```

**可选参数 / Options:**
- `linenos=true/false`: 显示行号
- 支持语言: python, java, cpp, javascript, latex, bash 等

### 4. 图像插入 / Images

```latex
% 基本用法
\img[width=0.8\linewidth, label=my_plot]{assets/plot.png}{演示图}

% 引用
参见 \cref{fig:my_plot}。
```

### 5. 图标 / Icons

```latex
\HypoIcon{github}  % GitHub icon
\HypoIcon{email}   % Email icon
\HypoIcon{python}  # Python icon
```

**常用图标 / Common Icons:**
- **界面/操作**: user, search, home, settings, check, warn, link, download, upload
- **文件类型**: file, pdf, word, image, video, zip, code
- **社交**: twitter, github, weixin, telegram, discord, zhihu
- **技术栈**: python, java, linux, docker, git, react, vue, node, cpp

### 6. 数学速写 / Math Shorthand

当 `shorthand=true` (默认) 时可用：

```latex
\R, \N, \Z, \Q, \C                    % 集合符号
\Set{x}, \Paren{x}, \Abs{x}, \Brack{x}  % 定界符
\MB{...}, \MC{...}, \BS{...}          % 样式封装
```

### 7. 封面系统 / Cover System

```latex
\HypoCoverSetup{
    style=modern,          % 布局: modern, classic, academic
    background=wave,       % 背景: wave, sidebar, particle, grid, frame, corner
    title={文档标题},
    subtitle={副标题},
    subject={学科},
    author={作者},
    date={\today},
    logo={assets/logo.png},
    image={assets/cover.jpg}  % 中央大图 (v1.3.1+)
}
\makecover
```

### 8. 表格系统 / Table System

**推荐使用 `tabularray` 宏包**，而不是传统的 `tabular`。

```latex
\usepackage{tabularray}

% 基本用法
\begin{tblr}{
  colspec = {l c r},
  row{1} = {font=\bfseries, bg=HypoPrimary!10},
  hline{1} = {solid},
}
  Name & Age & Score \\
  Alice & 25 & 95 \\
  Bob & 30 & 87 \\
\end{tblr}
```

**更多参考**：`references/tabularray.md`

---

## 🔍 环境检查 / Environment Check

在创建文档前，先检查构建环境：

```bash
# 运行环境检查脚本
./Hypoxanthine-LaTeX/scripts/hypo doctor

# 检查内容：
# - xelatex 是否安装
# - latexmk 是否可用
# - pygmentize 是否安装（用于代码高亮）
# - 字体是否可用
```

**如果检查失败，指导用户：**

1. 安装 TeX Live (包含 xelatex)
2. 安装 Python 和 Pygments (`pip install Pygments`)
3. 配置 Python 路径：`make PYTHON_BIN=/path/to/python`
4. 验证字体安装：Noto Sans/Serif CJK SC, LXGW WenKai

---

## 📚 详细参考 / Detailed References

当需要更多细节时，按需读取以下参考文件：

### 语法参考 / Syntax References
- `references/syntax-cn.md` - 完整的中文语法说明
- `references/syntax-en.md` - Complete English syntax guide
- `references/tabularray.md` - **Tabularray 表格库参考** (推荐使用)

### 快速开始 / Quick Start
- `references/quickstart-cn.md` - 中文快速开始指南
- `references/quickstart-en.md` - English quick start guide

### 架构文档 / Architecture
- `references/architecture.md` - Core-Module-Class 架构说明

### 工作流示例 / Workflow Examples
- `references/workflows/paper-to-slides.md` - 从论文生成幻灯片
- `references/workflows/notes-to-chsh.md` - 从笔记生成速查表
- `references/workflows/content-insertion.md` - 在已有文档中插入内容

### 代码示例 / Code Examples
- `references/examples/` - 完整的文档模板和示例
  - Note 示例 (note-cn.tex, note-en.tex)
  - CHSH 示例 (chsh.tex)
  - Slide 示例 (slide-*.tex)

---

## ✅ 最佳实践 / Best Practices

1. **智能引用 / Smart References**: 始终使用 `\cref{...}` 而非 `\ref{...}`
2. **语义化颜色 / Semantic Colors**: 使用 `HypoPrimary`, `HypoAccent` 等语义化颜色
3. **相对路径 / Relative Paths**: 图片使用相对路径（如 `assets/`）
4. **环境检查 / Environment Check**: 使用前运行 `hypo doctor`
5. **构建脚本 / Build Scripts**: 指导用户使用 `scripts/hypo` 和 Makefile

---

## 🎯 触发条件 / Trigger Conditions

当用户请求包含以下关键词或场景时，激活此 Skill：

**中文触发词:**
- latex, hypo, beamer, 幻灯片, 演示文稿, 速查表, 笔记, ctex, xelatex

**英文触发词:**
- latex, hypo, beamer, slides, presentation, cheatsheet, notes, ctex

**典型场景:**
- "帮我创建一个 LaTeX 文档"
- "制作一个机器学习的幻灯片"
- "写一份速查表"
- "使用 Hypo-Note 创建笔记"
- "Convert this to LaTeX slides"
