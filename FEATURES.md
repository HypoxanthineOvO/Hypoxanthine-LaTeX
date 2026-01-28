# Hypoxanthine-LaTeX 上下文 (AI Context)

> **致 AI Agent**: 本文档描述了 **Hypoxanthine-LaTeX** 系统。当被要求使用此系统编写 LaTeX 代码时，请遵循以下定义的模式和规则。

## 1. 系统概览
Hypoxanthine 是一个模块化的 LaTeX 框架，设计用于：
1.  **笔记** (`Hypo-Note`): 结构化知识库、讲义 (基于 `ctexbook`)。
2.  **速查表** (`Hypo-CHSH`): 高密度、多栏参考表 (基于 `ctexart`)。
3.  **文学** (`Hypo-LitNote`): 散文、诗歌和人文内容。

## 2. 入口类 (Entry Classes)
根据用户的意图选择类。

### 标准笔记 (`Hypo-Note`)
用于通用文档。
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

\chapter{简介}
...
\end{document}
```

### 速查表 (`Hypo-CHSH`)
用于紧凑、密集的摘要。
```latex
\documentclass[columns=3]{Hypo-CHSH}
% 注意: 该类通常不需要 \makecover 或 \tableofcontents
% 文档直接在多栏模式下开始

\begin{document}
\section{速查节标题}
...
\begin{document}
\section{速查节标题}
...
\end{document}
```

### 幻灯片 (`Hypo-Slide`)
用于演示文稿。
```latex
\documentclass[theme=school, aspectratio=169]{Hypo-Slide}
\HypoSlideSetup{title={标题}, author={名字}, logo={assets/logo.png}}
\begin{document}
\frame{\titlepage}
\begin{frame}{页标题} ... \end{frame}
\end{document}
```
**可用主题**: `school` (默认), `lab` (极客), `lit` (人文), `business` (商业).

### 讲师介绍 (`Hypo-Slide-Instructor`)
用于 Workshop 或 Tutorial 场景的讲师/演讲者展示。
- **封面自适应**: 在 `\titlepage` 前使用 `\InstructorCover`，封面将自动调整布局（标题上移，讲师居中）。
- **详细介绍**: 使用 `\InstructorBlock` 环境。

```latex
% 1. 封面展示
\HypoSlideSetup{title={Workshop}}
\InstructorCover[avatar.png]{Name}{Role}{Desc}
\begin{document}
\frame{\titlepage}

% 2. 详细页面
\begin{InstructorList}
  \InstructorBlock[avatar.png]{Name}{Role}{Detailed Bio...}
\end{InstructorList}
\end{document}
```


## 3. 核心模块与语法

### 3.1 字体策略 (Hypo-Fonts)
- **Tech Mode** (`fontset=tech`, 默认): 
    - 主字体: **Noto Sans CJK SC** (思源黑体)。
    - 适用: 技术文档、幻灯片、速查表。
- **Lit Mode** (`fontset=lit`): 
    - 主字体: **Noto Serif CJK SC** (思源宋体)。
    - 强调/引用: **LXGW WenKai** (霞鹜文楷)。
    - 适用: 文学笔记、诗歌、文科论文。

### 3.2 颜色与主题 (Colors & Schemes)
- **方案**: `Base` (基础), `CN` (国风/莫兰迪), `Tech` (科技/深蓝), `Simple` (极简灰)。
- **语义色**: 请使用以下代号而非硬编码颜色：
    - 主色: `HypoPrimary`
    - 强调: `HypoAccent`
    - 文本: `HypoText`
    - 背景: `HypoBackground` (或用于盒子的 `HypoSurface`)
    - 边框: `HypoBorder`

### 3.3 盒子 (`Hypo-Box`)
使用基于 `tcolorbox` 的环境。
**签名**: `\begin{env}{标题}{标签} ... \end{env}`.
- `标签` 是可选的（如果不需要引用，可以留空 `{}`）。
- `标签` 会自动获得前缀 (`def:`, `ex:`, `note:`)。

```latex
\begin{definition}{质能方程}{mass_energy}
    $E = mc^2$
\end{definition}

