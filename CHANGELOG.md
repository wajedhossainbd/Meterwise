# Changelog

All notable changes to MeterWise are documented here. Version format is
`X.Y.Z+BUILD` where `BUILD` is the Android `versionCode` (from `pubspec.yaml`).

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
