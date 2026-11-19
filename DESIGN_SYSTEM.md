# MeterWise Design System — "Soft Modern"

The app reads as **one calm, capable product**, not a collection of default
widgets. The visual language is **modern minimalist soft UI (neumorphism) with a
touch of skeuomorphism**: surfaces extrude gently from a single neutral base,
wells recede into it, and one accent carries meaning. These rules are binding
for new screens.

- Tokens: `lib/core/theme/app_tokens.dart`, `app_colors.dart`, `soft_ui.dart`
- Shared components: `lib/core/widgets/`, `lib/core/theme/soft_ui.dart`
- Theme wiring: `lib/core/theme/app_theme.dart`

## 1. Brand idea

A utility you trust with money. The character is **precise, calm, tactile**, with a warm light-orange bolt as the signature accent on cool white tiles.
Depth comes from light and shadow, never from hue gradients. The mark is a soft
raised disc with a recessed dial holding the brand bolt — used on splash and
onboarding. No gradients, glows, sparkles or emoji as icons.

## 2. The soft-UI model

Everything sits on **one neutral base** shared by the scaffold and all surfaces:

| Role | Light | Dark |
|---|---|---|
| Base / tile | `#F7F9FC` (cool white) | `#232A35` |
| Light shadow | `#FFFFFF` | lighter navy |
| Dark shadow | `#D2DBE6` | `#151A22` |
| Inset well | `#E9EEF5` | `#1C222C` |
| Ink primary | `#253247` | `#E7ECF5` |
| Ink secondary | `#5C6B80` | `#A7B4C6` |
| Accent fill (light orange) | `#F4A24C` | `#FFBC70` |
| Accent ink (icons / small text) | `#C96A12` | `#FFC78A` |
| Success | `#2F8A5E` | `#63C79C` |
| Warning | `#C97A22` | `#C97A22` |
| Danger | `#C85A48` | `#F08E80` |

The **fill** accent is light orange (buttons, selection, dial arc). Small icons
and labels use the deeper **accent ink** so they stay legible on near-white
tiles — never use the light fill orange for thin strokes or small text.

Two shadow recipes, both brightness-aware, live in `Soft`:

- **Raised** (`Soft.raised`): light highlight top-left, dark shade bottom-right.
  Used for cards, tiles, buttons, the FAB.
- **Pressed / inset** (`Soft.pressed`): reversed inner shadows. Used for wells,
  inputs, chips, progress tracks, the meter dial and pressed states.

Rules: no coloured shadows, no hue gradients, no gradient text, no glows.
Accent and semantic colours are used sparingly and only where they carry
meaning. Ink stays high-contrast for legibility — soft UI must not become
low-contrast UI.

## 3. Type

One system family. Sizes: 12 caption, 14 body, 16 title, 20 heading, 30 display.
Weights: 400 regular, 500 medium, 600 semibold for emphasis only — never 700+.
Figures use tabular numerals. Sentence case everywhere. The same formatter from
`core/utils/formatters.dart` is used on every surface.

## 4. Spacing and radius

4px grid: 4 / 8 / 12 / 16 / 20 / 24 / 32. Same thing, same size: all list rows
share height and gap, all cards share padding. Radii: chips 10, controls 14,
cards 20, large surfaces 26, avatars circular. Radius is intentionally larger
than the old Material look to read as soft.

## 5. Components

### `SoftSurface` / `SoftCard` (`core/theme/soft_ui.dart`)
The foundation. `SoftCard` is the drop-in replacement for Material `Card` —
never introduce a raw `Card` again. `SoftSurface` adds `inset`, `depth`, `onTap`
and custom radius. `SoftInset` is the well variant. `SoftIconTile` is the single
accent container used in lists, settings and status rows. `SoftIconButton` is a
circular raised button that sinks when pressed.

### Buttons — `BrandButton` (`core/widgets/brand_button.dart`)
- **Primary**: filled accent, light label, raised shadow. One per screen.
- **Secondary**: neutral raised surface, for the alternative action.
- **Quiet**: text button for low-emphasis actions.
- **Danger**: filled semantic red, destructive only.
- Height 50, radius 14, label 14/600, icon 18, press-scale + haptic, loading
  spinner built in, full-width via `expanded: true`. Never hand-roll a spinner.

### Chips — `BrandChip` (`core/widgets/brand_chip.dart`)
Recessed soft pill, 30px height, 10px radius, 12/600 label. Used for
draft/finalized, paid/due/credit, billing mode.

### Cards and sections
Extruded surface, radius 20, padding 16–24, no outline hairline (the paired
shadows define the edge). `SectionCard` wraps this for titled form groups.

### Inputs
Inset well fill (`Soft.inset`), radius 14, no border at rest, accent hairline on
focus. Camera/Gallery and similar choice controls are raised soft tiles.

### Navigation
Bottom bar, 5 landlord destinations or 2 tenant destinations, always labelled;
selected state is a tonal pill + 600 label in the accent. The wide-screen rail
uses the same palette.

### Signature visual — `MeterGauge` (`core/widgets/meter_gauge.dart`)
A dial recessed into the surface, its arc drawn in code in the accent. No stock
illustration, no gradient. It is the app's one distinctive graphic moment.

## 6. Motion

One easing (`easeOutCubic`), 150ms for feedback and 250ms for entrances. Press
scale on buttons and tiles; fade + small rise on content entry only. No looping,
bouncing or parallax motion.

## 7. Emotional design (peak / end)

Finance conventions: feel safe, professional and tactile. Trust is built through
precision and feedback, not decoration.

- **The peak** is the dashboard balance reveal: the figure plus the recessed
  `MeterGauge`, the app's signature visual.
- **The end** of a task is a confident confirmation: haptic tap on every
  `BrandButton`, a medium haptic + clear snackbar after mark-paid, finalize and
  entry-save.
- Empty states explain what to do next and offer the action inline.

## 8. Checklist for a new screen
- [ ] Uses tokens for every spacing/radius value
- [ ] Surfaces are `SoftCard` / `SoftSurface` / `SoftInset` — no raw `Card`
- [ ] Icon containers are `SoftIconTile`; icon buttons are `SoftIconButton`
- [ ] One primary action, at most one secondary
- [ ] Status is `BrandChip`; semantic colour only where it means something
- [ ] Sentence case, max 600 weight, tabular figures for money/units
- [ ] Empty, loading and error states included
- [ ] Checked in both light and dark themes
- [ ] Localized through en + bn ARB
