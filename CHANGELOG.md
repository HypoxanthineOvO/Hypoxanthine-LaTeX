# Changelog

本文件记录版本更新内容（面向使用者）。

## v0.1.0
- 初始化工程文档：新增 DEVELOPMENT_PLAN、FEATURES、PROMPT
- 构建系统可用性修复：Makefile include 大小写对齐、补齐 watch 目标
- manual：入口文件重命名为 Manual.tex，完善 manual/Makefile

## v0.2.0
- 新增 tests 隔离测试入口：用于验证 corner cases，不污染 manual
- Fonts 层增强：Hypo-Fonts 增加字体缺失时的自动降级策略
