# Hypoxanthine-LaTeX 功能清单（简述版）

这份文档只记录“现有能力与接口”，不追求排版效果。
后续生成 manual 时，以本文件为唯一事实来源（manual 会更正式、更完整）。

## 入口（Classes）
- Hypo-Note：笔记入口（版式偏舒适阅读）
  - 推荐新用法：`\documentclass[...]{Hypo-Note}`（v0.8.0 起提供 `Hypo-Note.cls`）
  - 兼容旧用法：`\usepackage[...]{Hypo-Note}` 仍可用（内部改为加载 `Hypo-Note-Core`）
  - 内容层级：默认基底为 `ctexbook`（book-like），提供原生 `\chapter/\part` 等。
  - 默认策略：book 模式下默认注入 `oneside/openany`（可通过传入 `twoside/openright` 等覆盖）。
  - 章节编号风格：`chapterstyle=en`（默认，“1.”）或 `chapterstyle=cn`（“第一章”）。
- Hypo-Sheet：小抄入口（版式偏紧凑/多栏）
- Hypo-CHSH：CheatSheet / 小抄入口（信息密度优先）
  - 基底：`ctexart`
  - 多栏：基于 `multicol` 的等宽分栏（默认 3 栏）
  - 代码块：在多栏中默认自动“退回单栏”排版，避免跨列造成的断行/溢出
  - 页面尺寸：支持 `paperarea=a4` + `areascale` + `paperaspect` 进行面积/纵横比控制
- Hypo-LitNote：文学阅读/理解笔记入口（v0.9.0）
- 目标：两者导出的命令/环境尽量一致，切换入口时正文无需大改。

当前状态：已提供入口骨架（可加载 core 能力与统一选项）。

## 全局选项（拟定）
- indent=true/false：控制段首缩进策略（两入口一致）
- boxes=true/false：是否启用盒子环境（两入口一致，默认开启）
- refs=true/false：是否启用引用模块（hyperref + cleveref，两入口一致，默认开启）
- lists=true/false：是否启用列表美化（基于 enumitem；入口默认开启）
- colorscheme=<name>：选择配色方案（支持 Base、CN、Tech、Simple；旧值 CN01..CNxx、Tech01..Techxx、Simple01..Simplexx 作为别名兼容）
  - 可用值（当前内置）：Base、CN、Tech、Simple；旧值 CN01..CNxx、Tech01..Techxx、Simple01..Simplexx 作为别名兼容
  - 说明：该选项主要影响“语义色”和 Note-facing 别名色；旧的基础色卡（例如 HypoBlueDark）仍保留以兼容历史样式
- outputdir=...：给 minted 等模块使用的输出目录（由 Hypo-Base 导出）
  - v0.8.0 起：这些选项也可作为 `Hypo-Note` class 的 class option 使用

## 颜色（Core，v0.9.0 起逐步完善）
- 基础色卡：保留历史颜色名（如 `HypoBlue/HypoBlueDark/...`），用于兼容旧模块/旧文档
- 色系（Palette）：新增国风/科技/简约等色卡（命名示例：`HypoCN01...`、`HypoTech01...`、`HypoSimple01...`）
- 语义色（Semantic Aliases，推荐新模块使用）：
  - `HypoText` / `HypoTextMuted`
  - `HypoBackground` / `HypoSurface` / `HypoBorder` / `HypoBorderStrong`
  - `HypoSurfaceAlt`：第二层浅背景（用于行内引用/轻量强调）
  - `HypoTitleBackground` / `HypoTitleText`：标题栏语义色（保证“浅底 + 深色字”，同时随 colorscheme 变 tint）
  - `HypoPrimary` / `HypoSecondary` / `HypoAccent`
  - `HypoSuccess` / `HypoWarning` / `HypoDanger`
  - `HypoPrimarySoft` / `HypoSuccessSoft` / `HypoWarningSoft` / `HypoDangerSoft`：柔和底色（用于彩色盒子背景，随 colorscheme 自动派生）
- Note-facing 别名（给用户稳定引用）：
  - `HypoNoteText` / `HypoNoteBackground` / `HypoNoteBorder`
  - `HypoNotePrimary` / `HypoNoteAccent`

## Note 元数据与封面（v0.8.0）
- 元数据统一入口：`\HypoNoteSetup{title=..., subtitle=..., author=..., email=..., homepage=..., affiliation=..., date=...}`
- 封面：`\makecover`（手动触发；未设置任何元数据时会 Warning 且不输出空封面）
- 页眉页脚：book-like（twoside 时奇偶页分离），章首页使用 plain 样式，仅保留页码

### 封面图（规划中，未实现）
- 目标：在 `\makecover` 里支持封面图/Logo/背景图（默认不显示，设置才显示）
- 可能的 keys 草案（最终以 DEVELOPMENT_PLAN 为准）：
  - `coverimage=<path>`：标题上方主图（可配 `coverimage-width/coverimage-vspace`）
  - `coverlogo=<path>`：角标 Logo（可配 `coverlogo-width/coverlogo-pos`）
  - `coverbg=<path>`：整页背景（可配 `coverbg-scale/coverbg-opacity`）

## Icon（模块：Hypo-Icon，v0.8.0）
- 统一接口：`\HypoIcon{<key>}`
- 映射维护：
  - `\HypoIconDeclare{key}{value}`：声明/覆盖单个映射
  - `\HypoIconSetup{key={value}, ...}`：批量声明映射（未知 key 会写入映射表）
- 默认映射：`email/homepage/github`
  - 若存在 `fontawesome5`，默认使用 `\faIcon{...}`；否则降级为可读文本标记

