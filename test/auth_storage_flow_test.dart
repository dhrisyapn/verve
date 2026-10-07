import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verve/models/user_model.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/screens/home/home_screen.dart';
import 'package:verve/screens/login/login_screen.dart';
import 'package:verve/screens/profile/profile_screen.dart';
import 'package:verve/screens/register/register_screen.dart';
import 'package:verve/screens/splash/splash_screen.dart';
import 'package:verve/services/storage_service.dart';
import 'package:verve/widgets/app_button.dart';

class InMemoryStorageService extends StorageService {
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

  late InMemoryStorageService storage;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    storage = InMemoryStorageService();
  });

  group('StorageService & UserModel unit tests', () {
    test('UserModel serializes and deserializes password correctly', () {
      const user = UserModel(
        id: 'u1',
        email: 'test@example.com',
        name: 'Tester',
        phoneNumber: '1234567890',
        password: 'securePassword123',
      );

      final jsonMap = user.toJson();
      expect(jsonMap['password'], 'securePassword123');

      final deserialized = UserModel.fromJson(jsonMap);
      expect(deserialized.id, 'u1');
      expect(deserialized.email, 'test@example.com');
      expect(deserialized.password, 'securePassword123');
      expect(deserialized, equals(user));
    });

    test('StorageService saves and retrieves users in SharedPreferences', () async {
      const user1 = UserModel(
        id: 'u1',
        email: 'user1@example.com',
        password: 'password1',
      );
      const user2 = UserModel(
        id: 'u2',
        email: 'user2@example.com',
        password: 'password2',
      );

      await storage.saveUserToList(user1);
      await storage.saveUserToList(user2);

      final users = await storage.getUsers();
      expect(users.length, 2);
      expect(users[0].email, 'user1@example.com');
      expect(users[0].password, 'password1');
      expect(users[1].email, 'user2@example.com');
      expect(users[1].password, 'password2');

      // Verify directly from SharedPreferences instance
      final prefs = await SharedPreferences.getInstance();
      final rawStored = prefs.getString(StorageKeys.usersList);
      expect(rawStored, isNotNull);
      expect(rawStored, contains('user1@example.com'));
      expect(rawStored, contains('user2@example.com'));
    });

    test('StorageService checks if user exists with email', () async {
      const user = UserModel(
        id: 'u1',
        email: 'unique@example.com',
        password: 'password123',
      );
      await storage.saveUserToList(user);

      expect(await storage.userExistsWithEmail('unique@example.com'), isTrue);
      expect(await storage.userExistsWithEmail('UNIQUE@EXAMPLE.COM'), isTrue);
      expect(await storage.userExistsWithEmail('other@example.com'), isFalse);
    });

    test('StorageService saves, reads, and deletes currentUser', () async {
      const user = UserModel(
        id: 'u1',
        email: 'current@example.com',
        name: 'Current User',
        password: 'password123',
      );

      expect(await storage.getCurrentUser(), isNull);

      await storage.saveCurrentUser(user);
      final retrieved = await storage.getCurrentUser();
      expect(retrieved, isNotNull);
      expect(retrieved?.email, 'current@example.com');
      expect(retrieved?.name, 'Current User');

      await storage.deleteCurrentUser();
      expect(await storage.getCurrentUser(), isNull);
    });
  });

  group('Registration Flow Tests', () {
    testWidgets('registers user, saves to userdata_list, currentuser, and updates provider', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final container = ProviderContainer(
        overrides: [storageServiceProvider.overrideWithValue(storage)],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            navigatorKey: AppRouter.navigatorKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const RegisterScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Alice Wonderland');
      await tester.enterText(fields.at(1), 'alice@example.com');
      await tester.enterText(fields.at(2), '9876543210');
      await tester.enterText(fields.at(3), 'SuperSecret123');
      await tester.enterText(fields.at(4), 'SuperSecret123');

      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();

      // Check users list in storage
      final users = await storage.getUsers();
      expect(users.length, 1);
      expect(users.first.email, 'alice@example.com');
      expect(users.first.password, 'SuperSecret123');
      expect(users.first.name, 'Alice Wonderland');

      // Check currentUser in storage
      final currentUser = await storage.getCurrentUser();
      expect(currentUser, isNotNull);
      expect(currentUser?.email, 'alice@example.com');

      // Check provider state
      final userInProvider = container.read(currentUserProvider);
      expect(userInProvider, isNotNull);
      expect(userInProvider?.name, 'Alice Wonderland');
    });

    testWidgets('rejects registration when email already exists', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      // Pre-populate an existing user
      await storage.saveUserToList(
        const UserModel(
          id: 'existing_id',
          email: 'existing@example.com',
          name: 'Existing User',
          password: 'Password123',
        ),
      );

      final container = ProviderContainer(
        overrides: [storageServiceProvider.overrideWithValue(storage)],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            navigatorKey: AppRouter.navigatorKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const RegisterScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Duplicate User');
      await tester.enterText(fields.at(1), 'existing@example.com');
      await tester.enterText(fields.at(2), '9876543210');
      await tester.enterText(fields.at(3), 'Password123');
      await tester.enterText(fields.at(4), 'Password123');

      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();

      expect(
        find.text('An account with this email address already exists.'),
        findsOneWidget,
      );

      // Verify users list has not added duplicate
      final users = await storage.getUsers();
      expect(users.length, 1);
    });
  });

  group('Login Flow Tests', () {
    testWidgets('authenticates against userdata_list, saves to currentuser and provider', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await storage.saveUserToList(
        const UserModel(
          id: 'user_bob',
          email: 'bob@example.com',
          name: 'Bob Ross',
          phoneNumber: '+1 555 987 6543',
          password: 'HappyTrees123',
        ),
      );

      final container = ProviderContainer(
        overrides: [storageServiceProvider.overrideWithValue(storage)],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            navigatorKey: AppRouter.navigatorKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      await tester.enterText(emailField, 'bob@example.com');
      await tester.enterText(passwordField, 'HappyTrees123');

      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      // Check currentuser in storage
      final current = await storage.getCurrentUser();
      expect(current, isNotNull);
      expect(current?.email, 'bob@example.com');
      expect(current?.name, 'Bob Ross');

      // Check provider
      expect(container.read(currentUserProvider)?.email, 'bob@example.com');
    });

    testWidgets('fails login when credentials do not match userdata_list', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await storage.saveUserToList(
        const UserModel(
          id: 'user_bob',
          email: 'bob@example.com',
          password: 'CorrectPassword123',
        ),
      );

      final container = ProviderContainer(
        overrides: [storageServiceProvider.overrideWithValue(storage)],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            navigatorKey: AppRouter.navigatorKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      await tester.enterText(emailField, 'bob@example.com');
      await tester.enterText(passwordField, 'WrongPassword!');

      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email or password.'), findsOneWidget);
      // Both text fields are marked with the credential error
      expect(find.text('Invalid email or password'), findsNWidgets(2));
      expect(await storage.getCurrentUser(), isNull);

      // Typing into a text field immediately removes the error
      await tester.enterText(emailField, 'bob2@example.com');
      await tester.pumpAndSettle();
      expect(find.text('Invalid email or password'), findsNothing);
    });
  });

  group('Splash Screen Tests', () {
    testWidgets('loads currentUser into provider and routes to home if present', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      const savedUser = UserModel(
        id: 'u123',
        email: 'splash@example.com',
        name: 'Splash User',
      );
      await storage.saveCurrentUser(savedUser);

      final container = ProviderContainer(
        overrides: [storageServiceProvider.overrideWithValue(storage)],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            navigatorKey: AppRouter.navigatorKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const SplashScreen(),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(container.read(currentUserProvider)?.email, 'splash@example.com');
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('clears provider and routes to login if currentUser is null', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final container = ProviderContainer(
        overrides: [storageServiceProvider.overrideWithValue(storage)],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            navigatorKey: AppRouter.navigatorKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const SplashScreen(),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(container.read(currentUserProvider), isNull);
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });

  group('Profile Screen Sign Out & Display Tests', () {
    testWidgets('displays data from provider and deletes currentuser on sign out', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(600, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      const user = UserModel(
        id: 'u_profile',
        email: 'profile_test@example.com',
        name: 'Profile Hero',
        phoneNumber: '+1 555 777 8888',
      );
      await storage.saveCurrentUser(user);

      final container = ProviderContainer(
        overrides: [storageServiceProvider.overrideWithValue(storage)],
      );
      container.read(currentUserProvider.notifier).setUser(user);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            navigatorKey: AppRouter.navigatorKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const ProfileScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check display
      expect(find.text('Profile Hero'), findsWidgets);
      expect(find.text('profile_test@example.com'), findsOneWidget);
      expect(find.text('+1 555 777 8888'), findsOneWidget);
      expect(find.text('P'), findsOneWidget);

      // Sign out
      await tester.tap(find.text('Sign Out'));
      await tester.pumpAndSettle();

      // Tap confirm sign out dialog button
      final confirmBtn = find.widgetWithText(TextButton, 'Sign Out');
      await tester.tap(confirmBtn);
      await tester.pumpAndSettle();

      // Storage current user must be deleted
      expect(await storage.getCurrentUser(), isNull);
      // Provider user must be cleared
      expect(container.read(currentUserProvider), isNull);
      // Navigated to LoginScreen
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    test('CurrentUserNotifier.signOut() explicitly clears provider state and deletes current user', () async {
      final container = ProviderContainer(
        overrides: [storageServiceProvider.overrideWithValue(storage)],
      );

      const user = UserModel(
        id: 'u_100',
        email: 'clear_test@example.com',
        name: 'Clear Test',
      );
      await storage.saveCurrentUser(user);
      container.read(currentUserProvider.notifier).setUser(user);

      expect(container.read(currentUserProvider), isNotNull);
      expect(container.read(currentUserProvider)?.email, 'clear_test@example.com');

      await container.read(currentUserProvider.notifier).signOut();

      expect(container.read(currentUserProvider), isNull);
      expect(await storage.getCurrentUser(), isNull);
    });

    test('CurrentUserNotifier.clearUser() resets provider state to null', () {
      final container = ProviderContainer();
      const user = UserModel(
        id: 'u_200',
        email: 'direct_clear@example.com',
        name: 'Direct Clear',
      );

      container.read(currentUserProvider.notifier).setUser(user);
      expect(container.read(currentUserProvider), isNotNull);

      container.read(currentUserProvider.notifier).clearUser();
      expect(container.read(currentUserProvider), isNull);
    });
  });
}
