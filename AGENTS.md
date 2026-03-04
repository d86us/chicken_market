# AGENTS.md - Development Guide for chicken_market

## App Purpose

You're here to help develop Chicken Market app for Android phones in Kenya. Make it useful, easy to use and accessible.

**Target device**: Samsung Galaxy A03 Core

**Accessibility requirements**:
- High contrast, big fonts – users with bad eyesight use the app in bright light
- Big tap areas – users have swollen fingers from manual work

---

## Project Overview

This is a **Flutter/Dart** mobile application. The project uses Flutter SDK ^3.11.1 and follows standard Flutter/Dart conventions.

---

## Build, Lint, and Test Commands

### Running the Application

> **⚠️ IMPORTANT: ALWAYS use the run_app.sh script!**
> 
> Never run `flutter run` directly. Always use:
> ```bash
> # For Android device (default)
> ./scripts/run_app.sh
> 
> # For Chrome browser
> ./scripts/run_web.sh
> ```
> 
> - `run_app.sh` - launches scrcpy and runs the app on your Android device
> - `run_web.sh` - runs the app in Chrome browser

```bash
# Run on all platforms
flutter run

# Run on specific platform
flutter run -d ios
flutter run -d android
flutter run -d macos
flutter run -d linux
flutter run -d windows

# Run in debug mode (default)
flutter run --debug

# Run in release mode
flutter run --release

# Run in profile mode
flutter run --profile
```

### Building for Release

```bash
# Build iOS (requires macOS)
flutter build ios --release

# Build Android APK
flutter build apk --release

# Build Android App Bundle
flutter build appbundle --release

# Build macOS
flutter build macos --release

# Build Linux
flutter build linux --release

# Build Windows
flutter build windows --release

# Build web
flutter build web --release
```

### Deploying to GitHub Pages

Run the deploy script:
```bash
./scripts/deploy_web.sh
```

Check deployment progress:
```bash
tail -f deploy.log
```

Live site: **https://d86us.github.io/chicken_market/**

Note: GitHub Pages may take 1-2 minutes to update after deployment.

### Code Analysis and Linting

```bash
# Run static analysis (linting)
flutter analyze

# Run analysis with fix suggestions
flutter analyze --fix

# Run specific linter rules
dart analyze lib/ test/
```

### Testing

```bash
# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Run a single test by name (pattern matching)
flutter test --name "Counter increments"

# Run tests with coverage
flutter test --coverage

# Run tests in watch mode (re-runs on file changes)
flutter test --watch

# Run specific test matching a regex
flutter test -N "test_name_pattern"

# Run tests with verbose output
flutter test -reporter expanded
```

---

## Code Style Guidelines

### General Principles

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart)
- Use the [Effective Dart](https://dart.dev/guides/language/effective-dart) conventions
- Enable `flutter_lints` rules from `analysis_options.yaml`

### Formatting

- Use **2 spaces** for indentation (no tabs)
- Maximum line length: 80 characters (soft limit)
- Use `dart format` or Flutter's auto-formatting
- trailing commas for better diffs in collections

### Imports

- Use **package imports** for external packages:
  ```dart
  import 'package:flutter/material.dart';
  import 'package:flutter_test/flutter_test.dart';
  ```
- Use **relative imports** for internal project files:
  ```dart
  import '../models/user.dart';
  import 'utils/helpers.dart';
  ```
- Group imports in this order:
  1. Flutter SDK imports
  2. External package imports
  3. Internal package imports
  4. Relative imports
- Use `show` or `hide` to avoid namespace pollution

### Naming Conventions

- **Classes, Enums, Typedefs**: `PascalCase`
  ```dart
  class UserModel { }
  enum OrderStatus { }
  typedef ApiCallback = void Function(Response);
  ```
- **Functions, Variables, Constants**: `camelCase`
  ```dart
  void fetchUserData() { }
  final userName = 'John';
  const maxRetries = 3;
  ```
- **Private members**: prefix with underscore `_`
  ```dart
  class MyClass {
    int _privateField;
    void _privateMethod() { }
  }
  ```
- **File names**: `snake_case`
  ```
  user_model.dart
  home_screen.dart
  api_helper.dart
  ```

### Types and Type Safety

- Always specify return types and parameter types
- Use `void` explicitly for functions that don't return
- Prefer `const` constructors when possible
- Use `late` sparingly - only when initialization is guaranteed before use
- Enable strict type checking in `analysis_options.yaml`

### Widgets

- Use `const` constructors for widgets with no mutable state
- Extract widgets into separate files for reuse (common pattern: `widget_name.dart`)
- Follow widget composition over inheritance
- Use meaningful names for custom widgets (e.g., `UserAvatar`, not `AvatarWidget`)

### Error Handling

- Use `try-catch` for synchronous operations
- Use `try-catch` with `async-await` for async operations
- Provide meaningful error messages
- Consider using `Result` type pattern for operations that can fail:
  ```dart
  Either<String, User> fetchUser();
  ```
- Avoid empty catch blocks - at minimum log the error

### State Management

- Follow Flutter's state management patterns (setState, Provider, Riverpod, BLoC, etc.)
- Keep stateful logic separated from UI when possible
- Use immutable state objects where practical

### Testing

- Place tests in `test/` directory mirroring `lib/` structure
- Test file naming: `widget_name_test.dart`
- Use `flutter_test` package
- Follow AAA pattern: **Arrange, Act, Assert**
- Use `testWidgets` for widget tests
- Use `test` for unit tests

---

## Known Issues

- **Bug in lib/main.dart**: Line 31 has `ColorScheme.fromSeed` missing class prefix (`ColorScheme.`), and line 105 has `MainAxisAlignment.center` missing class prefix (`MainAxisAlignment.`). This appears to be a template issue.

---

## Project Structure

```
lib/
  main.dart           # App entry point
  # Add your structure here, e.g.:
  # models/           # Data models
  # screens/          # Screen widgets
  # widgets/          # Reusable widgets
  # services/         # Business logic, API calls
  # utils/            # Helper functions

test/
  widget_test.dart    # Default test file
  # Add more test files here
```

---

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Lints](https://pub.dev/packages/flutter_lints)
