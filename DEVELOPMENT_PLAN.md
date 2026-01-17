# Hypoxanthine-LaTeX 开发计划书

## 1. 项目目标

创建一个"可工程化维护"的 LaTeX 生态，提供：
- **Hypo-Note / Hypo-Sheet** 两套入口，接口语法一致
- 常用写作动作用速写命令提升效率，且可开关
- Box/样式可扩展但不失控：先做最小集，后续增量扩展

## 2. 核心原则

1) **接口冻结优先于实现**：先冻结用户命令/环境，再实现
2) **职责分离**：
   - Class 管版式（geometry/titlesec/fancyhdr等）
   - Core 管基础能力（字体/颜色/数学基础）
   - Module 管插件功能（minted/algorithm2e/hyperref等）
3) **一处定义，多处复用**：颜色、速写、label规则等必须单点维护

## 3. 命名规范

- 统一采用 `Hypo-*.sty`（`*` 首字母大写）
- Linux 大小写敏感：文件名与 `\RequirePackage` / Makefile 严格一致
- 允许兼容入口文件（薄wrapper），但只能转发逻辑

## 4. 项目结构

```text
Hypoxanthine-LaTeX/
├── sty/
│   ├── core/                 # 原子能力（无版式）
│   │   ├── Hypo-Base.sty     # kvoptions + FinalOutputDir ✅ v0.2.2
│   │   ├── Hypo-Colors.sty   # 专业色系（浅/中/深）✅ v0.3.2
│   │   ├── Hypo-Fonts.sty    # 字体策略 ✅ v0.2.0
│   │   └── Hypo-Math.sty     # 数学基础 + 速写 ✅ v0.2.3
│   ├── modules/              # 插件能力（按需加载）
│   │   ├── Hypo-Box.sty      # 盒子系统 ✅ v0.3.0-v0.3.4
│   │   ├── Hypo-Code.sty     # minted 配置 ✅ 
│   │   └── Hypo-Refs.sty     # hyperref + cleveref ✅ v0.3.5
│   └── classes/              # 场景入口
│       ├── note/             # Hypo-Note 类 ✅ v0.2.4
│       └── sheet/            # Hypo-Sheet 类 ✅ v0.2.4
├── make/Hypoxanthine.mk      # 构建系统 ✅
├── templates/Makefile        # 模板 ✅
├── FEATURES.md               # 功能/接口清单
├── PROMPT.md                 # 协作提示词模板
├── CHANGELOG.md              # 版本更新内容 ✅
├── tests/                    # 隔离测试入口 ✅ v0.2.0
│   ├── edge/                 # 边缘用例 ✅ v0.2.3
│   └── Main.tex              # 主线测试
└── manual/                   # 使用手册 ✅ v0.4.0
    └── Manual.tex            # 中文手册 ✅ v0.4.1
```

## 5. 对外接口（冻结清单）

### 5.1 选项
- `shorthand`：默认开启，允许关闭速写
- `indent`：段首缩进开关
- `boxes`：是否启用盒子环境
- `refs`：是否启用引用模块
- `outputdir`：输出目录设置

### 5.2 命令
- `\img{<path>}{<caption>}`
- 文字速写：`\TX{...}`, `\TBF{...}`
- 数学速写：`\MB{...}`, `\MC{...}`, `\BS{...}`, `\Abs`

### 5.3 环境
- `definition` / `example` / `note`
- `detail` / `vital`

## 6. Box 系统（当前实现状态）

### 6.1 最小盒子集合 ✅ v0.3.0-v0.3.3
- [x] `definition` 环境（浅底 + 细边框，HypoBlue系列）
- [x] `example` 环境（浅底 + 细边框，HypoGreen系列）
- [x] `note` 环境（浅底 + 细边框，HypoBrown系列）

### 6.2 label 系统
- [x] 显式 label 参数（前缀 def:/ex:/note:）✅ v0.3.4
- [ ] ASCII 标题自动 label（计划 v0.3.6）

### 6.3 引用系统 ✅ v0.3.5
- [x] `\cref` 输出格式 "Definition: 0.1"
- [x] `\Cref` 输出格式 "Definition 0.1"
- [x] hyperref + cleveref 集成

## 7. 模块职责（当前实现状态）

### 7.1 Core ✅ v0.2.0-v0.2.3
- [x] `Hypo-Base`：kvoptions + `FinalOutputDir` ✅
- [x] `Hypo-Colors`：专业色系（浅/中/深）✅
- [x] `Hypo-Fonts`：字体策略 + 降级策略 ✅
- [x] `Hypo-Math`：数学速写（可关闭）✅

