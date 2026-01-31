# Changelog

本文件记录版本更新内容（面向使用者）。
## [Unreleased] 


## v1.4.0 (2026-01-30)

### Bug Fixes
- **Hypo-Code.sty**: 修复了当 `hypocode` 环境没有选项（如 `linenos=false`）时导致的 `keyval Error: undefined` 问题。使用 `clist` 正确构建选项列表，并在选项为空时不传递 `[]` 给 minted。

### Refactoring & Code Quality
- **Hypo-Note.cls**: 移除了重复的 `\ExplSyntaxOff` 语句。
- **Hypo-Plot.sty**: 将核心函数重构为可读性更高的辅助函数。
    - `\hypo_plot_include_graphics:nn` 分解为 6 个职责单一的辅助函数：`\hypo_plot_opts_empty:NTF`、`\hypo_plot_render_error_box:N`、`\hypo_plot_include_bare:N`、`\hypo_plot_include_with_opts:NN`、`\hypo_plot_include_missing:N`。
    - `\hypo_plot_assemble_and_execute:` 分解为 5 个辅助函数：`\hypo_plot_write_header:`、`\hypo_plot_write_footer:`、`\hypo_plot_concat_script:`、`\hypo_plot_update_script_if_changed:`、`\hypo_plot_run_python_if_needed:`。
- **版本号**: 所有 27 个 `.cls/.sty` 文件版本号统一更新至 v1.4.0。


## v1.3.3 (2026-01-28)

### Header Layout Improvements
- **Hypo-Note**: 页眉左侧现在采用 `Chapter / Section` 的组合显示（粗体 `/` 分隔），增强了导航性。
- **Hypo-LitNote**: 页眉左侧现在采用 `Chapter　Section` 的组合显示（全角空格分隔），更加符合中文人文书籍的排版美学。

### Cover System Refinements & Minimalism
- **Layout Enhancements**:
    - **No-Overlap Logic**: `classic` 与 `academic` 版式现在会将 `image` 作为流式内容排版（Flow content），彻底避免其与标题文字重叠。
    - **Academic Layout**: 改为极简风格，默认移除装饰性元素，更符合学术规范；插图（image）位置调整至标题下方，并改用动态间距（vfill）彻底解决插图过大导致的非正常分页问题。
- **Cleanup**: 删除了 `banner` 和 `lines` 背景纹理，以保持系统清爽。
- **UI**: 调整了 `wave` 和 `sidebar` 的不透明度，使背景更加深沉专业。

## v1.3.1 (2026-01-28)

### Cover System Refinements
- **Classic Layout**:
    - **UI Optimization**: 增加了内部边距，彻底解决 Frame 边框与文字/图片重叠的问题。
    - **Central Image**: 新增对 `image` 字段的支持，用于在封面中央显示带有阴影效果（Drop Shadow）的主题配图。
- **Academic Layout**:
    - **Layout Fix**: 修复了顶部 Banner 与 Affiliation/Logo 重叠的严重视觉问题，采用更稳健的布局策略。
- **General**:
    - **Robustness**: 优化了 `Hypo-Cover.sty` 的内部依赖加载顺序，修复了某些情况下 `pgfkeys` 报错的问题。
- [CHORE] **Hypo-Colors**: 为所有 `\definecolor` 添加了 `% #xxxxxx` 格式的注释，方便编辑器插件直接预览颜色。

## v1.3.0 (2026-01-27)

### Major Updates / 重大更新
- **Hypo-Cover**: 全新重构的封面系统 (`sty/modules/Hypo-Cover.sty`)。
    - **Architecture**: 分离 Layout (版式) 与 Background (纹理)，支持自由组合。
    - **API**: 新增 `\HypoCoverSetup` 统一配置接口，支持 `style`, `background`, `logo` 等参数。
    - **Themes**:
        - `modern`: 科技感、不对称布局（默认）。支持 `wave`, `sidebar`, `particle`, `grid` 背景。
        - `classic`: 人文感、居中衬线布局。支持 `frame`, `corner` 背景。
        - `academic`: 严谨报告风格。支持 `banner`, `lines` 背景。
    - **Error Handling**: 优雅处理缺失字段，支持自定义扩展 (`\NewHypoCoverStyle`)。



## v1.2.3 (2026-01-27)
- [FIX] **Hypo-LitNote**: 修复了 `fontset=lit` 选项未能正确传递给底层核心包的问题。现在文学笔记可正确加载 **思源宋体 (Noto Serif CJK SC)** 作为正文，而非之前的思源黑体。
- [REFACTOR] **Hypo-Note-Core**: 优化了 `Hypo-Fonts` 的加载逻辑，使用 `\PassOptionsToPackage` 确保参数透传。

## v1.2.1 & v1.2.2 (2026-01-27)
### 手动修复
- 修复了大量 AI 无法修复的细节格式问题

### Major Changes / 重大变更
- **Hypo-Fonts**: 全局字体迁移至 **Noto/Source Han** 系列，移除对 Fandol 的默认依赖。
    - **Tech Mode**: 统一使用 Noto Sans CJK SC (思源黑体) 作为正文与标题字体。
    - **Lit Mode**: 使用 Noto Serif CJK SC (思源宋体) 作为正文，**LXGW WenKai (霞鹜文楷)** 作为引用与强调字体。
- **Hypo-LitBox**: 诗歌 (`poem`) 与引用 (`quotepara`) 环境现在自动使用系统安装的 **LXGW WenKai (霞鹜文楷)** 渲染（如果可用）。

### Build System & Fixes
- **Makefile**: 默认开启 `SHELL_ESCAPE=1`，开箱即支持 `minted` 代码高亮与 `Hypo-Plot` 绘图。
- **Hypo-Code**: 修复了传递 `linenos=false` 时引发的 `keyval Error`。
- **Hypo-Fonts**: 修复了 Noto Sans Mono 在部分状态下缺少 Italic 特性的警告；修复了 `\kaishu` 重定义时的冲突问题。

