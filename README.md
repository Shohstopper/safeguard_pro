# SafeGuard Pro

**AI worker safety monitoring, on the worker's phone.**

SafeGuard Pro is a Flutter mobile app for workers on industrial sites. A worker signs in at the start of a shift, pairs their company-issued smartwatch over Bluetooth, and the app keeps the watch linked for the whole shift so their safety can be monitored.

This is a university capstone project.

<p align="center">
  <img src="docs/screenshots/login.png" alt="SafeGuard Pro login screen" width="280">
</p>

## Project status

The backend is not ready yet, so the app runs on **fake data** for now (see [Fake data](#fake-data-mock-repositories)).

| Screen | What it does | Status |
|---|---|---|
| Login ("Welcome Back") | Worker enters name, Employee ID and site location | ✅ Done |
| Device setup (Step 1 of 3) | Turn on Bluetooth and scan for smartwatches | ⏳ Next |
| Choose a smartwatch (Step 2 of 3) | Pick the company-issued watch and connect | ⏳ Next |
| Shift protection active | Confirms the connection and shows the shift summary | ⏳ Next |

## Tech stack

| Purpose | Package |
|---|---|
| UI framework | [Flutter](https://flutter.dev) (stable channel) |
| State management | [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Cubits) |
| Navigation | [go_router](https://pub.dev/packages/go_router) |
| Comparing states and models | [equatable](https://pub.dev/packages/equatable) |
| Testing | flutter_test and [bloc_test](https://pub.dev/packages/bloc_test) |
| Code style | flutter_lints |

The font is [Inter](https://rsms.me/inter/), which is bundled in `assets/fonts/`.

## Getting started

### Requirements

- Flutter SDK (latest stable), which includes Dart
- Android Studio with an Android emulator, or a real Android phone

Check your setup with:

```bash
flutter doctor
```

### Run the app

```bash
git clone https://github.com/Shohstopper/safeguard-pro.git
cd safeguard-pro
flutter pub get
flutter run
```

### Try it out

With the fake data you can sign in with any name and location. The Employee ID must look like `SW-001`: the letters `SW`, a dash, and three digits.

| To see… | Do this |
|---|---|
| A successful login | Fill in all fields with a valid ID, for example `SW-001` |
| Field errors | Tap **Login** with empty fields, or type an ID like `12345` |
| A failed login | Use the Employee ID **`SW-000`** |

## Project structure

The code is organised **by feature**. Each feature has the same four folders, so every screen is built the same way.

```
lib/
  core/                     used by the whole app
    constants/              all on-screen text and asset paths
    router/                 all app routes in one file
    session/                who is signed in (app-wide)
    theme/                  colors, spacing, text styles, app theme
    utils/                  small helpers (form validators)
    widgets/                shared widgets (button, card, logo)
  features/
    login/
      data/                 repository: gets the data (fake now, real API later)
      bloc/                 cubit and state: the screen's logic
      pages/                the full screen
      widgets/              small widgets used only on this screen
  app.dart                  creates repositories and app-wide cubits
  main.dart                 starts the app
test/                       same layout as lib/
```

### How data flows

```
Page (UI)  →  Cubit (logic)  →  Repository (data)
```

- **Pages** only draw the screen and call cubit methods.
- **Cubits** hold the logic and talk to the repository. Each loading screen has four states: initial, loading, success and failure.
- **Repositories** return data, or throw an error that the cubit turns into a failure state.

### Fake data (mock repositories)

Each repository is an abstract class with two versions:

- `MockXRepository` returns fake data after a short delay. **This is used now.**
- `ApiXRepository` will call the real backend. It will be added when the API is ready.

All repositories are created in one place, [`lib/app.dart`](lib/app.dart). Switching from fake to real data means changing **one line per repository** there.

### Design

The screens follow the project's Figma design. Every color, spacing value, corner radius and text style is defined once in [`lib/core/theme/`](lib/core/theme/) and used from there. Widgets never hardcode these values.

## Development

Run these after every change. All three must pass before a screen is considered done:

```bash
dart format .
flutter analyze
flutter test
```

- `flutter analyze` must report **zero issues**.
- Every cubit has `bloc_test` tests for its success, failure and empty or validation cases.
- Important shared widgets have widget tests.

Contributor rules (folder structure, Bloc usage, design rules) are in [`CLAUDE.md`](CLAUDE.md).
