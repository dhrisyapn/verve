import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verve/models/user_model.dart';

/// Service for managing local storage:
/// - SharedPreferences for general persisted user list (userdata list).
/// - FlutterSecureStorage for active session (current user and auth tokens).
class StorageService {
  StorageService({
    FlutterSecureStorage? storage,
    this.preferences,
  }) : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
              ),
            );

  final FlutterSecureStorage _storage;
  SharedPreferences? preferences;

  Future<SharedPreferences> _getPrefs() async {
    return preferences ??= await SharedPreferences.getInstance();
  }

  /// Writes a key-value pair to secure storage.
  Future<void> write({required String key, required String value}) async {
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

  /// Retrieves the list of all registered users from SharedPreferences.
  Future<List<UserModel>> getUsers() async {
    final prefs = await _getPrefs();
    var rawJson = prefs.getString(StorageKeys.usersList);

    // Gracefully migrate from legacy secure storage if not yet in SharedPreferences
    if (rawJson == null || rawJson.trim().isEmpty) {
      rawJson = await read(key: StorageKeys.usersList);
      if (rawJson != null && rawJson.trim().isNotEmpty) {
        await prefs.setString(StorageKeys.usersList, rawJson);
        await delete(key: StorageKeys.usersList);
      }
    }

    if (rawJson == null || rawJson.trim().isEmpty) {
      return <UserModel>[];
    }
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is List) {
        return decoded
            .whereType<Map<String, dynamic>>()
            .map((item) => UserModel.fromJson(item))
            .toList();
      }
    } catch (_) {
      // In case of corrupt or invalid JSON
    }
    return <UserModel>[];
  }

  /// Persists the full list of registered users to SharedPreferences.
  Future<void> saveUsers(List<UserModel> users) async {
    final prefs = await _getPrefs();
    final jsonList = users.map((user) => user.toJson()).toList();
    await prefs.setString(
      StorageKeys.usersList,
      jsonEncode(jsonList),
    );
  }

  /// Appends or updates a user in the registered users list within SharedPreferences.
  Future<void> saveUserToList(UserModel user) async {
    final users = await getUsers();
    final index = users.indexWhere(
      (u) => u.email.trim().toLowerCase() == user.email.trim().toLowerCase(),
    );
    if (index >= 0) {
      users[index] = user;
    } else {
      users.add(user);
    }
    await saveUsers(users);
  }

  /// Checks whether a user with the specified email already exists in SharedPreferences.
  Future<bool> userExistsWithEmail(String email) async {
    final users = await getUsers();
    final normalized = email.trim().toLowerCase();
    return users.any((u) => u.email.trim().toLowerCase() == normalized);
  }

  /// Clears the userdata list from SharedPreferences.
  Future<void> clearUsersList() async {
    final prefs = await _getPrefs();
    await prefs.remove(StorageKeys.usersList);
  }

  /// Retrieves the currently authenticated user from secure storage.
  Future<UserModel?> getCurrentUser() async {
    final rawJson = await read(key: StorageKeys.currentUser);
    if (rawJson == null || rawJson.trim().isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is Map<String, dynamic>) {
        return UserModel.fromJson(decoded);
      }
    } catch (_) {
      // Corrupt or invalid JSON
    }
    return null;
  }

  /// Persists the currently authenticated user to secure storage.
  Future<void> saveCurrentUser(UserModel user) async {
    await write(
      key: StorageKeys.currentUser,
      value: jsonEncode(user.toJson()),
    );
  }

  /// Deletes the currently authenticated user data from secure storage.
  Future<void> deleteCurrentUser() async {
    await delete(key: StorageKeys.currentUser);
  }
}

/// Common storage key constants.
abstract final class StorageKeys {
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
  static const String userPhone = 'user_phone';
  static const String usersList = 'userdata_list';
  static const String currentUser = 'current_user';
  static const String themeMode = 'theme_mode';
}

/// Riverpod provider for accessing [StorageService].
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

/// State notifier for managing the currently logged-in [UserModel] in memory.
class CurrentUserNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() => null;

  /// Sets the currently active user in state.
  void setUser(UserModel? user) {
    state = user;
  }

  /// Clears the currently active user from state (resets to null).
  void clearUser() {
    state = null;
  }

  /// Clears provider state and deletes currentuser data and session tokens from storage.
  Future<void> signOut() async {
    state = null;
    try {
      final storage = ref.read(storageServiceProvider);
      await storage.deleteCurrentUser();
      await storage.delete(key: StorageKeys.authToken);
      await storage.delete(key: StorageKeys.userEmail);
      await storage.delete(key: StorageKeys.userId);
      await storage.delete(key: StorageKeys.userName);
      await storage.delete(key: StorageKeys.userPhone);
    } catch (_) {
      // Ensure provider state is cleared regardless of storage errors
      state = null;
    }
  }
}

/// Riverpod provider for reactive access to the current authenticated [UserModel].
final currentUserProvider =
    NotifierProvider<CurrentUserNotifier, UserModel?>(CurrentUserNotifier.new);

