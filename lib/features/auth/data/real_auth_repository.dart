import 'dart:async';

import 'package:dio/dio.dart';

import '../../../core/services/api_client.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../core/utils/api_error.dart';
import '../domain/auth_exception.dart';
import '../domain/auth_repository.dart';
import '../domain/driver_session.dart';

/// Talks to the real backend's driver actor (`/api/v1/driver/auth/...`).
/// The backend accepts either a driver's code (DR-001) or email as the
/// login identifier, so [driverIdOrPhone] is passed straight through —
/// phone-based login was never supported server-side (no OTP/SMS infra
/// exists), which is also why [loginWithOtp] always fails honestly instead
/// of pretending to work.
class RealAuthRepository implements AuthRepository {
  RealAuthRepository(this._apiClient, this._secureStorage) {
    _controller = StreamController<DriverSession?>.broadcast(
      onListen: () async {
        final saved = await _secureStorage.readSession();
        _controller.add(saved == null ? null : DriverSession(token: saved.$1, driverId: saved.$2));
      },
    );
    _unauthorizedSub = _apiClient.onUnauthorized.listen((_) async {
      await _secureStorage.clearSession();
      _controller.add(null);
    });
  }

  final ApiClient _apiClient;
  final SecureStorageService _secureStorage;
  late final StreamController<DriverSession?> _controller;
  late final StreamSubscription<void> _unauthorizedSub;

  @override
  Stream<DriverSession?> watchSession() => _controller.stream;

  @override
  Future<DriverSession> login({
    required String driverIdOrPhone,
    required String password,
  }) async {
    try {
      final response = await _apiClient.dio.post('/auth/login', data: {
        'email': driverIdOrPhone,
        'password': password,
      });
      final data = response.data as Map<String, dynamic>;
      final driver = data['driver'] as Map<String, dynamic>;
      final session = DriverSession(
        driverId: driver['driverId'].toString(),
        token: data['token'] as String,
      );
      await _secureStorage.saveSession(token: session.token, driverId: session.driverId);
      _controller.add(session);
      return session;
    } on DioException catch (e) {
      throw AuthException(extractApiErrorMessage(e) ?? 'Unable to sign in — check your driver ID and password.');
    }
  }

  @override
  Future<DriverSession> loginWithOtp({required String phone, required String otp}) async {
    throw AuthException("OTP sign-in isn't available yet — use your driver ID or email and password.");
  }

  @override
  Future<void> logout() async {
    try {
      await _apiClient.dio.post('/auth/logout');
    } on DioException {
      // Token may already be invalid — clearing the local session is enough.
    } finally {
      await _secureStorage.clearSession();
      _controller.add(null);
    }
  }

  void dispose() {
    _unauthorizedSub.cancel();
    _controller.close();
  }
}
