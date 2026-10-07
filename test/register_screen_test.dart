import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verve/screens/register/register_screen.dart';
import 'package:verve/widgets/app_button.dart';
import 'package:verve/widgets/app_text_field.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createSubject() {
    return const ProviderScope(child: MaterialApp(home: RegisterScreen()));
  }

  group('RegisterScreen UI & Interaction Tests', () {
    testWidgets('renders header, logo, title, and subtitle', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // Brand Title & Subtitle
      expect(find.text('Create Account'), findsNWidgets(2)); // Title & button
      expect(
        find.text('Join Verve and unlock your peak productivity.'),
        findsOneWidget,
      );

      // Logo Image asset
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
      final imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.image, isA<AssetImage>());
      final asset = imageWidget.image as AssetImage;
      expect(asset.assetName, 'assets/logo-app.png');
    });

    testWidgets('renders all 5 input fields with labels and hints', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // Labels
      expect(find.text('FULL NAME'), findsOneWidget);
      expect(find.text('EMAIL ADDRESS'), findsOneWidget);
      expect(find.text('PHONE NUMBER'), findsOneWidget);
      expect(find.text('PASSWORD'), findsOneWidget);
      expect(find.text('CONFIRM PASSWORD'), findsOneWidget);

      // Hints
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('hello@verve.app'), findsOneWidget);
      expect(find.text('+1 (555) 000-0000'), findsOneWidget);
      expect(find.text('••••••••'), findsNWidgets(2));

      // Submit Button
      expect(find.byType(AppButton), findsOneWidget);

      // Footer
      expect(find.text('Already have an account? '), findsOneWidget);
      expect(find.text('Log in here'), findsOneWidget);
    });

    testWidgets('toggles password and confirm password visibility', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      final textFields = find.byType(AppTextField);
      expect(textFields, findsNWidgets(5));

      // Initial state has 2 visibility_outlined icons
      expect(find.byIcon(Icons.visibility_outlined), findsNWidgets(2));
      expect(find.byIcon(Icons.visibility_off_outlined), findsNothing);

      // Tap the first eye icon (Password field)
      await tester.tap(find.byIcon(Icons.visibility_outlined).first);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      // Tap the second eye icon (Confirm Password field)
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_off_outlined), findsNWidgets(2));
      expect(find.byIcon(Icons.visibility_outlined), findsNothing);
    });

    testWidgets('validates required fields on submit', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      // Ensure button is visible in scrollable view and tap
      await tester.ensureVisible(find.byType(AppButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your full name'), findsOneWidget);
      expect(find.text('Please enter your email address'), findsOneWidget);
      expect(find.text('Please enter your phone number'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
      expect(find.text('Please confirm your password'), findsOneWidget);
    });

    testWidgets('validates password length and password mismatch', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      final formFields = find.byType(TextFormField);

      // Enter name, email, phone
      await tester.enterText(formFields.at(0), 'John Doe');
      await tester.enterText(formFields.at(1), 'john@example.com');
      await tester.enterText(formFields.at(2), '9876543210');

      // Enter short password
      await tester.enterText(formFields.at(3), '12345');
      await tester.enterText(formFields.at(4), 'differentPassword');

      await tester.ensureVisible(find.byType(AppButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();

      expect(
        find.text('Password must be at least 6 characters'),
        findsOneWidget,
      );
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('validates password matching succeeds when identical', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createSubject());
      await tester.pumpAndSettle();

      final formFields = find.byType(TextFormField);

      await tester.enterText(formFields.at(0), 'John Doe');
      await tester.enterText(formFields.at(1), 'john@example.com');
      await tester.enterText(formFields.at(2), '9876543210');
      await tester.enterText(formFields.at(3), 'securePassword123');
      await tester.enterText(formFields.at(4), 'securePassword123');

      await tester.ensureVisible(find.byType(AppButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(AppButton));
      await tester.pump();

      // No validation errors should be displayed
      expect(find.text('Please enter your full name'), findsNothing);
      expect(find.text('Please enter your email address'), findsNothing);
      expect(find.text('Please enter your phone number'), findsNothing);
      expect(find.text('Password must be at least 6 characters'), findsNothing);
      expect(find.text('Passwords do not match'), findsNothing);

      // Advance simulated network request timer
      await tester.pump(const Duration(milliseconds: 1500));
    });
  });
}
