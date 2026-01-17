\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Hypo-LitNote}[2026/01/17 v0.9.3 Hypoxanthine Literature Note Class]

% Options:
% - Pass Hypoxanthine entry options to Hypo-Note-Core and local modules.
% - Pass unknown options to base class (ctexbook).
\RequirePackage{expl3}
\RequirePackage{l3keys2e}
\ExplSyntaxOn

\bool_new:N \g_hypo_litnote_opt_shorthand_bool
\bool_new:N \g_hypo_litnote_opt_indent_bool
\bool_new:N \g_hypo_litnote_opt_boxes_bool
\bool_new:N \g_hypo_litnote_opt_refs_bool
\bool_new:N \g_hypo_litnote_opt_algorithm_bool
\bool_new:N \g_hypo_litnote_opt_code_bool
\bool_new:N \g_hypo_litnote_opt_lists_bool
\bool_new:N \g_hypo_litnote_opt_litbox_bool
\tl_new:N   \g_hypo_litnote_opt_outputdir_tl
\tl_new:N   \g_hypo_litnote_opt_colorscheme_tl
\tl_new:N   \g_hypo_litnote_opt_chapterstyle_tl
\tl_new:N   \g_hypo_litnote_opt_sectionstyle_tl
\seq_new:N  \g_hypo_litnote_base_unknown_opts_seq
\bool_new:N \g_hypo_litnote_base_user_side_bool
\bool_new:N \g_hypo_litnote_base_user_open_bool

