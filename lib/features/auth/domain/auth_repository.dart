import 'driver_session.dart';

abstract class AuthRepository {
  /// Emits the current session, or null when logged out.
  Stream<DriverSession?> watchSession();

  Future<DriverSession> login({
    required String driverIdOrPhone,
    required String password,
  });

  Future<DriverSession> loginWithOtp({
    required String phone,
    required String otp,
  });

  Future<void> logout();
}
