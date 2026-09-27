import 'driver_profile.dart';

abstract class ProfileRepository {
  /// Emits the profile of the currently authenticated driver only.
  Stream<DriverProfile> watchMyProfile();
}
