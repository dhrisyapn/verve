import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/screens/home/home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createSubject({NavigatorObserver? observer}) {
    return ProviderScope(
      child: MaterialApp(
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.onGenerateRoute,
        navigatorObservers: observer != null ? [observer] : [],
        home: const HomeScreen(),
      ),
    );
  }

  group('HomeScreen UI & Static Structure Tests', () {
    testWidgets('renders logo asset and user avatar initial in AppBar', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // AppBar existence
      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);

      // Logo image asset inside AppBar
      final imageFinder = find.descendant(
        of: appBarFinder,
        matching: find.byType(Image),
      );
      expect(imageFinder, findsOneWidget);
      final imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.image, isA<AssetImage>());
      final asset = imageWidget.image as AssetImage;
      expect(asset.assetName, 'assets/logo-app.png');

      // User avatar initial inside AppBar
      final avatarFinder = find.descendant(
        of: appBarFinder,
        matching: find.text('A'),
      );
      expect(avatarFinder, findsOneWidget);
    });

    testWidgets(
      'renders greeting wish and current date dynamically according to device time',
      (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 1000));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(createSubject());
        await tester.pumpAndSettle();

        final hour = DateTime.now().hour;
        final expectedGreeting = hour < 12
            ? 'Good morning'
            : hour < 17
                ? 'Good afternoon'
                : 'Good evening';

        expect(find.textContaining(expectedGreeting), findsOneWidget);
        expect(find.textContaining('Alex!'), findsOneWidget);

        // Date check
        const weekdays = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ];
        final now = DateTime.now();
        expect(find.textContaining(weekdays[now.weekday - 1]), findsOneWidget);
      },
    );

    testWidgets('renders productivity insight card as static content', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      expect(find.text('PRODUCTIVITY INSIGHT'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is RichText &&
              widget.text.toPlainText().contains('Focus is up 12%'),
        ),
        findsOneWidget,
      );
      expect(
        find.text("You're on a 4-day streak. Keep it up!"),
        findsOneWidget,
      );
    });

    testWidgets(
      'renders 4 quick action buttons as static elements (no click actions)',
      (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 1000));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(createSubject());
        await tester.pumpAndSettle();

        expect(find.text('Add Task'), findsOneWidget);
        expect(find.text('Timer'), findsOneWidget);
        expect(find.text('Analytics'), findsOneWidget);
        expect(find.text('Notes'), findsOneWidget);

        // Tapping 'Add Task' does not open a bottom sheet or dialog
        await tester.tap(find.text('Add Task'));
        await tester.pumpAndSettle();
        expect(find.text('Add New Task'), findsNothing);

        // Tapping 'Timer' does not show snackbar
        await tester.tap(find.text('Timer'));
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsNothing);
      },
    );

    testWidgets('renders Today\'s Tasks section with static task cards', (
      WidgetTester tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      expect(find.text("Today's Tasks"), findsOneWidget);
      expect(find.text('See all'), findsOneWidget);
      expect(find.text('Finalize Q3 Report'), findsNWidgets(3));
      expect(find.text('10:00 AM'), findsNWidgets(3));
      expect(find.text('WORK'), findsNWidgets(3));

      // Tapping task does not toggle completion (remains static unchecked)
      expect(find.byIcon(Icons.check_rounded), findsNothing);
      final firstTask = find.text('Finalize Q3 Report').first;
      await tester.tap(firstTask);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check_rounded), findsNothing);
    });

    testWidgets(
      'tapping profile avatar opens profile page as the only action',
      (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 1000));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(createSubject());
        await tester.pumpAndSettle();

        // Find avatar in AppBar
        final avatar = find.text('A');
        expect(avatar, findsOneWidget);

        await tester.tap(avatar);
        await tester.pumpAndSettle();

        // Profile screen is pushed
        expect(find.text('Profile'), findsOneWidget);
        expect(find.text('Sign Out'), findsOneWidget);
      },
    );
  });
}