参见 \cref{def:mass_energy}。
```
**可用环境**:
- `definition` (主色)
- `example` (成功色/绿色)
- `note` (警告色/橙色)

### 3.4 代码 (`Hypo-Code`)
使用 `hypocode` 环境。**避免**使用标准的 `minted` 或 `lstlisting` 以确保可移植性。
**签名**: `\begin{hypocode}[选项]{语言} ... \end{hypocode}`.

```latex
\begin{hypocode}[linenos=false]{python}
def hello():
    print("Hello AI")
\end{hypocode}
```
**重要**: `hypocode` 环境是鲁棒的，可在 Beamer 帧中安全使用（通过 `fragile`）。

### 3.5 图标 (`Hypo-Icon`)
使用 `\HypoIcon{key}` 获取图标。
**常用 Keys**:
- **界面/操作**: `user`, `search`, `home`, `settings`, `check`, `warn`, `link`, `download`, `upload`
- **文件类型**: `file`, `pdf`, `word`, `image`, `video`, `zip`, `code`
- **社交**: `twitter`, `github`, `weixin`, `telegram`, `discord`, `zhihu`
- **技术栈**: `python`, `java`, `linux`, `docker`, `git`, `react`, `vue`, `node`, `cpp`
- **学术/联系**: `article`, `book`, `school`, `email`, `phone`

### 3.6 图像 (`Hypo-Img`)
使用 `\img` 获取简化的插图插入。
**签名**: `\img[选项]{文件名}{标题}`.
- 如果在选项中提供了 `label`，会自动生成 `fig:<label>`。

```latex
\img[width=0.8\linewidth, label=my_plot]{assets/plot.png}{演示图}

参见 \cref{fig:my_plot}。
```

### 3.7 数学 (`Hypo-Math`)
如果 `shorthand=true` (在 `Hypo-Note` 中默认开启)，则使用：
- 集合: `\R`, `\N`, `\Z`
- 定界符: `\Set{x}`, `\Paren{x}`, `\Abs{x}`
- 物理 (如果检测到 `physics` 包): `\dd{x}`, `\pdv{f}{x}`, `\ket{\psi}`.

### 3.8 绘图 (`Hypo-Plot`)
直接内嵌 Python 绘图代码，或编译外部 TikZ 文件。

**Python 绘图**:
```latex
\begin{HypoPyPlot}[name=sine_wave, width=0.8\linewidth]
x = np.linspace(0, 10, 100)
plt.plot(x, np.sin(x), color=HYPO_PRIMARY) # 使用注入的主题色
\end{HypoPyPlot}
```
*提示*: 可通过 `make PYTHON_BIN=/path/to/python` 指定解释器路径。

**TikZ 外部编译**:
```latex
% 自动处理依赖指纹与增量编译
\HypoTikZFile[width=0.8\linewidth]{network_diagram}{assets/network.tikz}
```

### 3.9 封面系统 (Hypo-Cover)
全新模块化的封面生成系统，从 v1.3.0 起可用，v1.3.2 进行了大幅优化。
**签名**: `\HypoCoverSetup{...}` + `\makecover`.

**核心参数**:
- `style`: 布局风格 (`modern`, `classic`, `academic`).
- `background`: 背景装饰 (`wave`, `sidebar`, `particle`, `grid`, `frame`, `corner`). **注意**: `banner`, `lines` 已在 v1.3.2 移除.
- `color`: 主题色 (默认 `HypoPrimary`).
- `logo`: Logo 图片路径 (通常在右上角).
- `image`: 中央/主配图 (Central Hero Image, v1.3.1 新增).

```latex
\HypoCoverSetup{
    style=modern, background=wave,
    title={文档标题}, subtitle={副标题},
    subject={学科/类别}, author={作者},
    date={\today}, logo={assets/logo.png},
    image={assets/cover_art.jpg} % 封面大图
}
\makecover
```

## 4. AI 最佳实践
1.  **优先 `cref`**: 始终使用 `\cref{...}` 而非 `\ref{...}` 进行智能引用。
2.  **使用相对路径**: 对于图片，假设标准结构（例如 `assets/`）。
3.  **语义化宏**: 只要可用，就是用 `\Hypo...` 命令。
4.  **无长导言**: 不要添加长导言区。Class 会处理宏包加载。仅在绝对必要时添加 `\usepackage`。
5.  **使用 `hypo` 脚本**: 指导用户时，建议使用 `scripts/hypo` 或 `scripts/hypo.bat` 进行构建。
