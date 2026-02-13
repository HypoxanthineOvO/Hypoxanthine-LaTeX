# Workflow: From Notes to Cheatsheet
# 工作流：从笔记到速查表

本文档描述如何将学习笔记转换为高密度速查表。

This document describes how to convert study notes into high-density cheatsheets.

---

## Workflow Overview / 工作流概述

```
[Input: Study Notes/Documentation]
     ↓
1. Extract Key Information (commands, APIs, concepts)
     ↓
2. Organize by Category (syntax, data types, examples)
     ↓
3. Optimize for Density (compact layout, concise text)
     ↓
4. Generate LaTeX Code (Hypo-CHSH)
     ↓
[Output: PDF Cheatsheet]
```

---

## Step 1: Extract Key Information / 提取关键信息

### What to Extract / 提取什么

**优先包含**:
- 常用命令和语法
- 数据类型和结构
- 核心概念和定义
- 实用代码片段
- 常见陷阱和注意事项

**可选包含**:
- 简短示例（每个概念 1-2 个）
- 快速参考表
- 键盘快捷键

### Example: Python Cheatsheet / 示例：Python速查表

从文档中提取：

```python
# 数据类型
int, float, str, list, dict, set, tuple

# 常用操作
len(), range(), enumerate(), zip()

# 列表推导式
[x**2 for x in range(10)]

# 字典方法
dict.keys(), dict.values(), dict.items()
```

---

## Step 2: Organize by Category / 按类别组织

### Suggested Structure / 建议结构

**编程语言速查表**:
```
1. 数据类型 (Data Types)
   - 基本类型
   - 容器类型
   - 类型转换

2. 基本语法 (Basic Syntax)
   - 变量赋值
   - 控制流
   - 循环

3. 常用操作 (Common Operations)
   - 字符串操作
   - 文件操作
   - 数学运算

4. 标准库 (Standard Library)
   - 常用模块
   - 重要函数

5. 示例代码 (Examples)
   - 实用片段
```

**理论概念速查表**:
```
1. 核心定义 (Definitions)
2. 重要定理 (Theorems)
3. 常用公式 (Formulas)
4. 应用场景 (Applications)
```

---

## Step 3: Optimize for Density / 优化密度

### Layout Tips / 布局技巧

1. **使用多栏**: `columns=3` 或 `columns=4`
2. **紧凑描述**: 避免冗长解释
3. **表格优先**: 表格比文字更紧凑
4. **代码无行号**: `linenos=false`
5. **最小化空白**: CHSH 默认已优化

### Text Optimization / 文本优化

**冗长 → 精简**:
- "这是一个用于计算平方的函数" → "平方计算"
- "你可以使用这个命令来..." → "用法："
- "下面的代码展示了..." → "示例���"

---

## Step 4: Generate Content / 生成内容

### Basic Template / 基本模板

```latex
\documentclass[columns=3]{Hypo-CHSH}

% 可选：添加元数据
\title{Python 速查表}
\author{Your Name}

\begin{document}

% 内容部分

\end{document}
```

### Example Sections / 示例章节

#### 1. Data Types Section / 数据类型部分

```latex
\section{数据类型}

\subsection{基本类型}

\begin{description}
  \item[int] 整数：\texttt{x = 42}
  \item[float] 浮点：\texttt{x = 3.14}
  \item[str] 字符串：\texttt{s = "hello"}
  \item[bool] 布尔：\texttt{b = True}
\end{description}

\subsection{容器类型}

\begin{description}
  \item[list] 列表：\texttt{[1, 2, 3]}
  \item[tuple] 元组：\texttt{(1, 2, 3)}
  \item[dict] 字典：\texttt{\{'a': 1\}}
  \item[set] 集合：\texttt{\{1, 2, 3\}}
\end{description}
```

#### 2. Syntax Section / 语法部分

```latex
\section{基本语法}

\subsection{控制流}

\textbf{If 语句}:
\begin{hypocode}[linenos=false]{python}
if x > 0:
    print("positive")
elif x < 0:
    print("negative")
else:
    print("zero")
\end{hypocode}

\textbf{For 循环}:
\begin{hypocode}[linenos=false]{python}
for i in range(10):
    print(i)
\end{hypocode}

\textbf{While 循环}:
\begin{hypocode}[linenos=false]{python}
while x < 10:
    x += 1
\end{hypocode}
```

#### 3. Operations Section / 操作部分

```latex
\section{常用操作}

\subsection{列表操作}

\begin{description}
  \item[添加] \texttt{list.append(x)}
  \item[扩展] \texttt{list.extend([1,2])}
  \item[插入] \texttt{list.insert(i, x)}
  \item[删除] \texttt{list.remove(x)}
  \item[弹出] \texttt{list.pop()}
  \item[排序] \texttt{list.sort()}
  \item[反转] \texttt{list.reverse()}
\end{description}

\subsection{列表推导式}

\begin{hypocode}[linenos=false]{python}
# 平方
squares = [x**2 for x in range(10)]

# 条件过滤
evens = [x for x in range(10) if x % 2 == 0]

# 嵌套
matrix = [[i*j for j in range(3)] for i in range(3)]
\end{hypocode}
```

