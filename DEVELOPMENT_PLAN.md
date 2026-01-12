# Hypoxanthine-LaTeX 开发计划书（Draft）

## 🧩 更新提示词（Prompt Template）

把你新增/修改的需求（例如：新增 Block、调整现有 Block 配置与颜色、增加 Snippets、调整目录结构等）直接粘贴在下面分隔线之后，然后对我说“按计划书更新”。

要求：
- 先更新本计划书里对应章节（结构/规范/里程碑/任务清单）。
- 只在你明确要求时才开始改代码/加文件；否则只输出“需要改哪些文件、怎么改”的清单。
- 修复时优先处理：大小写/路径可用性、构建系统可运行、文档示例可编译。
- 任何命名变更必须同时更新引用点（README、Makefile、\RequirePackage 路径等）。

---
（在此粘贴你的新需求）


## 1. 一句话目标（你真正想要的体验）

你要的是一个“可工程化维护”的 LaTeX 生态：
- 入口分为 **Hypo-Note / Hypo-Sheet** 两套，但 **接口语法尽量一致**，切换时“尽量只改引入文件”。
- 常用写作动作用速写命令提升效率，且可开关。
- Box/样式可扩展但不失控：先做最小集，后续增量扩展。


## 2. 关键原则（防止计划书越写越乱）

1) **接口冻结优先于实现**：先把“我写文档会用哪些命令/环境”冻结，再动代码。

2) **Class 管版式，Core 管能力，Module 管插件**：
- geometry/titlesec/fancyhdr/multicol/tocloft 永远放 class。
- 字体/颜色/数学基础永远放 core。
- minted/algorithm2e/hyperref/cleveref/enumitem 这类按需能力放 modules。

3) **一处定义，多处复用**：颜色、速写、label 规则、cref 注册都必须单点维护。


## 3. 命名与兼容性（已确认）

- 统一采用 `Hypo-*.sty`（`*` 首字母大写）。
- Linux 大小写敏感：文件名与 `\\RequirePackage` / Makefile include 必须严格一致。
- 允许“兼容入口文件”（薄 wrapper）来缓冲重命名/迁移，但 wrapper 只能转发，不得重复实现逻辑。


## 4. 目标结构（V1.x）

```text
Hypoxanthine-LaTeX/
├── sty/
│   ├── core/                 # 原子能力（无版式）
│   ├── modules/              # 插件能力（按需加载）
│   └── classes/              # 场景入口（定义版式与对外接口）
│       ├── note/Hypo-Note.sty
│       └── sheet/Hypo-Sheet.sty
├── make/Hypoxanthine.mk
├── templates/Makefile
├── FEATURES.md               # 功能/接口清单（简述版，事实来源）
├── PROMPT.md                 # 协作提示词模板
├── CHANGELOG.md              # 版本更新内容（面向使用者）
├── tests/                    # 隔离测试入口（corner cases，不污染 manual）
└── manual/                   # 后续再生成（从 FEATURES.md 出发）
```


## 5. 对外接口（冻结清单，切入口不改正文的关键）

### 5.1 两个入口必须共同导出

- 选项：
  - `shorthand`：**默认开启**，允许 `shorthand=false` 关闭（用于排查冲突/兼容其他包）。
    - 实现约定：入口内部通过预先定义 `\HypoDisableShorthand` 来关闭 Hypo-Math 内置速写（不单独拆分 Shorthand 包）。
  - `indent`：段首缩进开关（`true/false`，两入口一致）。
  - `outputdir`：给 minted 等使用（由 core 导出）。

- 命令（第一批冻结）：
  - `\\img{<path>}{<caption>}`
  - 速写：文字类 + 数学字母类（见 5.2）

- 环境（第一批冻结）：
  - `definition` / `example` / `note`
  - `detail` / `vital`

### 5.2 速写（默认开启）

- 文字速写：`\\TX{...}` = `\\text{...}`，`\\TBF{...}` = `\\textbf{...}`。
- 数学速写：你明确更需要 `\\mathbf/\\mathcal` 这类，而不是数集符号。
  - 建议第一批：`\\MB{...}` = `\\mathbf{...}`，`\\MC{...}` = `\\mathcal{...}`，`\\BS{...}` = `\\boldsymbol{...}`。
  - `\\Abs` 保留。
- 约束：速写必须可关闭；命名要尽量避开常见冲突（例如 `\\T` 很短，未来如遇冲突优先提供替代名并在 FEATURES 记录）。


## 6. Box 系统（先做最小集 + 自动 label + cref 注册）

### 6.1 最小盒子集合（已确认）

- 仅实现：`definition`、`example`、`note`。
- 其他 theorem/lemma/claim 等后续按需加（不提前预埋大段样式）。

### 6.2 自动 label（从标题推导）

- 目标：标题“Lemma Of Math” → label `lemma_of_math`。
- 规则：
  - 若用户显式提供 `label` 参数：优先使用该参数（用于稳定 cref）。
  - 否则，标题为 ASCII 且可归一化：小写 + 空格转 `_` + 去掉不安全字符。
  - 否则（中文等非 ASCII）：**默认不自动生成 label**（因为 hash 虽可用但不可记忆，用户无法方便地 `\\cref`）。
    - 可选增强：提供 `autolabel=hash` 模式时再启用 hash 兜底。
    - 中文拼音/首字母：后续如确有刚需再评估引入可选依赖。

