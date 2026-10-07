import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for managing secure persistent local storage.
class StorageService {
  StorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
              ),
            );

  final FlutterSecureStorage _storage;

  /// Writes a key-value pair to secure storage.
  Future<void> write({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a value by key from secure storage.
  Future<String?> read({required String key}) async {
    return _storage.read(key: key);
  }

  /// Deletes a key from secure storage.
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// Clears all keys in secure storage.
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Checks if a key exists in secure storage.
  Future<bool> containsKey({required String key}) async {
    return _storage.containsKey(key: key);
  }

  /// Reads all key-value pairs from secure storage.
  Future<Map<String, String>> readAll() async {
    return _storage.readAll();
  }
}

/// Common storage key constants.
abstract final class StorageKeys {
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
}

/// Riverpod provider for accessing [StorageService].
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});
