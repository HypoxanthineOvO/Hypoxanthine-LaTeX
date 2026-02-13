# Hypoxanthine-LaTeX 快速开始指南

本文档帮助你快速上手 Hypoxanthine-LaTeX 框架。

---

## 安装

### 1. 作为独立项目使用

```bash
# 克隆仓库
git clone https://github.com/HypoxanthineOvO/Hypoxanthine-LaTeX.git
cd Hypoxanthine-LaTeX

# 检查环境
./scripts/hypo doctor

# 创建一个新项目
./scripts/hypo template note --dest ./my-note

# 编译
cd my-note
make
```

### 2. 作为子模块使用

```bash
# 在你的项目中添加为子模块
git submodule add git@github.com:HypoxanthineOvO/Hypoxanthine-LaTeX.git Hypoxanthine-LaTeX
git submodule update --init --recursive

# 创建 Makefile
cat > Makefile << 'EOF'
HYPO_PATH := $(PWD)/Hypoxanthine-LaTeX
export TEXINPUTS := .:$(HYPO_PATH)/sty//:
include $(HYPO_PATH)/make/Hypoxanthine.mk
EOF

# 编译
make
```

---

## 环境要求

### 必需工具

- **TeX Live**: 包含 `xelatex` 和 `latexmk`
- **Python 3**: 用于脚本和代码高亮
- **Pygments**: `pip install Pygments` (用于 minted 代码高亮)

### 可选工具

- **VS Code**: 推荐安装 LaTeX Workshop 扩展
- **字体**:
  - Noto Sans/Serif CJK SC (思源黑体/宋体）
  - LXGW WenKai (霞鹜文楷）

### 环境检查

```bash
./Hypoxanthine-LaTeX/scripts/hypo doctor
```

**检查项目**:
- xelatex 是否可用
- latexmk 是否可用
- pygmentize 是否安装
- 字体是否可用

---

## 选择文档类型

### 技术笔记 → Hypo-Note

适合场景：
- 课程笔记
- 技术文档
- 教程

```bash
./scripts/hypo template note --dest ./my-note
```

### 文学笔记 → Hypo-LitNote

适合场景：
- 读书笔记
- 文学分析
- 诗歌创作

```bash
./scripts/hypo template litnote --dest ./my-litnote
```

### 速查表 → Hypo-CHSH

适合场景：
- 语法速查
- 命令参考
- 高密度信息

```bash
./scripts/hypo template chsh --dest ./my-chsh
```

### 幻灯片 → Hypo-Slide

适合场景：
- 演示文稿
- 学术报告
- 技术分享

```bash
./scripts/hypo template slide --dest ./my-slide
```

---

## 编译文档

### 使用 Makefile

```bash
# 默认编译（启用 minted）
make

# 不使用 minted
make SHELL_ESCAPE=0

# 清理中间文件
make clean

# 指定 Python 解释器
make PYTHON_BIN=/usr/bin/python3
```

### 使用 latexmk

```bash
latexmk -xelatex -shell-escape main.tex
```

---

## 配色方案

| 方案 | 风格 | 推荐场景 |
|------|------|----------|
| `Base` | 通用 | 一般文档 |
| `CN` | 国风/莫兰迪 | 人文、艺术类文档 |
| `Tech` | 科技/深蓝 | 技术、理工类文档 |
| `Simple` | 极简灰 | 简洁风格文档 |

### 使用示例

```latex
\HypoNoteSetup{
  title={文档标题},
  author={作者},
  colorscheme=Tech  % 选择配色
}
```

---

## 幻灯片主题

| 主题 | 风格 | 推荐场景 |
|------|------|----------|
| `school` | 学术风格 | 课程、学术报告 |
| `lab` | 极客风格 | 技术分享、实验室报告 |
| `lit` | 人文风格 | 文学、历史、艺术 |
| `business` | 商业风格 | 商务汇报、项目展示 |

### 使用示例

```latex
\documentclass[theme=school]{Hypo-Slide}
```

---

## 字体模式

| 模式 | 主字体 | 强调字体 | 推荐场景 |
|------|--------|----------|----------|
| `lit` | 思源宋体 | 霞鹜文楷 | 文学、笔记 |
| `tech` | 思源黑体 | - | 技术、幻灯片 |

### 使用示例

```latex
\documentclass[fontset=lit]{Hypo-Note}
\documentclass[fontset=tech]{Hypo-Slide}
```

---

## 快速参考

### 常用命令

| 命令 | 用途 |
|------|------|
| `\img[...]{path}{caption}` | 插入图片 |
| `\HypoIcon{key}` | 插入图标 |
| `\cref{label}` | 智能引用 |

### 常用环境

| 环境 | 用途 |
|------|------|
| `definition` | 定义 |
| `example` | 示例 |
| `note` | 注意 |
| `hypocode` | 代码块 |

### 数学速写

| 命令 | 输出 |
|------|------|
| `\R` | ℝ |
| `\N` | ℕ |
| `\Z` | ℤ |
| `\Set{x}` | {x} |
| `\Paren{x}` | (x) |
| `\Abs{x}` | |x| |

---

## 项目结构

```
my-project/
├── main.tex              # 主文件
├── Makefile             # 构建文件
├── assets/              # 资源文件
│   ├── logo.png
│   └── images/
├── build/               # 构建输出（自动创建）
└── Hypoxanthine-LaTeX/  # 作为子模块
    ├── sty/
    ├── make/
    └── scripts/
```

---

## VS Code 配置

### 推荐扩展

- **LaTeX Workshop**: LaTeX 编辑支持
- **LaTeX Utilities**: 辅助工具

### 配置示例

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "xelatex",
      "command": "xelatex",
      "args": [
        "-shell-escape",
        "-output-directory=build",
        "%DOC%"
      ]
    }
  ]
}
```

### 使用 Snippets

仓库提供了 VS Code snippets：

```bash
# 复制 snippets 到 VS Code 目录
cp Hypoxanthine-LaTeX/snippets/hypoxanthine-latex.code-snippets \
   ~/.config/Code/User/snippets/
```

---

## 常见问题

### Q: 编译时找不到 .sty 文件

**A**: 确保 `TEXINPUTS` 正确设置：

```bash
export TEXINPUTS:=.:$(PWD)/Hypoxanthine-LaTeX/sty//:
```

或在 Makefile 中设置。

### Q: minted 报错

**A**: 安装 Pygments 并确保使用 `-shell-escape`：

```bash
pip install Pygments
make  # Makefile 默认启用 -shell-escape
```

### Q: 中文显示不正常

**A**: 使用 `xelatex` 编译，确保已安装中文字体：

```bash
./Hypoxanthine-LaTeX/scripts/hypo doctor
```

### Q: 幻灯片中代码出错

**A**: 使用 `[fragile]` 选项：

```latex
\begin{frame}[fragile]{Title}
  \begin{hypocode}{python}
    ...
  \end{hypocode}
\end{frame}
```

---

## 下一步

- 阅读完整语法：`references/syntax-cn.md`
- 查看架构文档：`references/architecture.md`
- 探索工作流示例：`references/workflows/`
