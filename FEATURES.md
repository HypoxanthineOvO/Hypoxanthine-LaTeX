# Hypoxanthine-LaTeX 功能清单（简述版）

这份文档只记录“现有能力与接口”，不追求排版效果。
后续生成 manual 时，以本文件为唯一事实来源（manual 会更正式、更完整）。

## 入口（Classes）
- Hypo-Note：笔记入口（版式偏舒适阅读）
- Hypo-Sheet：小抄入口（版式偏紧凑/多栏）
- 目标：两者导出的命令/环境尽量一致，切换入口时正文无需大改。

当前状态：已提供入口骨架（可加载 core 能力与统一选项）。

## 全局选项（拟定）
- indent=true/false：控制段首缩进策略（两入口一致）
- boxes=true/false：是否启用盒子环境（两入口一致，默认开启）
- outputdir=...：给 minted 等模块使用的输出目录（由 Hypo-Base 导出）

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

## 图片命令
- \img{<path>}{<caption>}：插图（sheet 下宽度自适应栏宽；note 下可用较宽比例）

## 内容层级（拟定）
- detail 环境：sheet 下默认隐藏；note 下显示（样式可后定）
- vital 环境：强调重点（两入口一致）

## 盒子（当前最小集）
- definition：定义盒子（v0.3.0 起可用）
- example：例子盒子
- note：笔记/提示盒子

### 盒子标题与 label
- 盒子支持“标题”（例如 Definition 的名字）
- label 规则（用于后续 cref/引用）：
  - 优先使用你显式提供的 label（推荐用于中文标题）
  - 若未提供 label：标题为 ASCII 时自动生成（例如 "Lemma Of Math" -> "lemma_of_math"）
  - 中文/非 ASCII：默认不自动生成 label（避免 hash 难以记忆导致无法方便引用）；可选增强再讨论

## 引用与链接（拟定）
- hyperref + cleveref：统一由注册宏机制接入
- box 定义时注册 cref 名称，避免手动同步维护映射表
