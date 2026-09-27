// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DriverProfile _$DriverProfileFromJson(Map<String, dynamic> json) =>
    _DriverProfile(
      driverId: json['driverId'] as String,
      fullName: json['fullName'] as String,
      driverCode: json['driverCode'] as String,
      phone: json['phone'] as String,
      photoUrl: json['photoUrl'] as String?,
      rating: (json['rating'] as num).toDouble(),
      completedTrips: (json['completedTrips'] as num).toInt(),
      completionRate: (json['completionRate'] as num).toDouble(),
      assignedVehicle: AssignedVehicle.fromJson(
        json['assignedVehicle'] as Map<String, dynamic>,
      ),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$DriverProfileToJson(_DriverProfile instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'fullName': instance.fullName,
      'driverCode': instance.driverCode,
      'phone': instance.phone,
      'photoUrl': instance.photoUrl,
      'rating': instance.rating,
      'completedTrips': instance.completedTrips,
      'completionRate': instance.completionRate,
      'assignedVehicle': instance.assignedVehicle,
      'joinedAt': instance.joinedAt.toIso8601String(),
    };
