# Hypoxanthine-LaTeX Syntax Reference (English)

Complete syntax reference for the Hypoxanthine-LaTeX framework.

## Table of Contents

1. [Entry Classes](#entry-classes)
2. [Module System](#module-system)
3. [Command Reference](#command-reference)
4. [Environment Reference](#environment-reference)
5. [Configuration Options](#configuration-options)

---

## Entry Classes

### Hypo-Note (Technical Notes)

**Purpose**: Technical notes, documentation, tutorials, course notes

**Base**: ctexbook

**Class Options**:
```latex
\documentclass[
  outputdir=build,      % Output directory
  code=true,            % Load code module
  boxes=true,           % Load box module
  refs=true,            % Load reference module
  shorthand=true,       % Enable shorthand commands
  indent=true           % Paragraph indentation
]{Hypo-Note}
```

**Setup Command**:
```latex
\HypoNoteSetup{
  title={Document Title},
  author={Author Name},
  email={email@example.com},
  date={\today},
  colorscheme=Tech       % Base, CN, Tech, Simple
}
```

**Complete Example**:
```latex
\documentclass[outputdir=build, code=true, boxes=true]{Hypo-Note}

\HypoNoteSetup{
  title={Machine Learning Basics},
  author={John Doe},
  email={john@example.com},
  date={\today},
  colorscheme=Tech
}

\begin{document}
\makecover
\tableofcontents

\chapter{Supervised Learning}
\section{Linear Regression}

\begin{definition}{Linear Regression}{lin_reg}
Linear regression is a regression analysis method...
\end{definition}

\begin{example}{Simple Linear Regression}{ex_lin}
Given data points $(x_1, y_1), \ldots, (x_n, y_n)$
\end{example}

\begin{hypocode}{python}
import numpy as np
from sklearn.linear_model import LinearRegression

X = np.array([[1], [2], [3]])
y = np.array([2, 4, 6])

model = LinearRegression()
model.fit(X, y)
print(model.predict([[4]]))  # Output: [8.]
\end{hypocode}

\img[width=0.8\linewidth, label=regression]{assets/plot.png}{Regression Results}

See \cref{def:lin_reg, ex:lin_reg, fig:regression}.

\end{document}
```

---

### Hypo-LitNote (Literature Notes)

**Purpose**: Literature notes, reading notes, poetry, prose

**Base**: ctexbook

**Features**:
- Chinese chapter numbering (第一章、一、）
- Hidden section numbering by default
- Literary boxes (poem, quotepara）
- Chinese color schemes

**Class Options**: Same as Hypo-Note

**Setup**:
```latex
\HypoNoteSetup{
  title={Dream of the Red Chamber Notes},
  author={Reader},
  colorscheme=CN  % Chinese style colors
}
```

**Literary Box Examples**:
```latex
\chapter{Reflections on Chapter 1}

\begin{poem}{Title of Poem}{poem_id}
Poem line 1,
Poem line 2.
\end{poem}

\begin{quotepara}
The opening chapter of "Dream of the Red Chamber" uses "Zhen Shiyin's dream" as an introduction...
\end{quotepara}

Inline quote: \InlineQuote{Text here}
```

---

### Hypo-CHSH (Cheatsheets)

**Purpose**: High-density reference tables, cheat sheets, syntax quick reference

**Base**: ctexart

**Class Options**:
```latex
\documentclass[
  columns=3,              % Number of columns (2-4)
  indent=false,           % No indentation by default
  outputdir=build
]{Hypo-CHSH}
```

**Features**:
- Automatic multi-column layout
- Compact spacing (reduced line height, margins）
- Code blocks default to no line numbers
- Code blocks automatically single-column (prevent overflow)

**Complete Example**:
```latex
\documentclass[columns=3]{Hypo-CHSH}

\begin{document}

\section{Python Basics}

\subsection{Data Types}

\begin{description}
  \item[int] Integer type
  \item[float] Floating point type
  \item[str] String type
  \item[list] List type
\end{description}

\subsection{Common Operations}

\begin{hypocode}{python}
# List comprehension
squares = [x**2 for x in range(10)]

# Dict comprehension
square_dict = {x: x**2 for x in range(5)}
\end{hypocode}

\section{NumPy}

\subsection{Array Creation}

\begin{hypocode}{python}
import numpy as np

a = np.array([1, 2, 3])
b = np.zeros((3, 3))
c = np.ones((2, 2))
\end{hypocode}

\end{document}
```

**Column Control**:
```latex
% Manual column break
\CHSHColumnBreak
```

---

### Hypo-Slide (Slides)

**Purpose**: Presentations, academic reports, technical talks

**Base**: ctexbeamer

**Class Options**:
```latex
\documentclass[
  theme=school,         % Theme: school, lab, lit, business
  fontset=tech,         % Font: tech, lit
  aspectratio=169,      % Ratio: 169, 43
  darkmode=false,       % Dark mode
  linecolor=colored    % Line color
]{Hypo-Slide}
```

**Setup**:
```latex
\HypoSlideSetup{
  title={Presentation Title},
  subtitle={Subtitle},
  author={Speaker},
  institute={Institution},
  date={\today},
  logo={assets/logo.png}
}
```

**Theme Details**:

| Theme | Style | Use Case |
|------|-------|----------|
| school | Academic style, clean and professional | Courses, academic reports |
| lab | Geek style, dark colors | Tech talks, lab reports |
| lit | Humanities style, soft colors | Literature, history, art |
| business | Business style, formal and clean | Business reports, project demos |

**Complete Example**:
```latex
\documentclass[theme=school, aspectratio=169]{Hypo-Slide}

\HypoSlideSetup{
  title={Machine Learning Intro},
  subtitle={Supervised Learning Basics},
  author={John Doe},
  institute={University},
  date={\today},
  logo={assets/logo.png}
}

\begin{document}

% Title page
\frame{\titlepage}

% Outline page
\begin{frame}{Outline}
  \tableofcontents
\end{frame}

\section{Introduction}

\begin{frame}{What is Machine Learning}
  Machine learning is a branch of AI...

  \begin{definition}{Machine Learning}{ml}
    Machine learning is a method for computers to learn patterns from data.
  \end{definition}
\end{frame}

\begin{frame}[fragile]{Code Example}
  % Use [fragile] option with code

  \begin{hypocode}{python}
from sklearn import svm
clf = svm.SVC()
clf.fit(X_train, y_train)
  \end{hypocode}
\end{frame}

\section{Algorithms}

\begin{frame}{Support Vector Machines}
  SVM is a binary classification model...

  \begin{itemize}
    \item Find optimal hyperplane
    \item Maximize margin
    \item Use kernel functions for non-linear problems
  \end{itemize}
\end{frame}

\end{document}
```

---

## Module System

### Hypo-Colors (Color System)

**Color Schemes**:
- `Base`: Basic color scheme (general purpose）
- `CN`: Chinese style (Morandi color palette）
- `Tech`: Technology scheme (deep blue tones）
- `Simple`: Minimalist (grayscale）

**Semantic Colors**:
```latex
% Use semantic colors instead of hardcoding
\textcolor{HypoPrimary}{primary text}
\textcolor{HypoAccent}{accent text}
\textcolor{HypoText}{normal text}
\textcolor{HypoBackground}{background}
\textcolor{HypoSurface}{surface/box background}
\textcolor{HypoBorder}{border}
```

### Hypo-Fonts (Font System)

**Font Modes**:
- `fontset=lit`: Literature mode (default for Hypo-LitNote）
  - Main: Noto Serif CJK SC
  - Emphasis: LXGW WenKai
  - Use case: Notes, literature, poetry

- `fontset=tech`: Technology mode (default for Hypo-Note, Hypo-CHSH, Hypo-Slide）
  - Main: Noto Sans CJK SC
  - Use case: Technical docs, slides, cheat sheets

### Hypo-Code (Code Module)

**Environment**: `hypocode`

**Options**:
- `linenos=true/false`: Show line numbers
- Supported languages: python, java, cpp, c, javascript, typescript, html, css, bash, latex, sql, etc.

**Note**: When using hypocode in Beamer, add `[fragile]` to the frame

### Hypo-Box (Box System)

**Technical Boxes**:
```latex
\begin{definition}{Title}{label}
  Content...
\end{definition}

\begin{example}{Title}{label}
  Content...
\end{example}

\begin{note}{Title}{label}
  Content...
\end{note}
```

**Referencing**: Use `\cref{label}` for automatic references with type prefix

### Hypo-Icon (Icon System)

**Usage**: `\HypoIcon{key}`

**Icon Categories**:

**UI/Actions**:
user, search, home, settings, check, warn, error, info,
link, download, upload, arrow, next, prev, close

**File Types**:
file, pdf, word, image, video, audio, zip, code, text

**Social Platforms**:
twitter, github, weixin, telegram, discord, zhihu, email

**Tech Stack**:
python, java, javascript, cpp, c, rust, go, html, css,
react, vue, angular, node, docker, git, linux

**Academic/Contact**:
article, book, journal, school, university, email, phone

---

## Command Reference

### Image Command

```latex
\img[width=0.8\linewidth, label=myfig]{assets/image.png}{Image Caption}

% Reference
See \cref{fig:myfig}.
```

**Parameters**:
- First argument: Options (width, label, etc.)
- Second argument: File path
- Third argument: Caption

### Math Shorthand

**Set Symbols**:
```latex
\R  % Real numbers
\N  % Natural numbers
\Z  % Integers
\Q  % Rational numbers
\C  % Complex numbers
```

**Delimiters**:
```latex
\Set{x}      % Set {x}
\Paren{x}   % Parentheses (x)
\Brack{x}   % Brackets [x]
\Abs{x}     % Absolute value |x|
```

**Styles**:
```latex
\MB{...}    % \mathbf
\MC{...}    % \mathcal
\BS{...}    % \boldsymbol
```

### Text Commands

```latex
\TX{...}    % Normal text
\TBF{...}   % Bold text
```

---

## Environment Reference

### Literary Boxes

```latex
\begin{poem}{Title}{label}
  Poem content...
\end{poem}

\begin{quotepara}
  Quote paragraph...
\end{quotepara}
```

**Inline Quote**: `\InlineQuote{text}`

### Lists

```latex
\begin{itemize}
  \item First item
  \item Second item
\end{itemize}

\begin{enumerate}
  \item First item
  \item Second item
\end{enumerate}

\begin{description}
  \item[Keyword] Description
  \item[Another] Description
\end{description}
```

### Algorithms

```latex
\begin{algorithm}
  \caption{Algorithm Name}
  \begin{algorithmic}[1]
    \State Initialize
    \For{each item}
      \State Process
    \EndFor
  \end{algorithmic}
\end{algorithm}
```

---

## Configuration Options

### Global Class Options

| Option | Values | Default | Description |
|--------|--------|----------|-------------|
| shorthand | true/false | true | Enable shorthand commands |
| indent | true/false | true | Paragraph indentation |
| boxes | true/false | true | Load box module |
| refs | true/false | true | Load reference module |
| code | true/false | true | Load code module |
| outputdir | <path> | build | Output directory |

### Color Schemes

| Scheme | Style | Use Case |
|---------|-------|----------|
| Base | General | General documents |
| CN | Chinese style | Humanities, arts |
| Tech | Technology | Technical, engineering |
| Simple | Minimalist | Clean style |

---

## Best Practices

1. **References**: Use `\cref{...}` instead of `\ref{...}`
2. **Colors**: Use semantic colors (`HypoPrimary`, etc.) instead of hardcoding
3. **Images**: Use relative paths (`assets/`)
4. **Code**: Prefer `hypocode` environment
5. **Environment Check**: Run `hypo doctor` before use
6. **Build**: Use Makefile or `scripts/hypo` scripts

---

## Common Questions

### Q: How to change fonts?

Specify `fontset` in class options:
```latex
\documentclass[fontset=lit]{Hypo-Note}    % Literature mode
\documentclass[fontset=tech]{Hypo-Slide}  % Technology mode
```

### Q: How to customize cover?

```latex
\HypoCoverSetup{
  style=modern,          % modern, classic, academic
  background=wave,        % wave, sidebar, particle, grid, frame, corner
  title={Title},
  subtitle={Subtitle},
  ...
}
\makecover
```

### Q: Code errors in Beamer?

Make sure to use `[fragile]` option:
```latex
\begin{frame}[fragile]{Title}
  \begin{hypocode}{python}
    ...
  \end{hypocode}
\end{frame}
```

### Q: How to create multi-column documents?

Use Hypo-CHSH class:
```latex
\documentclass[columns=3]{Hypo-CHSH}
```
