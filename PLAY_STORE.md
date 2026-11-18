# Google Play publishing — compliance plan

This document records what is already compliant, what is prepared, and the
remaining **account-side actions** that only the developer can perform in
Google Play Console / Google Cloud Console.

App: `com.meterwise.app` · version `3.3.0+23` (next release should bump to
`3.4.0+24` after the UI craft pass) · AAB built with
`flutter build appbundle --release`.

## 1. Already compliant / done in code

| Requirement | Status |
|---|---|
| Target API level | ✅ `targetSdk = 36` (Flutter 3.44 default) — meets current Play requirement |
| 64-bit support | ✅ Flutter ARM64 AAB |
| Signed release AAB | ✅ `android/key.properties` + upload keystore, verified by `bundleRelease` |
| Incremental versionCode | ✅ `pubspec.yaml` `+23` → Android `versionCode` |
| Privacy policy URL | ✅ https://wajedhossainbd.github.io/Meterwise/privacy.html (GitHub Pages), linked in app Settings |
| In-app privacy access | ✅ Settings → Privacy policy |
| Permissions are minimal and justified | ✅ INTERNET (Drive sign-in/sync), CAMERA (meter photo + QR scan), FOREGROUND_SERVICE/POST_NOTIFICATIONS/RECEIVE_BOOT_COMPLETED/WAKE_LOCK (WorkManager hourly sync), USE_BIOMETRIC/FINGERPRINT (Google Sign-In), ACCESS_NETWORK_STATE |
| No ads / no analytics / no trackers | ✅ none in dependencies |
| No self-update outside Play | ✅ in-app GitHub updater is compiled out of the AAB with `--dart-define=METERWISE_GITHUB_UPDATER=false`; enabled only in the sideload APK |
| Local-first data | ✅ SQLite on device; no MeterWise server |
| Screenshots for listing | ✅ `docs/screenshots/` (8 device captures) |

## 2. Remaining actions in Play Console (developer account)

1. **Google Play developer account** — one-time $25 registration fee (needed to
   publish). If it is a personal account created after 2023, a new app needs a
   **closed test with at least 12 testers for 14 days** before production access.
2. **App signing by Google Play** — enrol during the first upload. Keep the
   local upload keystore safe; do **not** lose it. If you use Play App Signing,
   the key used to sign the uploaded AAB is the upload key.
   - Upload certificate SHA-256 (for reference in Play Console):
     `50:47:2B:20:79:01:BB:32:FB:95:E7:1F:20:85:75:C0:2C:3C:2B:50:F1:8D:65:A9:3B:E3:77:53:D8:A6:BC:54`
   - Exact steps: Play Console → app → **Setup → App integrity** → enrol in
     **App signing by Google Play** → accept terms → upload the signed AAB on
     the release track. Google generates and holds the *app-signing* key; the
     local keystore remains the *upload* key used to sign future AABs.
   - After enrolment, verify Play Console shows the upload certificate above.
   - **Back up** the upload keystore + `key.properties` + `.secrets/` outside
     this repo. A local encrypted backup already exists at
     `~/Documents/MeterWise-secrets/v3.4.1/` (with verified identical hashes);
     also copy it to an external drive or password manager.
3. **Store listing**
   - Short description (80 chars): "Fair prepaid electricity billing for multi-tenant buildings in Bangladesh."
   - Full description: see `STORE_LISTING.md`.
   - App icon 512×512 (from `android/app/src/main/res/mipmap-*/ic_launcher.png`).
   - Feature graphic 1024×500 — create from the brand blue + app name + tagline.
   - Screenshots: use the PNGs in `docs/screenshots/`.
   - Category: Tools or Finance; tags: electricity, billing, landlord, tenants.
4. **Content rating questionnaire** — answer honestly (no violence, no user
   generated content, no ads). Expected rating: Everyone.
5. **Data safety form** — suggested answers:
   - Data collected: **Email address** (Google Sign-In, for account display only)
     and **Photos** (meter/receipt photos, only if the user takes them).
   - Purpose: App functionality. Not used for advertising, not sold, not shared
     with third parties.
   - Email is processed by Google Sign-In and stored locally; photos stay on
     device. Drive packets are stored in the **user's own Google Drive** and are
     AES-GCM encrypted; MeterWise has no server.
   - Data encrypted in transit: yes (Google APIs/HTTPS). User can request
     deletion: yes — uninstall the app and delete the `MeterWise` Drive folder.
6. **OAuth consent screen / sensitive scope verification** — ⚠️ **main blocker**
   - **Decision: keep the `drive` scope and apply for verification.** The app's
     core sync requires the tenant to read a packet created by the landlord's
     *different* Google account. `drive.file` only grants access to files the
     app created or the user opened through Drive's "Open with", so it would
     require a separate per-file sharing flow and break the automatic sync.
   - `https://www.googleapis.com/auth/drive` is a **restricted** scope; Google
     will review before the app can be published to all users.
   - Verification submission checklist:
     1. Google Cloud project with Drive API enabled and quota set to **Production**
        (a project in "Testing" expires after 7 days).
     2. OAuth consent screen in **Production**, with app domain and the public
        privacy policy URL: https://wajedhossainbd.github.io/Meterwise/privacy.html
     3. Authorized domain: `wajedhossainbd.github.io` (for the policy link).
     4. A short demo video showing: sign-in, landlord creating the
        `MeterWise/<code>` folder and encrypted packet, tenant joining with the
        code and reading the packet, and the in-app privacy-policy link.
     5. A written justification: "The app stores each user's billing packets in
        their own Google Drive so two users can synchronise a shared meter
        without a MeterWise-hosted server; access is limited to the app-created
        `MeterWise` folder."
     6. Submit the verification request from the OAuth consent screen page.
   - **Fallback if verification is rejected or too slow:** add a Google Drive
     "Open with" intent filter for packet files and switch
     `driveScopes` in `lib/features/sync/data/drive_config.dart` to
     `https://www.googleapis.com/auth/drive.file`, then ask the tenant to open
     the shared packet once from Drive. This is a smaller review burden but
     needs app changes and a manual first-time step.
7. **App access / tester instructions** — no sign-in wall after install (the
   Google sign-in is optional, for Drive sync only), so "no credentials needed"
   can be declared for the reviewer.
8. **Release** — upload the AAB to the Internal/Production track, complete the
   rollout, then attach the APK on GitHub Releases for sideloaders.

## 3. Device verification already completed

- S9+ (SM-G965F, Android 10) and Pixel_7 emulator (Android 16).
- Sign-in, encrypted backup, tenant sync, join/approval, self-entry, Bangla PDF,
  finalize/unlock guards, migration paths.
- `flutter analyze` clean; 61/61 unit tests pass.

## 4. Notes

- `docs/privacy.html` is served by GitHub Pages from the `main:/docs` folder.
- If the domain/URL changes, update both Play Console and Settings → Privacy policy.
- Keep `CHANGELOG.md`, `README.md` status and `AppConstants.appVersion` in sync
  on every release (see README → Versioning and updates).
