# MeterWise Design System

The app should read as **one calm, capable product for landlords**, not a
collection of default widgets. These rules are binding for new screens.
Tokens live in `lib/core/theme/app_tokens.dart`; shared components live in
`lib/core/widgets/`.

## 1. Brand idea

A utility you trust with money. The visual character is **precise, calm,
warm** — quiet surfaces, one clear accent, and rich colour only where it means
something (balance, status, series in a chart).

The mark is a **solid brand-blue disc with a white bolt**. No gradients, no
glow, no sparkles, no emoji as icons. The same mark is used on splash,
onboarding, launcher icon and invoices.

## 2. Colour

| Role | Light | Dark | Use |
|---|---|---|---|
| Canvas | `#F4F6FB` | surface | page background |
| Surface | `#FFFFFF` | `surfaceContainerHigh` | cards, sheets |
| Ink primary | `#1D2433` | onSurface | headlines, figures |
| Ink secondary | `#6B7280` | onSurfaceVariant | labels, captions |
| Brand | `#2962FF` | primary | primary action, selection, key figure |
| Success | `#2E9E5B` | — | credit, finalized |
| Warning | `#F57C00` | — | draft, attention |
| Danger | `#E8553C` | — | due, destructive |

Rules: chrome (navigation, buttons, text) uses neutral + brand. Semantic colours
carry meaning only. No hue gradients, no gradient text, no coloured shadows,
no colour blobs.

## 3. Type

One system family. Sizes: 12 caption, 14 body, 16 title, 20 heading, 28 display.
Weights: 400 regular, 500 medium, 600 semibold for emphasis only — never 700+.
Sentence case everywhere. Numbers use the same formatter from
`core/utils/formatters.dart` on every surface.

## 4. Spacing and radius

4px grid: 4 / 8 / 12 / 16 / 20 / 24 / 32. Same thing, same size: all list rows
share height and gap; all cards share padding. Radius pair: chips 8, controls 12,
cards 16, large surfaces 20, avatars circular.

## 5. Components

### Buttons — `BrandButton` (`core/widgets/brand_button.dart`)
- **Primary**: filled brand blue, white label. One per screen.
- **Secondary**: outlined / tonal neutral, for the alternative action.
- **Quiet**: text button for low-emphasis actions.
- **Danger**: filled semantic red, destructive only.
- Height 48, radius 12, label 14/600, icon 18, loading spinner built in,
  full-width via `expanded: true`. Never hand-roll a button spinner.

### Chips — `BrandChip` (`core/widgets/brand_chip.dart`)
Tinted semantic surface at 12% opacity, 8px radius, 28px height, 12/600 label.
Used for draft/finalized, paid/due/credit, billing mode.

### Cards
Surface colour, 1px hairline outline at low opacity, radius 16, padding 16–20.
Light theme: tiny neutral elevation. Dark theme: no shadow — surface steps and
hairlines create depth.

### Inputs
Filled neutral, radius 12, no border in rest state, 16/14 horizontal/vertical
padding, label and helper in ink secondary.

### Navigation
Bottom bar, 5 landlord destinations or 2 tenant destinations, always labelled;
selected state is a tonal pill + 600 label, never a colour wash.

## 6. Motion
One easing (`easeOutCubic`), 150ms for feedback and 250ms for entrances. Fade +
small rise on content entry only. No looping, bouncing or parallax motion.

## 7. Checklist for a new screen
- [ ] Uses tokens for every spacing/radius value
- [ ] One primary action, at most one secondary
- [ ] All buttons are `BrandButton`; status is `BrandChip`
- [ ] Semantic colour only where it means something
- [ ] Sentence case, max 600 weight
- [ ] Empty, loading and error states included
- [ ] Localized through en + bn ARB
