# 📱 SmartPDF - Flutter Document Management App# 📄 SmartPDF



<div align="center">[![Flutter](https://img.shields.io/badge/Flutter-3.1.0-blue?logo=flutter)](https://flutter.dev/)

[![Dart](https://img.shields.io/badge/Dart-3.1.0-blue?logo=dart)](https://dart.dev/)

![SmartPDF Logo](https://img.shields.io/badge/SmartPDF-v1.0.0-red?style=for-the-badge&logo=pdf)[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

[![Flutter Version](https://img.shields.io/badge/Flutter-3.1.0+-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev/)[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-blue)](https://flutter.dev/)

[![Dart Version](https://img.shields.io/badge/Dart-3.1.0+-0175C2?style=for-the-badge&logo=dart)](https://dart.dev/)

[![Firebase](https://img.shields.io/badge/Firebase-v9-FFA500?style=for-the-badge&logo=firebase)](https://firebase.google.com/)A **production-ready Flutter application** for seamless PDF and Word document conversion with cloud-based storage, Firebase authentication, and multi-platform support.

[![Platform](https://img.shields.io/badge/Platform-iOS%20|%20Android%20|%20Web-blue?style=for-the-badge&logo=apple)](https://flutter.dev/)

[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)**Status:** ✅ **Fully Functional & Ready for Deployment**

[![Status](https://img.shields.io/badge/Status-Production%20Ready-success?style=for-the-badge)](https://github.com)

---

**A Production-Ready Flutter Application for PDF Management, Document Conversion, and Cloud Storage**

## 🎯 Features

[Features](#-features) • [Tech Stack](#-tech-stack) • [Installation](#-installation) • [Architecture](#-architecture) • [Contributing](#-contributing)

### Authentication

</div>- ✅ **Email/Password** - Create account, login, password reset with email verification

- ✅ **Google Sign-In** - One-tap authentication (iOS, Android)

---- ✅ **Guest Mode** - Access without creating an account

- ✅ **Secure Password** - Validation (8+ chars, uppercase, lowercase, number, special char)

## 📋 Table of Contents- ✅ **Remember Me** - Optional credential persistence



1. [Overview](#overview)### File Management

2. [Features](#-features)- ✅ **Upload PDFs** - Select and upload with progress tracking

3. [Tech Stack](#-tech-stack)- ✅ **Download PDFs** - Download to device storage

4. [Project Structure](#-project-structure)- ✅ **Share PDFs** - Generate shareable download links

5. [Installation & Setup](#-installation--setup)- ✅ **Delete PDFs** - Manage cloud storage files

6. [Running the App](#-running-the-app)- ✅ **View Metadata** - File size, creation date, page count

7. [Firebase Configuration](#-firebase-configuration)

8. [Architecture & Design](#-architecture--design)### PDF Conversion (Mobile Only)

9. [API Documentation](#-api-documentation)- ✅ **PDF to Word** - Extract text and save as RTF/DOCX

10. [Testing](#-testing)- ✅ **Word to PDF** - Convert documents with formatting

11. [Building for Production](#-building-for-production)- ✅ **Progress Tracking** - Real-time upload/download UI

12. [Troubleshooting](#-troubleshooting)- ✅ **Conversion History** - Track all conversions in Firestore

13. [Future Enhancements](#-future-enhancements)

14. [References](#-references)### User Profile

15. [License](#-license)- ✅ **Update Profile** - Edit name and photo

- ✅ **Change Password** - Secure password change

---- ✅ **Delete Account** - Remove account and all data

- ✅ **Theme Toggle** - Dark/Light mode support

## Overview

### Cross-Platform

**SmartPDF** is a full-featured Flutter application that enables users to:- ✅ **iOS** - Full feature support

- ✅ **Android** - Full feature support

- 🔐 **Authenticate** via email/password, Google Sign-In, or as a guest (no account required)- ✅ **Web** - Guest mode, auth, UI (PDF conversion not supported on web)

- 📤 **Upload & Store** PDF files securely in Firebase Cloud Storage with progress tracking

- 🔄 **Convert** between PDF and Word document formats seamlessly---

- 📁 **Manage** PDFs with search, share, and download capabilities

- 🌐 **Access** across **iOS, Android, and Web** platforms## 🛠️ Tech Stack

- 🎨 **Enjoy** dark/light theme support with Material Design 3

| Layer | Technology | Version |

**Status:** ✅ **Fully Functional, Tested, and Ready for Deployment**|-------|-----------|---------|

| **UI Framework** | Flutter | 3.1.0+ |

---| **State Management** | GetX | 4.6.6 |

| **Authentication** | Firebase Auth + Google Sign-In | 6.1.1 / 6.1.5 |

## 🎯 Features| **Cloud Storage** | Firebase Storage + Firestore | 13.0.3 / 6.0.3 |

| **PDF Processing** | Syncfusion Flutter PDF | 31.2.4 |

### Authentication & User Management| **File Operations** | file_picker, path_provider | 10.3.3 / 2.1.1 |

- ✅ **Email/Password Registration** with strong password validation (8+ chars, uppercase, lowercase, number, special char)| **Sharing** | share_plus | 7.2.1 |

- ✅ **Email/Password Login** with email verification required| **UI Design** | Material Design 3 | - |

- ✅ **Google Sign-In (OAuth 2.0)** for one-tap authentication

- ✅ **Guest Mode** - Access without creating an account (local session)---

- ✅ **Password Reset** - Secure email-based password recovery

- ✅ **Profile Management** - Edit name, photo, change password, delete account## 📦 Project Structure

- ✅ **Remember Me** - Optional credential persistence via SharedPreferences

- ✅ **Session Management** - Persistent login with last login tracking```

lib/

### File Management & Cloud Storage├── main.dart                    # App entry point

- ✅ **Upload PDFs** - Select files with file picker, show progress (0-100%)├── app/

- ✅ **Download PDFs** - Download from Firebase Storage to device│   ├── routes/app_pages.dart   # Navigation routes

- ✅ **Share PDFs** - Generate shareable download links via share_plus│   ├── themes/app_theme.dart   # Material Design 3

- ✅ **Delete PDFs** - Permanently remove files from cloud storage│   ├── services/               # Business logic

- ✅ **View Metadata** - Display file size (KB), creation date, page count│   │   ├── auth_service.dart

- ✅ **List Files** - Show all user's uploaded PDFs│   │   ├── pdf_service.dart

- ✅ **File Search** - Find conversions by name or date│   │   ├── storage_service.dart

│   │   └── document_conversion_service.dart

### PDF Conversion (Mobile Only)│   ├── modules/                # Feature modules

- ✅ **PDF to Word** - Extract text from PDF, save as RTF document with formatting│   │   ├── auth/               # Login, Register, Password Reset

- ✅ **Word to PDF** - Convert text documents to PDF with proper formatting│   │   ├── home/               # Dashboard, History, Profile

- ✅ **Progress Tracking** - Real-time upload/download progress UI with percentage│   │   ├── conversion/         # PDF Conversion

- ✅ **Conversion History** - Track all conversions in Firestore with timestamps│   │   └── splash/             # Splash Screen

- ✅ **Batch Operations** - Convert and upload multiple files│   └── data/                   # Models & Repositories

- ✅ **Error Handling** - User-friendly error messages and validation└── assets/                     # Images & Icons



### User Interface & Experienceandroid/

- ✅ **Material Design 3** - Modern, responsive UI following latest design guidelines├── app/google-services.json    # Firebase config

- ✅ **Dark/Light Themes** - System theme detection (iOS/Android) + manual toggle└── build.gradle.kts

- ✅ **Bottom Navigation** - Easy access to Home, History, and Profile tabs

- ✅ **Loading Animations** - Smooth animations during file operationsios/

- ✅ **Error Messages** - Clear, actionable error messages from Firebase└── Runner/GoogleService-Info.plist  # Firebase config

- ✅ **Responsive Layout** - Works on phones, tablets, and web browsers```



### Cross-Platform Support---

- ✅ **iOS** - Full feature support with native integration

- ✅ **Android** - Full feature support with native permissions## 🚀 Quick Start

- ✅ **Web** - Guest mode, authentication, UI (PDF conversion via mobile only)

- ✅ **macOS, Windows, Linux** - Base support (UI may require adjustments)### Prerequisites



---```bash

# Check Flutter installation

## 🛠️ Tech Stackflutter --version



### Core Framework# Verify environment

| Component | Technology | Version | Purpose |flutter doctor

|-----------|-----------|---------|---------|```

| **UI Framework** | Flutter | 3.1.0+ | Cross-platform UI development |

| **Programming Language** | Dart | >=3.1.0 <4.0.0 | Application logic |**Required:**

| **State Management** | GetX | 4.6.6 | Reactive state & routing |- Flutter SDK 3.1.0 or higher

- Xcode 14+ (for iOS)

### Backend & Cloud Services- Android SDK 21+ (for Android)

| Component | Technology | Version | Purpose |- Firebase Project (https://console.firebase.google.com)

|-----------|-----------|---------|---------|

| **Authentication** | Firebase Auth | 6.1.1 | Email/password, user management |### Installation

| **Cloud Storage** | Firebase Storage | 13.0.3 | File upload/download |

| **Database** | Cloud Firestore | 6.0.3 | User profiles, conversion history |#### 1. Clone Repository

| **OAuth** | Google Sign-In | 6.1.5 | Google authentication |```bash

git clone https://github.com/yourusername/smartpdf.git

### Libraries & Packagescd smartpdf

| Category | Package | Version | Purpose |```

|----------|---------|---------|---------|

| **PDF Processing** | syncfusion_flutter_pdf | 31.2.4 | PDF text extraction, manipulation |#### 2. Install Dependencies

| **File Handling** | file_picker | 10.3.3 | File selection (Android/iOS) |```bash

| **File Selection** | file_selector | 1.0.3 | File selection (Web/Desktop) |flutter pub get

| **System Paths** | path_provider | 2.1.1 | Temporary/document directories |```

| **Permissions** | permission_handler | 12.0.1 | Runtime permissions (Android/iOS) |

| **File Sharing** | share_plus | 7.2.1 | System share dialog |#### 3. Configure Firebase

| **Typography** | google_fonts | 6.1.0 | Custom fonts |

| **Icons** | flutter_svg | 2.0.9 | SVG vector graphics |**For Android:**

| **Loading** | loading_animation_widget | 1.2.0+4 | Loading animations |- Ensure `android/app/google-services.json` exists ✅ (already included)

| **Localization** | intl | 0.20.2 | Internationalization |

| **URL Launcher** | url_launcher | 6.2.1 | Open URLs |**For iOS:**

| **Local Storage** | shared_preferences | 2.2.2 | Persistent key-value storage |- Ensure `ios/Runner/GoogleService-Info.plist` exists ✅ (already included)

- Add to Xcode if needed:

---  ```bash

  open ios/Runner.xcworkspace

## 📁 Project Structure  # Right-click Runner → Add Files → GoogleService-Info.plist

  ```

```

smartpdf/**For Web:**

│- Firebase config is in `lib/main.dart` (hardcoded for development)

├── lib/- For production: `flutterfire configure`

│   ├── main.dart                           # 🎯 App entry point (Firebase init, GetMaterialApp)

│   │#### 4. Install iOS Dependencies (if building for iOS)

│   └── app/```bash

│       ├── routes/cd ios

│       │   └── app_pages.dart              # 🗺️ Route definitions & bindingspod install --repo-update

│       │cd ..

│       ├── themes/```

│       │   └── app_theme.dart              # 🎨 Light/Dark theme definitions

│       │#### 5. Verify Setup

│       ├── services/                       # 💼 Business logic services```bash

│       │   ├── auth_service.dart           # 🔐 Firebase authenticationflutter doctor

│       │   ├── pdf_service.dart            # 📄 PDF operations```

│       │   ├── storage_service.dart        # ☁️ Cloud storage operations

│       │   └── document_conversion_service.dart # 🔄 PDF ↔ Word conversion### Run the App

│       │

│       ├── modules/                        # 📦 Feature modules (MVC)**Web (Chrome):**

│       │   ├── auth/```bash

│       │   │   ├── bindings/flutter run -d chrome

│       │   │   │   └── auth_binding.dart   # Dependency injection```

│       │   │   ├── controllers/

│       │   │   │   └── auth_controller.dart # Authentication logic**Android:**

│       │   │   └── views/```bash

│       │   │       ├── login_view.dartflutter run -d android

│       │   │       ├── register_view.dart```

│       │   │       └── forgot_password_view.dart

│       │   │**iOS:**

│       │   ├── home/```bash

│       │   │   ├── bindings/flutter run -d ios

│       │   │   │   └── home_binding.dart```

│       │   │   ├── controllers/

│       │   │   │   └── home_controller.dart # Dashboard logic**Test Guest Mode:**

│       │   │   └── views/1. Open app

│       │   │       ├── home_view.dart       # Main dashboard2. Click "Continue as Guest" button

│       │   │       └── tabs/3. Instant access without login ✅

│       │   │           ├── dashboard_tab.dart

│       │   │           ├── history_tab.dart---

│       │   │           └── profile_tab.dart

│       │   │## 🔐 Firebase Setup

│       │   ├── conversion/                 # PDF conversion module

│       │   │   ├── bindings/### Enable Authentication

│       │   │   ├── controllers/1. Go to **Firebase Console** > **Authentication** > **Sign-in method**

│       │   │   └── views/2. Enable:

│       │   │   - ✅ **Email/Password**

│       │   └── splash/                     # Splash/onboarding screen   - ✅ **Google** (add OAuth client ID)

│       │       ├── bindings/   - ✅ **Anonymous** (optional)

│       │       ├── controllers/

│       │       └── views/### Enable Firestore

│       │1. **Firebase Console** > **Firestore Database**

│       ├── data/                           # 📊 Data layer (models, repositories)2. Set rules:

│       │   ├── models/```javascript

│       │   │   ├── user_profile.dartrules_version = '2';

│       │   │   └── conversion_model.dartservice cloud.firestore {

│       │   └── repositories/  match /databases/{database}/documents {

│       │       └── user_repository.dart    # Firestore access    match /users/{uid} {

│       │      allow read, write: if request.auth.uid == uid;

│       └── controllers/                    # Global controllers (if needed)    }

│    match /conversions/{document=**} {

├── assets/      allow read, write: if request.auth != null;

│   ├── images/                             # 🖼️ App images    }

│   └── icons/                              # 🎯 App icons  }

│}

├── android/```

│   ├── app/

│   │   └── google-services.json            # 🔑 Firebase config (Android)### Enable Cloud Storage

│   └── build.gradle.kts1. **Firebase Console** > **Cloud Storage**

│2. Set rules:

├── ios/```

│   ├── Runner/rules_version = '2';

│   │   └── GoogleService-Info.plist        # 🔑 Firebase config (iOS)service firebase.storage {

│   └── Podfile  match /b/{bucket}/o {

│    match /users/{uid}/{allPaths=**} {

├── web/      allow read, write: if request.auth.uid == uid;

│   ├── index.html                          # 🌐 Web entry (Firebase init)    }

│   └── manifest.json  }

│}

├── docs/```

│   ├── Complete_Documentation.md           # 📚 Full documentation

│   └── screenshots/                        # 📸 App screenshots### Google OAuth Setup (Mobile)

│1. **Google Cloud Console** > **Credentials**

├── test/2. Create OAuth 2.0 Client IDs:

│   └── widget_test.dart                    # ✅ Tests   - **iOS:** Bundle ID = `com.smartpdf.app`

│   - **Android:** Package name = `com.smartpdf.app`

├── pubspec.yaml                            # 📦 Dependencies & metadata3. Get Android SHA-1:

├── analysis_options.yaml                   # 🔍 Linting rules   ```bash

├── README.md                               # 📖 This file   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey

└── LICENSE                                 # ⚖️ MIT License   # Password: android

   ```

```4. Add to **Firebase Console** > **Project Settings**



------



## 🚀 Installation & Setup## 📱 Build & Deploy



### Prerequisites### Debug Build



Before you begin, ensure you have:```bash

# Android APK (debug)

1. **Flutter SDK** (3.1.0 or later)flutter build apk --debug

   ```bash

   flutter --version# iOS (debug)

   ```flutter build ios --debug

```

2. **Dart SDK** (included with Flutter)

   ```bash### Release Build

   dart --version

   ``````bash

# Android APK (release)

3. **Git** for version controlflutter build apk --release

   ```bash

   git --version# Android App Bundle (for Google Play)

   ```flutter build appbundle --release



4. **Firebase Project**# iOS (release)

   - Create at https://console.firebase.google.comflutter build ios --release

   - Enable: Authentication (Email/Password, Google), Firestore, Cloud Storage```



5. **IDE/Editor**### Web Deployment

   - VS Code with Flutter extension, or

   - Android Studio, or```bash

   - IntelliJ IDEA# Build for web

flutter build web --release

### Step 1: Clone Repository

# Deploy to Firebase Hosting

```bashfirebase deploy --only hosting

git clone https://github.com/yourusername/smartpdf.git```

cd smartpdf

```---



### Step 2: Install Dependencies## 🧪 Testing



```bash### Run Tests

flutter pub get```bash

```flutter test

```

### Step 3: Configure Firebase (Android)

### Manual Testing Checklist

1. Download `google-services.json` from Firebase Console- [ ] Guest mode works

2. Place at: `android/app/google-services.json`- [ ] Email/Password login/register

3. *(Already present in this repository)*- [ ] Password reset email sent

- [ ] Google Sign-In (mobile only)

```bash- [ ] PDF upload with progress

ls -la android/app/google-services.json  # Verify it exists- [ ] PDF download succeeds

```- [ ] PDF conversion (PDF↔Word)

- [ ] Conversion history displays

### Step 4: Configure Firebase (iOS)- [ ] Delete files and conversions

- [ ] Share with download link

1. Download `GoogleService-Info.plist` from Firebase Console- [ ] Edit user profile

2. Open Xcode:- [ ] Change password

   ```bash- [ ] Delete account

   open ios/Runner.xcworkspace- [ ] Theme toggle (dark/light)

   ```

3. Drag & drop `GoogleService-Info.plist` to Runner folder---

4. Ensure it's added to all targets

5. *(Already present in this repository)*## 🐛 Troubleshooting



### Step 5: Configure Google Sign-In (Web)### App won't start

```bash

Update `web/index.html` with your Google client ID:flutter clean

flutter pub get

```htmlflutter run

<meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">```

```

### Firebase connection errors

### Step 6: Verify Setup- Verify `google-services.json` and `GoogleService-Info.plist` exist

- Check Firebase Console project is active

```bash- Ensure API keys are not restricted

flutter doctor

# Should show: Flutter ✓, Dart ✓, Chrome ✓, Android SDK ✓, Xcode ✓### PDF conversion not working

```- PDF conversion only works on **iOS/Android** (not Web)

- Ensure storage permissions granted

---- Check device has sufficient disk space



## 🎮 Running the App### iOS build fails

```bash

### Development Modecd ios

rm -rf Pods Podfile.lock

**Run on Web (Chrome):**pod install --repo-update

```bashcd ..

flutter run -d chromeflutter clean

```flutter pub get

```

**Run on Android Emulator:**

```bash### Android build fails

flutter emulators --launch Pixel_5- Verify Android SDK installed: `flutter doctor`

flutter run- Set ANDROID_HOME: `export ANDROID_HOME=~/Android/Sdk`

```- Run: `flutter clean && flutter pub get`



**Run on iOS Simulator:**---

```bash

open -a Simulator## 📚 Documentation

flutter run

```For detailed documentation, see:

- **[Complete Project Documentation](docs/Complete_Documentation.md)** - Full guide with architecture, setup, features

**Run on Physical Device:**- **[Project Summary](PROJECT_SUMMARY.md)** - Quick overview and completion status

```bash- **[HTML Version](docs/Complete_Documentation.html)** - Print-friendly documentation

flutter devices

flutter run -d <device-id>---

```

## 🤝 Contributing

### Hot Reload During Development

Contributions are welcome! Please:

While the app is running:1. Fork the repository

- Press `r` to **hot reload** (quick code changes)2. Create a feature branch (`git checkout -b feature/amazing-feature`)

- Press `R` to **hot restart** (full app restart)3. Commit changes (`git commit -m 'Add amazing feature'`)

- Press `d` to **detach** (keep app running, close terminal)4. Push to branch (`git push origin feature/amazing-feature`)

- Press `q` to **quit**5. Open Pull Request



### View Logs---



```bash## 📄 License

flutter logs

```This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.



### Open DevTools---



```bash## 👨‍💻 Author

flutter pub global activate devtools

devtools**Hamza Munir**

# Opens http://localhost:9100

```---



---## 🙏 Acknowledgments



## 🔥 Firebase Configuration- [Flutter](https://flutter.dev/) - UI framework

- [Firebase](https://firebase.google.com/) - Backend services

### Step 1: Create Firebase Project- [GetX](https://pub.dev/packages/get) - State management

- [Syncfusion](https://www.syncfusion.com/) - PDF processing

1. Go to https://console.firebase.google.com- [Material Design 3](https://m3.material.io/) - Design system

2. Click **Create Project**

3. Name: `smartpdf`---

4. Enable Google Analytics (optional)

## 📞 Support

### Step 2: Enable Services

For help and questions:

**Authentication:**1. Check [Complete Documentation](docs/Complete_Documentation.md)

1. Go to **Authentication** > **Sign-in method**2. Review [Troubleshooting Section](#troubleshooting)

2. Enable:3. Check Flutter logs: `flutter logs`

   - ✅ **Email/Password**4. Open GitHub Issue

   - ✅ **Google** (requires OAuth client ID)

   - ✅ **Anonymous** (optional)---



**Firestore Database:**## 🎉 Get Started Now!

1. Go to **Firestore Database**

2. **Create database** in Production mode```bash

3. Create collections:git clone https://github.com/yourusername/smartpdf.git

   - `users` - User profilescd smartpdf

   - `conversions` - Conversion historyflutter pub get

flutter run -d chrome

**Cloud Storage:**```

1. Go to **Cloud Storage**

2. **Create bucket** (default settings)Click **"Continue as Guest"** to test the app immediately! 🚀



### Step 3: Set Security Rules---



**Firestore Rules:****Last Updated:** November 12, 2025  

```javascript**Version:** 1.0.0+1  

rules_version = '2';**Status:** ✅ Production Ready

service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
    }
    match /conversions/{uid}/{document=**} {
      allow read, write: if request.auth.uid == uid;
    }
  }
}
```

**Storage Rules:**
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{uid}/{allPaths=**} {
      allow read, write: if request.auth.uid == uid;
    }
  }
}
```

### Step 4: Get Configuration Files

**For Android:**
1. Go to **Project Settings** > **Your apps** > **Android**
2. Download `google-services.json`
3. Place at `android/app/google-services.json`

**For iOS:**
1. Go to **Project Settings** > **Your apps** > **iOS**
2. Download `GoogleService-Info.plist`
3. Add to Xcode Runner project

**For Web:**
Web config is in `lib/main.dart`:
```dart
FirebaseOptions(
  apiKey: 'YOUR_API_KEY',
  appId: 'YOUR_APP_ID',
  messagingSenderId: 'YOUR_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  authDomain: 'YOUR_AUTH_DOMAIN',
  storageBucket: 'YOUR_STORAGE_BUCKET',
)
```

---

## 🏗️ Architecture & Design

### Clean Architecture Layers

```
┌─────────────────────────────────────┐
│         View Layer (UI)             │
│  (Screens, Widgets, Material Design)│
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│    Controller Layer (Business Logic) │
│  (GetX Controllers, State Management)│
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      Service Layer (Features)        │
│ (Auth, PDF, Storage, Conversion)     │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│       Data Layer (Persistence)       │
│ (Firebase, SharedPreferences, Models)│
└─────────────────────────────────────┘
```

### GetX Pattern

**MVC with Reactive State:**

1. **View** - UI screens (e.g., `LoginView`)
2. **Controller** - Business logic (e.g., `AuthController`)
3. **Service** - Backend operations (e.g., `AuthService`)

**Example: Login Flow**

```
User taps "Login" button
    ↓
LoginView calls AuthController.signIn()
    ↓
AuthController calls AuthService.signIn()
    ↓
AuthService uses FirebaseAuth
    ↓
User state updates via Rx<User?> stream
    ↓
AuthController navigates to /home
    ↓
GetMaterialApp shows HomeView
```

### Key Design Principles

1. **Separation of Concerns** - UI, logic, and data are separate
2. **Dependency Injection** - GetX manages all service lifecycles
3. **Reactive State** - Rx observables for automatic UI updates
4. **Error Handling** - User-friendly messages with detailed logging
5. **Offline Support** - SharedPreferences for local caching

---

## 🔌 API Documentation

### AuthService

```dart
// Sign up with email
Future<bool> signUp(String email, String password, String name)

// Sign in with email
Future<bool> signIn(String email, String password)

// Google Sign-In
Future<bool> signInWithGoogle()

// Sign out
Future<void> signOut()

// Password reset
Future<bool> resetPassword(String email)

// Change password
Future<bool> updatePassword(String newPassword)

// Observable state
Rx<User?> user              // Current Firebase user
RxString error              // Error messages
RxBool isLoading            // Loading state
Rx<UserProfile?> userProfile // User profile data
```

### PdfService

```dart
// Load PDF
Future<PdfDocument> loadPdfFile(String filePath)

// Extract text
Future<String> extractAllText(PdfDocument document)
String extractPageText(PdfDocument document, int pageIndex)

// Search
Future<List<int>> searchText(PdfDocument document, String searchTerm)

// Watermark
Future<File> addWatermark(File pdfFile, String watermarkText)

// Merge
Future<File> mergePdfs(List<File> pdfFiles, String outputFileName)

// Compress
Future<File> compressPdf(File pdfFile)

// Metadata
Future<Map<String, dynamic>> getPdfMetadata(File pdfFile)
```

### StorageService

```dart
// Upload
Future<bool> uploadPdf(File pdfFile, String userId, String fileName)
Future<bool> uploadMultiplePdfs(List<File> pdfFiles, String userId)

// Download
Future<File?> downloadPdf(String userId, String fileName)

// List & Info
Future<List<String>> listUserPdfs(String userId)
Future<Map<String, dynamic>> getPdfMetadata(String userId, String fileName)

// Share
Future<String> getPdfDownloadUrl(String userId, String fileName)
Future<String> sharePdf(String userId, String fileName)

// Delete
Future<bool> deletePdf(String userId, String fileName)

// Observable state
RxDouble uploadProgress      // 0.0 to 1.0
RxDouble downloadProgress    // 0.0 to 1.0
RxBool isUploading
RxBool isDownloading
```

---

## ✅ Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
open coverage/lcov.html
```

### Manual Testing Checklist

- [ ] **Guest Mode** - "Continue as Guest" works without login
- [ ] **Email Auth** - Sign up, email verification, login
- [ ] **Password Reset** - "Forgot Password" sends email
- [ ] **Google Sign-In** - Works on iOS and Android
- [ ] **PDF Upload** - File picker, progress display, upload succeeds
- [ ] **PDF Download** - Downloaded file appears on device
- [ ] **Conversion** - PDF→Word and Word→PDF succeed
- [ ] **History** - Conversions display in history tab
- [ ] **Delete** - Remove files and conversions
- [ ] **Share** - Generate and share download links
- [ ] **Profile** - Edit name, change password, delete account
- [ ] **Theme** - Dark/light mode toggle works
- [ ] **Offline** - App handles no internet gracefully

---

## 📦 Building for Production

### Android Release

```bash
# Build APK
flutter build apk --release
# Output: build/app/outputs/apk/release/app-release.apk

# Build App Bundle (for Google Play)
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab

# With optimization
flutter build apk --release --obfuscate --split-symbols
```

### iOS Release

```bash
# Build iOS
flutter build ios --release

# Archive for App Store
open ios/Runner.xcworkspace
# In Xcode: Product > Archive
```

### Web Release

```bash
# Build web app
flutter build web --release
# Output: build/web/

# Deploy to Firebase Hosting
firebase deploy
```

---

## 🐛 Troubleshooting

### Issue: "Google-services.json not found"
**Solution:**
```bash
# Download from Firebase Console
# Place at: android/app/google-services.json
ls -la android/app/google-services.json
```

### Issue: "Gradle build failed"
**Solution:**
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: "PDF conversion not working"
**Solution:**
- PDF conversion **only works on iOS/Android**, not Web
- Check file permissions (Android/iOS)
- Verify Syncfusion package is installed: `flutter pub get`

### Issue: "Firebase authentication fails"
**Solution:**
1. Verify credentials in `lib/main.dart` match Firebase Console
2. Check internet connection
3. Ensure authentication methods are enabled in Firebase Console
4. Verify Security Rules in Firestore/Storage

### Issue: "Google Sign-In fails on web"
**Solution:**
Add to `web/index.html`:
```html
<meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">
```

### Issue: "App crashes on startup"
**Solution:**
```bash
flutter logs  # Check error details
flutter clean
flutter pub get
flutter run -v  # Verbose output
```

---

## 🚀 Future Enhancements

### Short-term (1-2 months)
- [ ] PDF annotation tools (highlight, comment, draw)
- [ ] Batch file conversion
- [ ] Email file sharing
- [ ] In-app PDF viewer
- [ ] File compression before upload

### Medium-term (3-6 months)
- [ ] OCR (optical character recognition)
- [ ] PDF signatures/digital signing
- [ ] Advanced PDF editing (merge, split, reorder pages)
- [ ] File encryption
- [ ] Collaborative features (team folders)

### Long-term (6-12 months)
- [ ] Freemium/subscription model
- [ ] REST API for third-party integrations
- [ ] Desktop application (standalone)
- [ ] Advanced analytics dashboard
- [ ] Multi-language support (i18n)

---

## 📚 References

### Official Documentation
- [Flutter Documentation](https://docs.flutter.dev)
- [Dart Documentation](https://dart.dev/guides)
- [Firebase Documentation](https://firebase.google.com/docs)
- [GetX Documentation](https://pub.dev/packages/get)
- [Syncfusion Flutter PDF](https://help.syncfusion.com/flutter/pdf/overview)

### Useful Resources
- [Flutter Pub (Packages)](https://pub.dev)
- [Firebase Console](https://console.firebase.google.com)
- [Google Cloud Console](https://console.cloud.google.com)
- [Flutter Community](https://flutter.dev/community)

### Learning Resources
- [Flutter Codelabs](https://docs.flutter.dev/codelabs)
- [Firebase Tutorials](https://firebase.google.com/learn)
- [Dart Tutorials](https://dart.dev/tutorials)

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Authors & Contributors

- **Developer:** Hamza Munir
- **Project:** SmartPDF v1.0.0
- **Date:** November 12, 2025

---

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [Firebase](https://firebase.google.com) for backend services
- [Syncfusion](https://www.syncfusion.com) for PDF library
- [GetX Community](https://pub.dev/packages/get) for state management

---

## 📞 Support & Contact

For questions, issues, or suggestions:
- Open an [Issue](https://github.com/yourusername/smartpdf/issues)
- Create a [Discussion](https://github.com/yourusername/smartpdf/discussions)
- Contact: [your-email@example.com]

---

<div align="center">

**Made with ❤️ using Flutter**

⭐ If you find this project helpful, please star it! ⭐

[⬆ Back to Top](#-smartpdf---flutter-document-management-app)

</div>
