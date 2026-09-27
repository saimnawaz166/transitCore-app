import 'package:freezed_annotation/freezed_annotation.dart';

import '../../rides/domain/ride_models.dart';

part 'driver_profile.freezed.dart';
part 'driver_profile.g.dart';

@freezed
abstract class DriverProfile with _$DriverProfile {
  const factory DriverProfile({
    required String driverId,
    required String fullName,
    required String driverCode,
    required String phone,
    String? photoUrl,
    required double rating,
    required int completedTrips,
    required double completionRate,
    required AssignedVehicle assignedVehicle,
    required DateTime joinedAt,
  }) = _DriverProfile;

  factory DriverProfile.fromJson(Map<String, dynamic> json) =>
      _$DriverProfileFromJson(json);
}
