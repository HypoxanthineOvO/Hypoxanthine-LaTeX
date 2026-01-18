# Hypoxanthine-LaTeX 功能清单（真值表）

本文档只记录“已经实现并可用”的能力与接口；不写规划、不写愿景。

## 入口（Classes / Entry Packages）

### Hypo-Note（class）

推荐用法：

```latex
\documentclass[outputdir=build]{Hypo-Note}
```

实现状态：
- 基类：`ctexbook`（原生 book 语义：`\chapter/\part` 等均可用）
- 默认注入（仅当用户未显式指定时）：`oneside` + `openany`
- 章节编号风格：`chapterstyle=en|cn`（默认 `en`）
- 自动加载：`Hypo-Note-Core`（能力包）+ `Hypo-Icon`（封面图标映射）

Class options（含默认值）：
- `base=book`（仅保留兼容占位；`base=article` 会报错）
- `chapterstyle=en|cn`（默认 `en`）
- `shorthand=true|false`（默认 `true`）
- `indent=true|false`（默认 `true`）
- `boxes=true|false`（默认 `true`）
- `refs=true|false`（默认 `true`）
- `algorithm=true|false`（默认 `true`）
- `code=true|false`（默认 `true`）
- `lists=true|false`（默认 `true`）
- `outputdir=<dir>`（默认 `build`）
- `colorscheme=Base|CN|Tech|Simple`（默认 `Base`；大小写不敏感；支持 `CN01/Tech01/...` 别名）

Note 元数据与封面（已实现）：
- `\HypoNoteSetup{title=..., subtitle=..., author=..., email=..., homepage=..., affiliation=..., date=...}`
- 便捷命令：`\HypoSetTitle` / `\HypoSetSubtitle` / `\HypoSetAuthor` / `\HypoSetEmail` / `\HypoSetHomepage` / `\HypoSetAffiliation` / `\HypoSetDate`
- `\makecover`：生成封面（若未设置任何元数据，会给出 Warning 且不输出空封面）

### Hypo-LitNote（class）

推荐用法：

```latex
\documentclass{Hypo-LitNote}
```

实现状态：
- 基类：`ctexbook`
- 默认 `chapterstyle=cn`
- 默认 `sectionstyle=outline`（避免标题出现“1.1”观感）
- 默认启用文学向盒子：`litbox=true`（加载 `Hypo-LitBox`）

Class options（含默认值）：
- `base=book`（仅保留兼容占位；`base=article` 会报错）
- `chapterstyle=cn|en`（默认 `cn`）
- `sectionstyle=outline|arabic`（默认 `outline`）
- `shorthand=true|false`（默认 `true`）
- `indent=true|false`（默认 `true`）
- `boxes=true|false`（默认 `true`）
- `refs=true|false`（默认 `true`）
- `algorithm=true|false`（默认 `true`）
- `code=true|false`（默认 `true`）
- `lists=true|false`（默认 `true`）
- `litbox=true|false`（默认 `true`）
- `outputdir=<dir>`（默认 `build`）
- `colorscheme=Base|CN|Tech|Simple`（默认 `Base`）

### Hypo-CHSH（class）

推荐用法：

```latex
\documentclass{Hypo-CHSH}
```

实现状态：
- 基类：`ctexart`
- 多栏：基于 `multicol`（默认 3 栏；在 `\begin{document}` 后自动进入多栏）
- 代码块：支持在多栏内正常排版（不跨列溢出）
- 页面尺寸：按“面积 + 纵横比”计算（见 options）

