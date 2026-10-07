import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // -------------------------
  // Color Palette
  // -------------------------
  static const Color primaryColor = Color(0xFF6366F1); // Vibrant Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color backgroundColor = Color(0xFFF8FAFC); // Soft Slate/White ambient
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFEF4444);

  // Typography Colors
  static const Color textPrimary = Color(0xFF0F172A); // Deep Slate
  static const Color textSecondary = Color(0xFF64748B); // Muted Slate

  // Component Colors
  static const Color inputFillColor = Color(0xFFF1F5F9);
  static const Color borderColor = Color(0xFFE2E8F0);

  // Shared Constants
  static const double borderRadius = 16.0;

  // Dark Theme Palette
  static const Color darkBackgroundColor = Color(0xFF0F172A);
  static const Color darkSurfaceColor = Color(0xFF1E293B);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkInputFillColor = Color(0xFF1E293B);
  static const Color darkBorderColor = Color(0xFF334155);

  // -------------------------
  // ThemeData Definition
  // -------------------------
  static ThemeData get lightTheme {
    final fontName = GoogleFonts.plusJakartaSans().fontFamily;

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontName,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryLight,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSurface: textPrimary,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Text Theme
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
          displayMedium: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
          headlineLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          titleLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          bodyLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: textSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          labelLarge: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Input Decoration (Text Fields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintStyle: const TextStyle(
          color: textSecondary,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: errorColor, width: 1.0),
        ),
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),

      // Card Theme (Used for Dashboard & Profile)
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: const BorderSide(color: borderColor, width: 1),
        ),
      ),

      // SnackBar Theme (Premium Toast Notifications)
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: textPrimary, // Dark, high-contrast look
        contentTextStyle: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 24,
      ),
    );
  }

  // -------------------------
  // Dark Theme Definition
  // -------------------------
  static ThemeData get darkTheme {
    final fontName = GoogleFonts.plusJakartaSans().fontFamily;

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontName,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: primaryLight,
        surface: darkSurfaceColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSurface: darkTextPrimary,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkTextPrimary),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Text Theme
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: darkTextPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
          displayMedium: TextStyle(
            color: darkTextPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
          headlineLarge: TextStyle(
            color: darkTextPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          titleLarge: TextStyle(
            color: darkTextPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          bodyLarge: TextStyle(
            color: darkTextPrimary,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: darkTextSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          labelLarge: TextStyle(
            color: primaryLight,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Input Decoration (Text Fields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkInputFillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintStyle: const TextStyle(
          color: darkTextSecondary,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: errorColor, width: 1.0),
        ),
        prefixIconColor: darkTextSecondary,
        suffixIconColor: darkTextSecondary,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryLight,
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),

      // Card Theme (Used for Dashboard & Profile)
      cardTheme: CardThemeData(
        color: darkSurfaceColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: const BorderSide(color: darkBorderColor, width: 1),
        ),
      ),

      // SnackBar Theme (Premium Toast Notifications)
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkSurfaceColor,
        contentTextStyle: GoogleFonts.plusJakartaSans(
          color: darkTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: darkBorderColor,
        thickness: 1,
        space: 24,
      ),
    );
  }
}
