\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Hypo-CHSH}[2026/01/26 v1.2.0 Hypoxanthine CheatSheet Class]

% CHSH is an independent entry.
% - Base class: ctexart
% - Paper sizing: keep A4 area * areascale, allow custom aspect ratio (W/H)
% - Multi-column layout via multicol

\RequirePackage{expl3}
\RequirePackage{l3keys2e}
\ExplSyntaxOn

\bool_new:N \g_hypo_chsh_opt_shorthand_bool
\bool_new:N \g_hypo_chsh_opt_indent_bool
\bool_new:N \g_hypo_chsh_opt_boxes_bool
\bool_new:N \g_hypo_chsh_opt_refs_bool
\bool_new:N \g_hypo_chsh_opt_algorithm_bool
\bool_new:N \g_hypo_chsh_opt_code_bool
\bool_new:N \g_hypo_chsh_opt_lists_bool
\bool_new:N \g_hypo_chsh_opt_balance_bool
\bool_new:N \g_hypo_chsh_opt_codelinenos_bool

\int_new:N  \g_hypo_chsh_opt_columns_int
\dim_new:N  \g_hypo_chsh_opt_colsep_dim
\tl_new:N   \g_hypo_chsh_opt_outputdir_tl
\tl_new:N   \g_hypo_chsh_opt_colorscheme_tl
\tl_new:N   \g_hypo_chsh_opt_chapterbreak_tl

\tl_new:N   \g_hypo_chsh_opt_paperarea_tl
\fp_new:N   \g_hypo_chsh_opt_areascale_fp
\fp_new:N   \g_hypo_chsh_opt_paperaspect_fp

\tl_new:N   \g_hypo_chsh_opt_textsize_tl

\bool_new:N \g_hypo_chsh_in_multicols_bool
\bool_new:N \g_hypo_chsh_in_multicols_star_bool
\bool_new:N \g_hypo_chsh_code_suspended_cols_bool

