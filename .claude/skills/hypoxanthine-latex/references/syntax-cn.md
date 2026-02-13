# Hypoxanthine-LaTeX 语法详解 (中文)

本文档提供 Hypoxanthine-LaTeX 框架的完整语法参考。

## 目录

1. [入口类详解](#入口类详解)
2. [模块系统](#模块系统)
3. [命令参考](#命令参考)
4. [环境参考](#环境参考)
5. [配置选项](#配置选项)

---

## 入口类详解

### Hypo-Note (技术笔记)

**用途**: 理工科笔记、技术文档、教程、课程笔记

**基底**: ctexbook

**类选项**:
```latex
\documentclass[
  outputdir=build,      % 输出目录
  code=true,            % 加载代码模块
  boxes=true,           % 加载盒子模块
  refs=true,            % 加载引用模块
  shorthand=true,       % 启用速写命令
  indent=true           % 段首缩进
]{Hypo-Note}
```

**配置命令**:
```latex
\HypoNoteSetup{
  title={文档标题},
  author={作者名},
  email={email@example.com},
  date={\today},
  colorscheme=Tech       % Base, CN, Tech, Simple
}
```

**完整示例**:
```latex
\documentclass[outputdir=build, code=true, boxes=true]{Hypo-Note}

\HypoNoteSetup{
  title={机器学习基础},
  author={张三},
  email={zhangsan@example.com},
  date={2026年1��},
  colorscheme=Tech
}

\begin{document}
\makecover
\tableofcontents

\chapter{监督学习}
\section{线性回归}

\begin{definition}{线性回归}{lin_reg}
线性回归是一种回归分析方法...
\end{definition}

\begin{example}{简单线性回归}{ex_lin}
假设我们有数据点 $(x_1, y_1), \ldots, (x_n, y_n)$
\end{example}

\begin{hypocode}{python}
import numpy as np
from sklearn.linear_model import LinearRegression

X = np.array([[1], [2], [3]])
y = np.array([2, 4, 6])

model = LinearRegression()
model.fit(X, y)
print(model.predict([[4]]))  # 输出: [8.]
\end{hypocode}

\img[width=0.8\linewidth, label=regression]{assets/plot.png}{回归结果}

参见 \cref{def:lin_reg, ex:lin_reg, fig:regression}。

\end{document}
```

---

### Hypo-LitNote (文学笔记)

**用途**: 文学笔记、读书笔记、诗歌、散文

**基底**: ctexbook

**特点**:
- 默认使用中文章节编号（第一章、一、）
- 默认隐藏 section 编号
- 加载文学盒子（poem, quotepara）
- 国风配色方案

**类选项**: 与 Hypo-Note 相同

**配置**:
```latex
\HypoNoteSetup{
  title={红楼梦读书笔记},
  author={读者},
  colorscheme=CN  % 国风配色
}
```

**文学盒子示例**:
```latex
\chapter{第一回 读后感}

\begin{poem}{满纸荒唐言}{满纸}
满纸荒唐言，
一把辛酸泪。
都云作者痴，
谁解其中味。
\end{poem}

\begin{quotepara}
《红楼梦》开篇以"甄士隐梦幻识通灵"为引，通过神话与现实的交织，展现了贾府的兴衰历程。作者巧妙地运用了"真"与"甄"的谐音，暗示全书"假作真时真亦假"的主题。
\end{quotepara}

行内引用：\InlineQuote{满纸荒唐言，一把辛酸泪。}
```

---

### Hypo-CHSH (速查表)

**用途**: 高密度参考表、Cheat Sheet、语法速查

**基底**: ctexart

**类选项**:
```latex
\documentclass[
  columns=3,              % 栏数 (2-4)
  indent=false,           % 默认无缩进
  outputdir=build
]{Hypo-CHSH}
```

**特点**:
- 自动多栏布局
- 紧凑排版（压缩行距、间距）
- 代码块默认无行号
- 代码块自动单栏保护（防止跨栏溢出）

**完整示例**:
```latex
\documentclass[columns=3]{Hypo-CHSH}

\begin{document}

\section{Python 基础}

\subsection{数据类型}

\begin{description}
  \item[int] 整数类型
  \item[float] 浮点类型
  \item[str] 字符串类型
  \item[list] 列表类型
\end{description}

\subsection{常用操作}

\begin{hypocode}{python}
# 列表推导式
squares = [x**2 for x in range(10)]

# 字典推导式
square_dict = {x: x**2 for x in range(5)}
\end{hypocode}

\section{NumPy}

\subsection{数组创建}

\begin{hypocode}{python}
import numpy as np

a = np.array([1, 2, 3])
b = np.zeros((3, 3))
c = np.ones((2, 2))
\end{hypocode}

\end{document}
```

**分栏控制**:
```latex
% 手动分栏
\CHSHColumnBreak
```

---

### Hypo-Slide (幻灯片)

**用途**: 演示文稿、学术报告、技术分享

**基底**: ctexbeamer

**类选项**:
```latex
\documentclass[
  theme=school,         % 主题: school, lab, lit, business
  fontset=tech,         % 字体: tech, lit
  aspectratio=169,      % 比例: 169, 43
  darkmode=false,       % 暗色模式
  linecolor=colored    % 线条颜色
]{Hypo-Slide}
```

**配置**:
```latex
\HypoSlideSetup{
  title={演示标题},
  subtitle={副标题},
  author={演讲者},
  institute={机构},
  date={\today},
  logo={assets/logo.png}
}
```

**主题详情**:

| 主题 | 风格 | 适用场景 |
|------|------|----------|
| school | 学术风格，清爽专业 | 课程、学术报告 |
| lab | 极客风格，深色系 | 技术分享、实验室报告 |
| lit | 人文风格，柔和配色 | 文学、历史、艺术 |
| business | 商业风格，正式简洁 | 商务汇报、项目展示 |

**完整示例**:
```latex
\documentclass[theme=school, aspectratio=169]{Hypo-Slide}

\HypoSlideSetup{
  title={机器学习入门},
  subtitle={监督学习基础},
  author={张三},
  institute={某某大学},
  date={\today},
  logo={assets/logo.png}
}

\begin{document}

% 标题页
\frame{\titlepage}

% 大纲页
\begin{frame}{大纲}
  \tableofcontents
\end{frame}

\section{简介}

\begin{frame}{什么是机器学习}
  机器学习是人工智能的一个分支...

  \begin{definition}{机器学习}{ml}
    机器学习是让计算机从数据中学习规律的方法。
  \end{definition}
\end{frame}

\begin{frame}[fragile]{代码示例}
  % 使用代码时需要 [fragile] 选项

  \begin{hypocode}{python}
from sklearn import svm
clf = svm.SVC()
clf.fit(X_train, y_train)
  \end{hypocode}
\end{frame}

\section{算法}

\begin{frame}{支持向量机}
  支持向量机是一种二分类模型...

  \begin{itemize}
    \item 寻找最优超平面
    \item 最大化分类间隔
    \item 使用核函数处理非线性问题
  \end{itemize}
\end{frame}

\end{document}
```

---

## 模块系统

### Hypo-Colors (颜色系统)

**配色方案**:
- `Base`: 基础配色（通用）
- `CN`: 国风配色（莫兰迪色系）
- `Tech`: 科技配色（深蓝系）
- `Simple`: 极简配色（黑白灰）

**语义化颜色**:
```latex
% 使用语义化颜色而非硬编码
\textcolor{HypoPrimary}{主色文本}
\textcolor{HypoAccent}{强调文本}
\textcolor{HypoText}{普通文本}
\textcolor{HypoBackground}{背景}
\textcolor{HypoSurface}{表面/盒子背景}
\textcolor{HypoBorder}{边框}
```

### Hypo-Fonts (字体系统)

**字体模式**:
- `fontset=lit`: 文学模式（默认）
  - 主字体: Noto Serif CJK SC (思源宋体)
  - 强调字体: LXGW WenKai (霞鹜文楷)
  - 适用: 笔记、文学、诗歌

- `fontset=tech`: 技术模式
  - 主字体: Noto Sans CJK SC (思源黑体)
  - 适用: 技术文档、幻灯片、速查表

### Hypo-Code (代码模块)

**环境**: `hypocode`

**选项**:
- `linenos=true/false`: 显示行号
- 支持语言: python, java, cpp, c, javascript, typescript, html, css, bash, latex, sql 等

**注意**: 在 Beamer 中使用 hypocode 时，需要给 frame 添加 `[fragile]` 选项

### Hypo-Box (盒子系统)

**技术盒子**:
```latex
\begin{definition}{标题}{label}
  内容...
\end{definition}

\begin{example}{标题}{label}
  内容...
\end{example}

\begin{note}{标题}{label}
  内容...
\end{note}
```

**引用**: 使用 `\cref{label}` 自动引用（带类型前缀）

### Hypo-Icon (图标系统)

**使用**: `\HypoIcon{key}`

**图标类别**:

**界面/操作**:
user, search, home, settings, check, warn, error, info,
link, download, upload, arrow, next, prev, close

**文件类型**:
file, pdf, word, image, video, audio, zip, code, text

**社交平台**:
twitter, github, weixin, telegram, discord, zhihu, email

**技术栈**:
python, java, javascript, cpp, c, rust, go, html, css,
react, vue, angular, node, docker, git, linux

**学术/联系**:
article, book, journal, school, university, email, phone

---

## 命令参考

### 图像命令

```latex
\img[width=0.8\linewidth, label=myfig]{assets/image.png}{图片标题}

% 引用
参见 \cref{fig:myfig}。
```

**参数**:
- 第一个参数: 选项（width, label 等）
- 第二个参数: 文件路径
- 第三个参数: 标题

### 数学速写

**集合符号**:
```latex
\R  % 实数集
\N  % 自然数集
\Z  % 整数集
\Q  % 有理数集
\C  % 复数集
```

**定界符**:
```latex
\Set{x}      % 集合 {x}
\Paren{x}   % 圆括号 (x)
\Brack{x}   % 方括号 [x]
\Abs{x}     % 绝对值 |x|
```

**样式**:
```latex
\MB{...}    % \mathbf
\MC{...}    % \mathcal
\BS{...}    % \boldsymbol
```

### 文本命令

```latex
\TX{...}    % 普通文本
\TBF{...}   % 加粗文本
```

---

## 环境参考

### 文学盒子

```latex
\begin{poem}{标题}{label}
  诗歌内容...
\end{poem}

\begin{quotepara}
  引用段落...
\end{quotepara}
```

**行内引用**: `\InlineQuote{文本}`

### 列表

```latex
\begin{itemize}
  \item 第一项
  \item 第二项
\end{itemize}

\begin{enumerate}
  \item 第一项
  \item 第二项
\end{enumerate}

\begin{description}
  \item[关键词] 描述
  \item[另一个] 描述
\end{description}
```

### 算法

```latex
\begin{algorithm}
  \caption{算法名称}
  \begin{algorithmic}[1]
    \State 初始化
    \For{each item}
      \State 处理
    \EndFor
  \end{algorithmic}
\end{algorithm}
```

---

## 配置选项

### 全局类选项

| 选项 | 值 | 默认值 | 说明 |
|------|-----|--------|------|
| shorthand | true/false | true | 启用速写命令 |
| indent | true/false | true | 段首缩进 |
| boxes | true/false | true | 加载盒子模块 |
| refs | true/false | true | 加载引用模块 |
| code | true/false | true | 加载代码模块 |
| outputdir | <path> | build | 输出目录 |

### 颜色方案

| 方案 | 风格 | 适用场景 |
|------|------|----------|
| Base | 通用 | 一般文档 |
| CN | 国风/莫兰迪 | 人文、艺术 |
| Tech | 科技/深蓝 | 技术、理工 |
| Simple | 极简灰 | 简洁风格 |

---

## 最佳实践

1. **引用**: 使用 `\cref{...}` 而非 `\ref{...}`
2. **颜色**: 使用语义化颜色（`HypoPrimary` 等）而非硬编码
3. **图片**: 使用相对路径（`assets/`）
4. **代码**: 优先使用 `hypocode` 环境
5. **环境检查**: 使用前运行 `hypo doctor`
6. **构建**: 使用 Makefile 或 `scripts/hypo` 脚本

---

## 常见问题

### Q: 如何更改字体？

在类选项中指定 `fontset`:
```latex
\documentclass[fontset=lit]{Hypo-Note}  % 文学模式
\documentclass[fontset=tech]{Hypo-Slide} % 技术模式
```

### Q: 如何自定义封面？

```latex
\HypoCoverSetup{
  style=modern,          % modern, classic, academic
  background=wave,       % wave, sidebar, particle, grid, frame, corner
  title={标题},
  subtitle={副标题},
  ...
}
\makecover
```

### Q: Beamer 中代码出错？

确保使用 `[fragile]` 选项:
```latex
\begin{frame}[fragile]{标题}
  \begin{hypocode}{python}
    ...
  \end{hypocode}
\end{frame}
```

### Q: 如何创建多栏文档？

使用 Hypo-CHSH 类:
```latex
\documentclass[columns=3]{Hypo-CHSH}
```
