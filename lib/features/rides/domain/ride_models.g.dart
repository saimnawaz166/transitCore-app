// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RideLocation _$RideLocationFromJson(Map<String, dynamic> json) =>
    _RideLocation(
      label: json['label'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RideLocationToJson(_RideLocation instance) =>
    <String, dynamic>{
      'label': instance.label,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
    };

_Passenger _$PassengerFromJson(Map<String, dynamic> json) => _Passenger(
  name: json['name'] as String,
  phone: json['phone'] as String,
  photoUrl: json['photoUrl'] as String?,
);

Map<String, dynamic> _$PassengerToJson(_Passenger instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'photoUrl': instance.photoUrl,
    };

_AssignedVehicle _$AssignedVehicleFromJson(Map<String, dynamic> json) =>
    _AssignedVehicle(
      make: json['make'] as String,
      model: json['model'] as String,
      plateNumber: json['plateNumber'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$AssignedVehicleToJson(_AssignedVehicle instance) =>
    <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'plateNumber': instance.plateNumber,
      'category': instance.category,
    };

_FareBreakdown _$FareBreakdownFromJson(Map<String, dynamic> json) =>
    _FareBreakdown(
      baseFare: (json['baseFare'] as num).toDouble(),
      distanceFare: (json['distanceFare'] as num).toDouble(),
      surcharge: (json['surcharge'] as num).toDouble(),
      driverPayout: (json['driverPayout'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$FareBreakdownToJson(_FareBreakdown instance) =>
    <String, dynamic>{
      'baseFare': instance.baseFare,
      'distanceFare': instance.distanceFare,
      'surcharge': instance.surcharge,
      'driverPayout': instance.driverPayout,
      'currency': instance.currency,
    };

_Ride _$RideFromJson(Map<String, dynamic> json) => _Ride(
  id: json['id'] as String,
  jobId: json['jobId'] as String,
  scheduledAt: DateTime.parse(json['scheduledAt'] as String),
  status: $enumDecode(_$RideStatusEnumMap, json['status']),
  pickup: RideLocation.fromJson(json['pickup'] as Map<String, dynamic>),
  dropoff: RideLocation.fromJson(json['dropoff'] as Map<String, dynamic>),
  passenger: Passenger.fromJson(json['passenger'] as Map<String, dynamic>),
  vehicle: AssignedVehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
  fare: FareBreakdown.fromJson(json['fare'] as Map<String, dynamic>),
  driverId: json['driverId'] as String,
  passengerCount: (json['passengerCount'] as num?)?.toInt(),
  luggageCount: (json['luggageCount'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  pickupInstructions: json['pickupInstructions'] as String?,
  voucherCode: json['voucherCode'] as String?,
  distanceKm: (json['distanceKm'] as num?)?.toDouble(),
  pickupSignedBy: json['pickupSignedBy'] as String?,
  tollFeesAllowed: json['tollFeesAllowed'] as bool? ?? true,
  extrasAllowed: json['extrasAllowed'] as bool? ?? true,
  pinRequired: json['pinRequired'] as bool? ?? false,
);

Map<String, dynamic> _$RideToJson(_Ride instance) => <String, dynamic>{
  'id': instance.id,
  'jobId': instance.jobId,
  'scheduledAt': instance.scheduledAt.toIso8601String(),
  'status': _$RideStatusEnumMap[instance.status]!,
  'pickup': instance.pickup,
  'dropoff': instance.dropoff,
  'passenger': instance.passenger,
  'vehicle': instance.vehicle,
  'fare': instance.fare,
  'driverId': instance.driverId,
  'passengerCount': instance.passengerCount,
  'luggageCount': instance.luggageCount,
  'notes': instance.notes,
  'pickupInstructions': instance.pickupInstructions,
  'voucherCode': instance.voucherCode,
  'distanceKm': instance.distanceKm,
  'pickupSignedBy': instance.pickupSignedBy,
  'tollFeesAllowed': instance.tollFeesAllowed,
  'extrasAllowed': instance.extrasAllowed,
  'pinRequired': instance.pinRequired,
};

const _$RideStatusEnumMap = {
  RideStatus.incoming: 'incoming',
  RideStatus.accepted: 'accepted',
  RideStatus.enRouteToPickup: 'enRouteToPickup',
  RideStatus.arrived: 'arrived',
  RideStatus.inProgress: 'inProgress',
  RideStatus.completed: 'completed',
  RideStatus.cancelled: 'cancelled',
};
