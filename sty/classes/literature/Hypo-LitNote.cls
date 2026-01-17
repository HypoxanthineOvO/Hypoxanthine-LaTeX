\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Hypo-LitNote}[2026/01/17 v0.9.0 Hypoxanthine Literature Note Class]

% Options:
% - Pass Hypoxanthine entry options to Hypo-Note-Core and local modules.
% - Pass unknown options to base class (ctexart).
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

\cs_new_protected:Npn \hypo_litnote_pass_unknown_to_base:n #1
  {
    \tl_set:Nx \l_tmpa_tl { \l_keys_key_str }
    \tl_if_blank:nTF {#1}
      { \PassOptionsToClass{\l_tmpa_tl}{ctexart} }
      {
        \tl_set:Nx \l_tmpb_tl { \l_tmpa_tl = {#1} }
        \PassOptionsToClass{\l_tmpb_tl}{ctexart}
      }
  }

\keys_define:nn { hypo / litnote / class }
  {
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

    unknown .code:n = { \hypo_litnote_pass_unknown_to_base:n {#1} },
  }

\ProcessKeysOptions{ hypo / litnote / class }
\ExplSyntaxOff

\LoadClass{ctexart}

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
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
\makeatother

\fancyhead[L]{\nouppercase{\rightmark}}
\fancyhead[R]{\thepage}

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
