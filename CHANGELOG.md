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
