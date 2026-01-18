# Changelog

本文件记录版本更新内容（面向使用者）。

## Unreleased


## v1.1.0 (Planned)

### v1.0.1 (2026-01-18)
- Math：固化可选 physics 的加载行为（默认 `trig,uprightdiff,bolddel`），并提供 `\HypoPhysicsOptions` 覆盖钩子
- Docs：Manual 增加 physics 速查小节（微分/导数、定界符、矢量算符、Dirac 记号），并保证缺包时可编译


## v1.0.0 (2026-01-18)
- Release：发布 v1.0.0 正式版（Stable）
- Scripts：新增并完善 `scripts/hypo.py`（doctor / template / snippets install），面向 submodule/子目录引入的工作流
- Templates：模板体系收敛为“复制 templates 文件 + Makefile 注入”，避免在脚本里 hardcode 文档骨架
- Snippets：新增 VS Code workspace snippets（`snippets/hypoxanthine-latex.code-snippets`），支持一键安装到项目 `.vscode/`
- Docs：Manual 扩写为“Quick Start + 参数说明 + 可运行示例 + 效果展示”的参考手册，并保证可编译
- Docs：FEATURES/DEVELOPMENT_PLAN 对齐实现事实与构建/子模块工作流说明


## v0.9.3:NoteSyntax (2026-01-17)
- Note：补齐 `lists=true/false` 选项（与 LitNote/CHSH 对齐），并默认启用列表美化（enumitem）
- Note：`chapterstyle=en` 为技术笔记默认，章节/小节标题更贴近技术文档的 “1.” / “1.1.” 观感
- Docs：对齐 FEATURES/CHANGELOG 中与 Note 系列相关的事实描述（以发布为准）


## v0.9.0:LitNote+Themes (2026-01-17)
- LitNote：新增文学笔记入口 `Hypo-LitNote.cls`（基底 `ctexbook`），提供 poem/quote/行内引语与示例模板
- LitBox：新增 `Hypo-LitBox`（`poem` / `quotepara` / `\InlineQuote`），并全面对接语义色（随 `colorscheme` 生效）
- Lists：新增 `Hypo-Lists`（基于 enumitem），统一 itemize/enumerate 样式，最多支持 4 级嵌套
- Colors：主题系统收敛为 `Base/CN/Tech/Simple` 四套规范 scheme；旧 `CN01..CNxx/Tech01..Techxx/Simple01..Simplexx` 作为别名归一化
- Colors：新增/完善多层语义色（`HypoSurfaceAlt`、`HypoTitleBackground/TitleText`、`Hypo*Soft`）以支持更丰富的盒子背景层次
- Box：definition/example/note 默认配色改为语义色 + 柔和底色（随 `colorscheme`），仍可通过 `\tcbset` 覆盖


## v0.8.0 (2026-01-17)
- Note：新增 `Hypo-Note.cls`（基底 `ctexbook`），支持作为 `\documentclass{Hypo-Note}` 使用
- Note：新增元数据接口 `\HypoNoteSetup{...}` 与手动封面命令 `\makecover`
- Note：新增页眉页脚（Title + Author + 章节标题），并保留标准目录能力（`\tableofcontents`）
- Icon：新增 `Hypo-Icon` 模块，统一接口 `\HypoIcon{key}`，并允许用户通过 `\HypoIconDeclare/\HypoIconSetup` 维护映射
- 兼容：`Hypo-Note.sty` 保留为 wrapper，继续支持旧的 `\usepackage{Hypo-Note}` 用法

## v0.1.0
- 初始化工程文档：新增 DEVELOPMENT_PLAN、FEATURES、PROMPT
- 构建系统可用性修复：Makefile include 大小写对齐、补齐 watch 目标
- manual：入口文件重命名为 Manual.tex，完善 manual/Makefile

## v0.2.0
- 新增 tests 隔离测试入口：用于验证 corner cases，不污染 manual
- Fonts 层增强：Hypo-Fonts 增加字体缺失时的自动降级策略

## v0.2.1
- Colors 层可用：Hypo-Colors 提供基础色名体系
- tests：增加颜色可用性验证用例

