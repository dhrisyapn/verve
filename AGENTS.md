# Agent Guidelines & Project Architecture

## Project Architecture

The project follows a modular, feature-oriented Flutter directory structure under `lib/`:

```text
lib/
├── main.dart
├── app.dart
├── models/
│   └── user_model.dart
├── services/
│   └── storage_service.dart
├── screens/
│   ├── splash/
│   ├── login/
│   ├── register/
│   ├── home/
│   └── profile/
├── widgets/
│   ├── (reusable text field)
│   └── (reusable button)
└── theme/
    └── app_theme.dart
```

### Directory Structure & Responsibilities

- **`lib/main.dart`**: Application entry point. Responsible for low-level initialization (`WidgetsFlutterBinding`, state management `ProviderScope`, background services) and launching `MyApp` from `lib/app.dart`.
- **`lib/app.dart`**: Root application widget (`MaterialApp`). Configures application-wide routing, theme integration (`AppTheme`), title, and global navigation. Always maintain and use `lib/app.dart` as the root application container.
- **`lib/models/`**: Data models and serialization/deserialization logic.
  - `user_model.dart`: User data schema and entity definition.
- **`lib/services/`**: Application services, data persistence, and API handling.
  - `storage_service.dart`: Persistent local storage management.
- **`lib/screens/`**: UI screens and page-level views:
  - `splash`: Initial launch and startup loading screen.
  - `login`: User authentication login screen.
  - `register`: New user registration / sign-up screen.
  - `home`: Main application home / dashboard screen.
  - `profile`: User profile and account details screen.
- **`lib/widgets/`**: Reusable UI components shared across multiple screens:
  - Reusable text fields (custom input fields, validation styling).
  - Reusable buttons (primary/secondary action buttons, loading states).
- **`lib/theme/`**: Visual styling and design system tokens.
  - `app_theme.dart`: Centralized theme configuration (color schemes, typography, component themes, design tokens).

---

## Guidelines for Agents & Developers

1. **Always Use `lib/app.dart`**: Always use and maintain `lib/app.dart` as the root application widget (`MyApp` / `MaterialApp`). Keep application configuration, routing, and global theme setup inside `lib/app.dart` rather than inlining them into `lib/main.dart`.
2. **Centralized Design System in `lib/theme/app_theme.dart`**: If any new design items, colors, styles, typography, component themes, or decorations are requested by the user, always add them directly to `lib/theme/app_theme.dart` and consume them in the UI. Never introduce hardcoded colors, font styles, or ad-hoc decorations directly in screen or widget files.
3. **Separation of Concerns**: Keep business logic and data persistence in `services/`, schema definitions in `models/`, and presentation logic in `screens/` and `widgets/`.
4. **Reusable UI Components**: Build reusable widgets for repeated UI elements (text fields, buttons, cards). Do not duplicate presentation logic across screens.
5. **Resource Management & Async Safety**: Dispose controllers, focus nodes, and listeners properly; always check `mounted` after async calls before calling `setState` or accessing `BuildContext`.
6. **Naming & Widget Structure**: Use meaningful names, keep widgets small and focused, and prevent unused code or imports.
7. **Consistent Styling**: Avoid hardcoded colors and styles; always reference definitions from `theme/app_theme.dart` or `Theme.of(context)`.
8. **Quality & Analyzer Cleanliness**: Code should compile with zero errors and zero analyzer warnings (`flutter analyze` clean).
