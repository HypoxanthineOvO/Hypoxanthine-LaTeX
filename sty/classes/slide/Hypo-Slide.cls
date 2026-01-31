\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Hypo-Slide}[2026/01/31 v1.4.1 Hypoxanthine Slide Class]

% ==============================================================================
% 1. Option Handling
% ==============================================================================
\RequirePackage{expl3}
\RequirePackage{l3keys2e}

\ExplSyntaxOn
\tl_new:N \g_hypo_slide_theme_tl
\tl_new:N \g_hypo_slide_aspect_tl
\tl_new:N \g_hypo_slide_fontset_tl
\bool_new:N \g_hypo_slide_dark_bool
\tl_new:N \g_hypo_slide_linecolor_tl

\keys_define:nn { hypo / slide }
  {
    theme .tl_set:N = \g_hypo_slide_theme_tl,
    theme .initial:n = school,
    
    fontset .tl_set:N = \g_hypo_slide_fontset_tl,
    fontset .initial:n = tech,
    
    aspectratio .tl_set:N = \g_hypo_slide_aspect_tl,
    aspectratio .initial:n = 169,

    darkmode .bool_set:N = \g_hypo_slide_dark_bool,
    darkmode .initial:n = false,

    linecolor .tl_set:N = \g_hypo_slide_linecolor_tl,
    linecolor .initial:n = colored,
    
    unknown .code:n = {
      \PassOptionsToClass{\CurrentOption}{ctexbeamer}
    }
  }

\ProcessKeysOptions { hypo / slide }

% Pass aspectratio manually to beamer (ctexbeamer passes unknown opts, but let's be explicit if needed logic exists)
\PassOptionsToClass{aspectratio=\g_hypo_slide_aspect_tl}{beamer}
\ExplSyntaxOff

% Load Base Class
\LoadClass{ctexbeamer}

% ==============================================================================
% 2. Core Dependencies
% ==============================================================================
\RequirePackage{Hypo-Colors}
% Font setup tailored for themes
\RequirePackage{Hypo-Fonts} 
\ExplSyntaxOn
\HypoFontSetup{fontset=\g_hypo_slide_fontset_tl}
\ExplSyntaxOff

\RequirePackage{Hypo-Icon}
\RequirePackage{Hypo-Img}
\RequirePackage{Hypo-Code}
% Box system adaptation for Beamer
\RequirePackage{Hypo-Box-Beamer}
\RequirePackage{Hypo-Slide-Instructor}

% ==============================================================================
% 3. Setup Interface (\HypoSlideSetup)
% ==============================================================================
\ExplSyntaxOn
\tl_new:N \g_hypo_slide_logo_tl
\tl_new:N \g_hypo_slide_avatar_tl
\tl_new:N \g_hypo_slide_cover_tl
\clist_new:N \g_hypo_slide_authors_clist

\keys_define:nn { hypo / slide / setup }
  {
    logo .tl_set:N = \g_hypo_slide_logo_tl,
    avatar .tl_set:N = \g_hypo_slide_avatar_tl,
    cover  .tl_set:N = \g_hypo_slide_cover_tl,
    authors .clist_set:N = \g_hypo_slide_authors_clist, 
    institute .code:n = { \institute{#1} },
    date .code:n = { \date{#1} },
    author .code:n = { \author{#1} },
    title .code:n = { \title{#1} },
    subtitle .code:n = { \subtitle{#1} },
  }

\NewDocumentCommand{\HypoSlideSetup}{m}
  {
    \keys_set:nn { hypo / slide / setup } {#1}
  }
\ExplSyntaxOff

% ==============================================================================
% 4. Theme Loading
% ==============================================================================
\ExplSyntaxOn
\IfFileExists{hypo-slide-theme-\g_hypo_slide_theme_tl.sty}
  {
    \RequirePackage{hypo-slide-theme-\g_hypo_slide_theme_tl}
  }
  {
    \msg_new:nnn { hypo } { theme-missing } { Theme~' \g_hypo_slide_theme_tl ' ~not~found!~Falling~back~to~School. }
    \msg_warning:nn { hypo } { theme-missing }
    \RequirePackage{hypo-slide-theme-school}
  }
\ExplSyntaxOff

\endinput
