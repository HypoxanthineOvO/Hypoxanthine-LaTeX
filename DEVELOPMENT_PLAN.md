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
- [ ] `Hypo-Lists`：列表增强（计划）

### 7.3 Classes ✅ v0.2.4
- [x] `Hypo-Note`：舒适阅读版式 ✅
- [x] `Hypo-Sheet`：紧凑/多栏版式 ✅
- [x] 统一接口：`shorthand`/`indent`/`boxes`/`refs`/`outputdir` ✅

## 8. 开发路线图（当前进度 v0.7.0）

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
- [ ] `v0.8.0`：Note 模块，将 `.sty` 更新为 `.cls` 
- [ ] `v0.9.0`：CHSH 模块支持
- [ ] `v1.0.0`：正式版发布
- [ ] `v1.1.0`：ASCII 标题自动 label、注册 LABEL 相关的宏

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

## 10. Release Checklist（v0.5.0–v0.7.0）
- [ ] 更新文档：manual/FEATURES/README 对齐（含 minted/fallback 说明）
- [ ] 更新 CHANGELOG：补齐 v0.5.0/v0.6.0/v0.7.0 的发布日期与条目
- [ ] 验证：`make -C tests`、`make -C manual`（可选 `SHELL_ESCAPE=1` 再跑一次）
- [ ] 打 Tag：`git tag -a v0.5.0`、`v0.6.0`、`v0.7.0`
- [ ] 推送：`git push --tags`（如需要发布到远端）