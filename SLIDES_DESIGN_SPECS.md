# Hypo-Slide Design Specifications (v1.2.0)

> **Note**: This is a local design document for internal reference. DO NOT PUSH.

## 1. System Architecture
**Hypo-Slide** is built on top of `ctexbeamer` (which wraps `beamer` + `ctex`).

### 1.1 Class Structure (`sty/classes/slide/Hypo-Slide.cls`)
- **Base**: Loads `ctexbeamer`.
- **Core Dependencies**:
    - `Hypo-Colors`: Provides the semantic color palette (`HypoPrimary`, `HypoText`, etc.).
    - `Hypo-Fonts`: Handles font fallback strategies (`tech` preset).
    - `Hypo-Icon` / `Hypo-Img`: Asset management.
    - `Hypo-Code`: Code highlighting (works in overlays via `fragile`).
- **Beamer Adaptation**:
    - `Hypo-Box-Beamer`: Adapts `Hypo-Box` (tcolorbox) to replace standard beamer blocks (`theorem`, `example`, `alert`).
        - *Crucial*: Disables `breakable` (not supported in frames).
        - *Conflict Resolution*: Overwrites `\note` command (conflict with beamer's note).
- **Module Injection**:
    - `Hypo-Slide-Instructor`: Injected after `Hypo-Box-Beamer` to provide instructor layouts.
- **Theme Loading**:
    - Dynamic loading via `theme=<name>` option.
    - Fallback: Defaults to `school` if theme missing.

## 2. Theme Systems

### 2.1 Common Interface (`\HypoSlideSetup`)
Unified configuration command using `l3keys`.
- Keys: `title`, `subtitle`, `author`, `date`, `institute`.
- Assets: `logo`, `cover`, `avatar`.
- Palette: `linecolor` (affects separators).

### 2.2 Theme: School (Academic / Default)
- **Target**: Thesis defense, formal reports.
- **Visual Identity**:
    - Primary Color: `#9D0004` (ShanghaiTech Red).
    - Font: Sans-serif (Standard).
- **Layout**:
    - **Header**: Minimal (Logo removed from headline to avoid occlusion).
    - **Title Page**:
        - Adaptive Layout via `\IfInstructorsExist`.
        - Standard: Centered big red title block + Author/Institute below.
        - Instructor: Title moves up, Instructor Grid centered.
        - Logo: Top-right absolute positioning (`tikzpicture`).
    - **Footer**: Three-column `tcolorbox` layout (Wireframe style).
        - Left (20%): Author (Gray).
        - Center (50%): Short Title (White).
        - Right (30%): Date + Page Number (Red).

### 2.3 Theme: Lab (Tech / Dark Mode)
- **Target**: Code reviews, dev logs.
- **Visual Identity**:
    - Dark Mode: `HypoDeepBg` (Slate 800: `#1E293B`).
    - Text: `HypoDeepText` (Slate 100).
    - Box Background: `HypoDeepBoxBg` (Slate 500: `#64748B`) for high contrast code blocks.
- **Layout**:
    - **Frametitle**: Centered `tcolorbox`, width constrained to prevent overflow. `HypoDeepAccent` border.
    - **Footer**: Minimalist. Page number only (Right aligned).
    - **Title Page**: "Terminal" style wireframe box.

### 2.4 Theme: Lit (Literature / Print)
- **Target**: Humanities, poetry, reading sharing.
- **Visual Identity**:
    - Background: `HypoLitPaper` (Warm White `#FFFDF5`).
    - Text: `HypoLitInk` (Dark Gray `#333333`).
    - Font: Serif (`\usefonttheme{serif}`).
- **Layout**:
    - **Header**: Italic metadata (Title | Section).
    - **Frametitle**: Centered Italic + Purple Separator Line.
    - **Special Support**:
        - `poem` Environment: Centered `varwidth` block + Inner Text Centering (`\centering`).

### 2.5 Theme: Business (Corporate)
- **Target**: Pitch decks, product intros.
- **Visual Identity**:
    - Style: "Liquid Glass" (Glassmorphism).
    - Colors: Navy Blue (`#001F3F`) + Gold (`#FFD700`) accents.
    - Background: Gradient (Top-Left to Bottom-Right).
- **Layout**:
    - **Frametitle**: Left-aligned, heavy font.
    - **Footer**: Gold progress bar overlay.
    - **Glass Box**: Semitransparent content boxes with blur effect (simulated via opacity).

## 3. Instructor Module (`Hypo-Slide-Instructor`)
Extracted from the standard `Tutorial` theme for reusability.

### 3.1 Data Model
- Uses `expl3` `clist` (`\g_hypo_instructor_clist`) to store instructor data items.
- Items are stored as executable code chunks (minipage wrappers).

### 3.2 Interfaces
- `\InstructorCover[img]{Name}{Role}{Desc}`: Registers an instructor for the Title Page.
    - Renders as: Compact Avatar + Name/Role side-by-side.
- `\InstructorBlock[img]{Name}{Role}{Bio}`: Renders a full-width detailed block.
    - Renders as: `tcolorbox` with "Red Line" left border.
- `InstructorList` Environment:
    - Wrapper around `\begin{frame}[allowframebreaks]`.

### 3.3 Adaptive Logic
- `\IfInstructorsExist{True}{False}`: Checks list emptiness.
- Used in `School` theme to toggle between "Standard Author" layout and "Instructor Grid" layout.

## 4. Technical Constraints & Decisions
- **tcolorbox Clash**: `Hypo-Box` loaded `tcolorbox` with `[most]`. `Hypo-Slide-Instructor` attempted to use `\tcbset` without loading package properly in early builds.
- **Fix**: Reordered loading in `Hypo-Slide.cls` to ensure `Hypo-Box-Beamer` (and thus `tcolorbox`) loads BEFORE `Hypo-Slide-Instructor`.
- **Fragile Frames**: `Hypo-Code` requires `\begin{frame}[fragile]` if using `minted`.
- **Aspect Ratio**: Defaults to 16:9 (`aspectratio=169`).

## 5. Future Considerations
- **Animation**: Add transition supports (`\animate<...>`).
- **More Themes**: Minimalist "Zen" theme?
- **Fonts**: Integration with `FiraCode` or `JetBrains Mono` for Lab theme.
