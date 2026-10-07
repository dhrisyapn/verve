import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verve/app.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/screens/home/home_screen.dart';
import 'package:verve/screens/login/login_screen.dart';
import 'package:verve/screens/profile/profile_screen.dart';
import 'package:verve/screens/register/register_screen.dart';
import 'package:verve/screens/splash/splash_screen.dart';

void main() {
  group('AppRouter Route Generation Tests', () {
    testWidgets('resolves all defined routes to expected screens',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final splashRoute = AppRouter.onGenerateRoute(
                const RouteSettings(name: AppRoutes.splash),
              ) as MaterialPageRoute<dynamic>;
              expect(splashRoute.builder(context), isA<SplashScreen>());

              final loginRoute = AppRouter.onGenerateRoute(
                const RouteSettings(name: AppRoutes.login),
              ) as MaterialPageRoute<dynamic>;
              expect(loginRoute.builder(context), isA<LoginScreen>());

              final registerRoute = AppRouter.onGenerateRoute(
                const RouteSettings(name: AppRoutes.register),
              ) as MaterialPageRoute<dynamic>;
              expect(registerRoute.builder(context), isA<RegisterScreen>());

              final homeRoute = AppRouter.onGenerateRoute(
                const RouteSettings(name: AppRoutes.home),
              ) as MaterialPageRoute<dynamic>;
              expect(homeRoute.builder(context), isA<HomeScreen>());

              final profileRoute = AppRouter.onGenerateRoute(
                const RouteSettings(name: AppRoutes.profile),
              ) as MaterialPageRoute<dynamic>;
              expect(profileRoute.builder(context), isA<ProfileScreen>());

              final unknownRoute = AppRouter.onGenerateRoute(
                const RouteSettings(name: '/unknown'),
              ) as MaterialPageRoute<dynamic>;
              expect(unknownRoute.builder(context), isA<Scaffold>());

              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('MyApp App Router Integration', () {
    testWidgets('renders initial SplashScreen via AppRouter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.text('Verve'), findsOneWidget);
    });
  });
}