\cs_new_protected:Npn \hypo_litnote_collect_unknown_to_base:n #1
  {
    \tl_set:Nx \l_tmpa_tl { \l_keys_key_str }
    \tl_if_blank:nTF {#1}
      { \tl_set_eq:NN \l_tmpb_tl \l_tmpa_tl }
      { \tl_set:Nx \l_tmpb_tl { \l_tmpa_tl = {#1} } }

    \str_case:nnF { \tl_to_str:N \l_tmpa_tl }
      {
        {oneside}   { \bool_set_true:N \g_hypo_litnote_base_user_side_bool }
        {twoside}   { \bool_set_true:N \g_hypo_litnote_base_user_side_bool }
        {openany}   { \bool_set_true:N \g_hypo_litnote_base_user_open_bool }
        {openright} { \bool_set_true:N \g_hypo_litnote_base_user_open_bool }
        {openleft}  { \bool_set_true:N \g_hypo_litnote_base_user_open_bool }
      }
      { }

    \seq_put_right:NV \g_hypo_litnote_base_unknown_opts_seq \l_tmpb_tl
  }

\keys_define:nn { hypo / litnote / class }
  {
    % Back-compat: keep base=... but only book is supported now.
    base .choice:,
    base / book .code:n = { },
    base / article .code:n =
      {
        \msg_error:nnn { hypo } { note-base-article-removed } { Hypo-LitNote }
      },
    base .default:n = book,
    base .initial:n = book,

    chapterstyle .choice:,
    chapterstyle / cn .code:n = { \tl_set:Nn \g_hypo_litnote_opt_chapterstyle_tl { cn } },
    chapterstyle / en .code:n = { \tl_set:Nn \g_hypo_litnote_opt_chapterstyle_tl { en } },
    chapterstyle .default:n = cn,
    chapterstyle .initial:n = cn,

    % Section numbering style (avoid 1.1 in headings by default).
    % - outline: 一、二、三… / （一）（二）…
    % - arabic:  1,2,3… / (1)(2)…
    sectionstyle .choice:,
    sectionstyle / outline .code:n = { \tl_set:Nn \g_hypo_litnote_opt_sectionstyle_tl { outline } },
    sectionstyle / arabic  .code:n = { \tl_set:Nn \g_hypo_litnote_opt_sectionstyle_tl { arabic } },
    sectionstyle .default:n = outline,
    sectionstyle .initial:n = outline,

    shorthand .choice:,
    shorthand / true  .code:n = { \bool_set_true:N  \g_hypo_litnote_opt_shorthand_bool },
    shorthand / false .code:n = { \bool_set_false:N \g_hypo_litnote_opt_shorthand_bool },
    shorthand .default:n = true,
    shorthand .initial:n = true,

    indent .choice:,
    indent / true  .code:n = { \bool_set_true:N  \g_hypo_litnote_opt_indent_bool },
    indent / false .code:n = { \bool_set_false:N \g_hypo_litnote_opt_indent_bool },
    indent .default:n = true,
    indent .initial:n = true,

    boxes .choice:,
    boxes / true  .code:n = { \bool_set_true:N  \g_hypo_litnote_opt_boxes_bool },
    boxes / false .code:n = { \bool_set_false:N \g_hypo_litnote_opt_boxes_bool },
    boxes .default:n = true,
    boxes .initial:n = true,

    refs .choice:,
    refs / true  .code:n = { \bool_set_true:N  \g_hypo_litnote_opt_refs_bool },
    refs / false .code:n = { \bool_set_false:N \g_hypo_litnote_opt_refs_bool },
    refs .default:n = true,
    refs .initial:n = true,

    algorithm .choice:,
    algorithm / true  .code:n = { \bool_set_true:N  \g_hypo_litnote_opt_algorithm_bool },
    algorithm / false .code:n = { \bool_set_false:N \g_hypo_litnote_opt_algorithm_bool },
    algorithm .default:n = true,
    algorithm .initial:n = true,

    code .choice:,
    code / true  .code:n = { \bool_set_true:N  \g_hypo_litnote_opt_code_bool },
    code / false .code:n = { \bool_set_false:N \g_hypo_litnote_opt_code_bool },
    code .default:n = true,
    code .initial:n = true,

    lists .choice:,
    lists / true  .code:n = { \bool_set_true:N  \g_hypo_litnote_opt_lists_bool },
    lists / false .code:n = { \bool_set_false:N \g_hypo_litnote_opt_lists_bool },
    lists .default:n = true,
    lists .initial:n = true,

    litbox .choice:,
    litbox / true  .code:n = { \bool_set_true:N  \g_hypo_litnote_opt_litbox_bool },
    litbox / false .code:n = { \bool_set_false:N \g_hypo_litnote_opt_litbox_bool },
    litbox .default:n = true,
    litbox .initial:n = true,

    outputdir .tl_set:N = \g_hypo_litnote_opt_outputdir_tl,
    outputdir .initial:n = build,

    colorscheme .tl_set:N = \g_hypo_litnote_opt_colorscheme_tl,
    colorscheme .initial:n = Base,

    unknown .code:n = { \hypo_litnote_collect_unknown_to_base:n {#1} },
  }

\ProcessKeysOptions{ hypo / litnote / class }
\ExplSyntaxOff

\ExplSyntaxOn
\msg_new:nnn { hypo } { note-base-article-removed }
  { The~ #1~ class~ no~ longer~ supports~ base=article.~ Use~ the~ book~ base~ (default). }
\ExplSyntaxOff

% Pass collected unknown options to the base class, then load it.
\ExplSyntaxOn
\seq_map_inline:Nn \g_hypo_litnote_base_unknown_opts_seq
  { \PassOptionsToClass{##1}{ctexbook} }

\bool_if:NF \g_hypo_litnote_base_user_side_bool
  { \PassOptionsToClass{oneside}{ctexbook} }
\bool_if:NF \g_hypo_litnote_base_user_open_bool
  { \PassOptionsToClass{openany}{ctexbook} }

% Bake style choices into plain macros (no expl3 commands used later).
\cs_set:Npx \HypoLitNoteChapterStyle { \tl_use:N \g_hypo_litnote_opt_chapterstyle_tl }
\cs_set:Npx \HypoLitNoteSectionStyle { \tl_use:N \g_hypo_litnote_opt_sectionstyle_tl }
\ExplSyntaxOff

\LoadClass{ctexbook}

% -----------------------------------------------------------------------------
% Layout (minimal first version)
% -----------------------------------------------------------------------------
\RequirePackage{geometry}
\geometry{margin=2.4cm}

\RequirePackage{fancyhdr}
\setlength{\headheight}{14pt}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

\makeatletter
\newcommand\Hypo@ChapterMarkNumber{\thechapter}
\@ifundefined{ctexset}{}{%
  \edef\Hypo@tmpstyle{\HypoLitNoteChapterStyle}
  \def\Hypo@style@cn{cn}
  \ifx\Hypo@tmpstyle\Hypo@style@cn
    \ctexset{chapter={name={第,章},number=\chinese{chapter},aftername=\quad}}
    \renewcommand\Hypo@ChapterMarkNumber{第\chinese{chapter}章}
  \else
    \ctexset{chapter={name={,},number=\arabic{chapter},aftername=.\quad}}
    \renewcommand\Hypo@ChapterMarkNumber{\arabic{chapter}}
  \fi
}

% Section numbering: LitNote defaults to outline style to avoid “1.1” headings.
\edef\Hypo@tmpsectstyle{\HypoLitNoteSectionStyle}
\def\Hypo@sectstyle@outline{outline}
\ifx\Hypo@tmpsectstyle\Hypo@sectstyle@outline
  \renewcommand\thesection{\chinese{section}}
  \renewcommand\thesubsection{（\chinese{subsection}）}
  \renewcommand\thesubsubsection{\arabic{subsubsection}}
\else
  \renewcommand\thesection{\arabic{section}}
  \renewcommand\thesubsection{(\arabic{subsection})}
  \renewcommand\thesubsubsection{\arabic{subsubsection}}
\fi

\renewcommand{\chaptermark}[1]{\markboth{\Hypo@ChapterMarkNumber\ #1}{\Hypo@ChapterMarkNumber\ #1}}%
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}%

\if@twoside
  \fancyhead[LE]{\thepage}
  \fancyhead[RO]{\thepage}
  \fancyhead[RE]{\nouppercase{\leftmark}}
  \fancyhead[LO]{\nouppercase{\rightmark}}
\else
  \fancyhead[L]{\nouppercase{\rightmark}}
  \fancyhead[R]{\thepage}
\fi

\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \fancyfoot[C]{\thepage}%
}
\makeatother

% -----------------------------------------------------------------------------
% Load Hypoxanthine capabilities
% -----------------------------------------------------------------------------
\ExplSyntaxOn
\tl_new:N \l_hypo_litnote_core_opts_tl
\cs_new_protected:Npn \hypo_litnote_core_opts_build:
  {
    \tl_clear:N \l_hypo_litnote_core_opts_tl
    \tl_put_right:Nn \l_hypo_litnote_core_opts_tl
      {
        shorthand=\bool_if:NTF \g_hypo_litnote_opt_shorthand_bool {true}{false},
        indent=\bool_if:NTF \g_hypo_litnote_opt_indent_bool {true}{false},
        boxes=\bool_if:NTF \g_hypo_litnote_opt_boxes_bool {true}{false},
        refs=\bool_if:NTF \g_hypo_litnote_opt_refs_bool {true}{false},
        algorithm=\bool_if:NTF \g_hypo_litnote_opt_algorithm_bool {true}{false},
        code=\bool_if:NTF \g_hypo_litnote_opt_code_bool {true}{false},
        outputdir=\tl_use:N \g_hypo_litnote_opt_outputdir_tl,
        colorscheme=\tl_use:N \g_hypo_litnote_opt_colorscheme_tl
      }
  }
\hypo_litnote_core_opts_build:
\RequirePackage[\l_hypo_litnote_core_opts_tl]{Hypo-Note-Core}
\ExplSyntaxOff

% Lists + literature boxes
\ExplSyntaxOn
\bool_if:NF \g_hypo_litnote_opt_lists_bool
  { \cs_set_protected:Npn \HypoDisableLists {} }
\ExplSyntaxOff
\RequirePackage{Hypo-Lists}

\ExplSyntaxOn
\bool_if:NT \g_hypo_litnote_opt_litbox_bool
  { \ExplSyntaxOff \RequirePackage{Hypo-LitBox} \ExplSyntaxOn }
\ExplSyntaxOff

\endinput
