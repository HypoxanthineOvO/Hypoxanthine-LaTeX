# Hypoxanthine-LaTeX Architecture / 架构文档

本文档描述 Hypoxanthine-LaTeX 的架构设计和工程实践。

This document describes the architecture and engineering practices of Hypoxanthine-LaTeX.

---

## Overview / 概述

Hypoxanthine-LaTeX is a modular LaTeX framework with a three-layer architecture:
Hypoxanthine-LaTeX 是一个三层架构的模块化 LaTeX 框架：

```
┌─────────────────────────────────────┐
│      Classes (场景层)               │  User Entry Points
│  Hypo-Note, Hypo-CHSH, etc.       │  用户直接调用
├───────���─────────────────────────────┤
│     Modules (组件层)               │  Feature Plugins
│  Hypo-Box, Hypo-Code, etc.        │  按需加载功能
├─────────────────────────────────────┤
│      Core (原子层)                │  Atomic Capabilities
│  Colors, Fonts, Math, etc.        │  通用基础能力
└─────────────────────────────────────┘
```

---

## Design Principles / 设计原则

### 1. Interface First / 接口优先

User-facing interfaces (Options/Commands/Environments) are frozen once released.
用户侧接口（选项/命令/环境）一旦发布即视为冻结。

- Changes follow Semantic Versioning
- 变更遵循语义化版本控制
- API stability prioritized over implementation details
- API 稳定性优先于实现细节

### 2. Separation of Concerns / 关注点分离

**Classes (.cls)**:
- Page geometry (geometry)
- Title formatting (titlesec)
- Structure (TOC)

**Core (.sty - core/)**:
- Global common capabilities (fonts, colors, math)
- No layout dependencies
- 无版式依赖

**Modules (.sty - modules/)**:
- Specific feature implementations
- No class layer intrusion
- 具体功能实现，不侵入 Class 层

### 3. DRY (Don't Repeat Yourself)

- Color definitions single-sourced in `Hypo-Colors`
- 颜色定义在 `Hypo-Colors` 中统一定义
- Label generation rules centralized
- Label 生成规则集中管理
- Icon mappings in one place
- 图标映射单点维护

---

## Directory Structure / 目录结构

```
Hypoxanthine-LaTeX/
├── sty/
│   ├── core/                 # [Atomic Layer] 无版式依赖
│   │   ├── Hypo-Base.sty     # 基础参数 + 路径管理
│   │   ├── Hypo-Colors.sty   # 配色系统
│   │   ├── Hypo-Fonts.sty    # 字体策略
│   │   ├── Hypo-Img.sty      # 图片命令
│   │   └── Hypo-Math.sty     # 数学基础 + 速写
│   │
│   ├── modules/              # [Plugin Layer] 按需加载
│   │   ├── Hypo-Box.sty      # 盒子系统 (tcolorbox)
│   │   ├── Hypo-Code.sty     # 代码高亮 (minted > listings)
│   │   ├── Hypo-Icon.sty     # 图标映射 (fontawesome5)
│   │   ├── Hypo-Refs.sty     # 引用系统 (hyperref+cleveref)
│   │   └── ...
│   │
│   └── classes/              # [Scenario Layer] 场景入口
│       ├── note/             # Hypo-Note.cls
│       ├── literature/       # Hypo-LitNote.cls
│       ├── chsh/             # Hypo-CHSH.cls
│       └── slide/            # Hypo-Slide.cls
│           └── themes/       # Slide themes
│
├── make/Hypoxanthine.mk       # 构建系统核心
├── templates/                # 启动模板
├── snippets/                 # VS Code snippets
├── scripts/                  # 环境脚本
├── manual/                   # 自举文档
├── tests/                    # 回归测试
├── FEATURES.md               # 功能真值表
└── CHANGELOG.md              # 版本变更
```

---

## Key Decisions / 关键决策

### Why Unified to Book Base? / 为何统一至 Book 基底？

