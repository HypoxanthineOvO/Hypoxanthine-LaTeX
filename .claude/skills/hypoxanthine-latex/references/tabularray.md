# Tabularray (tblr) Reference / 表格库参考

本文档提供 **tabularray** 宏包的使用参考。Tabularray 是一个现代 LaTeX3 表格包，提供比传统 `tabular` 更强大的功能。

This document provides a reference for the **tabularray** package. Tabularray is a modern LaTeX3 table package with more powerful features than traditional `tabular`.

---

## Overview / 概述

### Why Tabularray? / 为何使用？

**Advantages over traditional `tabular`**:
- LaTeX3 based, modern and maintainable
- Separates content and style (content = style)
- Flexible cell formatting
- Advanced row/column customization
- Better integration with other packages

**优势**：
- 基于 LaTeX3，现代且可维护
- 内容与样式分离
- 灵活的单元格格式化
- 高级行/列定制
- 与其他包更好的集成

### Basic Usage / 基本用法

```latex
\usepackage{tabularray}

\begin{tblr}{
  colspec = {l c r},
  row{1} = {font=\bfseries},
}
  Header 1 & Header 2 & Header 3 \\
  Data 1   & Data 2   & Data 3 \\
\end{tblr}
```

---

## Core Concepts / 核心概念

### 1. Key-Value Syntax / 键值语法

Tabularray uses modern keyval syntax instead of positional arguments:
Tabularray 使用现代键值语法，而非位置参数：

```latex
\begin{tblr}{
  % 列规格
  colspec = {l c r},
  % 行规格
  row{1} = {bg=blue!10},
  % 单元格规格
  cell{1}{1} = {text=red},
}
  ...
\end{tblr}
```

### 2. Content = Style / 内容即样式

```latex
% 内容
  A & B \\

% 样式在表头定义，不在内容中定义
  \SetRow{1}{bg=blue!10}
  A & B \\
```

---

## Column Specification / 列规格

### Basic Column Types / 基本列类型

```latex
\begin{tblr}{
  colspec = {
    l    % 左对齐
    c    % 居中对齐
    r    % 右对齐
    l    % 自动宽度
  }
}
  Left & Center & Right \\
\end{tblr}
```

### Fixed Width Columns / 固定宽度列

```latex
\begin{tblr}{
  colspec = {
    X[l]      % 弹性宽度，左对齐
    X[2,c]    % 2倍弹性宽度，居中
    Q[3,r]    % 3倍固定宽度，右对齐
    X[4cm,l]  % 固定 4cm 宽度
  }
}
  ...
\end{tblr}
```

### Column Groups / 列组

```latex
\begin{tblr}{
  colspec = {
    |X[2,l]|X[2,c]|X[2,r]|
  }
}
  Left & Center & Right \\
\end{tblr}
```

### Column Modifiers / 列修饰符

```latex
\begin{tblr}{
  colspec = {
    l       % 左对齐
    >{\itshape} c  % 居中，斜体
    >{\color{red}} r  % 右对齐，红色
  }
}
  ...
\end{tblr}
```

---

## Row Specification / 行规格

### Single Row / 单行

```latex
\begin{tblr}{
  colspec = {l c r},
  row{1} = {font=\bfseries, bg=blue!10},  % 第一行加粗，蓝色背景
}
  Header & Header & Header \\
  Data   & Data   & Data   \\
\end{tblr}
```

### Multiple Rows / 多行

```latex
\begin{tblr}{
  colspec = {l c r},
  row{1} = {font=\bfseries},     % 第 1 行
  row{2}{4} = {font=\itshape},   % 第 2-4 行
  row{odd} = {bg=gray!10},       % 奇数行
}
  ...
\end{tblr}
```

### Row Modifiers / 行修饰符

```latex
\begin{tblr}{
  row{1} = {
    font=\bfseries,      % 字体样式
    bg=blue!10,         % 背景色
    fg=white,           % 前景色（文字）
    h=1.5cm,            % 高度
  }
}
  ...
\end{tblr}
```

---

## Cell Specification / 单元格规格

### Single Cell / 单个单元格

```latex
\begin{tblr}{
  colspec = {l c r},
  cell{1}{1} = {text=red, font=\bfseries},  % 第 1 行第 1 列
}
  \SetCell{1}{1}{text=red}{Header} & Header & Header \\
  Data & Data & Data \\
\end{tblr}
```

### Cell Ranges / 单元格范围

```latex
\begin{tblr}{
  colspec = {l c r},
  cell{1}{1} = {bg=blue!10},           % 第 1 行第 1 列
  cell{2}{2}{3}{2} = {bg=yellow!10},  % 第 2-3 行第 2-2 列
}
  ...
\end{tblr}
```

---

## Common Features / 常用功能

### 1. Lines / 线条

```latex
\begin{tblr}{
  colspec = {|l|c|r|},
  row{1} = {hline},      % 第 1 行下划线
  row{2} = {hline{1-2}}, % 第 2 行第 1-2 列下划线
}
  ...
\end{tblr}
```

### 2. Cell Merging / 单元格合并

```latex
\begin{tblr}{
  colspec = {l c r},
}
  \SetCell{1}{1}{r=3}{\textbf{Merged Header}} & & \\
  Data 1 & Data 2 & Data 3 \\
\end{tblr}
```

### 3. Vertical Text / 竖排文字

```latex
\begin{tblr}{
  colspec = {l c r},
  cell{1}{1} = {rotate=90},  % 旋转 90 度
}
  \SetCell{1}{1}{rotate=90}{Vertical} & Normal & Normal \\
\end{tblr}
```

