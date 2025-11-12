# 📄 SmartPDF

[![Flutter](https://img.shields.io/badge/Flutter-3.1.0-blue?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.1.0-blue?logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web-blue)](https://flutter.dev/)

A **production-ready Flutter application** for seamless PDF and Word document conversion with cloud-based storage, Firebase authentication, and multi-platform support.

**Status:** ✅ **Fully Functional & Ready for Deployment**

---

## 🎯 Features

### Authentication
- ✅ **Email/Password** - Create account, login, password reset with email verification
- ✅ **Google Sign-In** - One-tap authentication (iOS, Android)
- ✅ **Guest Mode** - Access without creating an account
- ✅ **Secure Password** - Validation (8+ chars, uppercase, lowercase, number, special char)
- ✅ **Remember Me** - Optional credential persistence

### File Management
- ✅ **Upload PDFs** - Select and upload with progress tracking
- ✅ **Download PDFs** - Download to device storage
- ✅ **Share PDFs** - Generate shareable download links
- ✅ **Delete PDFs** - Manage cloud storage files
- ✅ **View Metadata** - File size, creation date, page count

### PDF Conversion (Mobile Only)
- ✅ **PDF to Word** - Extract text and save as RTF/DOCX
- ✅ **Word to PDF** - Convert documents with formatting
- ✅ **Progress Tracking** - Real-time upload/download UI
- ✅ **Conversion History** - Track all conversions in Firestore

### User Profile
- ✅ **Update Profile** - Edit name and photo
- ✅ **Change Password** - Secure password change
- ✅ **Delete Account** - Remove account and all data
- ✅ **Theme Toggle** - Dark/Light mode support

### Cross-Platform
- ✅ **iOS** - Full feature support
- ✅ **Android** - Full feature support
- ✅ **Web** - Guest mode, auth, UI (PDF conversion not supported on web)

---

## 🛠️ Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| **UI Framework** | Flutter | 3.1.0+ |
| **State Management** | GetX | 4.6.6 |
| **Authentication** | Firebase Auth + Google Sign-In | 6.1.1 / 6.1.5 |
| **Cloud Storage** | Firebase Storage + Firestore | 13.0.3 / 6.0.3 |
| **PDF Processing** | Syncfusion Flutter PDF | 31.2.4 |
| **File Operations** | file_picker, path_provider | 10.3.3 / 2.1.1 |
| **Sharing** | share_plus | 7.2.1 |
| **UI Design** | Material Design 3 | - |

---

## 📦 Project Structure

```
lib/
├── main.dart                    # App entry point
├── app/
│   ├── routes/app_pages.dart   # Navigation routes
│   ├── themes/app_theme.dart   # Material Design 3
│   ├── services/               # Business logic
│   │   ├── auth_service.dart
│   │   ├── pdf_service.dart
│   │   ├── storage_service.dart
│   │   └── document_conversion_service.dart
│   ├── modules/                # Feature modules
│   │   ├── auth/               # Login, Register, Password Reset
│   │   ├── home/               # Dashboard, History, Profile
│   │   ├── conversion/         # PDF Conversion
│   │   └── splash/             # Splash Screen
│   └── data/                   # Models & Repositories
└── assets/                     # Images & Icons

android/
├── app/google-services.json    # Firebase config
└── build.gradle.kts

ios/
└── Runner/GoogleService-Info.plist  # Firebase config
```

---

## 🚀 Quick Start

### Prerequisites

```bash
# Check Flutter installation
flutter --version

# Verify environment
flutter doctor
```

**Required:**
- Flutter SDK 3.1.0 or higher
- Xcode 14+ (for iOS)
- Android SDK 21+ (for Android)
- Firebase Project (https://console.firebase.google.com)

### Installation

#### 1. Clone Repository
```bash
git clone https://github.com/yourusername/smartpdf.git
cd smartpdf
```

#### 2. Install Dependencies
```bash
flutter pub get
```

#### 3. Configure Firebase

**For Android:**
- Ensure `android/app/google-services.json` exists ✅ (already included)

**For iOS:**
- Ensure `ios/Runner/GoogleService-Info.plist` exists ✅ (already included)
- Add to Xcode if needed:
  ```bash
  open ios/Runner.xcworkspace
  # Right-click Runner → Add Files → GoogleService-Info.plist
  ```

**For Web:**
- Firebase config is in `lib/main.dart` (hardcoded for development)
- For production: `flutterfire configure`

#### 4. Install iOS Dependencies (if building for iOS)
```bash
cd ios
pod install --repo-update
cd ..
```

#### 5. Verify Setup
```bash
flutter doctor
```

### Run the App

**Web (Chrome):**
```bash
flutter run -d chrome
```

**Android:**
```bash
flutter run -d android
```

**iOS:**
```bash
flutter run -d ios
```

**Test Guest Mode:**
1. Open app
2. Click "Continue as Guest" button
3. Instant access without login ✅

---

## 🔐 Firebase Setup

### Enable Authentication
1. Go to **Firebase Console** > **Authentication** > **Sign-in method**
2. Enable:
   - ✅ **Email/Password**
   - ✅ **Google** (add OAuth client ID)
   - ✅ **Anonymous** (optional)

### Enable Firestore
1. **Firebase Console** > **Firestore Database**
2. Set rules:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
    }
    match /conversions/{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### Enable Cloud Storage
1. **Firebase Console** > **Cloud Storage**
2. Set rules:
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

### Google OAuth Setup (Mobile)
1. **Google Cloud Console** > **Credentials**
2. Create OAuth 2.0 Client IDs:
   - **iOS:** Bundle ID = `com.smartpdf.app`
   - **Android:** Package name = `com.smartpdf.app`
3. Get Android SHA-1:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey
   # Password: android
   ```
4. Add to **Firebase Console** > **Project Settings**

---

## 📱 Build & Deploy

### Debug Build

```bash
# Android APK (debug)
flutter build apk --debug

# iOS (debug)
flutter build ios --debug
```

### Release Build

```bash
# Android APK (release)
flutter build apk --release

# Android App Bundle (for Google Play)
flutter build appbundle --release

# iOS (release)
flutter build ios --release
```

### Web Deployment

```bash
# Build for web
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting
```

---

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Manual Testing Checklist
- [ ] Guest mode works
- [ ] Email/Password login/register
- [ ] Password reset email sent
- [ ] Google Sign-In (mobile only)
- [ ] PDF upload with progress
- [ ] PDF download succeeds
- [ ] PDF conversion (PDF↔Word)
- [ ] Conversion history displays
- [ ] Delete files and conversions
- [ ] Share with download link
- [ ] Edit user profile
- [ ] Change password
- [ ] Delete account
- [ ] Theme toggle (dark/light)

---

## 🐛 Troubleshooting

### App won't start
```bash
flutter clean
flutter pub get
flutter run
```

### Firebase connection errors
- Verify `google-services.json` and `GoogleService-Info.plist` exist
- Check Firebase Console project is active
- Ensure API keys are not restricted

### PDF conversion not working
- PDF conversion only works on **iOS/Android** (not Web)
- Ensure storage permissions granted
- Check device has sufficient disk space

### iOS build fails
```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
flutter clean
flutter pub get
```

### Android build fails
- Verify Android SDK installed: `flutter doctor`
- Set ANDROID_HOME: `export ANDROID_HOME=~/Android/Sdk`
- Run: `flutter clean && flutter pub get`

---

## 📚 Documentation

For detailed documentation, see:
- **[Complete Project Documentation](docs/Complete_Documentation.md)** - Full guide with architecture, setup, features
- **[Project Summary](PROJECT_SUMMARY.md)** - Quick overview and completion status
- **[HTML Version](docs/Complete_Documentation.html)** - Print-friendly documentation

---

## 🤝 Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

---

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Hamza Munir**

---

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - UI framework
- [Firebase](https://firebase.google.com/) - Backend services
- [GetX](https://pub.dev/packages/get) - State management
- [Syncfusion](https://www.syncfusion.com/) - PDF processing
- [Material Design 3](https://m3.material.io/) - Design system

---

## 📞 Support

For help and questions:
1. Check [Complete Documentation](docs/Complete_Documentation.md)
2. Review [Troubleshooting Section](#troubleshooting)
3. Check Flutter logs: `flutter logs`
4. Open GitHub Issue

---

## 🎉 Get Started Now!

```bash
git clone https://github.com/yourusername/smartpdf.git
cd smartpdf
flutter pub get
flutter run -d chrome
```

Click **"Continue as Guest"** to test the app immediately! 🚀

---

**Last Updated:** November 12, 2025  
**Version:** 1.0.0+1  
**Status:** ✅ Production Ready
