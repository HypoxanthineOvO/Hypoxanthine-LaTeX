# Workflow: From Paper to Slides
# 工作流：从论文到幻灯片

本文档描述如何将学术论文转换为演示文稿。

This document describes how to convert academic papers into presentations.

---

## Workflow Overview / 工作流概述

```
[Input: Paper/PDF]
     ↓
1. Extract Structure (sections, key points)
     ↓
2. Plan Slides (outline, slide allocation)
     ↓
3. Generate LaTeX Code (Hypo-Slide)
     ↓
4. Compile and Review
     ↓
[Output: PDF Presentation]
```

---

## Step 1: Extract Structure / 提取结构

### Manual Extraction / 手动提取

Read through the paper and identify:

**必读部分**:
- Title / Abstract / Introduction
- Main sections (usually 3-5 key sections)
- Key figures and tables
- Conclusion / Future Work

**可选部分**:
- Related Work (can be brief)
- Methodology details (can be summarized)

### Using AI Assistance / 使用 AI 辅助

Ask Claude to help extract structure:

> "Please read this paper and extract:
> 1. Main contribution (1-2 sentences)
> 2. Key sections (3-5 most important)
> 3. Important figures/tables
> 4. Main conclusion"

---

## Step 2: Plan Slides / 规划幻灯片

### Slide Allocation Strategy / 分配策略