\cs_new_protected:Npn \hypo_chsh_pass_unknown_to_base:n #1
  {
    \tl_set:Nx \l_tmpa_tl { \l_keys_key_str }
    \tl_if_blank:nTF {#1}
      { \PassOptionsToClass{\l_tmpa_tl}{ctexart} }
      {
        \tl_set:Nx \l_tmpb_tl { \l_tmpa_tl = {#1} }
        \PassOptionsToClass{\l_tmpb_tl}{ctexart}
      }
  }

\keys_define:nn { hypo / chsh / class }
  {
    shorthand .choice:,
    shorthand / true  .code:n = { \bool_set_true:N  \g_hypo_chsh_opt_shorthand_bool },
    shorthand / false .code:n = { \bool_set_false:N \g_hypo_chsh_opt_shorthand_bool },
    shorthand .default:n = true,
    shorthand .initial:n = true,

    indent .choice:,
    indent / true  .code:n = { \bool_set_true:N  \g_hypo_chsh_opt_indent_bool },
    indent / false .code:n = { \bool_set_false:N \g_hypo_chsh_opt_indent_bool },
    indent .default:n = false,
    indent .initial:n = false,

    boxes .choice:,
    boxes / true  .code:n = { \bool_set_true:N  \g_hypo_chsh_opt_boxes_bool },
    boxes / false .code:n = { \bool_set_false:N \g_hypo_chsh_opt_boxes_bool },
    boxes .default:n = true,
    boxes .initial:n = true,

    refs .choice:,
    refs / true  .code:n = { \bool_set_true:N  \g_hypo_chsh_opt_refs_bool },
    refs / false .code:n = { \bool_set_false:N \g_hypo_chsh_opt_refs_bool },
    refs .default:n = true,
    refs .initial:n = true,

    algorithm .choice:,
    algorithm / true  .code:n = { \bool_set_true:N  \g_hypo_chsh_opt_algorithm_bool },
    algorithm / false .code:n = { \bool_set_false:N \g_hypo_chsh_opt_algorithm_bool },
    algorithm .default:n = false,
    algorithm .initial:n = false,

    code .choice:,
    code / true  .code:n = { \bool_set_true:N  \g_hypo_chsh_opt_code_bool },
    code / false .code:n = { \bool_set_false:N \g_hypo_chsh_opt_code_bool },
    code .default:n = true,
    code .initial:n = true,

    lists .choice:,
    lists / true  .code:n = { \bool_set_true:N  \g_hypo_chsh_opt_lists_bool },
    lists / false .code:n = { \bool_set_false:N \g_hypo_chsh_opt_lists_bool },
    lists .default:n = true,
    lists .initial:n = true,

    balance .choice:,
    balance / true  .code:n = { \bool_set_true:N  \g_hypo_chsh_opt_balance_bool },
    balance / false .code:n = { \bool_set_false:N \g_hypo_chsh_opt_balance_bool },
    balance .default:n = false,
    balance .initial:n = false,

    codelinenos .choice:,
    codelinenos / true  .code:n = { \bool_set_true:N  \g_hypo_chsh_opt_codelinenos_bool },
    codelinenos / false .code:n = { \bool_set_false:N \g_hypo_chsh_opt_codelinenos_bool },
    codelinenos .default:n = false,
    codelinenos .initial:n = false,

    outputdir .tl_set:N = \g_hypo_chsh_opt_outputdir_tl,
    outputdir .initial:n = build,

    colorscheme .tl_set:N = \g_hypo_chsh_opt_colorscheme_tl,
    colorscheme .initial:n = Base,

    columns .int_set:N = \g_hypo_chsh_opt_columns_int,
    columns .initial:n = 3,

    colsep .dim_set:N = \g_hypo_chsh_opt_colsep_dim,
    colsep .initial:n = 10pt,

    chapterbreak .choice:,
    chapterbreak / none   .code:n = { \tl_set:Nn \g_hypo_chsh_opt_chapterbreak_tl { none } },
    chapterbreak / column .code:n = { \tl_set:Nn \g_hypo_chsh_opt_chapterbreak_tl { column } },
    chapterbreak / page   .code:n = { \tl_set:Nn \g_hypo_chsh_opt_chapterbreak_tl { page } },
    chapterbreak .default:n = none,
    chapterbreak .initial:n = none,

    paperarea .tl_set:N = \g_hypo_chsh_opt_paperarea_tl,
    paperarea .initial:n = a4,

    areascale .fp_set:N = \g_hypo_chsh_opt_areascale_fp,
    areascale .initial:n = 1,

    paperaspect .fp_set:N = \g_hypo_chsh_opt_paperaspect_fp,
    paperaspect .initial:n = 0.7070707071, % 210/297

    textsize .choice:,
    textsize / normal      .code:n = { \tl_set:Nn \g_hypo_chsh_opt_textsize_tl { normal } },
    textsize / small       .code:n = { \tl_set:Nn \g_hypo_chsh_opt_textsize_tl { small } },
    textsize / footnotesize .code:n = { \tl_set:Nn \g_hypo_chsh_opt_textsize_tl { footnotesize } },
    textsize / scriptsize  .code:n = { \tl_set:Nn \g_hypo_chsh_opt_textsize_tl { scriptsize } },
    textsize .default:n = footnotesize,
    textsize .initial:n = footnotesize,

    unknown .code:n = { \hypo_chsh_pass_unknown_to_base:n {#1} },
  }

\ProcessKeysOptions{ hypo / chsh / class }
\ExplSyntaxOff

\LoadClass{ctexart}

% -----------------------------------------------------------------------------
% Paper sizing: A4 area * areascale, keep aspect ratio (W/H)
% -----------------------------------------------------------------------------
\ExplSyntaxOn
\fp_new:N \l_hypo_chsh_a_area_fp
\fp_new:N \l_hypo_chsh_area_fp
\fp_new:N \l_hypo_chsh_w_fp
\fp_new:N \l_hypo_chsh_h_fp

\cs_new_protected:Npn \hypo_chsh_set_papersize:
  {
    \tl_if_eq:NnF \g_hypo_chsh_opt_paperarea_tl { a4 }
      {
        \msg_warning:nnn { hypo } { chsh-paperarea-unsupported } { \tl_use:N \g_hypo_chsh_opt_paperarea_tl }
      }

    \fp_compare:nNnTF { \g_hypo_chsh_opt_areascale_fp } > { 0 }
      { }
      {
        \msg_error:nnn { hypo } { chsh-areascale-nonpositive } { \fp_use:N \g_hypo_chsh_opt_areascale_fp }
      }

    \fp_compare:nNnTF { \g_hypo_chsh_opt_paperaspect_fp } > { 0 }
      { }
      {
        \msg_error:nnn { hypo } { chsh-paperaspect-nonpositive } { \fp_use:N \g_hypo_chsh_opt_paperaspect_fp }
      }

    % Use mm as numeric base.
    % NOTE: expl3 control sequence names cannot contain digits (TeX rule).
    % So we avoid names like "...a4...".
    \fp_set:Nn \l_hypo_chsh_a_area_fp { 210 * 297 }
    \fp_set:Nn \l_hypo_chsh_area_fp { \l_hypo_chsh_a_area_fp * \g_hypo_chsh_opt_areascale_fp }

    \fp_set:Nn \l_hypo_chsh_w_fp { sqrt( \l_hypo_chsh_area_fp * \g_hypo_chsh_opt_paperaspect_fp ) }
    \fp_set:Nn \l_hypo_chsh_h_fp { sqrt( \l_hypo_chsh_area_fp / \g_hypo_chsh_opt_paperaspect_fp ) }

    \iow_log:x
      {
        (Hypo-CHSH)~PaperCalc:~areascale=\fp_to_decimal:N\g_hypo_chsh_opt_areascale_fp,
        ~aspect=\fp_to_decimal:N\g_hypo_chsh_opt_paperaspect_fp,
        ~A(mm2)=\fp_to_decimal:N\l_hypo_chsh_area_fp,
        ~W(mm)=\fp_to_decimal:N\l_hypo_chsh_w_fp,
        ~H(mm)=\fp_to_decimal:N\l_hypo_chsh_h_fp
      }

    % \\l_hypo_chsh_*_fp are numeric values in mm.
    \setlength{\paperwidth}{\fp_to_decimal:N \l_hypo_chsh_w_fp mm}
    \setlength{\paperheight}{\fp_to_decimal:N \l_hypo_chsh_h_fp mm}

    \iow_log:x
      {
        (Hypo-CHSH)~PaperSize~=~\the\paperwidth~x~\the\paperheight
      }
  }

\msg_new:nnn { hypo } { chsh-paperarea-unsupported }
  { CHSH~paperarea~'#1'~unsupported;~fallback~to~a4. }
\msg_new:nnn { hypo } { chsh-areascale-nonpositive }
  { CHSH~areascale~must~be~positive;~got~'#1'. }
\msg_new:nnn { hypo } { chsh-paperaspect-nonpositive }
  { CHSH~paperaspect~must~be~positive;~got~'#1'. }

\hypo_chsh_set_papersize:
\ExplSyntaxOff

\RequirePackage{geometry}
\geometry{margin=1.2cm}

% -----------------------------------------------------------------------------
% Multi-column scaffolding
% -----------------------------------------------------------------------------
\RequirePackage{multicol}
\setlength{\premulticols}{0pt}
\setlength{\postmulticols}{0pt}
\setlength{\multicolsep}{4pt}

\newcommand{\CHSHColumnBreak}{\columnbreak}

\ExplSyntaxOn
\cs_new_protected:Npn \hypo_chsh_setup_columns:
  {
    \setlength{\columnsep}{\dim_use:N \g_hypo_chsh_opt_colsep_dim}
  }

\cs_new_protected:Npn \hypo_chsh_begin_multicols_if_needed:
  {
    \int_compare:nNnTF { \g_hypo_chsh_opt_columns_int } > { 1 }
      {
        \bool_set_true:N \g_hypo_chsh_in_multicols_bool
        \bool_if:NTF \g_hypo_chsh_opt_balance_bool
          {
            \bool_set_false:N \g_hypo_chsh_in_multicols_star_bool
            \begin{multicols}{\int_use:N \g_hypo_chsh_opt_columns_int}
          }
          {
            \bool_set_true:N \g_hypo_chsh_in_multicols_star_bool
            \begin{multicols*}{\int_use:N \g_hypo_chsh_opt_columns_int}
          }
      }
      {
        \bool_set_false:N \g_hypo_chsh_in_multicols_bool
        \bool_set_false:N \g_hypo_chsh_in_multicols_star_bool
      }
  }

\cs_new_protected:Npn \hypo_chsh_end_multicols_if_needed:
  {
    \bool_if:NT \g_hypo_chsh_in_multicols_bool
      {
        \bool_if:NTF \g_hypo_chsh_in_multicols_star_bool
          { \end{multicols*} }
          { \end{multicols} }
        \bool_set_false:N \g_hypo_chsh_in_multicols_bool
        \bool_set_false:N \g_hypo_chsh_in_multicols_star_bool
      }
  }

\cs_new_protected:Npn \hypo_chsh_sectionbreak:
  {
    \tl_if_eq:NnTF \g_hypo_chsh_opt_chapterbreak_tl { none }
      { }
      {
        \tl_if_eq:NnTF \g_hypo_chsh_opt_chapterbreak_tl { column }
          {
            \bool_if:NT \g_hypo_chsh_in_multicols_bool { \CHSHColumnBreak }
          }
          {
            % page
            \bool_if:NTF \g_hypo_chsh_in_multicols_bool
              {
                \hypo_chsh_end_multicols_if_needed:
                \clearpage
                \hypo_chsh_begin_multicols_if_needed:
              }
              { \clearpage }
          }
      }
  }
\cs_new_protected:Npn \HypoCHSHSetupColumns { \hypo_chsh_setup_columns: }
\cs_new_protected:Npn \HypoCHSHBeginColumns { \hypo_chsh_begin_multicols_if_needed: }
\cs_new_protected:Npn \HypoCHSHEndColumns { \hypo_chsh_end_multicols_if_needed: }
\cs_new_protected:Npn \HypoCHSHSectionBreak { \hypo_chsh_sectionbreak: }
\cs_new_protected:Npn \hypo_chsh_apply_textsize:
  {
    \str_case:nnF { \tl_use:N \g_hypo_chsh_opt_textsize_tl }
      {
        { normal } { \normalsize }
        { small } { \small }
        { footnotesize } { \footnotesize }
        { scriptsize } { \scriptsize }
      }
      { \small }
  }
\cs_new_protected:Npn \HypoCHSHApplyBodySize { \hypo_chsh_apply_textsize: }

\cs_new_protected:Npn \hypo_chsh_suspend_columns_for_code:
  {
    \bool_set_false:N \g_hypo_chsh_code_suspended_cols_bool
    \bool_if:NT \g_hypo_chsh_in_multicols_bool
      {
        \bool_set_true:N \g_hypo_chsh_code_suspended_cols_bool
        \hypo_chsh_end_multicols_if_needed:
      }
  }
\cs_new_protected:Npn \hypo_chsh_resume_columns_after_code:
  {
    \bool_if:NT \g_hypo_chsh_code_suspended_cols_bool
      {
        \hypo_chsh_begin_multicols_if_needed:
        \bool_set_false:N \g_hypo_chsh_code_suspended_cols_bool
      }
  }
\cs_new_protected:Npn \HypoCHSHSuspendColumnsForCode { \hypo_chsh_suspend_columns_for_code: }
\cs_new_protected:Npn \HypoCHSHResumeColumnsAfterCode { \hypo_chsh_resume_columns_after_code: }
\ExplSyntaxOff

% Public helpers: allow temporarily leaving multicols.
\newcommand{\CHSHBeginColumns}{\HypoCHSHBeginColumns}
\newcommand{\CHSHEndColumns}{\HypoCHSHEndColumns}

\RequirePackage{etoolbox}
\pretocmd{\section}{\HypoCHSHSectionBreak}{}{}
\makeatletter
\@ifundefined{chapter}{}{ \pretocmd{\chapter}{\HypoCHSHSectionBreak}{}{} }
\makeatother

% Keep title in single column (multicols doesn't typeset \maketitle nicely).
\pretocmd{\maketitle}{\HypoCHSHEndColumns\normalfont\normalsize}{}{}
\apptocmd{\maketitle}{\HypoCHSHApplyBodySize\HypoCHSHBeginColumns}{}{}

% -----------------------------------------------------------------------------
% Load Hypoxanthine capabilities (reuse Note-Core as a feature bundle)
% -----------------------------------------------------------------------------
\ExplSyntaxOn
\tl_new:N \l_hypo_chsh_core_opts_tl
\cs_new_protected:Npn \hypo_chsh_core_opts_build:
  {
    \tl_clear:N \l_hypo_chsh_core_opts_tl
    \tl_put_right:Nn \l_hypo_chsh_core_opts_tl
      {
        shorthand=\bool_if:NTF \g_hypo_chsh_opt_shorthand_bool {true}{false},
        indent=\bool_if:NTF \g_hypo_chsh_opt_indent_bool {true}{false},
        boxes=\bool_if:NTF \g_hypo_chsh_opt_boxes_bool {true}{false},
        refs=\bool_if:NTF \g_hypo_chsh_opt_refs_bool {true}{false},
        algorithm=\bool_if:NTF \g_hypo_chsh_opt_algorithm_bool {true}{false},
        code=\bool_if:NTF \g_hypo_chsh_opt_code_bool {true}{false},
        outputdir=\tl_use:N \g_hypo_chsh_opt_outputdir_tl,
        colorscheme=\tl_use:N \g_hypo_chsh_opt_colorscheme_tl
      }
  }
\hypo_chsh_core_opts_build:
\RequirePackage[\l_hypo_chsh_core_opts_tl]{Hypo-Note-Core}
\ExplSyntaxOff

% Prefer compact code blocks for cheat sheets: disable line numbers by default
% to reduce wrapping inside narrow columns.
\ExplSyntaxOn
\bool_if:NT \g_hypo_chsh_opt_code_bool
  {
    \bool_if_exist:NT \l_hypo_code_linenos_bool
      {
        \bool_if:NTF \g_hypo_chsh_opt_codelinenos_bool
          { \bool_set_true:N \l_hypo_code_linenos_bool }
          { \bool_set_false:N \l_hypo_code_linenos_bool }
      }
  }
\ExplSyntaxOff

% Make code slightly smaller/tighter by default for cheat sheets.
% Implemented by overriding minted/listings defaults (more robust than
% injecting \footnotesize/\scriptsize via keyval extras).
\makeatletter
\@ifpackageloaded{minted}{%
  \setminted{fontsize=\scriptsize,baselinestretch=1.0,framesep=1mm,breaklines}%
}{}
\@ifpackageloaded{listings}{%
  \lstdefinestyle{hypo-code}{%
    basicstyle=\ttfamily\scriptsize,%
    frame=lines,%
    numberstyle=\tiny,%
    breaklines=true,%
    columns=fullflexible,%
    showstringspaces=false,%
    tabsize=4%
  }%
}{}
\makeatother

% Enter multicols after color/fonts/etc are initialized by Hypo-Note-Core.
% (xcolor initializes \current@color at begin document via \normalcolor.)
% Also use ragged columns to avoid vertical stretching (common "content sinks").
\AtBeginDocument{\normalcolor\raggedbottom\raggedcolumns\HypoCHSHSetupColumns\HypoCHSHApplyBodySize\HypoCHSHBeginColumns}
\AtEndDocument{\HypoCHSHEndColumns}

% By default, keep verbatim-like code blocks out of multicols to avoid
% column spanning/overlap and output routine issues.
% \makeatletter
% \AtBeginDocument{%
%   \@ifundefined{hypocode}{}{%
%     %\BeforeBeginEnvironment{hypocode}{\HypoCHSHSuspendColumnsForCode}%
%     %\AfterEndEnvironment{hypocode}{\HypoCHSHResumeColumnsAfterCode}%
%   }%
% }
% \makeatother

% -----------------------------------------------------------------------------
% CHSH rendering overrides (compact + multicols-friendly)
% -----------------------------------------------------------------------------
\makeatletter
\@ifpackageloaded{tcolorbox}{%
  \tcbset{%
    hypo box/.append style={%
      unbreakable,
      before skip=3pt,
      after skip=3pt,
      left=0.8mm,right=0.8mm,top=0.6mm,bottom=0.6mm,
    },%
  }%
}{}
\makeatother

% Lists
\ExplSyntaxOn
\bool_if:NF \g_hypo_chsh_opt_lists_bool
  { \cs_set_protected:Npn \HypoDisableLists {} }
\ExplSyntaxOff
\RequirePackage{Hypo-Lists}

\endinput
