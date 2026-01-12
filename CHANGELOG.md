# Changelog

本文件记录版本更新内容（面向使用者）。

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
- Box：definition/example/note 支持显式 label（用于 `\\label/\\ref`），label 前缀分别为 `def:` / `ex:` / `note:`
- tests：补充主线用例的显式引用验证

## v0.3.5
- Refs：新增 Hypo-Refs 模块（hyperref + cleveref），入口新增 `refs=true/false`（默认开启）
- 引用格式：使用 `\\cref{...}` 时输出 "Definition: 0.1" / "Example: 0.1" / "Note: 0.1" 这类格式
- tests：主线用例切换为 `\\cref` 验证输出

## v0.4.0
- README：对齐当前工程化用法（按包名加载、Makefile 注入 TEXINPUTS、入口选项说明等）
- manual：补齐自举式手册（覆盖入口/选项、core/modules、Box、Refs 与示例）
- DEVELOPMENT_PLAN：补充 v0.5.0–v1.0.0 长线里程碑与 release criteria