### 7.2 Modules
- [x] `Hypo-Box`：三盒子系统 ✅
- [x] `Hypo-Refs`：引用管理 ✅
- [x] `Hypo-Code`：代码模块（minted 优先 + listings fallback）✅
- [x] `Hypo-Algorithm`：算法环境（algorithm2e）✅
- [x] `Hypo-Lists`：列表增强（enumitem，最多 4 级嵌套）✅ v0.9.0
- [x] `Hypo-LitBox`：文学向盒子（poem/quotepara + InlineQuote）✅ v0.9.0

### 7.3 Classes ✅ v0.2.4
- [x] `Hypo-Note`：舒适阅读版式 ✅
- [x] `Hypo-Sheet`：紧凑/多栏版式 ✅
- [x] 统一接口：`shorthand`/`indent`/`boxes`/`refs`/`outputdir` ✅

## 8. 开发路线图（当前进度 v0.8.0）

### ✅ 已完成（v0.1.0 - v0.4.3）
- [x] `v0.1.0`：工程文档初始化 + 构建系统修复
- [x] `v0.2.0`：Fonts 骨架 + 测试框架
- [x] `v0.2.1`：Colors 色名体系
- [x] `v0.2.2`：Base 参数系统
- [x] `v0.2.3`：Math 速写系统
- [x] `v0.2.4`：双入口框架
- [x] `v0.3.0`：Definition 盒子
- [x] `v0.3.1`：Example 盒子
- [x] `v0.3.2`：专业色系重整
- [x] `v0.3.3`：Note 盒子
- [x] `v0.3.4`：显式 label 参数
- [x] `v0.3.5`：Refs 引用系统
- [x] `v0.4.0`：手册自举框架
- [x] `v0.4.1-3`：中文手册 + 代码文档整理

### 🔄 进行中/待完成
- [x] `v0.5.0`：`\img` 命令实现
- [x] `v0.6.0`：Algorithm 模块
- [x] `v0.7.0`：Code 模块
- [x] `v0.8.0`：Note 模块，将 `.sty` 更新为 `.cls` 
- [x] `v0.9.0`：文学笔记模板（LitNote）：文学向盒子 + 列表美化 + 配色体系整理 ✅
- [ ] `v0.9.5`：CHSH 模块支持（原 v0.9.0 后移）
- [ ] `v1.0.0`：正式版发布
- [ ] `v1.1.0`：ASCII 标题自动 label、注册 LABEL 相关的宏

### v0.9.0 计划：文学笔记模板（Hypo-LitNote）

> 目标：提供一份“专门为文学阅读/理解笔记”打造的入口（class + 模板），同时把列表美化能力推广到现有笔记。

#### 1) 命名策略（先冻结）
- 推荐入口名：`Hypo-LitNote`（Lit = Literature），对应 `\documentclass{Hypo-LitNote}`
- 预留后续论文入口名：`Hypo-LitPaper`（文学论文模板，字体/版式更严格）
- 复用命名原则：
  - **场景入口**用 `Hypo-<Domain><Kind>`（Domain=Lit，Kind=Note/Paper）
    - **通用能力**用 module（例如 `Hypo-Lists` / `Hypo-Margin`），避免把“写作动作”耦合进某个 class

> 目录约定（先冻结）：文学相关 class 统一放在 `sty/classes/literature/`（后续 LitPaper 也在同一目录）。

#### 2) 核心诉求拆解
1) **文学向 Box**
    - 诗词/诗行块（偏“作品原文”）：倾向使用楷体，适度留白
    - 引用/文段块（Quote）：可选楷体或宋体，带边框/底色
    - 行内引用（短诗句/引语）：希望有浅底色或轻量强调

2) **列表（itemize）美化（对所有笔记生效）**
    - 目标嵌套符号序列：黑圆点 → 空心圆 → 方块 → 三角形
    - 需要兼容嵌套 `itemize` + `enumerate`，并控制缩进与间距

3) **文学论文模板的可复用性**
    - 高复用：文学向 box、行内引语、列表美化、旁注/批注能力
    - 低复用：标题层级、目录/摘要/脚注规范、字体严格要求、行距/版心约束
    - 方案：共享 modules（LitBox/Lists/Margin），分离 class（LitNote/LitPaper）

4) **类似 `\todo` 的旁注块（可能拆分）**
    - 冻结为独立 module：`Hypo-Margin`（旁注/批注能力），避免耦合在 LitNote
    - 命名避冲突：仓库现有 Box 已使用 `note` 环境名，因此旁注能力避免再引入 `note`/`Note` 环境
    - 对外接口（先按“短名”冻结）：`\MarginNote{...}` / `\MarginTodo{...}`
    - 版本演进策略（与现有 shorthand 机制一致）：后续 release 前可统一内部实现为 `\HypoMarginNote`/`\HypoMarginTodo`，再通过一个独立的“缩写层”把短名映射出来（并允许用户关闭以规避命名冲突）
    - v0.9.0 先冻结接口与样式规范；实现可单独落在 v0.9.x

