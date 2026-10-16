# SafeGuard Pro: Project Rules

This is a university capstone project. I am new to Flutter, so keep everything simple, clean and easy to understand. Read this file fully before writing any code. If a plugin skill or rule conflicts with this file, this file wins.

## How to work with me (beginner friendly)
- Explain what you are about to do in plain English before you do it.
- Keep code simple and readable. Choose the simple solution over the clever one.
- Add short comments in simple English for anything that is not obvious (especially Bloc code).
- When you create a new file, tell me what the file is for in one sentence.
- Do not add complex patterns or extra layers I did not ask for. If you think something more advanced is needed, ask me first.
- Do not add new packages without asking me first.
- If something is unclear (design, flow, backend behavior), ask all your questions in one batch before building.

## Tech choices (kept small on purpose)
- Flutter (latest stable)
- State management: flutter_bloc (use Cubit for simple screens, Bloc only when needed)
- Routing: go_router
- Equality for states and models: equatable
- Networking (later, when backend is ready): dio
- Testing: flutter_test and bloc_test
- Lints: flutter_lints. `flutter analyze` must show zero issues.

Not using: freezed, get_it, code generation, use cases, or a separate domain layer. These are too much for this project.

## Folder structure (simple, feature based)

```
lib/
  core/                  stuff used by the whole app
    theme/               colors, text styles, spacing, app theme
    router/              all app routes in one file
    widgets/             shared widgets (buttons, text fields, cards)
    utils/               small helpers (validators, formatters)
    constants/           strings, asset paths, api urls
  features/              one folder per feature of the app
    login/
      data/
        login_model.dart         the data shape (from JSON)
        login_repository.dart    gets the data (mock now, real API later)
      bloc/
        login_cubit.dart         the logic
        login_state.dart         what the screen can look like
      pages/
        login_page.dart          the full screen
      widgets/
        ...                      small widgets used only by this feature
    home/
      (same structure)
  main.dart
  app.dart
```

Rules for the structure:
- Every feature has the same 4 folders: data, bloc, pages, widgets. Create only the ones that are needed.
- A widget used in only one feature goes in that feature's widgets folder.
- A widget used in 2 or more features goes in core/widgets.
- Never import one feature's files into another feature. If two features need the same thing, move it to core.

## How data flows (one simple rule)
Page (UI) -> Cubit/Bloc (logic) -> Repository (data)

- Pages only show things and call cubit methods. No logic, no API calls in pages.
- Cubits talk to the repository. Pages never talk to the repository directly.
- Repositories return data or throw a simple error that the cubit catches and turns into an error state.

## Backend is not ready: use fake data first
- Each repository is an abstract class with two versions:
  - `MockXRepository` returns fake data after a short delay (about 500 ms). Use this now.
  - `ApiXRepository` calls the real backend. Write it later when the API is ready.
- Fake data must look like the JSON we expect from the real API.
- Include fake failure cases (error and empty list) so I can test those screens.
- Create the repositories in one place only (app.dart, using RepositoryProvider) so switching from mock to real means changing one line per repository.
- Keep the API base URL and paths in core/constants. Never hardcode them in other files.
- Do not invent endpoints. If the API is unknown, make the repository method, mock it, and add a short note.

## Bloc rules (simple version)
- Every screen that loads data has 4 states: initial, loading, success, failure. Also handle the empty case in the UI.
- Show a loading spinner while loading and an error message with a retry button on failure.
- Use BlocBuilder to build the UI. Use BlocListener for navigation, snackbars and dialogs.
- Provide a cubit with BlocProvider in the page that uses it. Only app-wide things (like login status) go at the top of the app.
- Use setState only for tiny local things (a toggle, a text controller). Everything else uses Bloc.

## UI and Figma rules
- Build one Figma screen at a time. Before coding, tell me which screen you are building and which widgets you will create.
- Match the Figma design closely: spacing, sizes, colors, fonts, corner radius, and button states.
- Never hardcode colors, font styles or spacing inside widgets. Put them in core/theme and use them from there. If a Figma value is missing from the theme, add it to the theme first.
- Reuse widgets from core/widgets. If the same UI piece appears twice, make it a shared widget.
- Keep widgets small. If a build method gets longer than about 80 lines, split it into smaller widget classes in separate files.
- Use const constructors where possible.
- The layout must not break on small or large phones. Use Expanded, Flexible and SafeArea. Avoid fixed sizes that overflow.
- Save Figma images and icons in assets/ and declare them in pubspec.yaml.

## Code quality
- Follow normal Dart style. Run `dart format .` after every task.
- File names in snake_case. Class names in PascalCase. Use clear names, no abbreviations.
- No print statements, no commented out code, no unused imports.
- Put all text shown to users in one constants file, not scattered inside widgets.
- No TODO without a short note on what is needed.

## Testing (keep it realistic for a capstone)
- Write a bloc_test for each cubit or bloc (success, failure, empty).
- Write a simple widget test for important shared widgets.
- Run `flutter analyze` and `flutter test` before saying a task is done.

## Using the Dart and Flutter plugin
- Use the Dart and Flutter MCP tools to check errors and run tests instead of guessing.
- Trigger hot reload after editing widgets.
- Use plugin skills for Flutter help, but keep our folder structure and Bloc approach.

## Workflow
1. Plan first. Before any big task, show me the plan and wait for my approval.
2. Setup first: theme, router, shared widgets, and fake data layer. Then screens.
3. Build the first feature (for example Login) completely and let me review it. Use the same pattern for every other feature.
4. After each screen: run `flutter analyze`, `dart format .`, `flutter test`, and fix everything.
5. Do not touch unrelated files while working on a task.
6. Keep changes small so each screen can be one clean git commit.
