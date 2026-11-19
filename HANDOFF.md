# MeterWise — Project Handoff Document

> For a new Claude/engineering session. Everything needed to continue development
> without reading prior conversations. Companion docs: `BILLING.md` (formula
> spec), `~/.claude/.../memory/` (session memory, mirrors this).
>
> **Last state:** v4.5.0+35 · DB schema v12 · 63/63 tests green ·
> `flutter analyze` clean · signed release APK, device-verified on Samsung S9+
> (SM-G965F / Android 10): Bangla invoice renders, native PDF ~0.5 s, no UI freeze.
> Git history holds the revamp phases; baseline `1ba118a`. Read [README.md](README.md) first.

---

## 0. CURRENT HANDOFF SNAPSHOT — start here

**Repository:** `https://github.com/wajedhossainbd/Meterwise.git` (public,
default branch `main`, pushed from local `/Volumes/Mac 500 SSD/Claude/MeterWise`).

**Release:** v3.4.0+24, signed APK (and Play AAB) attached to the GitHub Release.
Users update by downloading the APK from Releases; Android uses the `+24` build
number to detect upgrades.

**Last verified (device, 2026-11-18):** two-device walkthrough with the S9+ as
landlord and the Pixel_7 AVD (`MeterTest`) as tenant:
- Landlord: setup → QR/code invite (`MW-6D82-72WB` at the time) → two reading
  sessions → recharge → Bills (300 kWh, 60 kWh common, ৳1,944.01) → mark paid.
- Tenant: join with the code → pick roster name → approve → scoped 2-tab home
  (৳862.88 credit, 175 kWh, ৳1,137.12) → self-entry reading → history.
- Google sign-in + AES‑GCM encrypted landlord backup and tenant sync verified on
  the S9+ (the emulator has no Google account, so Drive UI there needs one).
- Bangla PDF invoice exports correctly with filename `MeterWise_<tenant>_<month>.pdf`.

**Secrets:** `.secrets/` is git-ignored and holds both OAuth client IDs and the
downloaded JSONs. Never commit them. The Android keystore is
`android/app/upload-keystore.jks` with config in `android/key.properties`
(also git-ignored). Verified backup of all of these exists outside the repo at
`~/Documents/MeterWise-secrets/v3.4.1/` (hashes matched); also copy to an
external drive or password manager.