For a **20-minute presentation** (约 15-20 页）:

| Slide Type | Pages | Content |
|-----------|-------|----------|
| Title | 1 | Title, authors, affiliation |
| Overview | 1 | Table of contents / roadmap |
| Introduction | 2-3 | Motivation, problem statement, contribution |
| Method | 3-5 | Core approach, architecture |
| Results | 3-5 | Key figures, tables, analysis |
| Discussion | 1-2 | Insights, limitations |
| Conclusion | 1 | Summary, future work |
| Q&A | 1 | "Thank You" / questions |

### Template Outline / 模板大纲

```latex
\documentclass[theme=school, aspectratio=169]{Hypo-Slide}

\HypoSlideSetup{
  title={Paper Title Here},
  subtitle={A Short Description},
  author={Presenter Name},
  institute={Institution},
  date={\today},
  logo={assets/logo.png}
}

\begin{document}

% 1. Title
\frame{\titlepage}

% 2. Overview
\begin{frame}{大纲}
  \tableofcontents
\end{frame}

% 3. Introduction (2-3 slides)
\section{简介}

\begin{frame}{研究动机}
  ...
\end{frame}

\begin{frame}{主要贡献}
  ...
\end{frame}

% 4. Method (3-5 slides)
\section{方法}

\begin{frame}{方法概述}
  ...
\end{frame}

% 5. Results (3-5 slides)
\section{结果}

\begin{frame}{实验结果}
  ...
\end{frame}

% 6. Conclusion
\section{总结}

\begin{frame}{总结}
  ...
\end{frame}

% 7. Q&A
\begin{frame}
  \centering
  \Huge 谢谢！ / Thank You! \\
  \large Q \& A
\end{frame}

\end{document}
```

---

## Step 3: Generate Content / 生成内容

### Introduction Slides / 简介页

**Slide 1: Motivation / 动机**

```latex
\begin{frame}{研究动机}
  \begin{itemize}
    \item 现有方法的局限性
          \begin{itemize}
            \item Limitation 1
            \item Limitation 2
          \end{itemize}
    \item 本文要解决的问题
    \item 研究意义
  \end{itemize}
\end{frame}
```

**Slide 2: Contribution / 贡献**

```latex
\begin{frame}{主要贡献}
  \begin{enumerate}
    \item 提出了新方法 X，解决了问题 Y
    \item 设计了架构 Z，提升了效率
    \item 在数据集 D 上取得了 SOTA 结果
  \end{enumerate}

  \begin{note}{核心创新点}{core_innovation}
    方法 X 的关键在于...
  \end{note}
\end{frame}
```

### Method Slides / 方法页

**Slide 1: Overview / 概述**

```latex
\begin{frame}{方法概述}
  \begin{definition}{核心算法}{algo}
    我们提出的算法包括三个步骤：
    \begin{enumerate}
      \item 数据预处理
      \item 特征提取
      \item 模型优化
    \end{enumerate}
  \end{definition}

  \img[width=0.7\linewidth, label=arch]{assets/architecture.png}{系统架构}
\end{frame}
```

**Slide 2: Details / 细节**

```latex
\begin{frame}[fragile]{算法细节}
  关键公式：

  \[
    f(x) = \int_0^\infty e^{-xt} g(t) \, dt
  \]

  \begin{hypocode}{python}
def algorithm_step_2(data):
    # Step 2: Feature extraction
    features = extract(data)
    return features
  \end{hypocode}
\end{frame}
```

### Results Slides / 结果页

**Slide 1: Main Results / 主要结果**

```latex
\begin{frame}{实验结果}
  \begin{table}
    \centering
    \begin{tabular}{lccc}
      \toprule
      方法 & 准确率 & 召回率 & F1 分数 \\
      \midrule
      Baseline & 85.2\% & 78.3\% & 81.6\% \\
      Method A & 87.1\% & 80.5\% & 83.7\% \\
      \textbf{Ours} & \textbf{90.5\%} & \textbf{85.2\%} & \textbf{87.8\%} \\
      \bottomrule
    \end{tabular}
    \caption{与现有方法的比较}
  \end{table}

  \begin{example}{结果分析}{res_analysis}
    我们的方法在准确率上提升了 \textbf{3.4\%}。
  \end{example}
\end{frame}
```

**Slide 2: Visualization / 可视化**

```latex
\begin{frame}{结果可视化}
  \img[width=0.85\linewidth, label=results_plot]{assets/results.png}{性能对比}

  \begin{itemize}
    \item 在所有数据集上均优于基线方法
    \item 收敛速度更快
  \end{itemize}
\end{frame}
```

---

## Step 4: Compile and Review / 编译和审查

### Compilation / 编译

```bash
# 使用 Makefile
make

# 或直接使用 latexmk
latexmk -xelatex -shell-escape main.tex
```

### Review Checklist / 审查清单

- [ ] 标题页信息完整（标题、作者、机构）
- [ ] 每页内容不超过 5-7 行
- [ ] 图片清晰，字体大小合适
- [ ] 公式编号正确
- [ ] 表格对齐、易读
- [ ] 所有引用都有对应内容
- [ ] 时间控制合适（每页约 1-2 分钟）

---

## Tips and Best Practices / 提示和最佳实践

### 1. Less is More / 少即是多

- 每页一个核心观点
- 避免大段文字
- 用图表替代文字

### 2. Visual Consistency / 视觉一致性

- 使用统一的配色方案
- 相似类型的幻灯片使用相同布局
- 图标风格保持一致

### 3. Code Examples / 代码示例

```latex
% 在 Beamer 中使用代码必须加 [fragile]
\begin{frame}[fragile]{代码示例}
  \begin{hypocode}{python}
    # 代码
  \end{hypocode}
\end{frame}
```

### 4. Figures and Tables / 图片和表格

```latex
% 图片
\img[width=0.8\linewidth, label=myfig]{assets/fig.png}{标题}

% 表格 - 使用 booktabs
\begin{table}
  \centering
  \begin{tabular}{lcc}
    \toprule
    表头 & ... & ... \\
    \midrule
    数据 & ... & ... \\
    \bottomrule
  \end{tabular}
\end{table}
```

---

## Example: Complete Presentation / 完整示例

### Scenario: ML Paper Presentation / 场景：机器学习论文报告

```latex
\documentclass[theme=school, aspectratio=169]{Hypo-Slide}

\HypoSlideSetup{
  title={Deep Learning for Image Classification},
  subtitle={A Novel Approach},
  author={Jane Doe},
  institute={University of Example},
  date={\today},
  logo={assets/logo.png}
}

\begin{document}

\frame{\titlepage}

\begin{frame}{大纲 / Outline}
  \tableofcontents
\end{document}

\section{Introduction}

\begin{frame}{研究动机 / Motivation}
  \begin{itemize}
    \item 图像分类的重要性
    \item 现有方法的局限
    \item Our approach: 使用深度学习
  \end{itemize}
\end{frame}

\section{Method}

\begin{frame}{方法概述 / Method Overview}
  \begin{definition}{核心架构}{arch}
    卷积神经网络 (CNN) + 注意力机制
  \end{definition}

  \img[width=0.7\linewidth, label=network]{assets/network.png}{网络结构}
\end{frame}

\section{Experiments}

\begin{frame}{实验结果 / Results}
  \begin{table}
    \centering
    \begin{tabular}{lcc}
      \toprule
      方法 & 准确率 & 时间 (ms) \\
      \midrule
      SVM & 85.2\% & 12 \\
      CNN & 92.1\% & 8 \\
      \textbf{Ours} & \textbf{95.3\%} & \textbf{10} \\
      \bottomrule
    \end{tabular}
  \end{table}
\end{frame}

\section{Conclusion}

\begin{frame}{总结 / Conclusion}
  \begin{itemize}
    \item 提出了新的 CNN 架构
    \item 在 ImageNet 上达到 95.3\% 准确率
    \item 未来工作：扩展到视频分类
  \end{itemize}
\end{frame}

\begin{frame}
  \centering
  \Huge Thank You! \\
  \large Q \& A
\end{frame}

\end{document}
```

---

## Output Mode Specification / 输出模式说明

当用户请求 "从这个论文制作幻灯片" 时：

1. **先询问/推断演讲时长**（15分钟？30分钟？）
2. **确定主题风格**（学术用 school，技术用 lab）
3. **提取论文结构**
4. **生成完整 .tex 文件** (FULL_MODE)
5. **提供编译说明**

### Example Prompts / 示例提示词

- "Make a 20-minute presentation from this paper"
- "Create slides from [PDF/file] for academic conference"
- "Generate presentation code for paper on [topic]"
