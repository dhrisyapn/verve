import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/services/storage_service.dart';
import 'package:verve/theme/app_theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _scheduleNavigation();
  }

  void _scheduleNavigation() {
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      _navigateToNext();
    });
  }

  Future<void> _navigateToNext() async {
    try {
      final storage = ref.read(storageServiceProvider);
      final currentUser = await storage.getCurrentUser();
      if (!mounted) return;

      if (currentUser != null) {
        ref.read(currentUserProvider.notifier).setUser(currentUser);
        await AppRouter.pushReplacementNamed(AppRoutes.home);
      } else {
        ref.read(currentUserProvider.notifier).clearUser();
        await AppRouter.pushReplacementNamed(AppRoutes.login);
      }
    } catch (_) {
      if (!mounted) return;
      ref.read(currentUserProvider.notifier).clearUser();
      await AppRouter.pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.splashBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Verve Standalone Logo Image
            Image.asset(
              'assets/logo-app.png',
              width: AppTheme.splashLogoSize,
              height: AppTheme.splashLogoSize,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: AppTheme.splashTitleSpacing),
            // Verve Brand Title
            Text('Verve', style: AppTheme.splashTitleStyle),
          ],
        ),
      ),
    );
  }
}