**Problem (历史问题)**:
- Article doesn't support `\chapter`
- Article + Book dual-support caused .toc file crashes
- Article 不支持 `\chapter`
- Article 与 Book 双支持导致 .toc 文件崩溃

**Solution (解决方案)**:
- v0.9.0: Unified to `ctexbook` base
- v0.9.0：统一至 `ctexbook` 基底
- Define `\l@chapter` in core for TOC robustness
- 在核心包中定义 `\l@chapter` 确保 TOC 鲁棒性

### Why CHSH Uses Article Base? / CHSH 为何用 Article？

**Reasons (原因)**:
- Cheat sheets are usually single-page, no chapter structure needed
- 速查表通常单页，不需要章节结构
- Article's section as top-level structure suits compact layout
- Article 的节作为顶层结构更适合紧凑布局
- `multicol` works better with article, avoids book's odd/even page logic
- `multicol` 与 article 配合更好，避免 book 的奇偶页逻辑

### Minted vs Listings? / minted 还是 listings？

**Strategy (策略)**:
- Detect `-shell-escape` availability
- 检测 `-shell-escape` 可用性
- If available: use `minted` (Pygments)
- 可用：使用 `minted`
- If not: fallback to `listings` with warning
- 不可用：回退到 `listings` 并警告
- Avoids forcing environment configuration
- 避免强制环境配置

### Multi-column Code Block Handling / 多栏代码块处理

**Problem**:
- `multicol` environment causes verbatim environments to overflow
- `multicol` 环境导致 verbatim 类环境跨栏溢出

**Solution**:
- In CHSH class: auto single-column protection for `hypocode`
- 在 CHSH 类中为 `hypocode` 自动添加单栏保护
- Temporarily exit multi-column, render, then restore
- 临时退出多栏，渲染后恢复

---

## Naming Conventions / 命名约定

### File Naming / 文件命名

- PascalCase with `Hypo-` prefix
- PascalCase + `Hypo-` 前缀
- Example: `Hypo-Colors.sty`, `Hypo-Box.sty`
- Linux is case-sensitive - must match filesystem exactly
- Linux 大小写敏感，必须与文件系统严格匹配

### Macro Namespace / 宏命名空间

- Internal macros: `\Hypo@...` prefix
- 内部宏：`\Hypo@...` 前缀
- Public interfaces: `\Hypo...` or semantic names
- 公开接口：`\Hypo...` 或语义化名称

---

## Version Control / 版本控制

### Semantic Versioning / 语义化版本

```
MAJOR.MINOR.PATCH
```

- **MAJOR**: Incompatible API changes
  不兼容的 API 变更
- **MINOR**: Backward-compatible new features
  向后兼容的新功能
- **PATCH**: Backward-compatible bug fixes
  向后兼容的 Bug 修复

### Release Process / 发布流程

Pre-release checklist:
发布前检查清单：

- [ ] All regression tests pass
  所有回归测试通过
- [ ] `FEATURES.md` matches implementation
  `FEATURES.md` 与实现一致
- [ ] `CHANGELOG.md` updated
  `CHANGELOG.md` 已更新
- [ ] Version numbers updated in all .cls/.sty files
  所有 .cls/.sty 文件版本号已更新
- [ ] Git tag created
  Git tag 已创建

---

## Build System / 构建系统

### Makefile Core / Makefile 核心

**Location**: `make/Hypoxanthine.mk`

**Key Mechanisms**:
```makefile
# Auto-inject TEXINPUTS for TeX to find sty// directory
export TEXINPUTS := .:$(HYPO_PATH)/sty//:

# Support minted's shell-escape switch
ifdef SHELL_ESCAPE
    LATEXMK_FLAGS += -shell-escape
endif
```

### Submodule Workflow / 子模块工作流

**Problem**: When used as git submodule, TeX can't find `sty//` by default.
**问题**: 作为 git submodule 使用时，TeX 默认找不到 `sty//`。

