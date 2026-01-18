# Hypoxanthine-LaTeX Architecture & Development Plan

**Version**: `v1.0.1` (Maintenance Patch)
**Date**: 2026-01-18
**Status**: Maintenance & Release-Train Planning

---

## 1. 项目概述

Hypoxanthine-LaTeX 是一个**工程化**的 LaTeX 宏包生态系统。本项目旨在解决传统 LaTeX 模板逻辑耦合严重、样式难以复用、维护成本高昂的问题。

### 1.1 项目起源与演进

**早期问题（v0.8.x 之前）**：
- 单体式 `.sty` 文件包含所有逻辑（字体、颜色、代码、盒子全部耦合）
- 基于 `ctexart`，无法支持 `\chapter` 语义，导致大型文档结构失控
- Article 与 Book 双基底支持导致兼容性分裂，`.toc` 文件崩溃问题频发
- 多栏环境中代码块跨栏溢出，边缘测试不足

**架构重构（v0.9.0 - v0.9.3）**：
- **v0.9.0**: 完成 Core/Module 分层，移除 Article 基底支持，统一至 `ctexbook`
- **v0.9.1**: 添加 `chapterstyle`/`sectionstyle` 控制，解决中英文排版差异
- **v0.9.2**: 修复 CHSH 类多栏布局代码块溢出问题；实现 `hypocode` 单栏保护
- **v0.9.3**: 完善 Note 类语法支持（lists 选项）；添加 LitBox 文学环境

**v1.0.0 稳定版目标**：
- 接口冻结：公开 API 不再变更，遵循语义化版本控制
- 文档真值化：`FEATURES.md` 只记录已实现功能，删除所有"规划中"内容
- 工程完备性：提供 VS Code snippets、环境自检脚本、submodule 友好的模板生成工具

### 1.2 核心设计目标
1.  **架构解耦**：严格分离版式逻辑（Class）、核心能力（Core）与功能插件（Modules）。
2.  **统一接口**：通过 `Hypo-Note` (技术)、`Hypo-LitNote` (文学)、`Hypo-CHSH` (速查) 三大入口，底层复用同一套原子能力。
3.  **效率导向**：提供标准化的速写命令（Shorthand）以提升录入效率，支持全局开关。
4.  **可维护性**：接口冻结优先于实现，配置项（Colors/Fonts/Labels）单点维护。
5.  **边缘健壮性**：所有功能必须通过回归测试，包括多栏布局、TOC 生成、子模块路径等边缘场景。

## 2. 架构规范

### 2.1 设计原则
* **Interface First**：用户侧接口（Options/Commands/Environments）一旦发布即视为冻结，变更需遵循语义化版本控制。
* **Separation of Concerns**：
    * `.cls` 仅负责页面几何（Geometry）、标题格式（Titlesec）与结构（TOC）。
    * `.sty` (Core) 负责全局通用能力（字体、颜色、数学）。
    * `.sty` (Module) 负责具体功能实现，严禁侵入 Class 层。
