import 'driver_profile.dart';
import 'driver_status.dart';

abstract class ProfileRepository {
  /// Emits the profile of the currently authenticated driver only.
  Stream<DriverProfile> watchMyProfile();

  /// Re-fetches immediately rather than waiting for the next poll tick —
  /// for callers (like confirming a vehicle selection) that just changed
  /// something server-side and want the rest of the app to see it right away.
  Future<void> refresh();

  /// Sets the driver's own availability toggle (Active / Taking a break /
  /// Unavailable), persisted server-side so the admin panel sees it too.
  Future<void> setStatus(DriverStatus status);

  /// Updates one or more notification preferences (Settings screen's three
  /// switches). Only the fields passed are changed — the rest keep their
  /// current server-side value, matching the backend's `sometimes` rules.
  Future<void> updateNotificationPreferences({
    bool? notifyNewAssignments,
    bool? notifyStatusChanges,
    bool? notifyPromotions,
  });
}
