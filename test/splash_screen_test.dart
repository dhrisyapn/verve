import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verve/screens/splash/splash_screen.dart';
import 'package:verve/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SplashScreen UI Tests', () {
    testWidgets(
        'renders standalone logo image, brand title, and no card container',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SplashScreen(),
          ),
        ),
      );

      // Verify "Verve" brand name text exists
      expect(find.text('Verve'), findsOneWidget);

      // Verify the Text widget uses splashTitleStyle from AppTheme
      final textWidget = tester.widget<Text>(find.text('Verve'));
      expect(textWidget.style?.fontSize, AppTheme.splashTitleStyle.fontSize);
      expect(textWidget.style?.fontWeight, AppTheme.splashTitleStyle.fontWeight);

      // Verify the standalone logo Image widget exists with the expected asset & dimensions
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);

      final imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.image, isA<AssetImage>());
      final assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, 'assets/logo-app.png');
      expect(imageWidget.width, AppTheme.splashLogoSize);
      expect(imageWidget.height, AppTheme.splashLogoSize);

      // Verify there is no card container surrounding the logo
      final cardContainerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration == AppTheme.splashCardDecoration,
      );
      expect(cardContainerFinder, findsNothing);
    });
  });
}
