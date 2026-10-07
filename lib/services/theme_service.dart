import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verve/services/storage_service.dart';

/// State notifier managing the application's active [ThemeMode].
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _initTheme();
    return ThemeMode.light;
  }

  Future<void> _initTheme() async {
    try {
      final storage = ref.read(storageServiceProvider);
      final savedTheme = await storage.read(key: StorageKeys.themeMode);
      if (savedTheme == 'dark') {
        state = ThemeMode.dark;
      } else if (savedTheme == 'light') {
        state = ThemeMode.light;
      }
    } catch (_) {
      // Fallback gracefully to light mode
    }
  }

  Future<void> toggleTheme() async {
    final nextMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = nextMode;
    try {
      final storage = ref.read(storageServiceProvider);
      await storage.write(
        key: StorageKeys.themeMode,
        value: nextMode == ThemeMode.dark ? 'dark' : 'light',
      );
    } catch (_) {
      // Ignore storage errors to keep UI responsive
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    if (state == mode) return;
    state = mode;
    try {
      final storage = ref.read(storageServiceProvider);
      await storage.write(
        key: StorageKeys.themeMode,
        value: mode == ThemeMode.dark ? 'dark' : 'light',
      );
    } catch (_) {
      // Ignore storage errors
    }
  }
}

/// Riverpod provider for active [ThemeMode].
final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
