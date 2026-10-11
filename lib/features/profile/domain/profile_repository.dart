import 'driver_profile.dart';
import 'driver_status.dart';

abstract class ProfileRepository {
  /// Emits the profile of the currently authenticated driver only.
  Stream<DriverProfile> watchMyProfile();

  /// Sets the driver's own availability toggle (Active / Taking a break /
  /// Unavailable), persisted server-side so the admin panel sees it too.
  Future<void> setStatus(DriverStatus status);
}
