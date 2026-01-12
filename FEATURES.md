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
- refs=true/false：是否启用引用模块（hyperref + cleveref，两入口一致，默认开启）
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

## 图片命令（计划）
- \img{<path>}{<caption>}：插图快捷命令（尚未实现，拟在 v0.5+ 完成）

## 内容层级（拟定）
- detail 环境：sheet 下默认隐藏；note 下显示（样式可后定）
- vital 环境：强调重点（两入口一致）

## 盒子（当前最小集）
- definition：定义盒子（v0.3.0 起可用）
- example：例子盒子（v0.3.1 起可用）
- note：笔记/提示盒子（v0.3.3 起可用）

### 盒子默认配色（可覆盖）
- definition：边框 HypoBlueDark，底色 HypoBlueLight
- example：边框 HypoGreenDark，底色 HypoGreenLight
- note：边框 HypoAmberDark，底色 HypoAmberLight

覆盖方式：在导言区用 `\tcbset{hypo example box/.style={...}}` 等覆盖对应 hook。

### 盒子标题与 label
- 盒子支持“标题”（例如 Definition 的名字）
- 显式 label（v0.3.4）：
  - 语法：`\\begin{definition}{Title}{label}`（example/note 同理）
  - 实际生成的 label 会自动带前缀：definition=`def:`，example=`ex:`，note=`note:`
  - 不需要引用时可传空：`{}`（不生成 `\\label`）
- 自动 label（计划）：仅对 ASCII 标题做可读的 slug；中文/非 ASCII 默认不自动生成（避免不可记忆的 hash）

## 引用与链接（拟定）
- v0.3.5 起：入口默认加载 hyperref + cleveref（可通过 `refs=false` 关闭）
- 建议用法：用 `\\cref{...}` 输出 "Definition: 0.1" 这类格式