### 6.3 Box 与 Refs 的连接方式（避免联动修改）

- 引入“注册宏”桥接：例如 `\\HypoRegisterCref{definition}{定义}{定义}`。
- Box 文件只负责调用注册宏；Refs 模块负责实现注册宏到 `\\crefname`。
- 若未加载 Refs 模块：注册宏应为 no-op（不报错）。


## 7. 模块职责（拆分依据：你的集成文件）

### 7.1 Core
- `Hypo-Base`：kvoptions + `FinalOutputDir`。
- `Hypo-Colors`：项目色名统一来源（禁止各处重复 `\\definecolor{MyRed...}`）。
- `Hypo-Fonts`：字体策略；`fontset` 后续要么做 preset，要么删除。
- `Hypo-Math`：数学基础 + `\\Abs` +（可选）成对定界符；不要在 class 里重复定义。

### 7.2 Modules
- `Hypo-Code`：minted 配置（需要 `-shell-escape`，策略在构建层/文档中明确）。
- 其他模块（refs/lists/content/cover）先写规范、后按需实现。

### 7.3 Classes
- `Hypo-Note`：舒适阅读版式。
- `Hypo-Sheet`：紧凑/多栏版式。
- 两者共享同一套对外接口（第 5 节冻结清单），差异只在 layout 与密度。


## 8. 路线图（更可执行的版本）

### V0.2：入口 + 接口冻结
- 建立 `Hypo-Note` / `Hypo-Sheet` 两个入口文件（哪怕内部先简单转发）。
- 冻结 FEATURES 中的接口（速写默认开启、最小盒子集、indent 开关、img/detail/vital）。

### V0.3：Box 最小集落地
- definition/example/note 三个盒子 + 自动 label + cref 注册宏。

### V0.4：文档自举
- manual 最小示例能编译，覆盖：速写、盒子、图片、引用/链接（若启用）。


## 8.1 测试策略（你问“在哪里测试”）

- **默认测试场**：`manual/`（Dogfooding / 集成测试）。
  - 优点：始终用你自己的包写你自己的文档，最能暴露接口不一致问题。
  - 命令：`make -C manual`。
- **是否需要单独 tests/ 文件夹？**
  - 可选，但不是必须。若你希望更“单元化”的最小用例（只测 Fonts、只测 Shorthand、只测 Boxes），可以建 `tests/` 放一组极小 `.tex`。
  - 建议：测试输入（`.tex`）纳入版本控制；产物目录（例如 `tests/build/`）不纳入。
- **ignore 策略**：目前 `.gitignore` 已忽略 `build/` 与各类 LaTeX 中间文件；因此 `manual/build/`、`tests/build/` 都会自动被忽略。


## 8.2 建议 Tag / Version（支持你“边做边发”）

下面按“最小可测 + 小步提交”的粒度给出建议 tag，你可以按实际进度微调：

- `v0.2.0`：Step A（Fonts 最小可编译骨架）
- `v0.2.1`：Step B（Colors 色名体系）
- `v0.2.2`：Step C（Base：参数与 `FinalOutputDir`）
- `v0.2.3`：Step D（Shorthand：默认开启 + 可关闭；`\TX/\TBF/\MB/\MC/\BS/\Abs`）
- `v0.2.4`：Step E（两个入口文件 `Hypo-Note/Hypo-Sheet`：先转发/组织加载，接口一致）
- `v0.3.0`：Step F（Definition 盒子最小落地）
- `v0.3.1`：Step G（Example + Note 盒子补齐）
- `v0.3.2`：Step H（显式 `label=...` 参数 + 可引用）
- `v0.3.3`：Step I（ASCII 标题自动 label）
- `v0.4.0`：Step J（Refs 注册宏接入：box 改动不联动 refs）


## 9. 任务清单（按优先级）

P0（阻塞可用性）：
- 修复 `\\RequirePackage` 路径/大小写不一致（尤其 core 内部互相引用）。
- 明确 minted 的 `-shell-escape` 策略（默认开启 vs 按需开启）。
- README/模板/实际文件路径三者对齐。

P1（接口闭环）：
- 先把 [FEATURES.md](FEATURES.md) 作为“接口事实来源”写全（你现在就在做这个）。
- 再把接口映射到 `Hypo-Note/Hypo-Sheet`（实现可以后置）。


## 10. 文档工作流（你提出的双轨）

- `FEATURES.md`：只写简述与接口（你维护，我协助整理）。
- manual：当你把 `FEATURES.md` 发给我时，我据此生成更正式的 manual（章节化、示例更完整）。


## 附录 A：当前仓库现状（2026-01-12）

- 已有：`sty/core/`（Base/Colors/Fonts/Math）、`sty/modules/Hypo-Code.sty`、`make/Hypoxanthine.mk`、`templates/Makefile`。
- 缺失：`sty/classes/note/Hypo-Note.sty`、`sty/classes/sheet/Hypo-Sheet.sty`、manual 入口与示例。

