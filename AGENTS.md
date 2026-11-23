# AGENTS.md — MeterWise

Instructions for every coding agent working here (Claude Code, Antigravity, OpenCode, Codex).
The shared rules are in `~/.claude-master/Standards/agents.md`; anything below overrides them for this project.

## What it is
Smart multi-tenant electricity billing: a Flutter Android app for prepaid electricity in multi-tenant buildings in Bangladesh (DPDC-style tariffs). The landlord records meter readings and recharges; MeterWise does the rest.

## Stack
Flutter (Dart) app for Android and iOS

## Layout
Top-level folders: `android/`, `assets/`, `docs/`, `ios/`, `lib/`, `test/`.

## Commands
```bash
flutter pub get
flutter test
flutter run
```
Run the test, lint and type-check commands that exist before every push.

## Branches
- Production: `main`
- Staging: none
- Pull requests go to: `main`
- Agent branches: `claude/<type>/<task>`, `agy/<type>/<task>`, `oc/<type>/<task>`; owner: `wajed/<type>/<task>`
- Never push to the production branch; open a pull request. **The owner merges.**

## Environment
No environment files. Never commit `.env*` files, keys or tokens (they are gitignored).

## Rules for this project
- Public repository: never commit keys, tenant data or personal information.
- Release builds live in `archive/`; do not add new binaries to git.
