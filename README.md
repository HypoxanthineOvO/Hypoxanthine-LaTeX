# Hypoxanthine-LaTeX

![License](https://img.shields.io/badge/license-MIT-blue) ![Version](https://img.shields.io/badge/version-v0.7.0-orange) ![Status](https://img.shields.io/badge/status-Alpha-yellow)

**Hypoxanthine-LaTeX** 是一个模块化、工程化维护的个人 LaTeX 生态：
- 入口（Class）负责“场景与对外接口”（Hypo-Note / Hypo-Sheet）
- Core 提供“原子能力”（Fonts/Colors/Base/Math）
- Modules 提供“按需插件”（Box/Refs/Code ...）


## 🏗 Architecture / 架构

本项目采用 **Core-Module-Class** 分层架构，告别臃肿的单一文件：

- **Core (内核层)**: `sty/core/` - 提供数学符号、字体策略、品牌色等原子能力。
- **Modules (组件层)**: `sty/modules/` - 按需加载的代码高亮、伪代码、绘图插件。
- **Classes (场景层)**: `sty/classes/` - 针对不同场景的预设基底（如 `note`, `sheet`）。

接口/能力以 [FEATURES.md](FEATURES.md) 为事实来源；版本更新见 [CHANGELOG.md](CHANGELOG.md)。

## 🚀 Quick Start / 快速上手

### 1) 获取仓库

推荐将本仓库作为子目录（或 git submodule）放在你的项目里，例如：

```bash
git clone git@github.com:HypoxanthineOvO/Hypoxanthine-LaTeX.git

```

### 2) 最小示例（Note 入口）

新建 `main.tex`：

```latex
\documentclass{article}
% 从仓库的 sty/ 下按包名加载（由 Makefile 注入 TEXINPUTS）
\usepackage[outputdir=build]{Hypo-Note}

\begin{document}
\section{Hello}
This is a \TBF{Hypoxanthine} powered note.
Math: $\MB{x} + \MC{F}(\BS{\theta})$ and $\Abs{-3}=3$.

\begin{definition}{Group}{group}
    A group is a set...
\end{definition}
See \cref{def:group}.
\end{document}

```

### 3) 使用 Makefile 构建

复制模板 Makefile 到你的项目根目录（它会设置 `TEXINPUTS`，从而允许 `\usepackage{Hypo-Note}` 直接加载本仓库的 `sty/`）：

```bash
cp Hypoxanthine-LaTeX/templates/Makefile ./
make
```

若你把仓库放在其他路径，请在 Makefile 里调整：

- `HYPO_PATH = ./Hypoxanthine-LaTeX`

也可以参考：
- [manual/Makefile](manual/Makefile)
- [tests/Makefile](tests/Makefile)

## ✅ 当前能力（摘自 FEATURES）

- 入口：Hypo-Note / Hypo-Sheet（对外选项尽量一致）
- Core：Fonts / Colors / Base（`outputdir` + `\FinalOutputDir`）/ Math（含可关闭速写）
- Box：definition / example / note（显式 label：`def:` / `ex:` / `note:` 前缀）
- Refs：默认启用 hyperref + cleveref（可 `refs=false` 关闭），`\cref{...}` 输出形如 "Definition: 0.1"
- Img：`\img` 插图快捷命令（支持引用、figure/figure*、宽度/placement 参数）
- Algorithm：基于 `algorithm2e` 的算法环境配置（与 `\cref` 协作）
- Code：`hypocode` 环境（优先 minted；不可用时 fallback listings，并给一次性 Warning）

详细接口请直接看 [FEATURES.md](FEATURES.md)。

## 🧩 Code Highlight / 代码高亮（Hypo-Code）

推荐使用统一环境：

```latex
\begin{hypocode}{python}
def add(a, b):
    return a + b
\end{hypocode}
```

常用可选参数（两种后端都不会报错）：

```latex
% 是否显示行号（默认 true）
\begin{hypocode}[linenos=false]{python}
print("no line numbers")
\end{hypocode}

% 主题（仅对 minted 生效；fallback 下会忽略）
\begin{hypocode}[theme=monokai]{python}
print("monokai")
\end{hypocode}
```

启用 minted（推荐，需 `-shell-escape` + Pygments）：

- 使用本仓库 Makefile 体系：`make SHELL_ESCAPE=1`
- Pygments 依赖：需要可执行的 `pygmentize`（通常来自 `python3-pygments` 或 `pip install Pygments`）

安全提示：`-shell-escape` 会允许 TeX 执行外部命令；如果编译不可信的文档，请保持关闭。

## 🗺 路线图

路线图以 [DEVELOPMENT_PLAN.md](DEVELOPMENT_PLAN.md) 为准（包含 v0.5+ 到 v1.0.0 的里程碑拆分）。

## 🤝 Contribution

这是一个个人维护项目，但也欢迎提交 Issue 或 PR 来改进公共模块。