## 速写开关（拟定）
- 默认启用大写速写命令（例如 \TX, \TBF, \MB, \MC, \BS）。
- 对外接口：入口支持 `shorthand=true/false`。
- 内部实现：入口在加载 Hypo-Math 前通过定义 \HypoDisableShorthand 来关闭速写。

## 速写命令（拟定，需确认冲突风险）
- \TX{...}：等价于 \text{...}（避免 \T 这类短命令冲突）
- \TBF{...}：等价于 \textbf{...}
- 数学速写（重点是字母样式，而不是数集）：
  - \MB{...}：等价于 \mathbf{...}
  - \MC{...}：等价于 \mathcal{...}
  - \BS{...}：等价于 \boldsymbol{...}
  - 其他（argmin、集合交并补等）后续按需加，并记录在本文件

## 数学命令（Core）
- \Abs{...}：绝对值（推荐保留）
- 数集符号（\R, \N, \Z, \Q, \C）：可选能力；不作为“速写重点”，默认不强依赖
- \Set / \Paren / \Brack：属于“可读性命令”，是否保留/是否提供更短别名（待你偏好决定）

## 图片命令（已实现）
- \img{<path>}{<caption>}：插图快捷命令（默认 figure + [htbp] + width=0.95\linewidth）
- 可选键值参数：\img[...]{<path>}{<caption>}
  - label=xxx：自动生成 \label{fig:xxx}（与 box 的 def:/ex:/note: 前缀风格一致）
  - span=1|2：单栏 figure / 双栏 figure*
  - width=...：覆盖默认宽度
  - placement=...：覆盖默认浮动参数（默认 htbp）

## 内容层级（拟定）
- detail 环境：sheet 下默认隐藏；note 下显示（样式可后定）
- vital 环境：强调重点（两入口一致）

### Chapter / Book（补充说明）
- 现状：`Hypo-Note` / `Hypo-LitNote` 默认以 `ctexbook` 为基底，具备更完整的 book 语义。
- 章节编号风格：可用 `chapterstyle=cn|en` 一键切换“第一章”/“1.”（技术笔记默认 `chapterstyle=en`）。

### CHSH（补充说明）
- 现状：`Hypo-CHSH` 为独立 class（`ctexart` 基底），面向“速查/小抄”场景。
- 关键点：多栏下 `hypocode` 默认单栏排版；可通过 `columns/colsep/balance` 调整版面密度。

### LitNote 的小节编号（补充说明）
- 目标：在文学笔记里避免标题出现 “1.1” 这种观感。
- 默认：`Hypo-LitNote` 使用 `sectionstyle=outline`，即 section 用 “一、二、三…”，subsection 用 “（一）（二）…”。
- 可选：`sectionstyle=arabic`，即 section 用 “1,2,3…”，subsection 用 “(1)(2)…”。

## 盒子（当前最小集）
- definition：定义盒子（v0.3.0 起可用）
- example：例子盒子（v0.3.1 起可用）
- note：笔记/提示盒子（v0.3.3 起可用）

### 盒子默认配色（可覆盖）
- v0.9.0 起：盒子默认配色改为“语义色 + 柔和底色”（随 colorscheme 切换）
  - definition：边框 `HypoPrimary`，底色 `HypoPrimarySoft`
  - example：边框 `HypoSuccess`，底色 `HypoSuccessSoft`
  - note：边框 `HypoWarning`，底色 `HypoWarningSoft`

覆盖方式：在导言区用 `\tcbset{hypo example box/.style={...}}` 等覆盖对应 hook。

### 盒子标题与 label
- 盒子支持“标题”（例如 Definition 的名字）
- 显式 label（v0.3.4）：
  - 语法：`\begin{definition}{Title}{label}`（example/note 同理）
  - 实际生成的 label 会自动带前缀：definition=`def:`，example=`ex:`，note=`note:`
  - 不需要引用时可传空：`{}`（不生成 `\label`）
- 自动 label（计划）：仅对 ASCII 标题做可读的 slug；中文/非 ASCII 默认不自动生成（避免不可记忆的 hash）

## 引用与链接（拟定）
- v0.3.5 起：入口默认加载 hyperref + cleveref（可通过 `refs=false` 关闭）
- 建议用法：用 `\cref{...}` 输出 "Definition: 0.1" 这类格式

## 算法（已实现）
- 模块：`Hypo-Algorithm`（基于 `algorithm2e`）
- 入口默认加载，可通过 `algorithm=false` 关闭
- 与 `Hypo-Refs` 协作：`\cref{alg:...}` 输出形如 "Algorithm: 1"

## 代码（已实现）
- 模块：`Hypo-Code`（优先使用 `minted`，不可用时 fallback 到 `listings` 并给出 Warning）
- 入口默认加载，可通过 `code=false` 关闭
- 环境：`hypocode`，用法：`\begin{hypocode}{python} ... \end{hypocode}`
- 可选参数（对两种后端都稳定）：
  - `linenos=true|false`：是否显示行号（默认 true）
  - `theme=<pygments-style>`：主题/配色（仅对 minted 生效；fallback 下会被忽略）
  - `minted={...}`：透传 minted 原生选项（仅 minted 生效）
  - `listings={...}`：透传 listings 原生选项（仅 fallback 生效）
- 语言支持：
  - minted：以 Pygments 的 lexer 为准（通常覆盖绝大多数语言）
  - fallback：内置映射 `python/py`、`cpp/c++`、`latex/tex`、`bash/sh`；其他语言名会原样交给 listings
