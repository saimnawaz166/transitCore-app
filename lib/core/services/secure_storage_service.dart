import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Thin wrapper over [FlutterSecureStorage] so the rest of the app never
/// touches SharedPreferences for anything token-shaped. Backed by Keychain
/// on iOS and EncryptedSharedPreferences on Android.
class SecureStorageService {
  SecureStorageService()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        );

  final FlutterSecureStorage _storage;

  static const _tokenKey = 'auth_token';
  static const _driverIdKey = 'driver_id';

  Future<void> saveSession({required String token, required String driverId}) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _driverIdKey, value: driverId);
  }

  Future<(String, String)?> readSession() async {
    final token = await _storage.read(key: _tokenKey);
    final driverId = await _storage.read(key: _driverIdKey);
    if (token == null || driverId == null) return null;
    return (token, driverId);
  }

  Future<void> clearSession() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _driverIdKey);
  }
}