Class options（含默认值）：
- `shorthand=true|false`（默认 `true`）
- `indent=true|false`（默认 `false`）
- `boxes=true|false`（默认 `true`）
- `refs=true|false`（默认 `true`）
- `algorithm=true|false`（默认 `false`）
- `code=true|false`（默认 `true`）
- `lists=true|false`（默认 `true`）
- `balance=true|false`（默认 `false`；`false` 时使用 `multicols*`）
- `codelinenos=true|false`（默认 `false`；用于覆盖 CHSH 的“默认关闭代码行号”策略）
- `outputdir=<dir>`（默认 `build`）
- `colorscheme=Base|CN|Tech|Simple`（默认 `Base`）
- `columns=<int>`（默认 `3`）
- `colsep=<dim>`（默认 `10pt`）
- `chapterbreak=none|column|page`（默认 `none`；在 `\section` 前插入换栏/换页策略）
- `paperarea=a4`（默认 `a4`；其他值会 Warning 并回退到 `a4`）
- `areascale=<num>`（默认 `1`；必须为正数，否则报错）
- `paperaspect=<num>`（默认 `210/297`；必须为正数，否则报错）
- `textsize=normal|small|footnotesize|scriptsize`（默认 `footnotesize`）

辅助命令：
- `\CHSHColumnBreak`：强制换到下一栏
- `\CHSHBeginColumns` / `\CHSHEndColumns`：手动开始/结束多栏（一般不需要）

### Hypo-Note（package wrapper）与 Hypo-Note-Core（能力包）

为兼容旧用法保留：

```latex
\usepackage[outputdir=build]{Hypo-Note}
```

`Hypo-Note` 包内部仅转发加载 `Hypo-Note-Core`。

`Hypo-Note-Core` 支持的 options：
- `shorthand=true|false`（默认 `true`；`false` 时会定义 `\HypoDisableShorthand` 来关闭数学速写）
- `indent=true|false`（默认 `true`；`false` 时设置 `\parindent=0pt`）
- `boxes=true|false`（默认 `true`；控制是否加载 `Hypo-Box`）
- `refs=true|false`（默认 `true`；控制是否加载 `Hypo-Refs`）
- `algorithm=true|false`（默认 `true`；控制是否加载 `Hypo-Algorithm`）
- `code=true|false`（默认 `true`；控制是否加载 `Hypo-Code`）
- `lists=true|false`（默认 `true`；控制是否加载 `Hypo-Lists`）
- `outputdir=<dir>`（默认 `build`；传给 `Hypo-Base` 并导出 `\FinalOutputDir`）
- `colorscheme=Base|CN|Tech|Simple`（默认 `Base`；会在加载 `Hypo-Colors` 前设置 `\HypoColorScheme`）

补充能力（已实现，面向“更深层级/非 book 基类”）：
- `\HypoEnableDeepSections[<depth>]`：设置 `secnumdepth/tocdepth`（默认 5）
- `\HypoParagraphBlockHeadings`：将 `\paragraph/\subparagraph` 调整为块状标题
- `\HypoEnableChapters`：为“article-like 基类”启用 `chapter` 层级计数体系
  - 当基类不存在 `\chapter` 时，`Hypo-Note-Core` 会提供 `\chapter`（含编号与 TOC 支持）

### Hypo-Sheet（entry package）

文件为 `Hypo-Sheet.sty`（目前不是 class）。它加载与 `Hypo-Note-Core` 类似的一组 core/modules，但不包含 `lists` 开关（即：不自动加载 `Hypo-Lists`）。

## Core（原子能力）

### Hypo-Fonts
- 依赖 `xeCJK` + `fontspec`（因此推荐 XeLaTeX）
- 英文字体：优先 DejaVu，降级 Latin Modern
- 中文字体：优先 LXGW WenKai，降级 Noto Serif CJK SC，再降级 Fandol

### Hypo-Colors

配色选择：
- 入口通常通过 `colorscheme=...` 注入 `\HypoColorScheme` 后再加载本包
- 也可直接调用：`\HypoColorSchemeSetup{scheme=<name>}`

支持的 scheme 名称（会归一化为这四种）：`Base` / `CN` / `Tech` / `Simple`
- 别名：`CN01..CN99` -> `CN`，`Tech01..` -> `Tech`，`Simple01..` -> `Simple`

查询当前 scheme：`\HypoColorSchemeName`

### Hypo-Base

输出目录：
- option：`outputdir=<dir>`（默认 `build`）
- 导出：`\FinalOutputDir`（供 `minted` 等使用）

