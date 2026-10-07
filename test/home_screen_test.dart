import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verve/screens/home/home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createSubject() {
    return const ProviderScope(
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }

  group('HomeScreen UI & Interaction Tests', () {
    testWidgets('renders logo asset and user avatar initial in AppBar',
        (WidgetTester tester) async {
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

    testWidgets('renders greeting and date section',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      expect(find.textContaining('Alex!'), findsOneWidget);
    });

    testWidgets('renders productivity insight card',
        (WidgetTester tester) async {
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

    testWidgets('renders 4 quick action buttons with correct labels',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      expect(find.text('Add Task'), findsOneWidget);
      expect(find.text('Timer'), findsOneWidget);
      expect(find.text('Analytics'), findsOneWidget);
      expect(find.text('Notes'), findsOneWidget);
    });

    testWidgets('renders Today\'s Tasks section with initial tasks',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      expect(find.text("Today's Tasks"), findsOneWidget);
      expect(find.text('See all'), findsOneWidget);
      expect(find.text('Finalize Q3 Report'), findsNWidgets(3));
      expect(find.text('10:00 AM'), findsNWidgets(3));
      expect(find.text('WORK'), findsNWidgets(3));
    });

    testWidgets('toggles task completion when task is tapped',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // Initially no check icons
      expect(find.byIcon(Icons.check_rounded), findsNothing);

      // Tap first task item
      final firstTask = find.text('Finalize Q3 Report').first;
      await tester.ensureVisible(firstTask);
      await tester.tap(firstTask);
      await tester.pumpAndSettle();

      // Check icon is now visible
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);

      // Tap again to uncheck
      await tester.tap(firstTask);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_rounded), findsNothing);
    });

    testWidgets('opens Add Task bottom sheet and creates task',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // Tap Add Task action card
      final addTaskCard = find.text('Add Task');
      await tester.ensureVisible(addTaskCard);
      await tester.tap(addTaskCard);
      await tester.pumpAndSettle();

      // Verify bottom sheet appears
      expect(find.text('Add New Task'), findsOneWidget);
      expect(find.text('TASK TITLE'), findsOneWidget);

      // Enter task title
      await tester.enterText(
        find.byType(TextFormField).first,
        'Prepare Slides',
      );
      await tester.pumpAndSettle();

      // Tap Create Task button
      await tester.tap(find.text('Create Task'));
      await tester.pumpAndSettle();

      // Verify bottom sheet closed and new task is listed
      expect(find.text('Add New Task'), findsNothing);
      expect(find.text('Prepare Slides'), findsOneWidget);
    });
  });
}