#### 4. Quick Reference Table / 快速参考表

```latex
\section{快速参考}

\subsection{字符串方法}

\begin{table}
\centering
\small
\begin{tabular}{llp{5cm}}
\toprule
方法 & 描述 & 示例 \\
\midrule
\texttt{s.upper()} & 转大写 & \texttt{"ABC"} \\
\texttt{s.lower()} & 转小写 & \texttt{"abc"} \\
\texttt{s.strip()} & 去空白 & \texttt{"hello"} \\
\texttt{s.split()} & 分割 & \texttt{["hello", "world"]} \\
\texttt{s.join(lst)} & 连接 & \texttt{"a-b-c"} \\
\bottomrule
\end{tabular}
\end{table}
```

---

## Complete Example: Python Cheatsheet / 完整示例

```latex
\documentclass[columns=3, indent=false]{Hypo-CHSH}

\title{Python 3 快速参考}
\author{v3.12 | 2024}

\begin{document}

% ==================== 第 1 栏 ====================

\section{数据类型}

\subsection{基本类型}

\begin{description}
  \item[int] 整数：\texttt{x = 42}
  \item[float] 浮点：\texttt{x = 3.14}
  \item[str] 字符串：\texttt{s = "hello"}
  \item[bool] 布尔：\texttt{b = True}
\end{description}

\subsection{容器类型}

\begin{description}
  \item[list] 列表：\texttt{[1, 2, 3]}
  \item[tuple] 元组：\texttt{(1, 2, 3)}
  \item[dict] 字典：\texttt{\{'a': 1\}}
  \item[set] 集合：\texttt{\{1, 2, 3\}}
\end{description}

\section{基本语法}

\subsection{控制流}

\textbf{If}:
\begin{hypocode}[linenos=false]{python}
if x > 0:
    print("positive")
\end{hypocode}

\textbf{For}:
\begin{hypocode}[linenos=false]{python}
for i in range(10):
    print(i)
\end{hypocode}

% ==================== 第 2 栏 ====================

\section{列表操作}

\subsection{常用方法}

\begin{description}
  \item[append] \texttt{lst.append(x)}
  \item[extend] \texttt{lst.extend([1,2])}
  \item[insert] \texttt{lst.insert(i, x)}
  \item[remove] \texttt{lst.remove(x)}
  \item[pop] \texttt{lst.pop()}
  \item[sort] \texttt{lst.sort()}
\end{description}

\subsection{列表推导式}

\begin{hypocode}[linenos=false]{python}
# 平方
squares = [x**2 for x in range(10)]

# 条件过滤
evens = [x for x in range(10) if x % 2 == 0]
\end{hypocode}

\section{字典操作}

\subsection{常用方法}

\begin{description}
  \item[keys] \texttt{d.keys()}
  \item[values] \texttt{d.values()}
  \item[items] \texttt{d.items()}
  \item[get] \texttt{d.get(key, default)}
\end{description}

% ==================== 第 3 栏 ====================

\section{常用函数}

\subsection{内置函数}

\begin{description}
  \item[len] 长度
  \item[range] 范围
  \item[enumerate] 枚举
  \item[zip] 组合
  \item[map] 映射
  \item[filter] 过滤
\end{description}

\subsection{示例}

\begin{hypocode}[linenos=false]{python}
# enumerate
for i, val in enumerate(lst):
    print(i, val)

# zip
for a, b in zip(list1, list2):
    print(a, b)

# map
result = map(int, ["1", "2", "3"])
\end{hypocode}

\section{文件操作}

\begin{hypocode}[linenos=false]{python}
# 读取
with open("file.txt", "r") as f:
    content = f.read()

# 写入
with open("file.txt", "w") as f:
    f.write("Hello")
\end{hypocode}

\end{document}
```

---

## Advanced Tips / 高级技巧

### 1. Manual Column Breaks / 手动分栏

```latex
% 在特定位置强制分栏
\CHSHColumnBreak
```

### 2. Multi-Column Layout / 多栏布局

```latex
% 在单栏内创建多栏（用于表格或列表）
\begin{multicols}{2}
  内容...
\end{multicols}
```

### 3. Compact Lists / 紧凑列表

```latex
\begin{description}
  \item[关键词] 简短描述，保持在一行
  \item[另一个] 同样简短
\end{description}
```

### 4. Inline Code / 行内代码

```latex
使用 \texttt{code\_name} 引用代码
```

---

## Output Mode Specification / 输出模式说明

当用户请求 "制作速查表" 或 "从笔记生成cheatsheet" 时：

1. **识别内容类型**（编程语言？理论概念？API 参考？）
2. **确定栏数**（3栏适合大多数场景，4栏适合更多内容）
3. **提取并组织信息**
4. **优化密度**（精简描述，使用表格）
5. **生成完整 .tex 文件** (FULL_MODE)

### Example Prompts / 示例提示词

- "Create a cheatsheet for [programming language]"
- "Make a quick reference from my notes"
- "Generate a 3-column cheatsheet for [topic]"
- "Convert these notes to a compact reference sheet"