## v0.2.2
- Base 层可用：Hypo-Base 支持 outputdir 选项并导出 FinalOutputDir
- tests：增加 Base 参数导出验证用例

## v0.2.3
- Math 层增强：Hypo-Math 内置大写速写命令（默认启用）
- 速写开关：可通过预先定义 \HypoDisableShorthand 关闭速写（用于规避命名冲突）
- tests：默认只跑主线用例；边缘用例通过 `make -C tests edge` 单独运行

## v0.2.4
- 新增入口骨架：Hypo-Note 与 Hypo-Sheet（两入口对外选项一致）
- 入口选项透传：`outputdir/indent/shorthand`（`shorthand=false` 通过内部宏关闭 Hypo-Math 速写）
- 构建增强：默认通过 `TEXINPUTS` 支持用包名加载本地 `sty/` 下的 Hypo-* 文件

## v0.3.0
- Box 最小集：新增 definition 环境（样式方案 2：浅底 + 细边框）
- Box 开关：入口新增 `boxes=true/false`
- 编号策略：Box 支持 numbering=none/global/section/chapter（默认 section）
- 清理：移除未使用的旧入口文件 Hypo-Notes

## v0.3.1
- Box 扩展：新增 example 环境（仍沿用方案 2：浅底 + 细边框）
- Box 默认配色：对接 Hypo-Colors（definition：HypoDarkBlue/HypoSkyBlue；example：HypoGreen/HypoLightGreen；note：预留 hypo note box 样式 hook，默认 HypoBrown/HypoYellow）

## v0.3.2
- Colors：切换为更克制的“浅/中/深”专业色系，并提供成系列色名（如 HypoBlueLight/HypoBlue/HypoBlueDark）
- Box：definition/example/note 的默认配色同步切换到新色系（仍可用 `\tcbset{hypo ... box/.style={...}}` 覆盖）

## v0.3.3
- Box：新增 note 环境（Note）
- Box：内部设置样式时规避“tab+cbset”破坏（避免编辑器把 `\tcbset` 的 `\t` 误处理成 Tab）

## v0.3.4
- Box：definition/example/note 支持显式 label（用于 `\label/\ref`），label 前缀分别为 `def:` / `ex:` / `note:`
- tests：补充主线用例的显式引用验证

## v0.3.5
- Refs：新增 Hypo-Refs 模块（hyperref + cleveref），入口新增 `refs=true/false`（默认开启）
- 引用格式：使用 `\cref{...}` 时输出 "Definition: 0.1" / "Example: 0.1" / "Note: 0.1" 这类格式
- tests：主线用例切换为 `\cref` 验证输出

## v0.4.0
- README：对齐当前工程化用法（按包名加载、Makefile 注入 TEXINPUTS、入口选项说明等）
- manual：补齐自举式手册（覆盖入口/选项、core/modules、Box、Refs 与示例）
- DEVELOPMENT_PLAN：补充 v0.5.0–v1.0.0 长线里程碑与 release criteria

## v0.4.1 & v0.4.2 & v0.4.3
- 使用中文手册
- 整理目前的代码和文档
- 清理 `PROMPT.md`

## v0.5.0 (2026-01-17)
- 新增图片快捷命令：`\img`，默认 `figure` + `[htbp]` + `width=0.95\linewidth`
- 支持可选键值参数：`label=xxx` 自动使用 `fig:` 前缀，`span=2` 生成 `figure*`

## v0.6.0 (2026-01-17)
- 新增算法模块：`Hypo-Algorithm`（基于 `algorithm2e`）
- 入口新增 `algorithm=true/false`（默认开启），并与 `\cref` 协作输出 "Algorithm: <num>"

## v0.7.0 (2026-01-17)
- 重写代码模块：`Hypo-Code`（minted 优先；不可用时 fallback 到 `listings` 并给出 Warning）
- 入口新增 `code=true/false`（默认开启），并提供 `hypocode` 环境
- `hypocode` 新增稳定选项：`linenos=true|false`、`theme=<pygments-style>`（theme 仅对 minted 生效）
- 构建系统新增 `SHELL_ESCAPE=1` 开关，用于启用 `-shell-escape`（minted 推荐配置）
