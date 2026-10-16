import 'package:freezed_annotation/freezed_annotation.dart';
import 'ride_status.dart';

part 'ride_models.freezed.dart';
part 'ride_models.g.dart';

@freezed
abstract class RideLocation with _$RideLocation {
  const factory RideLocation({
    required String label,
    required String address,
    // Only ever populated for a booking made through the guest/rider web
    // flow (a real PricingLocation lookup) — an admin-created booking takes
    // free-text pickup/dropoff with no coordinates at all, so this is null
    // there. The map screen must handle that, not assume it's always set.
    double? lat,
    double? lng,
  }) = _RideLocation;

  factory RideLocation.fromJson(Map<String, dynamic> json) =>
      _$RideLocationFromJson(json);
}

@freezed
abstract class Passenger with _$Passenger {
  const factory Passenger({
    required String name,
    required String phone,
    String? photoUrl,
  }) = _Passenger;

  factory Passenger.fromJson(Map<String, dynamic> json) =>
      _$PassengerFromJson(json);
}

@freezed
abstract class AssignedVehicle with _$AssignedVehicle {
  const factory AssignedVehicle({
    required String make,
    required String model,
    required String plateNumber,
    required String category,
  }) = _AssignedVehicle;

  factory AssignedVehicle.fromJson(Map<String, dynamic> json) =>
      _$AssignedVehicleFromJson(json);
}

@freezed
abstract class FareBreakdown with _$FareBreakdown {
  const factory FareBreakdown({
    required double baseFare,
    required double distanceFare,
    required double surcharge,
    required double driverPayout,
    required String currency,
  }) = _FareBreakdown;

  const FareBreakdown._();

  double get total => baseFare + distanceFare + surcharge;

  factory FareBreakdown.fromJson(Map<String, dynamic> json) =>
      _$FareBreakdownFromJson(json);
}

@freezed
abstract class Ride with _$Ride {
  const factory Ride({
    required String id,
    required String jobId,
    required DateTime scheduledAt,
    required RideStatus status,
    required RideLocation pickup,
    required RideLocation dropoff,
    required Passenger passenger,
    required AssignedVehicle vehicle,
    required FareBreakdown fare,
    required String driverId,
    int? passengerCount,
    int? luggageCount,
    String? notes,
    String? pickupInstructions,
    String? voucherCode,
    double? distanceKm,
    String? pickupSignedBy,
    @Default(true) bool tollFeesAllowed,
    @Default(true) bool extrasAllowed,
    @Default(false) bool pinRequired,
  }) = _Ride;

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
}
