\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Hypo-Note}[2026/01/26 v1.2.0 Hypoxanthine Note Class]

% Route options: pass Hypo-Note specific options to Hypo-Note-Core,
% and pass everything else to the base class (ctexbook).
\RequirePackage{expl3}
\RequirePackage{l3keys2e}
\ExplSyntaxOn

\bool_new:N \g_hypo_note_opt_shorthand_bool
\bool_new:N \g_hypo_note_opt_indent_bool
\bool_new:N \g_hypo_note_opt_boxes_bool
\bool_new:N \g_hypo_note_opt_refs_bool
\bool_new:N \g_hypo_note_opt_algorithm_bool
\bool_new:N \g_hypo_note_opt_code_bool
\bool_new:N \g_hypo_note_opt_lists_bool
\tl_new:N   \g_hypo_note_opt_outputdir_tl
\tl_new:N   \g_hypo_note_opt_colorscheme_tl
\tl_new:N   \g_hypo_note_opt_chapterstyle_tl
\seq_new:N  \g_hypo_note_base_unknown_opts_seq
\bool_new:N \g_hypo_note_base_user_side_bool
\bool_new:N \g_hypo_note_base_user_open_bool

\cs_new_protected:Npn \hypo_note_collect_unknown_to_base:n #1
  {
    \tl_set:Nx \l_tmpa_tl { \l_keys_key_str }
    \tl_if_blank:nTF {#1}
      { \tl_set_eq:NN \l_tmpb_tl \l_tmpa_tl }
      { \tl_set:Nx \l_tmpb_tl { \l_tmpa_tl = {#1} } }

    % Track whether the user explicitly chose oneside/twoside or openany/openright/openleft.
    \str_case:nnF { \tl_to_str:N \l_tmpa_tl }
      {
        {oneside}   { \bool_set_true:N \g_hypo_note_base_user_side_bool }
        {twoside}   { \bool_set_true:N \g_hypo_note_base_user_side_bool }
        {openany}   { \bool_set_true:N \g_hypo_note_base_user_open_bool }
        {openright} { \bool_set_true:N \g_hypo_note_base_user_open_bool }
        {openleft}  { \bool_set_true:N \g_hypo_note_base_user_open_bool }
      }
      { }

    \seq_put_right:NV \g_hypo_note_base_unknown_opts_seq \l_tmpb_tl
  }

\keys_define:nn { hypo / note / class }
  {
    % Back-compat: keep base=... but only book is supported now.
    base .choice:,
    base / book .code:n = { },
    base / article .code:n =
      {
        \msg_error:nnn { hypo } { note-base-article-removed } { Hypo-Note }
      },
    base .default:n = book,
    base .initial:n = book,

    chapterstyle .choice:,
    chapterstyle / cn .code:n = { \tl_set:Nn \g_hypo_note_opt_chapterstyle_tl { cn } },
    chapterstyle / en .code:n = { \tl_set:Nn \g_hypo_note_opt_chapterstyle_tl { en } },
    chapterstyle .default:n = en,
    chapterstyle .initial:n = en,
    shorthand .choice:,
    shorthand / true  .code:n = { \bool_set_true:N  \g_hypo_note_opt_shorthand_bool },
    shorthand / false .code:n = { \bool_set_false:N \g_hypo_note_opt_shorthand_bool },
    shorthand .default:n = true,
    shorthand .initial:n = true,

    indent .choice:,
    indent / true  .code:n = { \bool_set_true:N  \g_hypo_note_opt_indent_bool },
    indent / false .code:n = { \bool_set_false:N \g_hypo_note_opt_indent_bool },
    indent .default:n = true,
    indent .initial:n = true,

    boxes .choice:,
    boxes / true  .code:n = { \bool_set_true:N  \g_hypo_note_opt_boxes_bool },
    boxes / false .code:n = { \bool_set_false:N \g_hypo_note_opt_boxes_bool },
    boxes .default:n = true,
    boxes .initial:n = true,

    refs .choice:,
    refs / true  .code:n = { \bool_set_true:N  \g_hypo_note_opt_refs_bool },
    refs / false .code:n = { \bool_set_false:N \g_hypo_note_opt_refs_bool },
    refs .default:n = true,
    refs .initial:n = true,

    algorithm .choice:,
    algorithm / true  .code:n = { \bool_set_true:N  \g_hypo_note_opt_algorithm_bool },
    algorithm / false .code:n = { \bool_set_false:N \g_hypo_note_opt_algorithm_bool },
    algorithm .default:n = true,
    algorithm .initial:n = true,

    code .choice:,
    code / true  .code:n = { \bool_set_true:N  \g_hypo_note_opt_code_bool },
    code / false .code:n = { \bool_set_false:N \g_hypo_note_opt_code_bool },
    code .default:n = true,
    code .initial:n = true,

    lists .choice:,
    lists / true  .code:n = { \bool_set_true:N  \g_hypo_note_opt_lists_bool },
    lists / false .code:n = { \bool_set_false:N \g_hypo_note_opt_lists_bool },
    lists .default:n = true,
    lists .initial:n = true,

    outputdir .tl_set:N = \g_hypo_note_opt_outputdir_tl,
    outputdir .initial:n = build,

    colorscheme .tl_set:N = \g_hypo_note_opt_colorscheme_tl,
    colorscheme .initial:n = Base,

    fontset .tl_set:N = \g_hypo_note_opt_fontset_tl,
    fontset .initial:n = tech,

    unknown .code:n = { \hypo_note_collect_unknown_to_base:n {#1} },
  }

\ProcessKeysOptions{ hypo / note / class }
\ExplSyntaxOff

\ExplSyntaxOn
\msg_new:nnn { hypo } { note-base-article-removed }
  { The~ #1~ class~ no~ longer~ supports~ base=article.~ Use~ the~ book~ base~ (default). }
\ExplSyntaxOff

% Pass collected unknown options to the base class, then load it.
\ExplSyntaxOn
\seq_map_inline:Nn \g_hypo_note_base_unknown_opts_seq
  { \PassOptionsToClass{##1}{ctexbook} }

% Default to a note-friendly pagination unless the user overrides.
\bool_if:NF \g_hypo_note_base_user_side_bool
  { \PassOptionsToClass{oneside}{ctexbook} }
\bool_if:NF \g_hypo_note_base_user_open_bool
  { \PassOptionsToClass{openany}{ctexbook} }

% Bake style choices into plain macros (no expl3 commands used later).
\cs_set:Npx \HypoNoteChapterStyle { \tl_use:N \g_hypo_note_opt_chapterstyle_tl }
\ExplSyntaxOff

\LoadClass{ctexbook}

% ------------------------------------------------------------------------------
% Style: layout + header/footer
% ------------------------------------------------------------------------------
\RequirePackage{geometry}
\geometry{margin=2.4cm}

\RequirePackage{fancyhdr}
\setlength{\headheight}{14pt}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% Chapter style (cn: "第一章"; en: "1.") and marks.
\makeatletter
\newcommand\Hypo@ChapterMarkNumber{\thechapter}
\@ifundefined{ctexset}{}{%
  \edef\Hypo@tmpstyle{\HypoNoteChapterStyle}
  \def\Hypo@style@cn{cn}
  \ifx\Hypo@tmpstyle\Hypo@style@cn
    % Prefer "第一章" style (Chinese numerals).
    \ctexset{chapter={name={第,章},number=\chinese{chapter},aftername=\quad}}
    \renewcommand\Hypo@ChapterMarkNumber{第\chinese{chapter}章}
  \else
    % Prefer plain Arabic numbering "1.".
    \ctexset{chapter={name={,},number=\arabic{chapter},aftername=.\quad}}
    % For technical notes, keep section-like headings consistent: "1.1.".
    \ctexset{section={aftername=.\quad},subsection={aftername=.\quad},subsubsection={aftername=.\quad}}
    \renewcommand\Hypo@ChapterMarkNumber{\arabic{chapter}}
  \fi
}

% leftmark = chapter, rightmark = section
\renewcommand{\chaptermark}[1]{\markboth{\Hypo@ChapterMarkNumber\ #1}{\Hypo@ChapterMarkNumber\ #1}}%
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}%

% Header/footer layout:
% - twoside: inner header = chapter, outer header = section, outer header = page
% - oneside: left header = section, right header = page
\if@twoside
  \fancyhead[LE]{\thepage}
  \fancyhead[RO]{\thepage}
  \fancyhead[RE]{\nouppercase{\leftmark}}
  \fancyhead[LO]{\nouppercase{\rightmark}}
\else
  \fancyhead[L]{\nouppercase{\rightmark}}
  \fancyhead[R]{\thepage}
\fi

% Chapter opening pages use plain pagestyle in book; make it clean.
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \fancyfoot[C]{\thepage}%
}
\makeatother

% ------------------------------------------------------------------------------
% Load Hypoxanthine capabilities and icons
% ------------------------------------------------------------------------------
\ExplSyntaxOn
\tl_new:N \l_hypo_note_core_opts_tl
\cs_new_protected:Npn \hypo_note_core_opts_build:
  {
    \tl_clear:N \l_hypo_note_core_opts_tl
    \tl_put_right:Nn \l_hypo_note_core_opts_tl
      {
        shorthand=\bool_if:NTF \g_hypo_note_opt_shorthand_bool {true}{false},
        indent=\bool_if:NTF \g_hypo_note_opt_indent_bool {true}{false},
        boxes=\bool_if:NTF \g_hypo_note_opt_boxes_bool {true}{false},
        refs=\bool_if:NTF \g_hypo_note_opt_refs_bool {true}{false},
        algorithm=\bool_if:NTF \g_hypo_note_opt_algorithm_bool {true}{false},
        code=\bool_if:NTF \g_hypo_note_opt_code_bool {true}{false},
        lists=\bool_if:NTF \g_hypo_note_opt_lists_bool {true}{false},
        outputdir=\tl_use:N \g_hypo_note_opt_outputdir_tl,
        colorscheme=\tl_use:N \g_hypo_note_opt_colorscheme_tl,
        fontset=\tl_use:N \g_hypo_note_opt_fontset_tl
      }
  }
\hypo_note_core_opts_build:
\RequirePackage[\l_hypo_note_core_opts_tl]{Hypo-Note-Core}
\ExplSyntaxOff

% (Hypo-Icon is now loaded by Hypo-Note-Core)

% ------------------------------------------------------------------------------
% Metadata + cover
% ------------------------------------------------------------------------------
\RequirePackage{xparse}
\ExplSyntaxOn
\tl_new:N \g_hypo_note_title_tl
\tl_new:N \g_hypo_note_subtitle_tl
\tl_new:N \g_hypo_note_author_tl
\tl_new:N \g_hypo_note_email_tl
\tl_new:N \g_hypo_note_homepage_tl
\tl_new:N \g_hypo_note_affil_tl
\tl_new:N \g_hypo_note_date_tl

\keys_define:nn { hypo / note }
  {
    title       .tl_set:N = \g_hypo_note_title_tl,
    subtitle    .tl_set:N = \g_hypo_note_subtitle_tl,
    author      .tl_set:N = \g_hypo_note_author_tl,
    email       .tl_set:N = \g_hypo_note_email_tl,
    homepage    .tl_set:N = \g_hypo_note_homepage_tl,
    affiliation .tl_set:N = \g_hypo_note_affil_tl,
    date        .tl_set:N = \g_hypo_note_date_tl,
  }

\NewDocumentCommand \HypoNoteSetup { m }
  { \keys_set:nn { hypo / note } {#1} }

\NewDocumentCommand \HypoSetTitle { m } { \HypoNoteSetup{title={#1}} }
\NewDocumentCommand \HypoSetSubtitle { m } { \HypoNoteSetup{subtitle={#1}} }
\NewDocumentCommand \HypoSetAuthor { m } { \HypoNoteSetup{author={#1}} }
\NewDocumentCommand \HypoSetEmail { m } { \HypoNoteSetup{email={#1}} }
\NewDocumentCommand \HypoSetHomepage { m } { \HypoNoteSetup{homepage={#1}} }
\NewDocumentCommand \HypoSetAffiliation { m } { \HypoNoteSetup{affiliation={#1}} }
\NewDocumentCommand \HypoSetDate { m } { \HypoNoteSetup{date={#1}} }

\cs_new:Npn \hypo_note_hdr_title: {\tl_use:N \g_hypo_note_title_tl}
\cs_new:Npn \hypo_note_hdr_author: {\tl_use:N \g_hypo_note_author_tl}

\cs_new_protected:Npn \hypo_note_cover_line:nn #1 #2
  {
    \tl_if_blank:nTF {#2}
      { }
      { \par\noindent #1\,\texttt{#2} }
  }

\cs_new_protected:Npn \hypo_note_cover_date:n #1
  {
    {\small \noindent\makebox[\linewidth][c]{\strut #1}\par}
  }

\cs_new_protected:Npn \HypoNoteMakeCover
  {
    \bool_set_false:N \l_tmpa_bool
    \tl_if_blank:VTF \g_hypo_note_title_tl { } { \bool_set_true:N \l_tmpa_bool }
    \tl_if_blank:VTF \g_hypo_note_subtitle_tl { } { \bool_set_true:N \l_tmpa_bool }
    \tl_if_blank:VTF \g_hypo_note_author_tl { } { \bool_set_true:N \l_tmpa_bool }
    \tl_if_blank:VTF \g_hypo_note_affil_tl { } { \bool_set_true:N \l_tmpa_bool }
    \tl_if_blank:VTF \g_hypo_note_email_tl { } { \bool_set_true:N \l_tmpa_bool }
    \tl_if_blank:VTF \g_hypo_note_homepage_tl { } { \bool_set_true:N \l_tmpa_bool }

    \bool_if:NF \l_tmpa_bool
      {
        \PackageWarningNoLine{Hypo-Note}{\string\makecover\space called but no metadata is set. Use \string\HypoNoteSetup\space first.}
      }

    \bool_if:NT \l_tmpa_bool
      {
        \begin{titlepage}
          \thispagestyle{empty}
          \centering
          \vspace*{0.18\textheight}

          \tl_if_blank:VTF \g_hypo_note_title_tl
            { }
            { {\Huge\bfseries \tl_use:N \g_hypo_note_title_tl\par} }
          \tl_if_blank:VTF \g_hypo_note_subtitle_tl
            { }
            { \vspace{0.8em}{\Large \tl_use:N \g_hypo_note_subtitle_tl\par} }

          \vspace{2.0em}

          \tl_if_blank:VTF \g_hypo_note_author_tl
            { }
            { {\large \tl_use:N \g_hypo_note_author_tl\par} }
          \tl_if_blank:VTF \g_hypo_note_affil_tl
            { }
            { \vspace{0.3em}{\normalsize \tl_use:N \g_hypo_note_affil_tl\par} }

          \vfill

          \begin{minipage}{0.85\textwidth}
            \raggedright
            \hypo_note_cover_line:nn {\HypoIcon{email}} {\tl_use:N \g_hypo_note_email_tl}
            \hypo_note_cover_line:nn {\HypoIcon{homepage}} {\tl_use:N \g_hypo_note_homepage_tl}
          \end{minipage}

          \vspace{1.2em}

          \tl_if_blank:VTF \g_hypo_note_date_tl
            { \hypo_note_cover_date:n {\today} }
            { \hypo_note_cover_date:n {\tl_use:N \g_hypo_note_date_tl} }

        \end{titlepage}
        \setcounter{page}{1}
      }
  }

\NewDocumentCommand \makecover { } { \HypoNoteMakeCover }
\ExplSyntaxOff

\endinput
