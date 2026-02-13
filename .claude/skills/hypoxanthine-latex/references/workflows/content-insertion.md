# Workflow: Content Insertion Mode
# 工作流：内容插入模式

本文档描述如何在已有文档中插入新内容，而不生成完整的 .tex 文件。

This document describes how to insert new content into existing documents without generating complete .tex files.

---

## When to Use CONTENT_MODE / 何时使用内容模式

### Use Cases / 使用场景

| Scenario | Example Output |
|----------|---------------|
| "Add a section about X" | `\section{...}` + content |
| "Write a slide about Y" | `\begin{frame}...\end{frame}` |
| "Insert a chapter on Z" | `\chapter{...}` + content |
| "Add these code examples" | `hypocode` environments only |
| "Create definition boxes for..." | `definition` environments |

### Difference from FULL_MODE / 与完整模式的区别

**FULL_MODE**: 生成完整 .tex 文件（含导言区 preamble）
```latex
\documentclass[...]{Hypo-Note}
\HypoNoteSetup{...}
\begin{document}
...内容...
\end{document}
```

**CONTENT_MODE**: 只生成内容片段
```latex
\section{新章节}
内容...
```

---

## Output Guidelines / 输出指南

### 1. Context Awareness / 上下文感知

在生成内容前，检查：

- [ ] 用户是否提供了现有文件？（Read it first）
- [ ] 插入位置在哪里？（章节末尾？特定位置？）
- [ ] 需要编号管理吗？（section 编号可能冲突）
- [ ] 引用标签是否唯一？（避免 label 冲突）

### 2. Minimal Viable Content / 最小可行内容

生成的内容应该：

- **独立可编译**: 内容片段可以放入文档中编译
- **遵循现有风格**: 匹配文档的编号、缩进、配色
- **包含必要结构**: `\begin{env}` ... `\end{env}` 完整
- **合理的标签**: 使用描述性 label 前缀

### 3. Reference Handling / 引用处理

如果内容中包含引用：

```latex
% 生成带标签的内容
\begin{definition}{术语}{context_term}
  定义内容...
\end{definition}

参见本节其他内容。

% 注意：不生成 \cref{context_term}，除非是内容内部引用
```

---

## Common Insertion Patterns / 常见插入模式

### Pattern 1: Add Section / 添加章节

**Request**: "Add a section about data structures"

**Output**:
```latex
\section{数据结构}

本节介绍基本数据结构。

\subsection{线性结构}

\begin{description}
  \item[数组] 连续内存存储
  \item[链表] 指针连接节点
  \item[栈] 后进先出 (LIFO)
  \item[队列] 先进先出 (FIFO)
\end{description}

\subsection{非线性结构}

\begin{description}
  \item[树] 层次结构
  \item[图] 网状结构
\end{description}
```

### Pattern 2: Add Slide / 添加幻灯片

**Request**: "Write a slide about recursion"

**Output**:
```latex
\begin{frame}{递归}
  \begin{definition}{递归}{recursion_def}
    函数直接或间接调用自身的过程。
  \end{definition}

  \begin{itemize}
    \item 基准情况 (Base Case)
    \item 递归情况 (Recursive Case)
  \end{itemize}

  \begin{example}[fragile]{阶乘实现}{factorial}
    \begin{hypocode}{python}
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)
    \end{hypocode}
  \end{example}
\end{frame}
```

### Pattern 3: Add Content Block / 添加内容块

**Request**: "Insert code examples for file operations"

**Output**:
```latex
\subsection{文件操作}

\begin{hypocode}{python}
# 读取文件
with open("file.txt", "r") as f:
    content = f.read()

# 写入文件
with open("file.txt", "w") as f:
    f.write("Hello")
\end{hypocode}

\begin{note}{注意事项}{file_note}
记得使用 \texttt{with} 语句确保文件正确关闭。
\end{note}
```

### Pattern 4: Add Chapter Content / 添加章节内容

**Request**: "Add content to Chapter 3 about algorithms"

**Output**:
```latex
% 假设这是 Chapter 3 内的插入

\section{排序算法}

\subsection{比较排序}

\begin{definition}{时间复杂度}{time_complexity}
  算法执行时间与输入规模的关系。
\end{definition}

\begin{table}
  \centering
  \begin{tabular}{lcc}
    \toprule
    算法 & 平均时间 & 最坏时间 \\
    \midrule
    冒泡排序 & $O(n^2)$ & $O(n^2)$ \\
    快速排序 & $O(n \log n)$ & $O(n^2)$ \\
    归并排序 & $O(n \log n)$ & $O(n \log n)$ \\
    \bottomrule
  \end{tabular}
  \caption{排序算法比较}
\end{table}
```

---

## Context-Based Examples / 基于上下文的示例

### Scenario 1: Extending Hypo-Note / 扩展技术笔记

**Context**: User has `main.tex` with Hypo-Note, Chapter 2 about Python basics

**Request**: "Add content about exception handling after section 2.3"

**Output**:
```latex
\section{异常处理}

Python 使用 \texttt{try-except} 块处理异常。

\subsection{基本语法}

\begin{hypocode}{python}
try:
    result = 10 / 0
except ZeroDivisionError as e:
    print(f"Error: {e}")
except Exception as e:
    print(f"General error: {e}")
finally:
    print("Cleanup code")
\end{hypocode}

\subsection{最佳实践}

\begin{note}{异常处理原则}{exception_tip}
\begin{itemize}
  \item 只捕获能处理的异常
  \item 避免裸 \texttt{except:}
  \item 使用具体异常类型
  \item 提供有意义的错误信息
\end{itemize}
\end{note}
```