**Solution**:
```makefile
# External project Makefile
HYPO_PATH := $(PWD)/Hypoxanthine-LaTeX
export TEXINPUTS := .:$(HYPO_PATH)/sty//:

include $(HYPO_PATH)/make/Hypoxanthine.mk
```

---

## Testing / 测试

### Regression Tests / 回归测试

**Location**: `tests/` directory

**Test Cases**:
1. **Main.tex**: Hypo-Note core functionality
2. **LitNote.tex**: Hypo-LitNote features
3. **CHSH.tex**: Hypo-CHSH multi-column layout
4. **Edge cases**: `tests/edge/BoxesOff.tex`, `ShorthandOff.tex`

**Execution**:
```bash
cd tests/
make all    # Build all test cases
make clean  # Clean intermediate files
```

**Pass Criteria**:
- All PDFs generated successfully
  所有 PDF 成功生成
- No LaTeX Errors (Warnings allowed)
  无 LaTeX Error（Warning 允许）
- Output matches expectations (manual check)
  输出符合预期（人工检查）

---

## Platform Differences / 平台差异

### Windows Path Separator / Windows 路径分隔符

**Issue**: `TEXINPUTS` separator is `;` on Windows, `:` on Linux/macOS
**问题**: Windows 上 `TEXINPUTS` 分隔符是 `;`，Linux/macOS 是 `:`

**Workaround**: Use latexmk's `-output-directory` instead of env vars
**规避方法**: 使用 latexmk 的 `-output-directory` 而非环境变量

### Line Endings / 换行符

**Issue**: Windows CRLF may cause TeX string matching failures
**问题**: Windows CRLF 可能导致 TeX 字符串匹配失败

**Recommendation**: Use LF line endings (Git config `autocrlf=input`)
**建议**: 统一使用 LF 换行符（Git 配置 `autocrlf=input`）

---

## Known Limitations / 已知限制

### Package Conflicts / 包冲突

Known conflicting packages:
已知冲突的包：

- `physics`: Conflicts with `\Set`, `\Abs` shorthand → use `shorthand=false`
  与 `\Set`, `\Abs` 速写冲突 → 使用 `shorthand=false`
- `beamer`: Not compatible with `ctexbook` base → no Beamer scenario support
  与 `ctexbook` 基底不兼容 → 不支持 Beamer 场景
- `listings`: Some language name mappings may conflict with user definitions
  部分语言名称映射可能与用户定义冲突

### Font Fallback / 字体回退

**Issue**: Fandol fonts missing CJK script definitions on some systems
**问题**: Fandol 字体在某些系统缺失 CJK Script 定义

**Impact**: Warning only, doesn't affect compilation
**影响**: 仅警告，不影响编译

**Current**: Fandol as last-resort fallback
**当前方案**: Fandol 作为最后降级选项

---

## Contribution Guidelines / 贡献指南

### Commit Message Format / Commit 消息格式

```
<type>(<scope>): <subject>
```

**Types**:
- `feat`: New feature (triggers MINOR version)
  新功能（触发 MINOR 版本）
- `fix`: Bug fix (triggers PATCH version)
  Bug 修复（触发 PATCH 版本）
- `docs`: Documentation only
  仅文档修改
- `refactor`: Refactoring (no behavior change)
  重构（不改变行为）
- `test`: Add tests
  添加测试
- `chore`: Build/tooling changes
  构建/工具链修改

**Scopes**:
- `core`: Core layer modifications
  Core 层修改
- `module`: Module layer modifications
  Module 层修改
- `class`: Class layer modifications
  Class 层修改
- `build`: Build system modifications
  构建系统修改

**Example**:
```
feat(module): add Hypo-Table module for complex table layouts

Implements a new module for creating publication-quality tables
with automatic row/column styling and multirow/multicolumn support.

Closes #42
```

---

## References / 参考

- **User Manual**: `manual/Manual.pdf`
- **AI Context**: `FEATURES.md`
- **Development Plan**: `DEVELOPMENT_PLAN.md`
- **Change History**: `CHANGELOG.md`
