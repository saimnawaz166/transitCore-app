import 'dart:async';

import '../../../core/services/secure_storage_service.dart';
import '../domain/auth_repository.dart';
import '../domain/driver_session.dart';

/// Fake auth backend: accepts any non-empty credentials, "persists" the
/// session via [SecureStorageService] (never SharedPreferences), and
/// restores it on cold start — mirroring how a real token-based API would
/// behave once wired in.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository(this._secureStorage) {
    _controller = StreamController<DriverSession?>.broadcast(
      onListen: () async {
        final saved = await _secureStorage.readSession();
        _controller.add(saved == null ? null : DriverSession(token: saved.$1, driverId: saved.$2));
      },
    );
  }

  final SecureStorageService _secureStorage;
  late final StreamController<DriverSession?> _controller;

  @override
  Stream<DriverSession?> watchSession() => _controller.stream;

  @override
  Future<DriverSession> login({
    required String driverIdOrPhone,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (driverIdOrPhone.trim().isEmpty || password.trim().isEmpty) {
      throw AuthException('Enter your driver ID/phone and password.');
    }
    final session = DriverSession(driverId: 'driver-001', token: 'fake-token-${DateTime.now().millisecondsSinceEpoch}');
    await _secureStorage.saveSession(token: session.token, driverId: session.driverId);
    _controller.add(session);
    return session;
  }

  @override
  Future<DriverSession> loginWithOtp({required String phone, required String otp}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (otp.trim().length < 4) {
      throw AuthException('Enter the 4-digit code sent to your phone.');
    }
    final session = DriverSession(driverId: 'driver-001', token: 'fake-token-${DateTime.now().millisecondsSinceEpoch}');
    await _secureStorage.saveSession(token: session.token, driverId: session.driverId);
    _controller.add(session);
    return session;
  }

  @override
  Future<void> logout() async {
    await _secureStorage.clearSession();
    _controller.add(null);
  }

  void dispose() => _controller.close();
}

class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}