文档排版辅助（面向 Manual/README/示例；已实现）：
- `\HypoBS`：反斜杠
- `\HypoCS{foo}`：排版控制序列 `\foo`
- `\HypoCode{...}`：等宽显示一段代码（对参数做 `\detokenize`）
- 以及 `\HypoTT` / `\HypoBF` / `\HypoIT` / `\HypoPkg` / `\HypoEnv` / `\HypoCls`

### Hypo-Img

命令：`\img[<key=val>]{<path>}{<caption>}`

Keys（含默认值）：
- `label=`（默认空；非空时写入 `\label{fig:<label>}`）
- `width=0.95\linewidth`
- `placement=htbp`
- `span=1|2`（默认 `1`；`2` 使用 `figure*`）

### Hypo-Math

基础：加载 `amsmath/amssymb/mathtools`

命令（已实现）：
- 数集：`\R` / `\N` / `\Z`
- 成对定界符：`\Paren` / `\Brack` / `\Set` / `\Abs`
- 速写（仅在未定义 `\HypoDisableShorthand` 时启用）：`\TX` / `\TBF` / `\MB` / `\MC` / `\BS`

## Modules（可选插件）

### Hypo-Box

加载：由入口选项 `boxes=true` 控制（默认开启）。

可用环境：
- `definition`
- `example`
- `note`

用法（tcolorbox theorem 形式）：

```latex
\begin{definition}{Title}{label}
  ...
\end{definition}
```

- 第 2 个参数为空 `{}` 时不生成 `\label`
- Label 前缀：`definition` -> `def:`，`example` -> `ex:`，`note` -> `note:`

选项：`numbering=none|global|section|chapter`（默认 `section`）

### Hypo-Refs

加载：由入口选项 `refs=true` 控制（默认开启）。

内容：
- `hyperref`（`hidelinks`）
- `cleveref`，并为 `Hypo-Box` 的计数器配置名称（如 `Definition:` / `Example:` / `Note:`）

### Hypo-Algorithm

加载：由入口选项 `algorithm=true` 控制（Note/LitNote 默认 `true`，CHSH 默认 `false`）。

内容：
- `algorithm2e` 默认风格：`ruled` + `linesnumbered` + `vlined`
- 若已加载 `cleveref`，则配置 `algocf` 的 `\cref` 名称为 `Algorithm:`

### Hypo-Code

加载：由入口选项 `code=true` 控制（默认开启；CHSH 默认开启）。

环境：`hypocode`

后端选择：
- 若存在 `minted.sty` 且启用 shell-escape：使用 `minted`（并传入 `outputdir=\FinalOutputDir`）
- 否则回退到 `listings`，并仅 Warning 一次

可选参数（两种后端都接受）：
- `linenos=true|false`（默认 `true`；CHSH 会默认关闭行号，可用 `codelinenos=true` 反转）
- `theme=<pygments style>`（仅 minted 生效）
- `minted=<raw options>`（仅 minted 生效）
- `listings=<raw options>`（仅 listings 生效）

### Hypo-Lists

加载：由入口选项 `lists=true` 控制（Note/LitNote/CHSH 默认 `true`）。

行为：
- 使用 `enumitem` 统一 `itemize/enumerate` 的缩进与间距
- `itemize` 1~4 级符号：`\bullet` / `\circ` / `\blacksquare` / `\blacktriangle`

### Hypo-LitBox

加载：由 `Hypo-LitNote` 的 `litbox=true` 控制（默认开启）。

命令与环境：
- `\InlineQuote{...}`：行内浅底强调
- `poem`：文学向诗词块（tcolorbox）
- `quotepara`：文学向引用段落块（tcolorbox）

### Hypo-Icon

加载：`Hypo-Note` class 会加载。

接口：
- `\HypoIcon{<key>}`：取出一个 icon 内容
- `\HypoIconDeclare{key}{value}`：声明/覆盖单个映射
- `\HypoIconSetup{key={value}, ...}`：批量声明映射

默认映射：`email/homepage/github`
- 若存在 `fontawesome5`，默认使用 `\faIcon{...}`；否则降级为可读文本标记
