import 'package:flutter_test/flutter_test.dart';
import 'package:verve/utils/validators.dart';

void main() {
  group('Validators Unit Tests', () {
    group('email', () {
      test('returns error when email is null or empty', () {
        expect(Validators.email(null), 'Please enter your email address');
        expect(Validators.email(''), 'Please enter your email address');
        expect(Validators.email('   '), 'Please enter your email address');
      });

      test('returns error for invalid email formats', () {
        expect(Validators.email('plainaddress'), 'Please enter a valid email address');
        expect(Validators.email('@missingusername.com'), 'Please enter a valid email address');
        expect(Validators.email('user@.com'), 'Please enter a valid email address');
        expect(Validators.email('user@domain'), 'Please enter a valid email address');
      });

      test('returns null for valid email address', () {
        expect(Validators.email('hello@verve.app'), isNull);
        expect(Validators.email('test.user+tag@domain.co.uk'), isNull);
      });
    });

    group('password', () {
      test('returns error when password is null or empty', () {
        expect(Validators.password(null), 'Please enter your password');
        expect(Validators.password(''), 'Please enter your password');
      });

      test('returns error when password is shorter than minLength', () {
        expect(Validators.password('12345'), 'Password must be at least 6 characters');
        expect(Validators.password('abc', minLength: 8), 'Password must be at least 8 characters');
      });

      test('returns null for valid password', () {
        expect(Validators.password('123456'), isNull);
        expect(Validators.password('securePassword123!'), isNull);
      });
    });

    group('required', () {
      test('returns error when value is null or whitespace', () {
        expect(Validators.required(null), 'This field is required');
        expect(Validators.required(''), 'This field is required');
        expect(Validators.required('   ', fieldName: 'Full name'), 'Full name is required');
      });

      test('returns null for valid string', () {
        expect(Validators.required('John Doe'), isNull);
      });
    });

    group('confirmPassword', () {
      test('returns error when confirmation is empty', () {
        expect(Validators.confirmPassword(null, 'secret123'), 'Please confirm your password');
        expect(Validators.confirmPassword('', 'secret123'), 'Please confirm your password');
      });

      test('returns error when passwords do not match', () {
        expect(Validators.confirmPassword('secret456', 'secret123'), 'Passwords do not match');
      });

      test('returns null when passwords match', () {
        expect(Validators.confirmPassword('secret123', 'secret123'), isNull);
      });
    });

    group('name', () {
      test('returns error when name is null, empty, or too short', () {
        expect(Validators.name(null), 'Please enter your full name');
        expect(Validators.name(''), 'Please enter your full name');
        expect(Validators.name('   '), 'Please enter your full name');
        expect(Validators.name('J'), 'Name must be at least 2 characters');
      });

      test('returns null for valid full name', () {
        expect(Validators.name('John Doe'), isNull);
        expect(Validators.name('Drishya'), isNull);
      });
    });

    group('phone', () {
      test('returns error when phone is null, empty, or invalid', () {
        expect(Validators.phone(null), 'Please enter your phone number');
        expect(Validators.phone(''), 'Please enter your phone number');
        expect(Validators.phone('   '), 'Please enter your phone number');
        expect(Validators.phone('123'), 'Please enter a valid phone number');
        expect(Validators.phone('abc-def-ghij'), 'Please enter a valid phone number');
      });

      test('returns null for valid phone numbers', () {
        expect(Validators.phone('+1 (555) 000-0000'), isNull);
        expect(Validators.phone('9876543210'), isNull);
        expect(Validators.phone('+91 9876543210'), isNull);
      });
    });

    group('registerPassword', () {
      test('returns error when password is null or empty', () {
        expect(Validators.registerPassword(null), 'Please enter your password');
        expect(Validators.registerPassword(''), 'Please enter your password');
      });

      test('returns error when password is shorter than 8 characters', () {
        expect(Validators.registerPassword('1234567'), 'Password must be at least 8 characters');
      });

      test('returns null for valid register password', () {
        expect(Validators.registerPassword('12345678'), isNull);
        expect(Validators.registerPassword('securePassword123!'), isNull);
      });
    });
  });
}