* **DRY (Don't Repeat Yourself)**：颜色定义、Label 生成规则、Icon 映射必须在 Core 层统一定义。

#### 关键技术决策记录

**1. 为何移除 Article 基底支持？**
- 历史问题：Article 不支持 `\chapter`，导致需要维护两套 TOC 处理逻辑
- 根本原因：`.toc` 文件中 `\contentsline{chapter}` 在 Article 下无定义，引发 LaTeX 崩溃
- 解决方案：v0.9.0 统一至 `ctexbook`，在核心包中提供 `\l@chapter` 定义以确保 TOC 鲁棒性
- 迁移路径：用户若需要 Article 样式，可通过 `oneside`/`openany` 选项模拟

**2. CHSH 为何基于 Article 而非 Book？**
- 业务需求：Cheat Sheet 通常单页或极少数页，不需要章节结构
- 技术优势：Article 的节（section）作为顶层结构更适合紧凑布局
- 多栏适配：`ctexart` 与 `multicol` 配合更好，避免 Book 的奇偶页逻辑干扰

**3. 为何 minted 不是强制依赖？**
- 环境兼容性：minted 依赖 Pygments (Python)，且需要 `-shell-escape`
- 降级策略：检测失败时自动回退至 `listings`，仅输出一次警告
- 用户体验：大部分场景下 listings 已足够，避免强制环境配置

**4. 多栏环境中代码块如何处理？**
- 问题根源：`multicol` 环境中 Verbatim 类环境（如 `lstlisting`/`minted`）会跨栏溢出
- 解决方案：在 CHSH 类中为 `hypocode` 自动添加单栏保护（通过 `\par\vspace` + box 包装）
- v0.9.2 修复：将代码块临时退出多栏，渲染后再恢复，确保不跨栏

### 2.2 命名约定
* **文件命名**：统一采用 PascalCase，前缀为 `Hypo-`（如 `Hypo-Colors.sty`）。
* **环境一致性**：Linux 环境下大小写敏感，`\RequirePackage` 与文件系统路径必须严格匹配。
* **宏命名空间**：内部宏使用 `\Hypo@` 前缀，公开接口使用 `\Hypo` 前缀或语义化名称（如 `\img`）。

### 2.3 目录结构 (v1.0.0 交付标准)

```text
Hypoxanthine-LaTeX/
├── sty/
│   ├── core/                 # [原子能力层] 无版式依赖，所有类通用
│   │   ├── Hypo-Base.sty     # 基础参数(kvoptions) + 路径管理
│   │   ├── Hypo-Colors.sty   # 配色系统(Base/CN/Tech/Simple)
│   │   ├── Hypo-Fonts.sty    # 字体策略(XeCJK/fontspec)
│   │   ├── Hypo-Img.sty      # 图片命令封装(\img)
│   │   └── Hypo-Math.sty     # 数学基础 + 速写命令
│   │
│   ├── modules/              # [插件能力层] 按需加载
│   │   ├── Hypo-Box.sty      # 盒子系统(tcolorbox)
│   │   ├── Hypo-Code.sty     # 代码高亮(minted > listings)
│   │   ├── Hypo-Algorithm.sty# 算法环境(algorithm2e)
│   │   ├── Hypo-Lists.sty    # 列表美化(enumitem)
│   │   ├── Hypo-LitBox.sty   # 文学盒子(poem/quote)
│   │   ├── Hypo-Icon.sty     # 图标映射(fontawesome5)
│   │   └── Hypo-Refs.sty     # 引用系统(hyperref+cleveref)
│   │
│   └── classes/              # [场景入口层] 用户直接调用
│       ├── note/             # 技术笔记: Hypo-Note.cls (book-native)
│       ├── literature/       # 文学笔记: Hypo-LitNote.cls (book-native)
│       └── chsh/             # 速查小抄: Hypo-CHSH.cls (article-native)
│
├── make/Hypoxanthine.mk      # 构建系统核心
├── templates/                # 启动模板 (Note/LitNote/CHSH)
├── snippets/                 # VS Code snippets (latex.json)
├── scripts/                  # 环境自检脚本
├── manual/                   # 自举说明书 (Dogfooding)
├── tests/                    # 回归测试集
├── FEATURES.md               # 功能真值表
└── CHANGELOG.md              # 版本变更记录

```

## 3. 接口约定 (Frozen API v1.0.0)

### 3.1 全局配置选项

所有 Class 入口均支持以下 Key-Value 参数：

| Key | Value | Default | 说明 |
| --- | --- | --- | --- |
| `shorthand` | `true/false` | `true` | 是否启用文本与数学速写命令 |
| `indent` | `true/false` | `true` | 段首缩进开关 (*CHSH 默认为 false) |
| `boxes` | `true/false` | `true` | 是否加载定理/文学盒子模块 |
| `refs` | `true/false` | `true` | 是否加载智能引用模块 |
| `outputdir` | `<path>` | `build` | 指定中间产物目录 (供 minted 使用) |
| `colorscheme` | `Base/CN/Tech/Simple` | `Base` | 指定配色主题 |

### 3.2 核心命令集

* **图像插入**：
* `\img[width=..., label=...]{path}{caption}`：封装了 `figure` 环境、居中与 Label 生成（自动前缀 `fig:`）。


* **文本速写**：
* `\TX{...}`：普通文本。
* `\TBF{...}`：加粗文本（适配当前配色）。


* **数学速写**（需 `shorthand=true`）：
* 集合符号：`\R`, `\N`, `\Z`, `\Q`, `\C`。
* 样式封装：`\MB{...}` (mathbf), `\MC{...}` (mathcal), `\BS{...}` (boldsymbol)。
* 定界符：`\Set{...}`, `\Abs{...}`, `\Paren{...}`, `\Brack{...}`。



### 3.3 环境体系
* **技术类盒子** (Hypo-Box)：
    * `definition`, `example`, `note`。
    * 统一签名：`{title}{label}`（第 2 个参数可为空 `{}`）。
* **文学类盒子** (Hypo-LitBox)：
    * `poem` (诗歌), `quotepara` (引用段落), `\InlineQuote` (行内引用)。
* **代码与算法**：
    * `hypocode` (代码块), `algorithm` (伪代码)。
* **结构控制**：
    * `detail` (细节/折叠), `vital` (重点强调)。

## 4. 交付组件清单 (v1.0.0 Status)

### 4.1 场景入口 (Classes)

#### `Hypo-Note`

* **基底**：`ctexbook`
* **定位**：标准理工科笔记、技术文档。
* **特性**：
    * 默认启用 `chapterstyle=en` (编号 "1.")。
    * 完整支持页眉页脚与目录结构。
    * 集成 `Hypo-Box` (Def/Ex/Note) 与 `Hypo-Code`。



#### `Hypo-LitNote`

* **基底**：`ctexbook`
* **定位**：人文社科笔记、阅读记录。
* **特性**：
    * 默认启用 `chapterstyle=cn` (编号 "一、")。
    * 默认启用 `sectionstyle=outline` (隐藏 "1.1" 编号)。
    * 加载 `Hypo-LitBox` (诗歌/引用) 与 `Hypo-Lists` (列表美化)。



#### `Hypo-CHSH`

* **基底**：`ctexart`
* **定位**：高密度速查表、Cheat Sheet。
* **特性**：
    * **面积锁定**：支持 `paperarea=a4` + `areascale=<num>`，确保缩放打印时字号密度一致。
    * **自动多栏**：默认 3 栏布局，支持 `\CHSHColumnBreak`。
    * **紧凑布局**：强制压缩行距、列表间距与标题留白；代码块默认无行号。



### 4.2 核心模块 (Modules)

* **Hypo-Colors**: 提供 `Base` (通用), `CN` (国风), `Tech` (深蓝), `Simple` (黑白) 四套色系，并暴露语义化颜色接口（如 `HypoEmph`）。
* **Hypo-Code**: 实现后端自动降级策略。检测 `-shell-escape`：开启则使用 `minted` (Pygments)，否则回退至 `listings` 并发出警告。
* **Hypo-Icon**: 封装 `fontawesome5`。提供 `\HypoIcon{github}` 等抽象接口，解耦具体字体依赖。
* **Hypo-Refs**: 集成 `cleveref`。实现自动化引用前缀（如 "Definition 1.1", "Fig 2"）。

## 5. 演进路线图 (Roadmap)

### Release Train 规则（后续版本分组推送）

从 v1.0.1 起，Roadmap 按“版本组（train）”组织：
- 每个 minor 版本（例如 v1.1.0）作为一个 train 的顶层目标与对外叙事。
- train 内允许出现多个 patch 版本（例如 v1.0.1 / v1.0.2 / ...），它们以“小步、安全、可回滚”为原则推进。
- 发布节奏：优先完成一组 patch（文档/修复/小增强）并验证通过后，再整体推进到对应的 minor 版本交付。

### v1.0.0 (Current Stable)

* [x] **架构冻结**：完成 Note/LitNote/CHSH 三大 Class 的接口固化。
* [x] **文档交付**：`manual/` 自举文档完成，`FEATURES.md` 作为单一事实来源。
* [x] **工程套件**：Makefile 构建流、VS Code Snippets、环境自检脚本已就绪。
* [x] **测试通过**：核心功能与边缘用例 (Edge Cases) 回归测试通过。

### v1.1.0 (Planned)

#### v1.0.1 (Maintenance Patch, in v1.1.0 train)

* [x] **Math/physics 固化**：Hypo-Math 在检测到 `physics.sty` 时加载 physics，并固定默认 options（`trig,uprightdiff,bolddel`）。
* [x] **可配置钩子**：提供 `\HypoPhysicsOptions` 覆盖 physics options（需在加载 Hypo-Math 前定义）。
* [x] **文档补齐**：Manual 增加 physics 速查小节，并保证缺包时仍可编译。

* [ ] **Label 增强**：支持 ASCII 标题自动转 Label (例如 `\section{Introduction}` -> `sec:introduction`)。
* [ ] **封面图支持**：在 `\makecover` 中增加 Hero Image / Logo / Background 的标准接口。
* [ ] **新入口 Hypo-LitPaper**：针对更严格的文学论文排版需求，提供独立的 Class（基于 `ctexart` 或 `ctexbook` 的严格子集）。

### v1.x (Long Term)

* [ ] **Web Support**：探索基于 `tex4ht` 或 `pandoc` 的 HTML 导出适配。
* [ ] **LSP Integration**：为 TexLab 提供专属的补全配置。

---

## 6. 构建系统与工程工具

### 6.1 Makefile 构建核心

**核心文件**：`make/Hypoxanthine.mk`

**关键机制**：
```makefile
# 自动注入 TEXINPUTS，确保 TeX 能找到 sty// 目录
export TEXINPUTS := .:$(HYPO_PATH)/sty//:

# 支持 minted 的 shell-escape 开关
ifdef SHELL_ESCAPE
    LATEXMK_FLAGS += -shell-escape
endif
```

**使用方法**：
```bash
# 标准构建（无 minted 高亮）
make

# 启用 minted（需要 Python + Pygments）
make SHELL_ESCAPE=1

# 清理中间文件
make clean
```

### 6.2 子模块（Submodule）工作流

**问题背景**：
当 Hypoxanthine-LaTeX 作为 Git submodule 引入到外部项目时，TeX 默认无法找到 `sty//` 目录。

**解决方案**：
```makefile
# 外部项目 Makefile 示例
HYPO_PATH := $(PWD)/Hypoxanthine-LaTeX
export TEXINPUTS := .:$(HYPO_PATH)/sty//:

include $(HYPO_PATH)/make/Hypoxanthine.mk
```

**scripts/hypo 工具**：
```bash
# 环境自检（检测 latexmk, xelatex, minted, pygmentize）
./scripts/hypo doctor

# 生成启动模板（支持自定义 HYPO_PATH）
./scripts/hypo template --type note --output MyNote --hypo-path ../Hypoxanthine-LaTeX
```

### 6.3 VS Code 开发支持

**snippets 文件**：`snippets/hypoxanthine-latex.code-snippets`

**核心 snippets**：
- `hypo-note`: Hypo-Note 文档骨架
- `hypo-litnote`: Hypo-LitNote 文档骨架
- `hypo-chsh`: Hypo-CHSH 文档骨架
- `hypo-def`: definition 环境
- `hypo-code`: hypocode 环境
- `hypo-img`: `\img` 命令
- `hypo-poem`: poem 环境

---

## 7. 已知问题与限制

### 7.1 技术债务

**1. TOC 文件兼容性问题（已缓解）**
- **现象**：早期版本在 Article 与 Book 基底切换时 `.toc` 文件崩溃
- **根因**：`\contentsline{chapter}` 在 Article 下未定义
- **当前方案**：v0.9.0 后统一至 Book 基底，并在核心包提前定义 `\l@chapter`
- **残留风险**：用户手动修改 `.toc` 文件可能导致意外错误

**2. minted 路径问题**
- **现象**：`outputdir` 与 `-output-directory` 不一致时，minted 生成的缓存文件位置错误
- **根因**：latexmk 的 `-outdir` 与 minted 的 `outputdir` 选项语义不同
- **当前方案**：统一使用 `outputdir=build`，并在 Makefile 确保一致性
- **已知限制**：不支持嵌套构建目录（如 `build/sub/`）

**3. 字体回退策略**
- **现象**：Fandol 字体在某些系统上缺失 CJK Script 定义，产生警告
- **影响范围**：仅警告，不影响编译
- **根因**：Fandol 字体元数据不完整
- **当前方案**：优先使用 LXGW WenKai，Fandol 作为最后降级

### 7.2 平台差异

**Windows 路径问题**：
- `TEXINPUTS` 路径分隔符在 Windows 下为 `;`，Linux/macOS 为 `:`
- **规避方法**：使用 latexmk 的 `-output-directory` 而非环境变量

**换行符问题**：
- Windows 的 CRLF 换行符可能导致某些 TeX 宏在字符串匹配时失败
- **建议**：统一使用 LF 换行符（Git 配置 `autocrlf=input`）

### 7.3 第三方包冲突

已知冲突的宏包：
- `physics`：与 `\Set`, `\Abs` 等速写命令冲突 → 禁用 `shorthand=false`
- `beamer`：与 `ctexbook` 基底不兼容 → 不支持 Beamer 场景
- `listings` 语言定义：部分语言名称映射可能与用户自定义冲突

---

## 8. 测试与质量保障

### 8.1 回归测试集

**位置**：`tests/` 目录

**测试用例**：
1. **Main.tex**：Hypo-Note 核心功能综合测试
   - 章节结构（chapter/section/subsection）
   - 定理盒子（definition/example/note）
   - 代码高亮（hypocode，多语言）
   - 图片插入（`\img`）
   - 数学速写（`\R`, `\Set`, `\MB` 等）

2. **LitNote.tex**：Hypo-LitNote 特性测试
   - 中文章节编号（第一章、一、）
   - sectionstyle=outline 行为
   - 文学盒子（poem, quotepara, InlineQuote）

3. **CHSH.tex**：Hypo-CHSH 多栏布局测试
   - 代码块单栏保护
   - 行号默认关闭
   - 紧凑排版效果

4. **边缘用例**（`tests/edge/`）：
   - `BoxesOff.tex`：测试 `boxes=false` 时的降级行为
   - `ShorthandOff.tex`：测试 `shorthand=false` 时的速写命令禁用

**执行方法**：
```bash
cd tests/
make all  # 构建所有测试用例
make clean  # 清理中间文件
```

**通过标准**：
- 所有 PDF 成功生成
- 无 LaTeX Error（允许 Warning）
- 输出效果符合预期（人工检查）

---

## 9. 贡献指南

### 9.1 开发流程

1. **Feature Branch**：从 `main` 创建功能分支（如 `feature/new-colorscheme`）
2. **小步提交**：每个 commit 只做一件事，message 遵循 Conventional Commits
3. **测试先行**：在 `tests/` 添加对应的回归测试用例
4. **文档同步**：更新 `FEATURES.md` 和 `CHANGELOG.md`
5. **代码审查**：提交 Pull Request，至少一人 Review 后合并

### 9.2 Commit Message 规范

```
<type>(<scope>): <subject>
```

**type 类型**：
- `feat`: 新功能（触发 minor 版本号）
- `fix`: Bug 修复（触发 patch 版本号）
- `docs`: 仅文档修改
- `refactor`: 重构（不改变外部行为）
- `test`: 添加测试
- `chore`: 构建/工具链修改

**scope 范围**：
- `core`: Core 层修改（Hypo-Base/Colors/Fonts/Math/Img）
- `module`: Module 层修改（Hypo-Box/Code/Refs 等）
- `class`: Class 层修改（Hypo-Note/LitNote/CHSH）
- `build`: 构建系统修改（Makefile/scripts）

**示例**：
```
feat(module): add Hypo-Table module for complex table layouts

Implements a new module for creating publication-quality tables
with automatic row/column styling and multirow/multicolumn support.

Closes #42
```

### 9.3 版本发布流程

1. **版本号规则**：遵循语义化版本 `MAJOR.MINOR.PATCH`
   - `MAJOR`: 不兼容的 API 变更
   - `MINOR`: 向后兼容的新功能
   - `PATCH`: 向后兼容的 Bug 修复

2. **发布检查清单**：
   - [ ] 回归测试全部通过
   - [ ] `FEATURES.md` 与实现一致
   - [ ] `CHANGELOG.md` 已更新
   - [ ] 版本号已更新（所有 `.cls/.sty` 文件的 `\ProvidesPackage` 行）
   - [ ] Git tag 已创建（如 `v1.0.0`）