**OAuth scope decision:** keep the restricted `drive` scope and submit Google
verification (landlord and tenant are different Google accounts, so
`drive.file` alone cannot read another user's packet). Full submission
checklist and fallback plan are in `PLAY_STORE.md` § 6.

**Build with sync:**
```bash
CID=$(tr -d '\r\n' < .secrets/google_client_id.txt)
SID=$(tr -d '\r\n' < .secrets/google_server_client_id.txt)
flutter build apk --release \
  --dart-define=METERWISE_DRIVE_CLIENT_ID="$CID" \
  --dart-define=METERWISE_DRIVE_SERVER_CLIENT_ID="$SID" \
  --dart-define=METERWISE_GITHUB_UPDATER=false
```

The sideload APK keeps the updater enabled (default). `features/updates/`
contains the GitHub Releases check, in-app APK download and install prompt.

**Where work left off / natural next steps:**
1. Drive sync on the emulator needs a Google account added to that AVD.
2. Hourly WorkManager task is registered but its background execution has not
   been observed over a full hour on device — verify with logcat.
3. No auto-refresh of tenant view when the app returns to foreground (manual
   Sync button only).
4. Tenant write-back currently covers readings + recharges; settlements and
   mark-paid flags are not yet exchanged through packets.
5. Old plain-JSON `landlord.json` files from pre-3.3.0 builds remain in Drive;
   new builds read `landlord.enc` only. Clean them up if desired.
6. Release signing uses a self-generated keystore — for Google Play, enrol in
   App Signing by Google Play or back up this keystore permanently.
7. QR code rotation/revocation is not implemented; a shared code is permanent.
8. **Play Store blockers are account-side only** — see `PLAY_STORE.md`: developer
   account, Play App Signing enrolment, restricted Drive scope verification,
   content rating, data safety form, tester programme, feature graphic. AAB is
   already built and ready to upload.

**Rules to preserve:** the billing engine is the single computation path; the
spreadsheet goldens are the contract; all migrations are additive; all
user-visible strings go through en+bn ARB; secrets stay out of git.

---

## 1. What this app is

**MeterWise** (`com.meterwise.app`, package `meterwise`) is a production-quality
Flutter Android app for **prepaid electricity billing in multi-tenant buildings
in Bangladesh** (DPDC-style). One prepaid main meter feeds tenant sub-meters;
the landlord records only **meter readings** and **recharges**; the app derives
consumption, splits slab tariffs fairly, tracks prepaid balances as a ledger,
and produces professional PDF invoices (English + বাংলা).

**Owner/user:** Wajed Hossain (pizzatrianglebd@gmail.com). Real deployment: one
property ("Rahman Villa"), one DPDC meter, two tenants (Shakil, Noman). His
spreadsheet `~/Desktop/Personal Finance - Noman Electric bill.csv` is the
**binding source of truth for all billing math** — its two tenant columns are
encoded as exact unit tests. His live data backups exist at
`~/Downloads/meterwise.sqlite` and `~/Downloads/meterwise_backup_*.zip`.

**Working preferences (important):**
- Do NOT stop for approval between features. Stop only for credentials
  (Google OAuth, Play Store) or true blockers.
- After every major feature: `flutter analyze` (zero issues) → `flutter test`
  → build release APK → then continue.
- When prose spec and his spreadsheet disagree, **the spreadsheet wins**.
- Be honest about what was and wasn't device-tested (no device attached here).

---

## 2. Environment & build commands

- macOS (darwin arm64). **Flutter 3.44.4 / Dart 3.12.2 via Homebrew — NOT on
  default PATH.** Prefix every command:
  ```bash
  export PATH="/opt/homebrew/bin:$PATH"
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
  ```
- Project root: `/Volumes/Mac 500 SSD/Claude/MeterWise` (git repo since the revamp baseline, commit `1ba118a`).
- Codegen: `dart run build_runner build` (the `--delete-conflicting-outputs`
  flag was removed from build_runner — don't pass it). If riverpod_generator
  throws `InvalidTypeException` on first pass after adding Drift tables, run it
  twice — but see §8 gotcha #1 first.
- Localization: `flutter gen-l10n` after editing `lib/l10n/app_*.arb`.
- Tests: `flutter test --timeout=90s`.
- Release: `flutter build apk --release` → copy from
  `build/app/outputs/flutter-apk/app-release.apk`, name it
  `archive/apks/MeterWise-vX.Y.Z-<slug>.apk` (older builds archived there in
  Phase 0). Bump `version:` in pubspec first (currently `4.5.0+35`) **and**
  `AppConstants.appVersion` in `core/constants/app_constants.dart`.
- `aapt` (icon/manifest checks): `$ANDROID_HOME/build-tools/35.0.0/aapt`.
- `.gov.bd` sites fail TLS in WebFetch — use `curl -sk` or Python ssl-noverify.
- No device usually attached (`adb devices` empty) → deliver APK file; user
  installs manually. Migration is additive, but always tell the user to Backup
  (Settings → Backup) before installing.

---

## 3. Architecture

- **Feature-first Clean Architecture**: `lib/features/<feature>/{data,domain,application,presentation}/`.
  Layers only exist where needed (no empty folders).
- **State:** Riverpod 3 (mixed codegen + manual providers — see gotcha #1).
- **DB:** Drift/SQLite, reactive `watch()` streams drive the UI.
- **Navigation:** GoRouter `StatefulShellRoute.indexedStack`, 5 tabs
  (Dashboard/Readings/Recharge/Bills/Settings); detail/form screens are
  full-screen routes on the root navigator (`parentNavigatorKey`). Adaptive:
  NavigationBar <720px, NavigationRail ≥720px.
- **Billing engine is pure Dart** (`features/billing/domain/billing_engine.dart`)
  — no Flutter, no Drift imports. **Single computation path**: every surface
  (dashboard, bills, invoice, PDF, charts, carry-forward) consumes the engine's
  `MonthlyBill` via providers. Never create a second calculation path.
- **Immutable accounting**: months are `BillingPeriods` (draft → finalized).
  Finalized months store the computed bill as a **JSON snapshot** and are
  **enforced read-only at the repository layer** (`PeriodGuard` throws
  `FinalizedPeriodException` on any mutation in a finalized month; UI also
  disables controls via `finalizedMonthsProvider`).
- **Startup seeding** (`main.dart`, shared ProviderContainer +
  `UncontrolledProviderScope`): tariff provider row, settings row, tariff
  "Version 1". Root widget swaps Onboarding ↔ router on `settings.onboarded`;
  `SplashGate` (in `MaterialApp.builder`) plays the animated logo once/session.

### Key files map

```
lib/
├── main.dart                          # seeding, locale, SplashGate, root swap
├── core/
│   ├── constants/app_constants.dart   # app name, DB name, schemaVersion (7)
│   ├── database/
│   │   ├── app_database.dart          # @DriftDatabase + ALL migrations
│   │   ├── database_provider.dart     # appDatabaseProvider (keepAlive)
│   │   ├── connection/database_connection.dart  # staged-restore swap on open
│   │   └── tables/*.dart              # one file per table
│   ├── router/{app_router,app_routes}.dart
│   ├── theme/{app_colors,app_theme,theme_controller}.dart
│   ├── utils/{formatters,image_storage}.dart
│   └── widgets/  # app_shell, splash_gate, animated_count(+FadeSlideIn),
│                 # async_value_view, section_card(+LabelValueRow),
│                 # feature_placeholder, attachment_picker
├── features/
│   ├── billing/
│   │   ├── domain/billing_engine.dart        # THE engine (see §5)
│   │   ├── domain/models/{tariff,billing_input,billing_result}.dart  # JSON-able
│   │   ├── application/billing_providers.dart # periodView, monthlyHistory, BillingContext
│   │   ├── application/period_actions.dart    # validate/finalize/unlock/isFinalizedOn
│   │   ├── application/invoice_pdf.dart       # vector PDF (English fallback)
│   │   ├── application/invoice_html.dart      # HTML invoice (primary, Bangla-capable)
│   │   ├── data/{billing_period_repository,period_guard,bill_payment_repository}.dart
│   │   └── presentation/{bills_screen,tenant_bill_detail_screen,period_status_chip}.dart
│   ├── dashboard/presentation/{dashboard_screen, widgets/{stat_card,mini_bar_chart}}.dart
│   ├── readings/   # list+add screens, reading_repository, reading_sessions
│   ├── recharge/   # list+edit screens, recharge_repository (RechargeDraft record type)
│   ├── settlements/ # tenant→tenant transfers (list+edit, repository)
│   ├── tenants/    # list+edit (billingMode/fixedRate UI), tenant_repository
│   ├── tariff/     # tariff_manager_screen, tariff_version_edit_screen,
│   │               # tariff_version_repository, tariff_repository(legacy seed),
│   │               # domain/tariff_presets.dart
│   ├── properties/, main_meter/, settings/ (settings hub, billing settings,
│   │               backup_screen+backup_service, settings_repository)
│   └── onboarding/presentation/onboarding_screen.dart  # 3-page tour
├── l10n/ app_en.arb, app_bn.arb (+generated app_localizations*.dart)
test/  # billing_engine_test, billing_periods_test, migration_test,
       # invoice_pdf_test, invoice_html_test, db_override_test, widget_test,
       # tools/launcher_icon_generator_test.dart (generates Android icons!)
```

---

## 4. Database schema (v11)

All migrations are **additive** (createTable/addColumn only). Migration code in
`app_database.dart onUpgrade`; version history in `app_constants.dart`.

| Table | Purpose / notable columns |
|---|---|
| `Properties` | name, address, currencyCode ('BDT' default), isActive |
| `ElectricityProviders` | mostly vestigial post-v4; its `name` = utility label (DPDC/DESCO/…) set from Main-Meter screen, shown on invoices |
| `TariffSlabs` | legacy v1 slab rows (superseded by TariffVersions; still seeds "Version 1") |
| `MainMeters` | propertyId, providerId, name, meterNumber, sanctionedLoad |
| `Tenants` | mainMeterId, name, phone, email, apartment, meterNumber, **billingMode** ('shared'\|'fixed', v7), **fixedRate** (nullable, v7) |
| `MeterReadings` | mainMeterId XOR tenantId (CHECK constraint), readingDate, cumulative readingValue, photoPath (v2). **Raw readings only, never monthly summaries** |
| `Recharges` | mainMeterId, date, **amount = energy credit**, energyCost/demandCharge/meterRent/vat/rebate/**agentFee/otherExpenses** (fees!), paidBy (free text matched to tenant name), tokenNumber, receiptPath (v2) |
| `AppSettings` | singleton id=1: multiTenant, fixedRate+fixedUnitPrice (legacy, migrated in v7), languageCode, onboarded, **fixedChargeDistribution** ('equal'\|'usage', v7) |
| `BillPayments` | (tenantId, monthKey 'yyyy-MM') manual "Mark paid" flags |
| `TariffVersions` | label, effectiveFrom, **tariffJson** (whole Tariff object incl. lifeline), archived (v5) |
| `BillingPeriods` | propertyId+year+month UNIQUE, status draft/finalized, finalizedAt, tariffVersionId, billingMethodSnapshot, currencySnapshot, **calculationSnapshot = MonthlyBill JSON** |
| `Settlements` | mainMeterId, date, fromTenantId, toTenantId, amount, notes |

**Version history:** v1 base · v2 AppSettings+photo/receipt paths · v3
BillPayments · v4 TariffVersions+BillingPeriods · v5 archived (`if (from == 4)`
— NOT `< 5`, because `from < 4`'s createTable already includes it) · v6
Settlements · v7 tenant contracts + distribution + SQL migrating legacy global
fixed-rate to per-tenant. v8 property `billingCalcMode`. v9 `AppSettings.themeMode`
(persisted appearance). v10 `AppSettings.invoiceLanguage` (auto/en/bn). v11 tenant
role fields (`appRole`, `meterCode`, `joinedMeterCode`, `tenantName`, `tenantApproved`).
All additive; migration tests cover v3/v4/v6/v7/v8/v9/v10 upgrade paths.

**Readings/recharges belong to a period BY DATE** (no FK): locking checks
whether the date's month is finalized. Foreign keys ON via `beforeOpen` PRAGMA.

---

## 5. Billing engine — FINAL semantics (spreadsheet-verified, do not change casually)

Full formulas in `BILLING.md`. Summary (engine v3 / app v2.3+). The engine also
supports three property-level calculation modes (`Properties.billingCalcMode`,
schema v8): `sharedSlab` (default, below), `reconciled` (Σ tenant bills == main
meter bill exactly, equal average rate for shared tenants) and `fixedRate`
(fixed tenants pay their rate, shared tenants split the remainder). All modes
are implemented in `billing_engine.dart` and covered by engine tests; the UI
switch is in `billing_settings_screen.dart`.

1. **Consumption**: `billedUnits_i = mainUnits × usageShare_i` (own units +
   proportional share of common area = main − Σ tenant units).
2. **Shared slab (default)** — *equal share of every slab*: per-tenant slab
   boundaries = `floor(original cumulative upper bounds ÷ N)`, N = count of
   SHARED tenants only. Each tenant walks their per-tenant ladder independently
   with own billedUnits; open-ended top slab absorbs remainder; breakdown rows
   keep ORIGINAL slab labels. **N=2 on 75/200/300/400/600 → shares
   37/63/50/50/100/∞.** It is **DIVIDE, not multiply** — an earlier prose spec
   said ×N; the spreadsheet overruled it.
3. **Lifeline is an ELIGIBILITY tariff, not slab 1**: if units ≤ lifelineUpTo
   (50) → ALL units at lifelineRate (4.63); else ignored entirely, ladder starts
   0–75@5.26. Lifeline threshold is **never divided** by N.
4. **Fixed-rate tenants**: `billedUnits × fixedRate`, all-inclusive; excluded
   from N; never consume slab capacity.
5. **Fixed charges** (demand+rent) and **expenses** (Σ per-recharge
   agentFee+otherExpenses — accumulated per transaction, not monthly) split by
   weight w = 1/N (Equal, default) or byUsage.
6. **VAT/rebate** (5% / 0.5%) on the **FULL subtotal incl. expense share**.
7. **Recharges**: payer's ledger credited `amount + fees` (actual money out);
   invoice shows energy credit and fees separately.
8. **Settlements**: from-tenant balance +amount, to-tenant −amount (net zero).
9. **Carry-forward**: `balance = previousBalance + rechargePaid + settlementsPaid
   − settlementsReceived − totalBill`; finalized snapshots seed the next month's
   openings; draft months compute live from last finalized snapshot forward.
10. `buildingBill` (what DPDC actually charges) is informational; Σ tenant bills
    ≠ buildingBill in general — **intentional** per user.
11. `sharedAdjustment` field always 0 now (kept for old-snapshot compat).

**Golden tests** (exact to 1e-6, from the CSV): T1 377u/2-shared → energy
4503.07, +rent 20 +demand 42 +fees 40, VAT 230.2535, rebate 23.02535, total
**4812.29815**; T2 204u → **1910.4272** (slabs 37/63/50/50/4).

**Verified official tariff** (dpdc.gov.bd, effective bill-month **June 2026**,
uniform across all BD utilities): lifeline ≤50 @4.63; 0-75 @5.26; 76-200 @8.50;
201-300 @9.10; 301-400 @9.62; 401-600 @15.01; 601+ @17.35; demand ৳42/kW/month.
Presets: one per provider (DPDC/DESCO/BPDB/BREB/NESCO/WZPDCL) + legacy pre-2026
(4.19…11.46). Presets are read-only; users clone.

**Tariff resolution**: strictly by effectiveFrom date (latest ≤ month start),
archived excluded, duplicate effective dates rejected (`TariffException`),
can't delete last active version.

---

## 6. Feature inventory (all implemented & verified)

- **Setup**: onboarding tour (3-page PageView: intro → how-it-works → mode
  choice), property/main-meter (with provider dropdown)/tenant CRUD, per-tenant
  billing contract (shared/fixed+rate) on tenant profile.
- **Data entry**: reading sessions (date + main + per-tenant values, meter
  photo, duplicate-date & lower-than-previous validation), recharge log (amount
  + fees breakdown in ExpansionTile, paid-by with tenant chips, receipt photo),
  settlements (tenant→tenant).
- **Accounting**: draft/finalized periods, validate-with-reasons → finalize
  (snapshot) → unlock (warned), PeriodGuard hard immutability, carry-forward
  ledger, Mark-paid flags, in-order finalize NOT hard-enforced (deliberate).
- **Tariff Manager**: presets, create/edit/clone/rename/archive/delete/preview
  versions, lifeline fields in editor (v2.0.2 — editor used to drop them: that
  was the real-world lifeline bug), unique effective dates.
- **Dashboard**: gradient hero (remaining prepaid = carry-forward) with
  AnimatedCount + status chip, pull-to-refresh, colorful tappable stat cards
  (navigate), quick actions, interactive fl_chart trend (Usage/Recharge/Bill/
  Avg-rate, tooltips, horizontal-scroll segmented control), recent activity,
  tenant rows with palette avatars + effective rate + usage-share bars.
- **Bills**: animated month selector, period header (finalize/unlock), tenant
  cards (avatar, paid/due/credit chip, mark-paid), detail screen with full
  breakdown incl. expense share / fees / effective rate / mode chip.
- **Invoices**: primary = **HTML → platform WebView PDF** (`invoice_html.dart`
  via deprecated-but-only-option `Printing.convertHtml`; full Bangla shaping,
  localized labels, escaped user input); fallback = English vector PDF
  (`invoice_pdf.dart`, gradient banner + chips + zebra table + total banner +
  QR/signature placeholders, Noto fonts bundled). Share/print.
- **i18n**: complete en + bn (~200 ARB keys), language switcher, persisted.
- **Backup**: local zip (DB + images) share-out; restore stages
  `restore.sqlite`, swapped atomically on next launch. Drive sync = stub
  (needs user OAuth).
- **Theme/UX**: electric blue #2962FF + violet/orange/yellow/teal accents,
  light-grey bg, animated splash (SplashGate), generated launcher icon
  (matches splash; regenerate via `flutter test
  test/tools/launcher_icon_generator_test.dart`), floating snackbars, undo on
  deletes, success toasts, animated empty states, dark mode.

---

## 7. Dependencies (and WHY they're pinned)

```yaml
flutter_riverpod ^3.3.2, riverpod_annotation ^4.0.3, go_router ^17.3.0,
drift ^2.34.0, sqlite3_flutter_libs ^0.6.0+eol, path_provider, path,
freezed_annotation ^3.1.0, json_annotation, pdf ^3.13.0, printing ^5.15.0,
share_plus ^12.0.2,        # PINNED: 13.x needs win32 ^6, file_picker 8–11 needs ^5 → conflict
fl_chart ^1.2.0, intl ^0.20.2,   # pinned by flutter_localizations
collection, url_launcher, image_picker ^1.2.2, archive ^4.0.9,
file_picker ^8.1.2,        # see share_plus note; do NOT dependency_override win32
flutter_localizations (sdk)
dev: build_runner, riverpod_generator, drift_dev, freezed ^3.2.6-dev.1,
     json_serializable, sqlite3 (for migration tests), flutter_lints
```
`build.yaml`: `json_serializable: explicit_to_json: true` (snapshots need fully
plain maps). NEVER add a `dependency_overrides: win32` — it compiles
file_picker's Windows code against wrong API and breaks the **Android** build.

Android: `android/app/build.gradle.kts` → `compileSdk = 36` AND
`android/build.gradle.kts` forces all plugin subprojects to compileSdk 36 via
`afterEvaluate` **in the early `subprojects` block** (before
`evaluationDependsOn(":app")`, else "already evaluated" error). App label
"MeterWise"; applicationId `com.meterwise.app` (namespace stays
`com.meterwise.meterwise`). Release build currently **signed with debug keys**
(template TODO) — must add real signing before Play Store.

---

## 8. Hard-won gotchas (read before coding)

1. **riverpod_generator cannot return Drift entity types** (they live in
   `app_database.g.dart` part) → `InvalidTypeException`. Those providers are
   **manual** (`final xProvider = StreamProvider(...)` in repository files);
   codegen only for Freezed/plain types. Both interop fine.
2. Riverpod 3 `AsyncValue`: use `.value`, there is **no** `.valueOrNull`.
3. **Widget tests**: never `pumpAndSettle` with Drift streams (frames never
   settle → 10-min timeout). Worse: under `testWidgets` fake-async, Drift's
   real I/O never progresses at all. So: pure-widget tests only + direct
   repository tests with `AppDatabase.forTesting(NativeDatabase.memory())`.
4. **Migration tests** simulate old versions on a shared
   `sqlite3.openInMemory()`: open current schema → DROP all later
   tables/columns → `PRAGMA user_version = N` → reopen. When adding schema vN+1,
   you MUST update older simulations to also drop the new columns.
5. **dart `pdf` has NO complex-script shaping** — Bengali is impossible in it
   with any font. Bangla path = `Printing.convertHtml` (deprecated; keep the
   `// ignore: deprecated_member_use` + vector-English fallback in try/catch).
   Also: bundled NotoSans lacks `✓` U+2713 — don't use it in vector PDFs.
6. fl_chart 1.2: `BarTouchTooltipData(tooltipBorderRadius: ...)` (NOT
   `tooltipRoundedRadius`); chart animation via `BarChart(duration:, curve:)`.
7. Overlay widgets above the Navigator (e.g. in `MaterialApp.builder`) need a
   `Material(type: transparency)` wrapper or text gets yellow underlines.
8. Formatters use `intl` with default locale (en digits/dates everywhere,
   including bn UI) — deliberate.
9. `PeriodGuard` must be called by EVERY new mutation path (repository layer);
   UI-only checks are not sufficient.
10. New `TenantBill`/`MonthlyBill` fields MUST have `@Default(...)` so old
    finalized snapshots keep decoding (regression test exists).
11. Old finalized snapshots render exactly as saved even after engine changes —
    by design; never "fix" historical months in code.
12. First slab of user's on-device tariff: if it still contains a `0–50` slab
    row, shared/lifeline math is wrong — user must edit the version (first slab
    0–75, lifeline fields 50/4.63) or clone the Jun-2026 preset. Code can't fix
    stored data.

---

## 9. Coding standards

- `flutter analyze` must be zero-issue before any delivery (info-level included).
- Files < ~300 lines where practical; feature-first placement; repositories
  expose primitive-arg methods (Drift `Value<>`/Companions never leak into UI).
- All user-visible strings through `AppLocalizations` (en + bn ARB); new keys
  need BOTH files + `flutter gen-l10n`.
- Money/units/dates via `core/utils/formatters.dart` only.
- Doc comments explain *constraints and whys*, not narration.
- Tests accompany every engine/repository/migration change; user-provided
  examples become exact regression tests.
- Version bump per delivery: `pubspec.yaml` `version: X.Y.Z+N`, copy APK to
  `archive/apks/MeterWise-vX.Y.Z-<slug>.apk`, update Settings footer string if minor/major.

---

## 10. Testing status (59 tests)

- `billing_engine_test.dart` — v2 semantics: spreadsheet golden columns (T1/T2
  exact), shared-ladder shares for N=1/2/3/4, mixed contracts (divisor counts
  only shared), fixed-rate, equal/byUsage distribution, recharge fees
  accumulation + actualPaid credit, lifeline eligibility + never-divided,
  settlements conservation, carry-forward, edge cases (negative readings, zero
  usage, over-collection clamp), v1-snapshot JSON decode, v2 round-trip.
- `billing_periods_test.dart` — finalize snapshot immutability, unlock,
  PeriodGuard blocks mutations in finalized months, latestFinalizedBefore,
  tariff version by-date resolution/unique-dates/archived exclusion.
- `migration_test.dart` — v3→current, v4→current, v6→v7 (incl. legacy global
  fixed-rate → per-tenant data migration).
- `invoice_pdf_test.dart` — vector invoice renders end-to-end (fonts+layout).
- `invoice_html_test.dart` — Bangla labels & Bangla names intact, HTML escaping,
  draft banner.
- `db_override_test.dart`, `widget_test.dart` — infra + pure widgets.
- `test/tools/launcher_icon_generator_test.dart` — regenerates Android icons
  (idempotent; runs with the suite).

**Not covered / device-only:** WebView HTML→PDF conversion output, camera/
gallery flows, share sheets, real upgrade on user's phone (mitigated by
migration tests + additive-only migrations).

---

## 11. Known issues & pending tasks

| Item | Status |
|---|---|
| Google Drive sync | v3.3.0: AES‑256‑GCM encrypted packets (`packet_crypto.dart`, key = SHA‑256 of `MeterWise:v1:<meterCode>`), `landlord.enc` + `tenant_<name>.enc` in `MeterWise/<code>`. Tenant write-back imported by landlord. Hourly WorkManager task (`sync_worker.dart`, registered in `main.dart`) runs sync when online. Both OAuth client IDs injected via `--dart-define` from `.secrets/`. UI: Settings → Drive sync. |
| Release signing | Real keystore generated at `android/app/upload-keystore.jks` with config in `android/key.properties` (both git-ignored). APK verified signed via apksigner. **Back up both files and the password** — losing them means you cannot publish updates. |
| Settlement transaction list inside PDF | Not embedded; invoice shows settlement paid/received totals, full list lives in Settlements screen. |
| WebView Bangla PDF | v3.0.4: native Android channel (`com.meterwise.app/invoice_pdf`, `MainActivity.kt` + `android.print/MeterWisePrintCallbacks.java`) owns a transparent WebView for the whole job. Runs on a background thread (MethodChannel handlers are on the main thread — waiting there froze the UI), 20s layout/write timeouts, teardown in `finally`, explicit `ISO_A4` + 300 DPI print attributes (missing resolution caused `attributes must specify print resolution`). `stampTitle()` appends an `/Info /Title` so sharing apps don't show "Untitled". Device-verified on S9+. Fallbacks: plugin converter (10s) → English vector PDF, with visible notice + Retry. Invoice language is a persisted setting (auto/en/bn). |
| In-order finalize | Not hard-enforced (carry-forward walks drafts correctly); could add strict ordering if user asks. |
| User's on-device tariff version | May still carry lifeline-as-slab-row (see gotcha #12) — remind if math complaints resurface. |
| iOS | Untouched (CocoaPods not installed; Android-only so far). |
| "Replay intro" in Settings | Offered, not requested; tour shows only on first run. |
| versionName in Settings footer | Hardcoded string — keep in sync on bumps (updated to v2.2.1). |

---

## 12. Release history (context for support)

| Version | Highlights |
|---|---|
| 1.0 | MVP: CRUD, readings, recharges, proportional engine v1, PDF, dashboard |
| 1.1 | PDF ৳ fonts, per-period billing, carry-forward, wizard, validation/undo, photos, local backup, en/bn i18n |
| 1.2 | Accounting: BillingPeriods, snapshots, tariff versioning, finalize/unlock (schema v4) |
| 1.3 | PeriodGuard hard immutability, settlements, tariff manager+presets, full i18n, electric-blue UI (schema v6) |
| 2.0 | Hybrid engine, per-tenant contracts, fee separation, provider selection, verified Jun-2026 tariff (schema v7) |
| 2.0.1–2.0.3 | Shared-slab corrections → final spreadsheet-exact divide semantics; lifeline eligibility; VAT base incl. fees |
| 2.1.0–2.1.1 | Colorful interactive UI, charts/tooltips, splash, tour, vector-PDF redesign |
| 2.2.0–2.2.1 | **Bangla-capable HTML invoices** (WebView) + launcher icon + splash fixes + share fix |
| 2.3.0 | Property-level calculation modes (sharedSlab / reconciled / fixedRate), schema v8 |
| 3.0.0 | Core-first revamp: persisted theme + invoice language, full en/bn coverage, working error Retry, finalized metadata freeze, dashboard split, quiet visual refresh (schema v10) |
| 3.0.1 | Native WebView-owned Bangla PDF channel + real signed release keystore |
| 3.0.2–3.0.4 | Device debugging on S9+: background thread fix, print resolution fix, PDF title stamping; Bangla invoices verified on-device |
| 3.1.0 | Tenant access prototype: meter code + QR invite, scan/manual join with roster-name selection, landlord approval, tenant-scoped home with usage/bill/balance (schema v11) |
| 3.1.1 | Tenant mode becomes the first tab; tenant self-entry for own readings, recharges and payments/reimbursements |
| 3.1.2 | Tenant-scoped bottom nav (Home + My entries), entry history list, building-total label |
| 3.1.3 | Cross-device join accepts any well-formed meter code; tenant can leave meter / return to landlord view |
| 3.2.0 | Google Drive packet sync: Google Sign-In, landlord upload, tenant download + idempotent import, Settings UI |
| 3.2.1 | Device fixes: Web OAuth `serverClientId`, UTC token expiry, tenant role restored when re-entering from Settings. Drive backup + tenant sync verified on S9+ |
| 3.3.0 | Encrypted Drive packets (AES‑GCM), tenant write-back, hourly WorkManager sync |
| 3.4.0 | Professional UI craft pass, privacy policy + in-app link, Play Store compliance docs and signed AAB |
| 3.4.1 | Dark-theme hero contrast fix |
| 3.5.0 | In-app GitHub updater for sideload builds (disabled in Play AAB) |
| 3.6.0 | Design system tokens, BrandButton/BrandChip components, themed buttons/chips/inputs across the app |
| 3.7.0 | Custom MeterGauge signature visual, haptic + press feedback, peak/end emotional design |
| 3.7.1 | Tenant can switch to landlord view to approve locally without leaving the meter; pending state has a status-check action |
| 4.5.0 | Redesigned invoice PDF (gradient hero, both vector + HTML paths); ID-based recharge/tenant attribution with v12 migration; settlement direction and balance signs corrected; reading validation, cascade unlock, join fallback, settlement confirm, mark-settled note-only, mode-switch warning |
| 4.4.0 | White tiles preserved; warm gradient dashboard hero + green/red tenant gradient hero, gradient icon tiles, white-on-gradient typography |
| 4.3.0 | Neutral cool-grey canvas with colourful elements: multi-hue icon tiles and coloured bottom-nav destinations, orange as accent only |
| 4.2.0 | Warm orange-forward canvas, cream tiles and a solid orange app-bar band; the washed-out white look is removed |
| 4.1.0 | Light-orange electricity accent on cool white tiles; deeper icon inks and stronger shadows fix low-visibility icons/mini-stats |
| 4.0.0 | Complete app-wide "Soft Modern" redesign: monochromatic neumorphic palette, paired light/dark shadows, reusable SoftSurface/SoftCard/SoftInset/SoftIconTile/SoftIconButton components, recessed meter dial, soft inputs/navigation/chips, light + dark; all existing features preserved |

---

## 13. First moves for a new session

1. `export PATH="/opt/homebrew/bin:$PATH"` and run `flutter analyze` +
   `flutter test` to confirm the green baseline.
2. Read `BILLING.md` before touching anything in `features/billing/`.
3. If schema changes: bump `databaseSchemaVersion`, add additive migration,
   update ALL older simulations in `migration_test.dart` (gotcha #4), add an
   upgrade test.
4. If engine changes: the spreadsheet golden tests must keep passing unless the
   user explicitly supplies a new spreadsheet — his sheet outranks prose.
5. Deliver: analyze → test → APK in project root → honest summary including
   anything not device-verifiable.