#### 3) 交付物拆分（v0.9.0）
1) 新增文学笔记 class
    - 文件：`sty/classes/literature/Hypo-LitNote.cls`
    - 基类建议：`ctexart`（与现有 Note 保持一致，降低维护成本）
    - 加载：核心能力 + Lit 相关 modules（见下）
    - 提供：标准目录、适合阅读的默认版式与字体策略（在“不破坏现有 Note 体验”的前提下）

1.5) 颜色系统整理（支撑 Lit / Tech / Simple 多主题）
    - 文件：`sty/core/Hypo-Colors.sty`
    - 目标：保留现有“基础色”（覆盖全面、向后兼容），新增多套主题色卡（国风/科技/简约）
    - 新增：可切换的语义色（如 `HypoText/HypoBackground/HypoPrimary`）与入口别名（如 `HypoNoteText/HypoNotePrimary`）
    - 接口：入口支持 `colorscheme=Base|CN|Tech|Simple`（并将旧值 `CN01..CNxx`、`Tech01..Techxx`、`Simple01..Simplexx` 作为别名归一化）
    - 演进：modules 优先消费语义色/入口别名，而不是硬编码 `HypoBlue/HypoRed`

2) 新增列表模块（全局可复用）
    - 文件：`sty/modules/Hypo-Lists.sty`
    - 依赖建议：`enumitem`
    - 对外目标：统一 itemize/enumerate 样式（四级 label 序列 + 合理的 leftmargin/itemsep/topsep）
    - 策略（先冻结）：不新造环境，采用 `enumitem` 对 `itemize`/`enumerate` 做样式层覆盖（由入口开关控制是否启用）
    - 多级规则（先冻结）：最多支持 4 级（LaTeX 原生限制）；超过 4 级不鼓励，建议改用 `enumerate`/`description` 或拆分结构
    - 对外选项（建议冻结）：`lists=true/false`（默认 true；由入口决定默认是否加载）

3) 新增文学向盒子模块（建议独立于现有 Hypo-Box）
    - 文件：`sty/modules/Hypo-LitBox.sty`
    - 依赖：复用 `tcolorbox`（仓库已在 Box 系统使用）
    - 计划提供环境（名称可再确认，但先冻结方向）：
      - `poem`：诗词/诗行块（默认楷体 `\kaishu`，支持标题/出处等字段）
      - `quotepara`：引用文段块（可选楷体/宋体，带浅底色）
    - 计划提供命令：
      - `\InlineQuote{...}`（短引语/诗句行内强调；具体命名可后续统一为 `\HypoInlineQuote`）

4) 模板（供用户直接开写）
    - 文件：`templates/LitNote.tex`（或 `templates/LitNote/Main.tex`）
    - 目标：5 分钟内可跑通并展示 poem/quote/list/todo 的最小示例

5) tests + docs
    - tests：新增 `tests/LitNote.tex`（覆盖封面/目录/poem/quote/list 嵌套）
    - docs：先更新 `FEATURES.md`（作为事实来源），再更新 `manual/Manual.tex`

#### 4) 对外接口（v0.9.0 需要冻结）
- 新入口：`\documentclass{Hypo-LitNote}`
- 选项：`lists=true/false`（是否启用列表美化；最终默认策略由入口决定）
- LitBox：至少冻结 2 个块级环境 + 1 个行内命令（名称可先用工作名，尽量避免与 LaTeX 原生命令冲突）
- 旁注 todo（若纳入 v0.9.0）：先冻结 `\todo[<opts>]{<text>}` 风格的外观与位置规则，但实现可后续拆分

### v0.8.0 计划：Hypo-Note 从 .sty 升级为 .cls（理工笔记版式）

#### 目标与约束
- 新入口：支持 `\documentclass{Hypo-Note}`（基于 `ctexart`）
- 兼容：保留 `\usepackage{Hypo-Note}` 的旧用法，不破坏历史文档
- 信息字段：默认不显示；用户显式设置后才显示
- 封面：手动 `\makecover`
- 页眉：标题 + 作者 + 章节；页脚：页码（居中）

#### 交付物拆分
1) 新增 class：`sty/classes/note/Hypo-Note.cls`
    - 基类：`ctexart`
    - 集成：`geometry`（版心）、`fancyhdr`（页眉页脚）、标准目录
    - 提供：`\makecover`（不自动触发）

