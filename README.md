# Verve

A Flutter mobile application designed with a clean, flat aesthetic, modular feature-oriented architecture, and robust state management.

---

## 🛠️ Flutter & Dart Version

This project is built and tested with:

- **Flutter SDK**: `3.47.5` (channel `stable`)
- **Dart SDK**: `^3.13.4` (Dart `3.13.4`)

---

## 📋 Prerequisites

Before setting up the project, ensure you have the following installed:

1. **Flutter SDK** (`3.47.5` or compatible `3.x` release):
   - [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)
2. **Android Studio** / **Xcode** (with command-line tools & simulators/emulators configured).
3. **VS Code** or **Android Studio** with Flutter and Dart extensions installed.

Verify your environment setup by running:
```bash
flutter doctor
```

---

## 🚀 Setup & Installation Steps

### 1. Clone or Open the Repository
```bash
git clone https://github.com/dhrisyapn/verve
cd verve
```

### 2. Install Dependencies
Fetch all required packages declared in `pubspec.yaml`:
```bash
flutter pub get
```

### 3. Generate Launcher Icons (Optional / As Needed)
If you update the application icons in `assets/`:
```bash
dart run flutter_launcher_icons
```

### 4. Analyze Codebase
Ensure there are no analyzer errors or lint warnings:
```bash
flutter analyze
```

### 5. Run Unit & Widget Tests
Execute the project test suite:
```bash
flutter test
```

### 6. Run the Application
Launch the app in debug mode on a connected device or running emulator:
```bash
flutter run
```
To run on a specific target device:
```bash
flutter devices
flutter run -d <device_id>
```

---

## 📂 Project Architecture

The codebase adheres to a modular, feature-oriented structure inside `lib/`:

```text
lib/
├── main.dart                  # Application entry point & low-level initialization
├── app.dart                   # Root MaterialApp configuration, routing & theme setup
├── router/
│   └── app_router.dart        # Centralized route definitions and navigation logic
├── models/
│   └── user_model.dart        # Data schema & serialization models
├── services/
│   └── storage_service.dart   # Persistent local & secure storage management
├── utils/
│   └── validators.dart        # Centralized form input validators
├── screens/
│   ├── splash/                # Splash & startup view
│   ├── login/                 # Authentication login screen
│   ├── register/              # Registration / Sign-up screen
│   ├── home/                  # Home dashboard screen
│   └── profile/               # User profile & account details screen
├── widgets/                   # Reusable UI widgets (buttons, text fields, cards)
└── theme/
    └── app_theme.dart         # Centralized design system & color tokens
```

---

## 🧰 Key Dependencies & Libraries

- **State Management**: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences) & [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- **Typography**: [google_fonts](https://pub.dev/packages/google_fonts)
- **Icons**: [cupertino_icons](https://pub.dev/packages/cupertino_icons)
- **Launcher Icons**: [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
