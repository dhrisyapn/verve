import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verve/screens/login/login_screen.dart';
import 'package:verve/widgets/app_button.dart';
import 'package:verve/widgets/app_text_field.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createSubject() {
    return const ProviderScope(
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  group('LoginScreen UI & Interaction Tests', () {
    testWidgets('renders header, logo, title, and subtitle',
        (WidgetTester tester) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // Brand Title & Subtitle
      expect(find.text('Verve'), findsOneWidget);
      expect(find.text('Unlock your peak productivity.'), findsOneWidget);

      // Logo Image asset
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
      final imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.image, isA<AssetImage>());
      final asset = imageWidget.image as AssetImage;
      expect(asset.assetName, 'assets/logo-app.png');
    });

    testWidgets('renders input fields with labels and placeholders',
        (WidgetTester tester) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // Labels
      expect(find.text('EMAIL ADDRESS'), findsOneWidget);
      expect(find.text('PASSWORD'), findsOneWidget);

      // Hints
      expect(find.text('hello@verve.app'), findsOneWidget);
      expect(find.text('••••••••'), findsOneWidget);

      // Sign In button
      expect(find.text('Sign In'), findsOneWidget);

      // Footer
      expect(find.text('New to Verve? '), findsOneWidget);
      expect(find.text('Create an account'), findsOneWidget);
    });

    testWidgets('toggles password visibility when eye icon is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // Find password TextFormField
      final textFields = find.byType(AppTextField);
      expect(textFields, findsNWidgets(2));

      // Initial state has visibility_outlined
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsNothing);

      // Tap the eye icon
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pumpAndSettle();

      // Now visibility_off_outlined is shown
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsNothing);
    });

    testWidgets('validates required fields on submit',
        (WidgetTester tester) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // Tap Sign In with empty fields
      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email address'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('validates invalid email format',
        (WidgetTester tester) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      final emailField = find.widgetWithText(TextFormField, 'hello@verve.app');
      await tester.enterText(emailField, 'invalid-email');

      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });
  });
}