2) 抽公共入口层（避免重复维护）：`sty/classes/note/Hypo-Note-Core.sty`
    - 承载当前 Hypo-Note 入口的：选项解析 + core/modules 加载逻辑

3) 兼容 wrapper：`sty/classes/note/Hypo-Note.sty`
    - 仅转发到 `Hypo-Note-Core.sty`
    - （可选）给出一次性 deprecate 提示：推荐改用 `\documentclass{Hypo-Note}`

4) 新增 icon 模块：`sty/modules/Hypo-Icon.sty`
    - 封装常用 icon（邮箱/主页/GitHub 等），底层优先用 `fontawesome5`
    - 依赖缺失时自动降级为纯文本（不报错）

5) tests 更新
    - 新增一个 class 用例（例如 `tests/ClassNote.tex`）：覆盖 `\makecover`、页眉页脚、目录
    - 继续保留现有 `tests/Main.tex`（package 入口回归）

6) manual 更新
    - 新增一节：Class 用法（`\documentclass{Hypo-Note}`）、信息字段 API、`\makecover` 示例

#### 对外接口（v0.8.0 需要冻结）
- 信息设置接口（建议 kv）：`\HypoNoteSetup{title=..., subtitle=..., author=..., email=..., ...}`
- 封面命令：`\makecover`
- icon 命令（由 Hypo-Icon 提供）：统一 `\HypoIcon{<key>}`，映射由用户维护（`\HypoIconDeclare` / `\HypoIconSetup`）

### 封面图支持（想法与计划，未实现，不急做）

#### 目标
- 在 `\makecover` 的 titlepage 内支持“封面图/Logo/背景图”三种常见形态
- 默认不启用，设置后才显示（与元数据一致）
- 对 XeLaTeX + xdvipdfmx 友好，尽量减少额外依赖

#### 设计想法（接口草案，择一落地）
1) **顶部主图（Hero）**：在标题上方插入图片
    - keys（建议）：`coverimage=path`, `coverimage-width=...`, `coverimage-vspace=...`

2) **角标 Logo**：在右上/左上放置小 Logo
    - keys（建议）：`coverlogo=path`, `coverlogo-width=...`, `coverlogo-pos=tr|tl|br|bl`

3) **整页背景图**：仅作用于封面页的 shipout 背景
    - keys（建议）：`coverbg=path`, `coverbg-opacity=...`, `coverbg-scale=...`
    - 实现建议：优先用 LaTeX shipout hooks；必要时再引入 `eso-pic` 作为兜底

#### 实施计划（后续版本）
- [ ] 1) 冻结 keys 命名（`coverimage/coverlogo/coverbg` 三选一或同时支持），并写清默认值与互斥规则
- [ ] 2) 实现 cover 内图片插入：优先用 `graphicx`（仓库已有）
- [ ] 3) （可选）实现透明度：评估 `transparent` / `tikz` 依赖，默认不开启 opacity 能力
- [ ] 4) tests：增加 `tests/` 下的封面图用例（附带一个小体积测试资源 `tests/assets/cover.pdf` 或 `cover.png`）
- [ ] 5) 文档：先更新 `FEATURES.md`（标注“规划中/未实现”），再据此更新 `manual/Manual.tex`

## 9. 当前支持的特征清单

### ✅ 已实现的核心特征
- [x] **双入口系统**: Hypo-Note / Hypo-Sheet
- [x] **速写命令**: `\TX{}`, `\TBF{}`, `\MB{}`, `\MC{}`, `\BS{}`, `\Abs`
- [x] **盒子环境**: definition, example, note
- [x] **引用系统**: `\cref` 智能引用
- [x] **颜色体系**: 专业的浅/中/深色系
- [x] **构建系统**: Makefile + TEXINPUTS 支持
- [x] **测试框架**: 主线测试 + 边缘用例
- [x] **中文手册**: 完整的自举文档

### ⚙️ 配置选项（全部可用）
- `shorthand=true/false` - 速写开关
- `indent=true/false` - 段首缩进
- `boxes=true/false` - 盒子环境开关
- `refs=true/false` - 引用系统开关
- `outputdir=...` - 输出目录设置

### 📦 模块依赖关系
```
Hypo-Note/Hypo-Sheet
    → Hypo-Base (core)
    → Hypo-Colors (core) 
    → Hypo-Fonts (core)
    → Hypo-Math (core)
    → Hypo-Box (module, 可选)
    → Hypo-Refs (module, 可选)
    → Hypo-Code (module, 可选)
    → Hypo-Algorithm (module, 可选)
```
