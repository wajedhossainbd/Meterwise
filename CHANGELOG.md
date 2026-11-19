# Changelog

All notable changes to MeterWise are documented here. Version format is
`X.Y.Z+BUILD` where `BUILD` is the Android `versionCode` (from `pubspec.yaml`).

## [4.0.0+30] — 2026-11-19

### Changed
- **Complete application-wide visual redesign** to "Soft Modern" — minimalist
  neumorphic / soft UI with subtle skeuomorphic depth, applied to every screen,
  module, card, form, control and interaction.
- Monochromatic neutral base shared by scaffold and surfaces; depth comes from
  paired light/dark shadows (raised) and reversed inner shadows (inset wells).
- Large, consistent radii (chips 10, controls 14, cards 20, surfaces 26) and a
  restrained single-accent palette with semantic colours only where meaningful.
- Global theme retuned: app bars, navigation bar/rail, all button roles, inputs
  (inset wells), dialogs, sheets, chips, segmented controls, FAB, snackbars,
  tooltips and typography.
- Signature `MeterGauge` rebuilt as a dial recessed into the surface; balance
  hero, tenant home hero, quick actions, stat cards, charts and onboarding /
  splash surfaces redesigned around the soft model.

### Added
- Reusable design-system primitives in `core/theme/soft_ui.dart`:
  `SoftSurface`, `SoftCard`, `SoftInset`, `SoftIconTile`, `SoftIconButton` and
  the brightness-aware `Soft` shadow/colour engine.
- `DESIGN_SYSTEM.md` fully documents the new language and component rules.

### Preserved
- All billing logic, migrations, permissions, Drive sync, updater, roles,
  localization and integrations are unchanged. This release is visual only.

## [3.7.1+29] — 2026-11-19

### Fixed
- Pending tenant state is no longer a dead end: added a status-check action and a "Switch to landlord view" menu item so the owner can approve without dropping the joined meter.

## [3.7.0+28] — 2026-11-19

### Added
- Custom-drawn `MeterGauge` on the balance hero — the app signature visual showing the tenant share of the main meter.
- Haptic feedback and press-scale motion on all `BrandButton`s, plus success haptics for mark-paid, finalize and entry-save.
- DESIGN_SYSTEM.md now covers the peak/end emotional moments and finance conventions.

## [3.6.0+27] — 2026-11-19

### Added
- Formal design system: `DESIGN_SYSTEM.md`, token file, `BrandButton` (4 roles) and `BrandChip` components.
- Theme-wide button, chip, input, FAB and dialog styling from tokens — every screen inherits the same 48px/12px-radius controls and 14/600 labels.

## [3.5.0+26] — 2026-11-18

### Added
- In-app GitHub Releases updater for sideload APK builds: checks on cold start, shows release notes, downloads the APK in-app and opens the Android installer. Disabled in the Play AAB via `METERWISE_GITHUB_UPDATER=false`.

## [3.4.1+25] — 2026-11-18

### Fixed
- Dark-theme contrast on the balance hero (explicit white text on brand blue).

## [3.4.0+24] — 2026-11-18

### Changed
- **Professional UI craft pass:** flat brand mark on splash, onboarding, empty
  states, charts and launcher icon (no hue gradients, glows or heavy 800-weight
  headings); solid-colour invoice banner; quieter 600-weight emphasis throughout.

### Added
- Privacy policy page (GitHub Pages) and in-app link under Settings.
- `PLAY_STORE.md` compliance plan and `STORE_LISTING.md` listing copy.
- Signed AAB build for Google Play upload.

## [3.3.0+23] — 2026-11-18

### Added
- **Encrypted Google Drive sync** — AES‑256‑GCM packets (`landlord.enc`,
  `tenant_<name>.enc`) stored in the user's own Drive under
  `MeterWise/<meter code>/`; no MeterWise server.
- **Tenant write-back** — tenants upload their own readings/recharges; the
  landlord imports them on next sync (idempotent, deduplicated).
- **Hourly background sync** — WorkManager task registered at startup, runs
  both directions when the device is online.
- **Drive sync entry from tenant mode** — available in the tenant app-bar menu;
  pending-approval tenants can still open it.
- `PacketCrypto` unit tests (round-trip + wrong-key rejection).

### Fixed
- `serverClientId` required by google_sign_in v7 on Android (Web OAuth client).
- OAuth token expiry had to be a UTC `DateTime`.
- Settings "Join meter account" didn't restore tenant role when a code was stored.

## [3.2.1+22] — 2026-11-18

- Device-debugged Google Drive sync on Samsung S9+.
- Verified Google sign-in, encrypted backup upload and tenant sync.
- Correct tenant role restored when re-entering tenant view.

## [3.2.0+21] — 2026-11-18

- First Google Drive sync layer: Google Sign-In, Drive API v3, landlord upload,
  tenant download + import, Settings UI.
- OAuth client IDs injected at build time via `--dart-define` from `.secrets/`.

## [3.1.3+20] — 2026-11-18

- Cross-device meter-code join accepts any well-formed `MW-XXXX-XXXX` code.
- Tenant can leave a meter and switch back to landlord view.

## [3.1.2+19] — 2026-11-18

- Tenant-scoped bottom navigation (My meter / My entries).
- Entry history list and "Building total" label.

## [3.1.1+18] — 2026-11-18

- Tenant home becomes the first tab in tenant mode.
- Tenant self-entry for own readings, recharges and payments/reimbursements.

## [3.1.0+17] — 2026-11-18

- Tenant access prototype: meter code + QR invite, scan/manual join with
  roster-name selection, landlord approval, tenant-scoped bill home (schema v11).

## [3.0.4+16] — 2026-11-18

- Native Android WebView-owned PDF channel: background thread, explicit 300 DPI
  print attributes, PDF `/Title` stamping; Bangla invoices verified on device.
- Real signed release keystore (SHA-256 in `GOOGLE_DRIVE_SETUP.md`).

## [3.0.0+12] — 2026-11-17

- Core-first revamp: persisted theme + invoice language, full en/bn coverage,
  working error Retry, finalized metadata freeze, dashboard split, quiet visual
  refresh (schema v10).

## [2.3.0+11]

- Property-level calculation modes: shared slab / reconciled / fixed rate (schema v8).

## [2.2.x]

- Bangla-capable HTML invoices, native WebView PDF fallback, share fixes.

## [2.0.x]

- Hybrid billing engine, per-tenant contracts, verified Jun-2026 DPDC tariff.

## [1.x]

- MVP, accounting periods, snapshots, settlements, tariff manager, local backup.
