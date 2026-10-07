import 'package:flutter/material.dart';
import 'package:verve/screens/home/home_screen.dart';
import 'package:verve/screens/login/login_screen.dart';
import 'package:verve/screens/profile/profile_screen.dart';
import 'package:verve/screens/register/register_screen.dart';
import 'package:verve/screens/splash/splash_screen.dart';

/// Application route path constants.
abstract final class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
}

/// Centralized router and navigation management for Verve.
class AppRouter {
  AppRouter._();

  /// Global navigator key used for application-wide navigation.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Generates the corresponding [Route] for the given [settings].
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(
          const SplashScreen(),
          settings: settings,
        );
      case AppRoutes.login:
        return _buildRoute(
          const LoginScreen(),
          settings: settings,
        );
      case AppRoutes.register:
        return _buildRoute(
          const RegisterScreen(),
          settings: settings,
        );
      case AppRoutes.home:
        return _buildRoute(
          const HomeScreen(),
          settings: settings,
        );
      case AppRoutes.profile:
        return _buildRoute(
          const ProfileScreen(),
          settings: settings,
        );
      default:
        return _buildRoute(
          Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }

  /// Helper to build a standard [PageRoute].
  static PageRoute<dynamic> _buildRoute(
    Widget page, {
    required RouteSettings settings,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => page,
      settings: settings,
    );
  }

  /// Pushes a named route onto the navigator stack.
  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Replaces the current route with a named route.
  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  /// Pushes a named route and removes routes until [predicate] returns true.
  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  /// Pops the top-most route off the navigator.
  static void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }
}
