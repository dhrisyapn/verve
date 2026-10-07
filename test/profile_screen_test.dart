import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/screens/profile/profile_screen.dart';
import 'package:verve/services/storage_service.dart';

class MockStorageService extends StorageService {
  final Map<String, String> _store = {};

  @override
  Future<void> write({required String key, required String value}) async {
    _store[key] = value;
  }

  @override
  Future<String?> read({required String key}) async {
    return _store[key];
  }

  @override
  Future<void> delete({required String key}) async {
    _store.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    _store.clear();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget createSubject({StorageService? storageService}) {
    final mockStorage = storageService ?? MockStorageService();
    return ProviderScope(
      overrides: [storageServiceProvider.overrideWithValue(mockStorage)],
      child: MaterialApp(
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: const ProfileScreen(),
      ),
    );
  }

  group('ProfileScreen UI & Interaction Tests', () {
    testWidgets('renders AppBar with back button and centered Profile title', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);

      final titleFinder = find.descendant(
        of: appBarFinder,
        matching: find.text('Profile'),
      );
      expect(titleFinder, findsOneWidget);

      final backIconFinder = find.descendant(
        of: appBarFinder,
        matching: find.byIcon(Icons.arrow_back_rounded),
      );
      expect(backIconFinder, findsOneWidget);
    });

    testWidgets('renders user avatar initial, edit badge, and name', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      expect(find.text('A'), findsOneWidget);
      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
      expect(find.text('Alex Carter'), findsWidgets);
    });

    testWidgets('renders profile details card with 3 info rows', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      expect(find.text('FULL NAME'), findsOneWidget);
      expect(find.text('EMAIL ADDRESS'), findsOneWidget);
      expect(find.text('PHONE NUMBER'), findsOneWidget);

      expect(find.byIcon(Icons.person_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.mail_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.phone_outlined), findsOneWidget);

      expect(find.text('alex.carter@verve.app'), findsOneWidget);
      expect(find.text('+1 (555) 123-4567'), findsOneWidget);
    });

    testWidgets('renders Sign Out button with logout icon', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      expect(find.text('Sign Out'), findsOneWidget);
      expect(find.byIcon(Icons.logout_rounded), findsOneWidget);
    });

    testWidgets('tapping edit badge opens bottom sheet and updates profile', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final storage = MockStorageService();
      await tester.pumpWidget(createSubject(storageService: storage));
      await tester.pumpAndSettle();

      final editIcon = find.byIcon(Icons.edit_outlined);
      await tester.tap(editIcon);
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.text('Save Changes'), findsOneWidget);

      final nameField = find.byType(TextFormField).first;
      await tester.enterText(nameField, 'Jordan Lee');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save Changes'));
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile'), findsNothing);
      expect(find.text('Jordan Lee'), findsWidgets);
      expect(find.text('J'), findsOneWidget);
    });

    testWidgets('tapping Sign Out opens confirmation dialog and can cancel', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      final signOutBtn = find.text('Sign Out');
      await tester.tap(signOutBtn);
      await tester.pumpAndSettle();

      expect(
        find.text('Are you sure you want to sign out of Verve?'),
        findsOneWidget,
      );
      expect(find.text('Cancel'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(
        find.text('Are you sure you want to sign out of Verve?'),
        findsNothing,
      );
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders appearance card and toggles theme mode switch', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final storage = MockStorageService();
      await tester.pumpWidget(createSubject(storageService: storage));
      await tester.pumpAndSettle();

      expect(find.text('APPEARANCE'), findsOneWidget);
      expect(find.text('Light Mode'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isFalse);

      // Tap the switch to toggle to Dark Mode
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(find.text('Dark Mode'), findsOneWidget);
      final updatedSwitch = tester.widget<Switch>(find.byType(Switch));
      expect(updatedSwitch.value, isTrue);

      // Tap again to toggle back to Light Mode
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(find.text('Light Mode'), findsOneWidget);
      final finalSwitch = tester.widget<Switch>(find.byType(Switch));
      expect(finalSwitch.value, isFalse);
    });
  });
}
