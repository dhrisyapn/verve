import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verve/router/app_router.dart';
import 'package:verve/services/storage_service.dart';
import 'package:verve/theme/app_theme.dart';

/// Splash screen displaying the standalone Verve logo and identity
/// over a clean background with subtle entrance animation.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.90, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
    _scheduleNavigation();
  }

  void _scheduleNavigation() {
    _navigationTimer = Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      _navigateToNext();
    });
  }

  Future<void> _navigateToNext() async {
    try {
      final storage = ref.read(storageServiceProvider);
      final token = await storage.read(key: StorageKeys.authToken);
      if (!mounted) return;

      final targetRoute = (token != null && token.isNotEmpty)
          ? AppRoutes.home
          : AppRoutes.login;

      await AppRouter.pushReplacementNamed(targetRoute);
    } catch (_) {
      if (!mounted) return;
      await AppRouter.pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.splashBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
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
        ),
      ),
    );
  }
}
