import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // -------------------------
  // Color Palette
  // -------------------------
  static const Color primaryColor = Color(0xFF6366F1); // Vibrant Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color backgroundColor = Color(
    0xFFF8FAFC,
  ); // Soft Slate/White ambient
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
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

  // -------------------------
  // Splash Screen Design Tokens
  // -------------------------
  static const Color splashBackgroundColor = Color(0xFFFAFAFA);
  static const Color splashCardBackground = Color(
    0xA6FFFFFF,
  ); // rgba(255, 255, 255, 0.65)
  static const Color splashCardBorder = Color(
    0xCCFFFFFF,
  ); // rgba(255, 255, 255, 0.80)
  static const Color splashCardShadow = Color(
    0x141F2687,
  ); // rgba(31, 38, 135, 0.08)
  static const Color splashTextColor = Color(0xFF0F172A);

  static const double splashCardRadius = 24.0;
  static const double splashCardSize = 96.0;
  static const double splashLogoSize = 88.0;
  static const double splashTitleSpacing = 32.0;
  static const double splashBlurSigma = 8.0;

  // Dark Theme Splash Tokens
  static const Color darkSplashBackgroundColor = Color(0xFF0F172A);
  static const Color darkSplashCardBackground = Color(0x26FFFFFF);
  static const Color darkSplashCardBorder = Color(0x33FFFFFF);
  static const Color darkSplashCardShadow = Color(0x33000000);

  /// Splash card glassmorphic decoration for light mode
  static BoxDecoration get splashCardDecoration => BoxDecoration(
    color: splashCardBackground,
    borderRadius: BorderRadius.circular(splashCardRadius),
    border: Border.all(color: splashCardBorder, width: 1.0),
    boxShadow: const [
      BoxShadow(
        color: splashCardShadow,
        blurRadius: 40.0,
        offset: Offset(0, 16),
      ),
    ],
  );

  /// Splash card glassmorphic decoration for dark mode
  static BoxDecoration get darkSplashCardDecoration => BoxDecoration(
    color: darkSplashCardBackground,
    borderRadius: BorderRadius.circular(splashCardRadius),
    border: Border.all(color: darkSplashCardBorder, width: 1.0),
    boxShadow: const [
      BoxShadow(
        color: darkSplashCardShadow,
        blurRadius: 40.0,
        offset: Offset(0, 16),
      ),
    ],
  );

  /// Splash brand title typography (Plus Jakarta Sans, 36px, 800 weight)
  static TextStyle get splashTitleStyle => GoogleFonts.plusJakartaSans(
    color: splashTextColor,
    fontSize: 36.0,
    fontWeight: FontWeight.w800,
    height: 1.11,
    letterSpacing: -0.5,
  );

  /// Splash brand title typography for dark theme
  static TextStyle get darkSplashTitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 36.0,
    fontWeight: FontWeight.w800,
    height: 1.11,
    letterSpacing: -0.5,
  );

  // -------------------------
  // Auth & Login Design Tokens
  // -------------------------
  static const Color authBackgroundColor = Colors.white; // Pure white background
  static const Color authBlue = Color(0xFF3B82F6); // Primary action blue
  static const Color authCardBackground = Colors.white;
  static const Color authCardBorder = Color(
    0xCCCACACA,
  ); // rgba(202, 202, 202, 0.80)
  static const Color authCardShadow = Color(0x0F0F172A);
  static const Color authFieldFill = Color(
    0xCCFFFFFF,
  ); // rgba(255, 255, 255, 0.80)
  static const Color authFieldBorder = Color(
    0xCCE2E8F0,
  ); // rgba(226, 232, 240, 0.80)
  static const Color authFieldBorderFocused = Color(0xFF3B82F6);
  static const Color authFieldHint = Color(0xFF9CA3AF);
  static const Color authFieldLabel = Color(0xFF0F172A);
  static const Color authButtonColor = Color(0xFF3B82F6);
  static const Color authButtonTextColor = Colors.white;
  static const Color authLogoBackground = Color(
    0xA6FFFFFF,
  ); // rgba(255, 255, 255, 0.65)
  static const Color authLogoBorder = Color(
    0xCCFFFFFF,
  ); // rgba(255, 255, 255, 0.80)
  static const Color authFooterText = Color(0xFF64748B);
  static const Color authFooterAction = Color(0xFF0F172A);

  // Auth Layout & Dimension Constants
  static const double authCardRadius = 24.0;
  static const double authFieldRadius = 12.0;
  static const double authButtonRadius = 12.0;
  static const double authLogoCardSize = 64.0;
  static const double authLogoIconSize = 34.0;
  static const double authLogoRadius = 16.0;
  static const double authCardPadding = 24.0;
  static const double authFieldSpacing = 20.0;
  static const double authLabelSpacing = 6.0;
  static const double authBlurSigma = 10.0;

  // Dark Theme Auth Tokens
  static const Color darkAuthBackgroundColor = Color(0xFF0F172A);
  static const Color darkAuthCardBackground = Color(0xB31E293B);
  static const Color darkAuthCardBorder = Color(0x4D475569);
  static const Color darkAuthCardShadow = Color(0x33000000);
  static const Color darkAuthFieldFill = Color(0x800F172A);
  static const Color darkAuthFieldBorder = Color(0x80334155);
  static const Color darkAuthFieldBorderFocused = Color(0xFF60A5FA);
  static const Color darkAuthFieldHint = Color(0xFF64748B);
  static const Color darkAuthFieldLabel = Color(0xFFF8FAFC);
  static const Color darkAuthLogoBackground = Color(0x33334155);
  static const Color darkAuthLogoBorder = Color(0x4D475569);
  static const Color darkAuthFooterText = Color(0xFF94A3B8);
  static const Color darkAuthFooterAction = Color(0xFFF8FAFC);

  /// Auth Screen Title Style
  static TextStyle get authTitleStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 30.0,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.3,
  );

  static TextStyle get darkAuthTitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 30.0,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.3,
  );

  /// Auth Screen Subtitle Style
  static TextStyle get authSubtitleStyle => GoogleFonts.plusJakartaSans(
    color: textSecondary,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.43,
  );

  static TextStyle get darkAuthSubtitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextSecondary,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.43,
  );

  /// Auth Form Field Label Style (Uppercase, 12px, Semi-Bold)
  static TextStyle get authFieldLabelStyle => GoogleFonts.plusJakartaSans(
    color: authFieldLabel,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.30,
    height: 1.33,
  );

  static TextStyle get darkAuthFieldLabelStyle => GoogleFonts.plusJakartaSans(
    color: darkAuthFieldLabel,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.30,
    height: 1.33,
  );

  /// Auth Form Field Text Style
  static TextStyle get authFieldInputStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get darkAuthFieldInputStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  /// Auth Form Field Hint Style
  static TextStyle get authFieldHintStyle => GoogleFonts.plusJakartaSans(
    color: authFieldHint,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get darkAuthFieldHintStyle => GoogleFonts.plusJakartaSans(
    color: darkAuthFieldHint,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  /// Auth Button Text Style
  static TextStyle get authButtonStyle => GoogleFonts.plusJakartaSans(
    color: authButtonTextColor,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.35,
    height: 1.43,
  );

  /// Auth Footer Prompt Style ("New to Verve?")
  static TextStyle get authFooterPromptStyle => GoogleFonts.plusJakartaSans(
    color: authFooterText,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.43,
  );

  static TextStyle get darkAuthFooterPromptStyle => GoogleFonts.plusJakartaSans(
    color: darkAuthFooterText,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.43,
  );

  /// Auth Footer Action Style ("Create an account")
  static TextStyle get authFooterActionStyle => GoogleFonts.plusJakartaSans(
    color: authFooterAction,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    height: 1.43,
  );

  static TextStyle get darkAuthFooterActionStyle => GoogleFonts.plusJakartaSans(
    color: darkAuthFooterAction,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    height: 1.43,
  );

  /// Auth Glassmorphic Card Decoration
  static BoxDecoration get authCardDecoration => BoxDecoration(
    color: authCardBackground,
    borderRadius: BorderRadius.circular(authCardRadius),
    border: Border.all(color: authCardBorder, width: 1.0),
    boxShadow: const [
      BoxShadow(color: authCardShadow, blurRadius: 32.0, offset: Offset(0, 12)),
    ],
  );

  static BoxDecoration get darkAuthCardDecoration => BoxDecoration(
    color: darkAuthCardBackground,
    borderRadius: BorderRadius.circular(authCardRadius),
    border: Border.all(color: darkAuthCardBorder, width: 1.0),
    boxShadow: const [
      BoxShadow(
        color: darkAuthCardShadow,
        blurRadius: 32.0,
        offset: Offset(0, 12),
      ),
    ],
  );

  /// Auth Logo Card Decoration
  static BoxDecoration get authLogoDecoration => BoxDecoration(
    color: authLogoBackground,
    borderRadius: BorderRadius.circular(authLogoRadius),
    border: Border.all(color: authLogoBorder, width: 1.0),
    boxShadow: const [
      BoxShadow(
        color: Color(0x0A0F172A),
        blurRadius: 16.0,
        offset: Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get darkAuthLogoDecoration => BoxDecoration(
    color: darkAuthLogoBackground,
    borderRadius: BorderRadius.circular(authLogoRadius),
    border: Border.all(color: darkAuthLogoBorder, width: 1.0),
    boxShadow: const [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 16.0,
        offset: Offset(0, 4),
      ),
    ],
  );

  /// Auth Button Style
  static ButtonStyle get authPrimaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: authButtonColor,
    foregroundColor: authButtonTextColor,
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
    textStyle: authButtonStyle,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(authButtonRadius),
    ),
  );
}
