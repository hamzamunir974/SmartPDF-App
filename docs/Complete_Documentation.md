# SmartPDF — Project Documentation

Author: [Your Name]
Date: 2025-11-11
Course / Supervisor: [Add name]

## Abstract

SmartPDF is a Flutter-based cross-platform application to work with PDF documents. It integrates file selection, PDF processing, cloud storage (Firebase), authentication, and sharing capabilities. This document describes the project objectives, architecture, setup, features, and how to build, run, and deliver a soft copy for submission.

## Table of Contents

1. Project Overview
2. Features
3. Tech Stack & Dependencies
4. Architecture & Module Breakdown
5. Setup & Installation
6. Build & Run
7. Testing
8. Screenshots and Assets
9. Future Work
10. References
11. Appendix: Key Files

---

## 1. Project Overview

- Project name: SmartPDF
- Version: 1.0.0+1 (as in `pubspec.yaml`)
- Description: A Flutter application to manage and process PDF files, with Firebase backend support.
- Entry point: `lib/main.dart`
- Project structure (high level):
  - `lib/app/controllers/` — GetX controllers for screens and business logic
  - `lib/app/modules/` — Feature modules organized by route
  - `lib/app/services/` — Services for Firebase, storage, PDF operations, etc.
  - `lib/app/routes/` — Route definitions (`AppPages`)
  - `lib/app/themes/` — Theme definitions (`AppTheme`)

Notes: The codebase uses GetX for routing and state management, and Syncfusion PDF package for PDF manipulation.

## 2. Features

Based on the codebase and dependencies, SmartPDF implements the following features (confirm/adjust as you finalize):

- Select and import files from device storage (file_picker / file_selector).
- View and process PDFs (syncfusion_flutter_pdf).
- Upload and download PDFs to/from Firebase Storage.
- Authentication via Firebase and Google Sign-In.
- Share PDFs using system share dialog (share_plus).
- Persistent settings using `shared_preferences`.

## 3. Tech Stack & Dependencies

- Flutter SDK: >=3.1.0 <4.0.0
- State management / routing: get (GetX)
- Backend / BaaS: Firebase (firebase_core, firebase_auth, cloud_firestore, firebase_storage)
- PDF processing: syncfusion_flutter_pdf
- File handling: file_picker, file_selector, path_provider, permission_handler
- Sharing: share_plus
- UI: google_fonts, flutter_svg
- Utilities: intl, url_launcher, shared_preferences

Full dependency list (from `pubspec.yaml`):

- cupertino_icons: ^1.0.8
- firebase_core: ^4.2.0
- firebase_auth: ^6.1.1
- firebase_storage: ^13.0.3
- cloud_firestore: ^6.0.3
- get: ^4.6.6
- google_fonts: ^6.1.0
- flutter_svg: ^2.0.9
- loading_animation_widget: ^1.2.0+4
- file_picker: ^10.3.3
- file_selector: ^1.0.3
- syncfusion_flutter_pdf: ^31.2.4
- path_provider: ^2.1.1
- permission_handler: ^12.0.1
- share_plus: ^7.2.1
- google_sign_in: ^6.1.5
- intl: ^0.20.2
- url_launcher: ^6.2.1
- shared_preferences: ^2.2.2

Dev dependencies:
- flutter_test
- flutter_lints: ^5.0.0

## 4. Architecture & Module Breakdown

- App entry: `lib/main.dart` — Initializes Firebase (web-specific options included), sets up `GetMaterialApp` with `AppPages` and themes from `AppTheme`.
- Routing & Navigation: `lib/app/routes/app_pages.dart` defines named routes and bindings for each module.
- State Management: GetX (controllers and reactive state in `lib/app/controllers/`).
- Services: `lib/app/services/` contains wrappers for Firebase, file IO, PDF generation/manipulation, and sharing logic.
- UI: Organized into modules that correspond to screens, each with its own views and controllers.