---

## Complete Examples / 完整示例

### Example 1: Basic Table / 基本表格

```latex
\begin{tblr}{
  colspec = {l c r},
  row{1} = {font=\bfseries, bg=HypoPrimary!10},
  hline{1} = {solid},
  hline{2} = {solid},
}
  Name & Age & Score \\
  Alice & 25 & 95 \\
  Bob & 30 & 87 \\
\end{tblr}
```

### Example 2: Styled Table / 样式表格

```latex
\begin{tblr}{
  colspec = {
    |X[2,l]|X[2,c]|X[2,r]|
  },
  row{1} = {
    font=\bfseries,
    bg=HypoPrimary!10,
    fg=HypoPrimary,
  },
  row{2}{-1} = {
    bg=gray!5,
  },
  hlines,
}
  Name & Age & Score \\
  Alice & 25 & 95 \\
  Bob & 30 & 87 \\
\end{tblr}
```

### Example 3: Complex Table / 复杂表格

```latex
\begin{tblr}{
  colspec = {l c c c},
  row{1} = {
    font=\bfseries,
    bg=HypoPrimary!10,
    c=4,  % 合并 4 列
  },
  row{2} = {font=\bfseries},
  cell{2}{2} = {bg=yellow!20},
  hline{1,2,5},
}
  \textbf{Quarterly Report} & & & \\
  Product & Q1 & Q2 & Q3 \\
  A & 100 & 120 & 130 \\
  B & \SetCell{2}{2}{bg=yellow!20}{150} & 160 & 170 \\
  C & 200 & 210 & 220 \\
\end{tblr}
```

### Example 4: Booktabs Style / Booktabs 风格

```latex
\begin{tblr}{
  colspec = {l c r},
  row{1} = {font=\bfseries},
  hline{1} = {$\VRuleWidth{1.5pt}$},
  hline{2} = {$\VRuleWidth{0.8pt}$},
  hline{-1} = {$\VRuleWidth{1.5pt}$},
}
  Name & Age & Score \\
  Alice & 25 & 95 \\
  Bob & 30 & 87 \\
\end{tblr}
```

---

## Integration with Hypoxanthine / 与 Hypoxanthine 集成

### Using with Semantic Colors / 使用语义化颜色

```latex
\begin{tblr}{
  colspec = {l c r},
  row{1} = {
    font=\bfseries,
    bg=HypoPrimary!10,  % 使用 Hypoxanthine 颜色
    fg=HypoPrimary,
  },
  cell{2}{2} = {
    bg=HypoAccent!20,     % 使用强调色
  },
}
  ...
\end{tblr}
```

### Compact Table for CHSH / CHSH 紧凑表格

```latex
% 在 Hypo-CHSH 中使用紧凑表格
\begin{tblr}{
  colspec = {@{} l l @{}},  % 无边距
  row{odd} = {bg=gray!5},
  rowspec = {t},  % 顶部对齐
}
  \textbf{Cmd} & \texttt{ls} \\
  \textbf{Desc} & List files \\
  \hline
  \textbf{Cmd} & \texttt{cd} \\
  \textbf{Desc} & Change directory \\
\end{tblr}
```

---

## Common Options / 常用选项

### Column Options / 列选项

| Option | Description | Example |
|--------|-------------|---------|
| `l`, `c`, `r` | 对齐方式 | `l` |
| `X[n,type]` | 弹性宽度 | `X[2,c]` |
| `Q[n,type]` | 固定宽度 | `Q[3cm,l]` |
| `>{code}` | 前置代码 | `>{\itshape}` |

### Row Options / 行选项

| Option | Description | Example |
|--------|-------------|---------|
| `font=...` | 字体 | `font=\bfseries` |
| `bg=...` | 背景色 | `bg=blue!10` |
| `fg=...` | 前景色 | `fg=red` |
| `h=...` | 高度 | `h=1cm` |
| `hline` | 横线 | `hline{}` |

### Cell Options / 单元格选项

| Option | Description | Example |
|--------|-------------|---------|
| `text=...` | 文字颜色 | `text=red` |
| `font=...` | 字体 | `font=\itshape` |
| `bg=...` | 背景 | `bg=yellow!10` |
| `rotate=...` | 旋转角度 | `rotate=90` |

---

## Resources / 资源

**Official Documentation**:
- [CTAN Package Page](https://ctan.org/pkg/tabularray?lang=en)
- [Official PDF Documentation](https://ctan.math.illinois.edu/macros/latex/contrib/tabularray/tabularray.pdf)
- [GitHub Repository](https://github.com/lvjr/tabularray)

**Community Resources**:
- [TeX Stack Exchange Guide](https://tex.stackexchange.com/questions/629480/guides-for-typesetting-tables-with-the-tabularray-package)
- [Understanding tabularray](https://chongkai.site/docs/posts/2023-03-05-understanding-the-best-table-package-for-latex-tabularray/)

---

**Sources:**
- [CTAN - tabularray Package](https://ctan.org/pkg/tabularray?lang=en)
- [Official Documentation PDF](https://ctan.math.illinois.edu/macros/latex/contrib/tabularray/tabularray.pdf)
- [GitHub Repository](https://github.com/lvjr/tabularray)
- [TeX Stack Exchange - tabularray Guide](https://tex.stackexchange.com/questions/629480/guides-for-typesetting-tables-with-the-tabularray-package)
