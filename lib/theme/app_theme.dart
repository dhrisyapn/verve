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
  static const Color authBackgroundColor = Color(
    0xFFFAFAFA,
  ); // Soft ambient background #FAFAFA
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

  // Register Screen Layout & Dimension Constants
  static const double registerLogoSize = 48.0;
  static const double registerCardPadding = 20.0;
  static const double registerFieldSpacing = 16.0;

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

  /// Register Screen Title Style (24px, Bold, #0F172A)
  static TextStyle get registerTitleStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    height: 1.33,
    letterSpacing: -0.2,
  );

  static TextStyle get darkRegisterTitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    height: 1.33,
    letterSpacing: -0.2,
  );

  /// Register Screen Subtitle Style (12px, Medium, #64748B)
  static TextStyle get registerSubtitleStyle => GoogleFonts.plusJakartaSans(
    color: textSecondary,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  static TextStyle get darkRegisterSubtitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextSecondary,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  /// Register Footer Prompt Style (12px, Medium, #64748B)
  static TextStyle get registerFooterPromptStyle => GoogleFonts.plusJakartaSans(
    color: authFooterText,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  static TextStyle get darkRegisterFooterPromptStyle =>
      GoogleFonts.plusJakartaSans(
        color: darkAuthFooterText,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        height: 1.33,
      );

  /// Register Footer Action Style (12px, Bold, #0F172A)
  static TextStyle get registerFooterActionStyle => GoogleFonts.plusJakartaSans(
    color: authFooterAction,
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    height: 1.33,
  );

  static TextStyle get darkRegisterFooterActionStyle =>
      GoogleFonts.plusJakartaSans(
        color: darkAuthFooterAction,
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        height: 1.33,
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

  // -------------------------
  // Home Screen Design Tokens
  // -------------------------
  static const double homePadding = 24.0;
  static const double homeCardRadius = 24.0;
  static const double homeActionCardRadius = 16.0;
  static const double homeTaskCardRadius = 16.0;
  static const double homeLogoSize = 36.0;
  static const double homeAvatarSize = 40.0;
  static const double homeActionIconCircleSize = 48.0;
  static const double homeActionIconSize = 24.0;
  static const double homeCheckboxSize = 22.0;
  static const double homeCheckboxRadius = 6.0;
  static const double homeBadgeRadius = 6.0;
  static const double homeBadgeHorizontalPadding = 10.0;
  static const double homeBadgeVerticalPadding = 4.0;
  static const double homeActionCardVerticalPadding = 16.0;
  static const double homeActionCardHorizontalPadding = 12.0;
  static const double homeTaskCardPadding = 16.0;
  static const double homeCardSpacing = 12.0;

  static const Color homeBlue = Color(0xFF3B82F6);
  static const Color homeDarkBlue = Color(0xFF60A5FA);
  static const Color homeCardBackground = Color(
    0xA6FFFFFF,
  ); // rgba(255, 255, 255, 0.65)
  static const Color darkHomeCardBackground = Color(0xB31E293B);
  static const Color homeCardBorder = Color(
    0xCCCACACA,
  ); // rgba(202, 202, 202, 0.80)
  static const Color darkHomeCardBorder = Color(0x4D475569);
  static const Color homeActionCardBackground = Color(
    0x66FFFFFF,
  ); // rgba(255, 255, 255, 0.40)
  static const Color darkHomeActionCardBackground = Color(0x661E293B);
  static const Color homeActionCardBorder = Color(
    0x99CACACA,
  ); // rgba(202, 202, 202, 0.60)
  static const Color darkHomeActionCardBorder = Color(0x4D475569);
  static const Color homeTaskCardBackground = Color(
    0x66FFFFFF,
  ); // rgba(255, 255, 255, 0.40)
  static const Color darkHomeTaskCardBackground = Color(0x661E293B);
  static const Color homeTaskCardBorder = Color(
    0x99CACACA,
  ); // rgba(202, 202, 202, 0.60)
  static const Color darkHomeTaskCardBorder = Color(0x4D475569);
  static const Color homeBadgeBackground = Color(0xFFEFF6FF);
  static const Color darkHomeBadgeBackground = Color(0x333B82F6);
  static const Color homeBadgeText = Color(0xFF3B82F6);
  static const Color darkHomeBadgeText = Color(0xFF60A5FA);
  static const Color homeCheckboxBorder = Color(0xFFCBD5E1);
  static const Color darkHomeCheckboxBorder = Color(0xFF475569);
  static const Color homeAvatarColor = Color(0xFF3B82F6);
  static const Color homeCardShadow = Color(0x0D0F172A);
  static const Color darkHomeCardShadow = Color(0x33000000);
  static const Color homeActionIconCircleBg = Colors.white;
  static const Color darkHomeActionIconCircleBg = Color(0xFF334155);
  static const Color homeActionIconBorder = Color(0x33E2E8F0);
  static const Color darkHomeActionIconBorder = Color(0x4D475569);
  static const Color homeActionIconColor = Color(0xFF3B82F6);
  static const Color darkHomeActionIconColor = Color(0xFF60A5FA);
  static const Color homeTaskTimeColor = Color(0xFF64748B);
  static const Color darkHomeTaskTimeColor = Color(0xFF94A3B8);
  static const Color homeTaskCheckedFill = Color(0xFF3B82F6);
  static const Color darkHomeTaskCheckedFill = Color(0xFF60A5FA);
  static const Color homeTaskCheckedIconColor = Colors.white;
  static const Color darkHomeTaskCheckedIconColor = Color(0xFF0F172A);

  // Home Screen Typography
  static TextStyle get homeDateStyle => GoogleFonts.plusJakartaSans(
    color: textSecondary,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.43,
  );

  static TextStyle get darkHomeDateStyle => GoogleFonts.plusJakartaSans(
    color: darkTextSecondary,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.43,
  );

  static TextStyle get homeGreetingStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 30.0,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -0.3,
  );

  static TextStyle get darkHomeGreetingStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 30.0,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -0.3,
  );

  static TextStyle get homeInsightTitleStyle => GoogleFonts.plusJakartaSans(
    color: textSecondary,
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.60,
    height: 1.33,
  );

  static TextStyle get darkHomeInsightTitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextSecondary,
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.60,
    height: 1.33,
  );

  static TextStyle get homeInsightTextStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    height: 1.33,
  );

  static TextStyle get darkHomeInsightTextStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    height: 1.33,
  );

  static TextStyle get homeInsightHighlightStyle => GoogleFonts.plusJakartaSans(
    color: homeBlue,
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    height: 1.33,
  );

  static TextStyle get darkHomeInsightHighlightStyle =>
      GoogleFonts.plusJakartaSans(
        color: homeDarkBlue,
        fontSize: 24.0,
        fontWeight: FontWeight.w800,
        height: 1.33,
      );

  static TextStyle get homeInsightSubtitleStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.43,
  );

  static TextStyle get darkHomeInsightSubtitleStyle =>
      GoogleFonts.plusJakartaSans(
        color: darkTextPrimary,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 1.43,
      );

  static TextStyle get homeActionTitleStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  static TextStyle get darkHomeActionTitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  static TextStyle get homeSectionTitleStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    height: 1.55,
  );

  static TextStyle get darkHomeSectionTitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    height: 1.55,
  );

  static TextStyle get homeSeeAllStyle => GoogleFonts.plusJakartaSans(
    color: homeBlue,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  static TextStyle get darkHomeSeeAllStyle => GoogleFonts.plusJakartaSans(
    color: homeDarkBlue,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  static TextStyle get homeTaskTitleStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  static TextStyle get darkHomeTaskTitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  static TextStyle get homeTaskTitleCompletedStyle =>
      GoogleFonts.plusJakartaSans(
        color: textSecondary,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 1.43,
        decoration: TextDecoration.lineThrough,
      );

  static TextStyle get darkHomeTaskTitleCompletedStyle =>
      GoogleFonts.plusJakartaSans(
        color: darkTextSecondary,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 1.43,
        decoration: TextDecoration.lineThrough,
      );

  static TextStyle get homeTaskTimeStyle => GoogleFonts.plusJakartaSans(
    color: homeTaskTimeColor,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static TextStyle get darkHomeTaskTimeStyle => GoogleFonts.plusJakartaSans(
    color: darkHomeTaskTimeColor,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static TextStyle get homeTaskTagStyle => GoogleFonts.plusJakartaSans(
    color: homeBadgeText,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static TextStyle get darkHomeTaskTagStyle => GoogleFonts.plusJakartaSans(
    color: darkHomeBadgeText,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static TextStyle get homeAvatarTextStyle => GoogleFonts.inter(
    color: const Color(0xFFFAFAFA),
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  );

  // Home Screen Decorations (Flat, zero shadows per project guidelines)
  static BoxDecoration get homeInsightCardDecoration => BoxDecoration(
    color: homeCardBackground,
    borderRadius: BorderRadius.circular(homeCardRadius),
    border: Border.all(color: homeCardBorder, width: 1.0),
  );

  static BoxDecoration get darkHomeInsightCardDecoration => BoxDecoration(
    color: darkHomeCardBackground,
    borderRadius: BorderRadius.circular(homeCardRadius),
    border: Border.all(color: darkHomeCardBorder, width: 1.0),
  );

  static BoxDecoration get homeActionCardDecoration => BoxDecoration(
    color: homeActionCardBackground,
    borderRadius: BorderRadius.circular(homeActionCardRadius),
    border: Border.all(color: homeActionCardBorder, width: 1.0),
  );

  static BoxDecoration get darkHomeActionCardDecoration => BoxDecoration(
    color: darkHomeActionCardBackground,
    borderRadius: BorderRadius.circular(homeActionCardRadius),
    border: Border.all(color: darkHomeActionCardBorder, width: 1.0),
  );

  static BoxDecoration get homeActionIconDecoration => BoxDecoration(
    color: homeActionIconCircleBg,
    shape: BoxShape.circle,
    border: Border.all(color: homeActionIconBorder, width: 1.0),
  );

  static BoxDecoration get darkHomeActionIconDecoration => BoxDecoration(
    color: darkHomeActionIconCircleBg,
    shape: BoxShape.circle,
    border: Border.all(color: darkHomeActionIconBorder, width: 1.0),
  );

  static BoxDecoration get homeTaskCardDecoration => BoxDecoration(
    color: homeTaskCardBackground,
    borderRadius: BorderRadius.circular(homeTaskCardRadius),
    border: Border.all(color: homeTaskCardBorder, width: 1.0),
  );

  static BoxDecoration get darkHomeTaskCardDecoration => BoxDecoration(
    color: darkHomeTaskCardBackground,
    borderRadius: BorderRadius.circular(homeTaskCardRadius),
    border: Border.all(color: darkHomeTaskCardBorder, width: 1.0),
  );

  static BoxDecoration get homeTaskTagDecoration => BoxDecoration(
    color: homeBadgeBackground,
    borderRadius: BorderRadius.circular(homeBadgeRadius),
  );

  static BoxDecoration get darkHomeTaskTagDecoration => BoxDecoration(
    color: darkHomeBadgeBackground,
    borderRadius: BorderRadius.circular(homeBadgeRadius),
  );

  static BoxDecoration get homeAvatarDecoration => BoxDecoration(
    color: homeAvatarColor,
    shape: BoxShape.circle,
    border: Border.all(color: Colors.white, width: 2.0),
  );

  static BoxDecoration get darkHomeAvatarDecoration => BoxDecoration(
    color: homeAvatarColor,
    shape: BoxShape.circle,
    border: Border.all(color: darkSurfaceColor, width: 2.0),
  );

  static BoxDecoration get homeCheckboxUncheckedDecoration => BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(homeCheckboxRadius),
    border: Border.all(color: homeCheckboxBorder, width: 2.0),
  );

  static BoxDecoration get darkHomeCheckboxUncheckedDecoration => BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(homeCheckboxRadius),
    border: Border.all(color: darkHomeCheckboxBorder, width: 2.0),
  );

  static BoxDecoration get homeCheckboxCheckedDecoration => BoxDecoration(
    color: homeTaskCheckedFill,
    borderRadius: BorderRadius.circular(homeCheckboxRadius),
    border: Border.all(color: homeTaskCheckedFill, width: 2.0),
  );

  static BoxDecoration get darkHomeCheckboxCheckedDecoration => BoxDecoration(
    color: darkHomeTaskCheckedFill,
    borderRadius: BorderRadius.circular(homeCheckboxRadius),
    border: Border.all(color: darkHomeTaskCheckedFill, width: 2.0),
  );

  // Home Screen Modal & Chip Tokens
  static const Color homeModalBackground = Colors.white;
  static const Color darkHomeModalBackground = Color(0xFF1E293B);
  static const Color homeChipBackground = Color(0xFFF1F5F9);
  static const Color darkHomeChipBackground = Color(0xFF334155);
  static const Color homeChipSelectedBackground = Color(0xFF3B82F6);
  static const Color darkHomeChipSelectedBackground = Color(0xFF3B82F6);

  static TextStyle get homeModalTitleStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get darkHomeModalTitleStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get homeChipTextStyle => GoogleFonts.plusJakartaSans(
    color: textSecondary,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get darkHomeChipTextStyle => GoogleFonts.plusJakartaSans(
    color: darkTextSecondary,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get homeChipSelectedTextStyle => GoogleFonts.plusJakartaSans(
    color: Colors.white,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get darkHomeChipSelectedTextStyle =>
      GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
      );

  static BoxDecoration get homeModalDecoration => const BoxDecoration(
    color: homeModalBackground,
    borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
  );

  static BoxDecoration get darkHomeModalDecoration => const BoxDecoration(
    color: darkHomeModalBackground,
    borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
  );

  // -------------------------
  // Profile Screen Design Tokens
  // -------------------------
  static const double profileAvatarSize = 112.0;
  static const double profileAvatarBadgeSize = 32.0;
  static const double profileItemIconSize = 40.0;
  static const double profileBackButtonSize = 40.0;
  static const double profileCardRadius = 24.0;
  static const double profileBackButtonRadius = 12.0;
  static const double profileSignOutRadius = 16.0;

  static const Color profileBackButtonBg = Color(
    0xA6FFFFFF,
  ); // rgba(255, 255, 255, 0.65)
  static const Color darkProfileBackButtonBg = Color(0x33334155);
  static const Color profileBackButtonBorder = Color(
    0xCCCACACA,
  ); // rgba(202, 202, 202, 0.80)
  static const Color darkProfileBackButtonBorder = Color(0x4D475569);

  static const Color profileAvatarBg = Color(0xFF3B82F6);
  static const Color profileAvatarBadgeBg = Colors.white;
  static const Color darkProfileAvatarBadgeBg = Color(0xFF1E293B);
  static const Color profileAvatarBadgeBorder = Color(0xFFF3F4F6);
  static const Color darkProfileAvatarBadgeBorder = Color(0xFF334155);

  static const Color profileCardBg = Color(
    0xA6FFFFFF,
  ); // rgba(255, 255, 255, 0.65)
  static const Color darkProfileCardBg = Color(0xB31E293B);
  static const Color profileCardBorder = Color(
    0xCCCACACA,
  ); // rgba(202, 202, 202, 0.80)
  static const Color darkProfileCardBorder = Color(0x4D475569);

  static const Color profileIconBg = Color(0xFFEFF6FF);
  static const Color darkProfileIconBg = Color(0x333B82F6);
  static const Color profileIconColor = Color(0xFF3B82F6);
  static const Color darkProfileIconColor = Color(0xFF60A5FA);

  static const Color profileDividerColor = Color(
    0x99E2E8F0,
  ); // rgba(226, 232, 240, 0.60)
  static const Color darkProfileDividerColor = Color(0x33475569);

  static const Color profileSignOutBg = Color(
    0xA6FFFFFF,
  ); // rgba(255, 255, 255, 0.65)
  static const Color darkProfileSignOutBg = Color(0x331E293B);
  static const Color profileSignOutBorder = Color(0xFFFFE4E6); // #FFE4E6
  static const Color darkProfileSignOutBorder = Color(0x66F43F5E);
  static const Color profileSignOutText = Color(0xFFF43F5E); // #F43F5E
  static const Color darkProfileSignOutText = Color(0xFFFB7185);

  // Profile Screen Typography
  static TextStyle get profileAppBarTitleStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    height: 1.55,
  );

  static TextStyle get darkProfileAppBarTitleStyle =>
      GoogleFonts.plusJakartaSans(
        color: darkTextPrimary,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
        height: 1.55,
      );

  static TextStyle get profileNameStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    height: 1.33,
  );

  static TextStyle get darkProfileNameStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    height: 1.33,
  );

  static TextStyle get profileItemLabelStyle => GoogleFonts.plusJakartaSans(
    color: textSecondary,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.50,
    height: 1.5,
  );

  static TextStyle get darkProfileItemLabelStyle => GoogleFonts.plusJakartaSans(
    color: darkTextSecondary,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.50,
    height: 1.5,
  );

  static TextStyle get profileItemValueStyle => GoogleFonts.plusJakartaSans(
    color: textPrimary,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  static TextStyle get darkProfileItemValueStyle => GoogleFonts.plusJakartaSans(
    color: darkTextPrimary,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  static TextStyle get profileSignOutStyle => GoogleFonts.plusJakartaSans(
    color: profileSignOutText,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static TextStyle get darkProfileSignOutStyle => GoogleFonts.plusJakartaSans(
    color: darkProfileSignOutText,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static TextStyle get profileAvatarTextStyle => GoogleFonts.plusJakartaSans(
    color: Colors.white,
    fontSize: 48.0,
    fontWeight: FontWeight.w800,
    height: 1.0,
  );

  // Profile Screen Decorations (Strictly Flat, Zero Shadows)
  static BoxDecoration get profileBackButtonDecoration => BoxDecoration(
    color: profileBackButtonBg,
    borderRadius: BorderRadius.circular(profileBackButtonRadius),
    border: Border.all(color: profileBackButtonBorder, width: 1.0),
  );

  static BoxDecoration get darkProfileBackButtonDecoration => BoxDecoration(
    color: darkProfileBackButtonBg,
    borderRadius: BorderRadius.circular(profileBackButtonRadius),
    border: Border.all(color: darkProfileBackButtonBorder, width: 1.0),
  );

  static BoxDecoration get profileAvatarDecoration =>
      const BoxDecoration(color: profileAvatarBg, shape: BoxShape.circle);

  static BoxDecoration get darkProfileAvatarDecoration =>
      const BoxDecoration(color: profileAvatarBg, shape: BoxShape.circle);

  static BoxDecoration get profileAvatarBadgeDecoration => BoxDecoration(
    color: profileAvatarBadgeBg,
    shape: BoxShape.circle,
    border: Border.all(color: profileAvatarBadgeBorder, width: 1.0),
  );

  static BoxDecoration get darkProfileAvatarBadgeDecoration => BoxDecoration(
    color: darkProfileAvatarBadgeBg,
    shape: BoxShape.circle,
    border: Border.all(color: darkProfileAvatarBadgeBorder, width: 1.0),
  );

  static BoxDecoration get profileCardDecoration => BoxDecoration(
    color: profileCardBg,
    borderRadius: BorderRadius.circular(profileCardRadius),
    border: Border.all(color: profileCardBorder, width: 1.0),
  );

  static BoxDecoration get darkProfileCardDecoration => BoxDecoration(
    color: darkProfileCardBg,
    borderRadius: BorderRadius.circular(profileCardRadius),
    border: Border.all(color: darkProfileCardBorder, width: 1.0),
  );

  static BoxDecoration get profileItemIconDecoration =>
      const BoxDecoration(color: profileIconBg, shape: BoxShape.circle);

  static BoxDecoration get darkProfileItemIconDecoration =>
      const BoxDecoration(color: darkProfileIconBg, shape: BoxShape.circle);

  static BoxDecoration get profileSignOutDecoration => BoxDecoration(
    color: profileSignOutBg,
    borderRadius: BorderRadius.circular(profileSignOutRadius),
    border: Border.all(color: profileSignOutBorder, width: 1.0),
  );

  static BoxDecoration get darkProfileSignOutDecoration => BoxDecoration(
    color: darkProfileSignOutBg,
    borderRadius: BorderRadius.circular(profileSignOutRadius),
    border: Border.all(color: darkProfileSignOutBorder, width: 1.0),
  );
}