### Scenario 2: Adding to Hypo-CHSH / 扩展速查表

**Context**: User has `chsh.tex` with 3 columns, section on NumPy already exists

**Request**: "Add pandas section after NumPy"

**Output**:
```latex
\section{Pandas}

\subsection{数据结构}

\begin{description}
  \item[Series] 一维标签数组
  \item[DataFrame] 二维表格
  \item[Index] 行标签
\end{description}

\subsection{常用操作}

\begin{hypocode}[linenos=false]{python}
import pandas as pd

# 创建 DataFrame
df = pd.DataFrame({'A': [1, 2], 'B': [3, 4]})

# 读取 CSV
df = pd.read_csv('file.csv')

# 选择列
df['A']

# 过滤
df[df['A'] > 1]
\end{hypocode}
```

### Scenario 3: Adding to Hypo-Slide / 扩展幻灯片

**Context**: User has slides with theme=school, section on Introduction

**Request**: "Add 2 slides about methodology after Introduction"

**Output**:
```latex
\section{方法论}

\begin{frame}{方法概述}
  我们的方法包含三个步骤：

  \begin{enumerate}
    \item 数据预处理
    \item 特征提取
    \item 模型训练
  \end{enumerate}

  \img[width=0.7\linewidth, label=flowchart]{assets/flowchart.png}{流程图}
\end{frame}

\begin{frame}[fragile]{核心算法}
  \begin{definition}{特征提取算法}{feat_extract}
    使用卷积神经网络自动提取图像特征。
  \end{definition}

  \begin{hypocode}{python}
def extract_features(image):
    cnn = load_cnn_model()
    features = cnn.forward(image)
    return features
  \end{hypocode}
\end{frame}
```

---

## Label Naming Conventions / 标签命名约定

在插入内容时，使用描述性的标签：

### Patterns / 模式

| Content Type | Label Pattern | Example |
|--------------|---------------|----------|
| Definition | `<context>_<concept>_def` | `ml_neural_network_def` |
| Example | `<context>_<concept>_ex` | `python_sort_ex` |
| Note | `<context>_<concept>_note` | `debug_tip_note` |
| Figure | `<context>_<concept>_fig` | `arch_diagram_fig` |
| Algorithm | `<context>_<concept>_algo` | `search_algo` |

### Avoiding Conflicts / 避免冲突

如果用户已有标签，检查：

```latex
% 如果用户已有标签 "sorting_ex"，使用
% 或者询问用户是否使用新标签

\begin{example}{快速排序示例}{quicksort_v2_ex}
  内容...
\end{example}
```

---

## Integration Examples / 集成示例

### Example 1: AI-Generated Content / AI 生成的内容

**Scenario**: AI reads documentation and generates summary

```latex
\section{函数式编程}

\begin{definition}{纯函数}{pure_func}
  相同输入总是产生相同输出，无副作用。
\end{definition}

\subsection{核心概念}

\begin{itemize}
  \item 不可变性 (Immutability)
  \item 高阶函数 (Higher-Order Functions)
  \item 函数组合 (Function Composition)
\end{itemize}

\begin{hypocode}{python}
# 高阶函数示例
def apply_operation(func, data):
    return [func(x) for x in data]

squared = apply_operation(lambda x: x**2, [1, 2, 3])
\end{hypocode}
```

### Example 2: Multi-Source Content / 多源内容

**Scenario**: Combining information from multiple sources

```latex
\section{相关研究}

\subsection{传统方法}

\begin{note}{局限性}{traditional_limit}
  传统方法在处理大规模数据时效率低下。
\end{note}

\subsection{深度学习方法}

\begin{definition}{卷积神经网络}{cnn_def}
  使用卷积层自动提取特征的神经网络架构。
\end{definition}

\begin{example}{成功案例}{cnn_success}
  ResNet 在 ImageNet 上达到超过人类水平的准确率。
\end{example}
```

---

## Output Mode Specification / 输出模式说明

当检测到以下请求时，使用 **CONTENT_MODE**：

### Trigger Phrases / 触发短语

- "Add a section about..."
- "Insert content on..."
- "Write a slide about..."
- "Add this to chapter X"
- "Extend the document with..."
- "After section Y, add..."

### Detection Logic / 检测逻辑

```python
if request_contains(["add", "insert", "extend"]) and
   not request_contains(["create", "new document", "from scratch"]):
    USE_CONTENT_MODE()
else:
    USE_FULL_MODE()
```

### Output Format / 输出格式

```latex
% CONTENT_MODE: 只输出内容
\section{...}
...

% FULL_MODE: 输出完整文件
\documentclass[...]{...}
\begin{document}
\section{...}
...
\end{document}
```

---

## Best Practices / 最佳实践

1. **Read First**: If user mentions existing file, read it first
2. **Context Match**: Match style, indentation, numbering
3. **Unique Labels**: Use descriptive, unique label prefixes
4. **Complete Structures**: Always close environments properly
5. **Minimal Dependencies**: Don't assume packages beyond basic Hypoxanthine setup

---

## Example Prompts / 示例提示词

- "Add a section on recursion to my Python notes"
- "Insert 3 slides about machine learning algorithms"
- "Extend Chapter 5 with content about optimization"
- "Write content about exception handling after section 2.3"