Security note: `lib/main.dart` contains web Firebase configuration with an `apiKey` inlined (this is common for web apps). Do not commit private server-side secrets. For production, follow Firebase security rules and consider using environment variables or remote config for sensitive runtime config.

## 5. Setup & Installation

Prerequisites
- Install Flutter SDK (version compatible with SDK constraint in `pubspec.yaml`).
- Install Android Studio / Xcode for mobile builds as needed.
- Install `flutterfire_cli` if you need to reconfigure Firebase for a new environment (optional).

Basic steps
1. Clone the repository.
2. From project root, run:

```bash
flutter pub get
```

3. Configure Firebase (mobile):
   - Android: Ensure `android/app/google-services.json` is present (there is a copy in `app/` directory of the repo). If not present, download from Firebase Console and place it at `android/app/google-services.json`.
   - iOS: Ensure `ios/Runner/GoogleService-Info.plist` is present in the Xcode project.

4. For web, `lib/main.dart` includes an inline FirebaseOptions object for web initialization. If you re-generate or change Firebase projects, update `lib/firebase_options.dart` (if using `flutterfire`), or adjust the web options in `main.dart`.

Environment variables: none required for local dev beyond the Firebase config files above.

## 6. Build & Run

Develop and run locally:

```bash
# Get dependencies
flutter pub get

# Run on connected device (Android/iOS) or simulator
flutter run

# Run for web
flutter run -d chrome
```

Build release artifacts:

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web
```

## 7. Testing

Run unit/widget tests (one included test file `test/widget_test.dart`):

```bash
flutter test
```

Add tests under `test/` for modules and services as you expand coverage.

## 8. Screenshots and Assets

- Assets are located under `assets/images/` and `assets/icons/`.
- Add screenshots to the `docs/screenshots/` folder and reference them here for the final PDF submission.

## 9. Future Work

Suggestions for improvements:
- Add more granular error handling and user-friendly error screens.
- Add offline support and sync strategies for Firebase data.
- Improve PDF editing features: annotate, sign, reorder pages, merge/split.
- Add CI to run tests and generate a PDF build artifact automatically.

## 10. References

- Flutter docs: https://docs.flutter.dev/
- GetX: https://pub.dev/packages/get
- Syncfusion Flutter PDF documentation: https://help.syncfusion.com/flutter/pdf/overview
- Firebase for Flutter: https://firebase.google.com/docs/flutter/setup

## 11. Appendix: Key Files

- `pubspec.yaml` — Project metadata and dependencies.
- `lib/main.dart` — App entry (initialization + routes + theme).
- `lib/firebase_options.dart` — (if present) auto-generated Firebase config (check this file for platform-specific options).
- `android/app/google-services.json` — Android Firebase config (present in repo under `app/`).
- `ios/Runner/GoogleService-Info.plist` — iOS Firebase config (verify existence for iOS builds).
- `lib/app/routes/app_pages.dart` — Route definitions and initial route.
- `lib/app/themes/app_theme.dart` — App theme definitions.

---

Converting this Markdown to PDF (soft copy)

Option A — Use pandoc (macOS)

```bash
# Install pandoc (if not installed)
brew install pandoc

# Convert Markdown to PDF using a TeX engine
pandoc docs/Complete_Documentation.md -o docs/Complete_Documentation.pdf --pdf-engine=pdflatex
```

Option B — Use VS Code extension "Markdown PDF" or "Markdown PDF Export" to export as PDF.

Option C — Print to PDF from any Markdown preview (e.g., GitHub or VS Code) using Print -> Save as PDF.

---

Assumptions & Notes
- I inferred feature set from dependencies and typical usage; verify and refine feature descriptions to match actual UI flows.
- The repo contains Firebase web credentials in `lib/main.dart`. Confirm with your supervisor if it's okay to include these in the submitted soft copy. Remove or rotate keys as needed.

---

End of document.
