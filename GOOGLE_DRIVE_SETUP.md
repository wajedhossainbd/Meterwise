# Google Drive sync — one-time setup

This app will use **each user's own Google Drive** as the transport for meter
data packets. There is no MeterWise server and no hosted database, so your cost
is zero. Google's free Drive API quota applies to each user's own account.

You need to create **one free Google Cloud project** and give me the Android
OAuth **client ID**. Everything below is free.

---

## Values to use (already correct for this app)

| Field | Value |
|---|---|
| Package name | `com.meterwise.app` |
| App label | `MeterWise` |
| SHA‑1 (release signing key) | `D9:C4:CD:9D:2D:83:A7:C5:35:17:67:A0:FD:0A:A7:91:60:4F:F0:D9` |
| SHA‑256 (release signing key) | `50:47:2B:20:79:01:BB:32:FB:95:E7:1F:20:85:75:C0:2C:3C:2B:50:F1:8D:65:A9:3B:E3:77:53:D8:A6:BC:54` |

The keystore is `android/app/upload-keystore.jks` (git‑ignored). If you ever
replace that keystore, the SHA‑1 changes and you must add the new one in step 5.

---

## Step 1 — Create a Google Cloud project

1. Go to <https://console.cloud.google.com/>
2. Sign in with the Google account you want as the developer account.
3. Click **Select a project → New Project**.
4. Name it `MeterWise` (or anything you like). Leave organization as **No organization**
   unless you have one. Click **Create**.

## Step 2 — Enable the Google Drive API

1. In the project, go to **APIs & Services → Library**.
2. Search for **Google Drive API**.
3. Click it and press **Enable**.

## Step 3 — Configure the OAuth consent screen

1. Go to **APIs & Services → OAuth consent screen**.
2. User Type: choose **External**. Click **Create**.
3. Fill the required fields:
   - App name: `MeterWise`
   - User support email: your email
   - Developer contact information: your email
4. Click **Save and Continue** through the remaining pages until **Test users**.
5. On **Test users**, add the Google accounts you will use to test (your own,
   and any tenant tester). While the app is "Testing", only these accounts can
   sign in — that is fine for development.
6. Click **Save and Continue**, then **Back to Dashboard**.

> Later, before publishing on the Play Store, you may need to move the app to
> "In Production". If Google asks for verification because of Drive scopes,
> complete it then. Using only `drive.file` (below) usually avoids the strictest
> review, but reading a *shared* file may require `drive.readonly`, which is a
> sensitive scope and can trigger review. I will design the code to use the
> narrowest scopes that work and document this clearly.

## Step 4 — Create TWO OAuth clients

`google_sign_in` v7 on Android needs **both**:

**A) Web application client (used as `serverClientId`) — REQUIRED**
1. Go to **APIs & Services → Credentials → + Create Credentials → OAuth client ID**.
2. Application type: **Web application**.
3. Name: `MeterWise Web`. Leave redirect URIs empty. Click **Create**.
4. Copy its **Client ID** into `.secrets/google_server_client_id.txt`
   (or drop the downloaded JSON in the project root — I'll extract it).

**B) Android client**
1. **+ Create Credentials → OAuth client ID**.
2. Application type: **Android**.
3. Name: `MeterWise Android`.
4. Package name: `com.meterwise.app`
5. SHA‑1 certificate fingerprint: paste the SHA‑1 from the table above.
6. Click **Create**. Copy its Client ID into `.secrets/google_client_id.txt`.

> A "Desktop app / installed" client JSON does **not** work as the Android
> `serverClientId` — sign-in fails with `missingServerClientId`. You need the
> **Web application** client for that field.

## Publishing note

The app requests `https://www.googleapis.com/auth/drive` (restricted scope)
because landlord and tenant are different Google accounts. Before a Play Store
release, put the Cloud project's OAuth consent screen into **Production** and
submit Google's verification. See `PLAY_STORE.md` § 6 for the submission
checklist, demo-video outline and the `drive.file` fallback.

## Step 5 — Send me the client ID

Copy the **Client ID** that appears (it looks like
`123456789012-abcdefghijklmnop.apps.googleusercontent.com`) and send it to me.

I will put it in the app (not committed publicly) and build the sync layer:

- Google Sign‑In on both landlord and tenant devices
- Landlord: encrypted packet backup to `MeterWise/<meter code>/` in his Drive,
  refreshed hourly via WorkManager
- Tenant: joins with meter code, reads the landlord's shared packet from Drive,
  imports it into local SQLite, sees their bill
- Tenant: writes their own entries back as `tenant_<name>.json`
- Landlord: picks up tenant packets on next sync

No new accounts, no server, and no cost to you — only each user's own Drive.

---

## Security notes (for later)

- The meter code + QR should carry a shared secret, not just an ID.
- Drive files must be shared only with approved tenant Google accounts.
- Packets are end‑to‑end encrypted; the relay (Drive) sees ciphertext only.
- Rotate/revoke the meter code if a tenant leaves.