## v1.2.0 (2026-01-26)

### Major Updates / 重大更新
- **Hypo-Slide**: 全新的幻灯片类 (based on `ctexbeamer`)。
    - 开箱即用的 5 套主题：School, Lab, Lit, Tutorial, Business。
    - 深度集成 Hypo-Box (Overlay 支持) 与 Hypo-Code (Fragile 支持)。
    - 统一的 `\HypoSlideSetup` 配置接口。

- **Modules**:
    - **Hypo-Slide-Instructor**: 新增讲师介绍模块 (Tutorial Theme 功能下沉)。
        - 支持 `\InstructorCover` (自适应列布局，用于封面)。
        - 支持 `\InstructorBlock` 和 `InstructorList` (用于单独页面或介绍页)。

### Theme Details
- **School**: 默认上海科技大学红 (#9D0004)，正式答辩风。底栏采用三段式显式边框设计。优化了 Logo 遮挡问题。
- **Lab**: 极客深色模式，采用 "Wireframe" 线框封面。代码块背景调浅 (Slate 500) 以增强对比度。页码移至右下角。
- **Lit**: 衬线字体与纸张白，适合人文汇报。支持居中诗歌 (`poem` 内部文字居中) 与雅致页眉。
- **Business**: 极简科技风，采用 "Liquid Glass" (毛玻璃+流体背景) 设计。
- **Note**: 删除了 `Tutorial` 主题，其能力已通用化为 Instructor 模块。

### Improvements
- **Template**: 新增 `hypo template slide` 命令。
- **Hypo-Box**: 增加了针对 Beamer 的适配层，解决了 `note` 环境冲突。

## v1.1.2 (2026-01-25)

### Major Updates / 重大更新
- **Manual Rewrite**: 全面重写用户手册（Chapter 3-7），新增详细的盒子系统、代码高亮、数学速写表、绘图工作流及文学模式指南。
- **Hypo-Note Class**: 新增 `fontset` 接口，防止自定义字体选项意外透传给底层 `ctexbook` 导致编译错误。
- **Hypo-Fonts**: 增强了字体加载的鲁棒性 (Safe Fallback)，缺失字体时自动降级使用 `ctex` 默认配置。
- **Core Refactoring**: `Hypo-Note-Core` 选项解析迁移至 `l3keys2e` (expl3)。

### Fixes & Improvements
- **Hypo-Plot**: 修复了 `HypoTikZFile` 在 `-output-directory` 模式下的路径错误，现在 TikZ 外部编译流程已完全打通。
- **Hypo-Plot**: 改进了 Python 环境检测机制。支持通过 Makefile 变量 `PYTHON_BIN` (`make PYTHON_BIN=...`) 或 LaTeX 宏 `\HypoPythonBin` 灵活指定解释器路径，不再硬编码为 `python3`。
- **Hypo-Icon**: 大幅扩充图标库（30+ 新图标），涵盖 Dev (React, Vue...), Office (PDF, Word...), Actions (Cloud, Download...) 等分类。
- **Hypo-Box**: 重构了盒子视觉样式：采用彩色标题栏（随环境类型变化）+ 黑色标题字 + 白色内容的现代设计；补齐了 `theorem`, `lemma`, `corollary`, `proposition`, `tip`, `important`, `warning` 等全量环境定义。
- **Docs**: `Manual` 完成全模块深度改写并同步渲染示例（含诗歌与引用段落）；`FEATURES.md` 全面汉化并转换为 AI Context 格式。

## v1.1.1 (2026-01-24)

### Refactoring & Optimization / 重构与优化
- **Architecture/架构**: `Hypo-Note.cls` 实现了与 `Hypo-Note-Core.sty` 的职责分离，增强了 `sty` 文件在标准类（如 `article`）下的鲁棒性。
- **Hypo-Code**: 移除了脆弱的 `+v` 参数类型；显式使用 `\VerbatimEnvironment` 以提升与 `beamer` 幻灯片的兼容性。
- **Hypo-Colors**: 重构为更清晰的“色板 (Palette) / 语义层 (Semantic Layer)”结构。
- **Tests**: 测试集重新组织为 `unit`（单元测试）与 `integration`（集成测试）文件夹。
- **Scripts**: Added `hypo clean` command and improved `hypo doctor` with font detection. Added `scripts/hypo` (.sh) and `scripts/hypo.bat` wrappers.
- **Docs**: `FEATURES.md` is now a dedicated "AI Context" document. `README.md` updated for clarity. Manual expanded significantly.
- **Icons**: Added 30+ new icons (Dev, Office, Actions) to `Hypo-Icon.sty`.
- **Manual**: Completely rewrote Chapters 3 (Box), 4 (Code), 5 (Math), 6 (Plot) to address feedback.

## v1.1.0 (2026-01-19)

- Plot：新增模块 `Hypo-Plot`，提供 `HypoPyPlot` 环境：在 TeX 内嵌 Python/Matplotlib 代码，自动生成图片并插入文档
- Plot：支持常用参数：`name=<id>`（必填）、`width/height`（传给 `\includegraphics`）、`figwidth/figheight`、`dpi`、`format=png|pdf`
- Plot：产物按 `outputdir` 统一落盘：脚本 `build/scripts/<name>.py`，图片 `build/figures/<name>.<format>`
- Build：绘图与代码高亮同属外部调用能力；如需执行绘图，请开启 `-shell-escape`（Makefile 体系：`make SHELL_ESCAPE=1`），并保证本机 Python 环境可用（Matplotlib）

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
