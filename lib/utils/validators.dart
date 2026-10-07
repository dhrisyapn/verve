/// Centralized input validation rules for forms and fields across the application.
abstract final class Validators {
  /// Validates full name presence and minimum length (at least 3 characters).
  static String? name(String? value, {int minLength = 3}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < minLength) {
      return 'Name must be at least $minLength characters';
    }
    return null;
  }

  /// Validates email address format and presence.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates phone number format and presence (exactly 10 digits, numbers only).
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    final trimmed = value.trim();
    if (!RegExp(r'^[0-9]+$').hasMatch(trimmed)) {
      return 'Phone number must contain numbers only';
    }
    if (trimmed.length != 10) {
      return 'Phone number must be exactly 10 digits';
    }
    return null;
  }

  /// Validates password presence and minimum length (minimum 6 characters).
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  /// Validates registration password requirements (minimum 6 characters).
  static String? registerPassword(String? value, {int minLength = 6}) {
    return password(value, minLength: minLength);
  }

  /// Validates required field presence.
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates that a confirmation password matches the primary password.
  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
