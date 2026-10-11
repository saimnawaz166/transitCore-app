// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DriverProfile {

 String get driverId; String get fullName; String get driverCode; String get phone; String? get photoUrl; double get rating; int get completedTrips; double get completionRate; AssignedVehicle get assignedVehicle; DateTime get joinedAt; DriverStatus get status;
/// Create a copy of DriverProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverProfileCopyWith<DriverProfile> get copyWith => _$DriverProfileCopyWithImpl<DriverProfile>(this as DriverProfile, _$identity);

  /// Serializes this DriverProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DriverProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverProfile&&(identical(other.driverId, _this.driverId) || other.driverId == _this.driverId)&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.driverCode, _this.driverCode) || other.driverCode == _this.driverCode)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.completedTrips, _this.completedTrips) || other.completedTrips == _this.completedTrips)&&(identical(other.completionRate, _this.completionRate) || other.completionRate == _this.completionRate)&&(identical(other.assignedVehicle, _this.assignedVehicle) || other.assignedVehicle == _this.assignedVehicle)&&(identical(other.joinedAt, _this.joinedAt) || other.joinedAt == _this.joinedAt)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DriverProfile;
  return Object.hash(runtimeType,_this.driverId,_this.fullName,_this.driverCode,_this.phone,_this.photoUrl,_this.rating,_this.completedTrips,_this.completionRate,_this.assignedVehicle,_this.joinedAt,_this.status);
}

@override
String toString() {
  final _this = this as DriverProfile;
  return 'DriverProfile(driverId: ${_this.driverId}, fullName: ${_this.fullName}, driverCode: ${_this.driverCode}, phone: ${_this.phone}, photoUrl: ${_this.photoUrl}, rating: ${_this.rating}, completedTrips: ${_this.completedTrips}, completionRate: ${_this.completionRate}, assignedVehicle: ${_this.assignedVehicle}, joinedAt: ${_this.joinedAt}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $DriverProfileCopyWith<$Res>  {
  factory $DriverProfileCopyWith(DriverProfile value, $Res Function(DriverProfile) _then) = _$DriverProfileCopyWithImpl;
@useResult
$Res call({
 String driverId, String fullName, String driverCode, String phone, String? photoUrl, double rating, int completedTrips, double completionRate, AssignedVehicle assignedVehicle, DateTime joinedAt, DriverStatus status
});


$AssignedVehicleCopyWith<$Res> get assignedVehicle;

}
/// @nodoc
class _$DriverProfileCopyWithImpl<$Res>
    implements $DriverProfileCopyWith<$Res> {
  _$DriverProfileCopyWithImpl(this._self, this._then);

  final DriverProfile _self;
  final $Res Function(DriverProfile) _then;

/// Create a copy of DriverProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? driverId = null,Object? fullName = null,Object? driverCode = null,Object? phone = null,Object? photoUrl = freezed,Object? rating = null,Object? completedTrips = null,Object? completionRate = null,Object? assignedVehicle = null,Object? joinedAt = null,Object? status = null,}) {
  return _then(DriverProfile(
driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,driverCode: null == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,completedTrips: null == completedTrips ? _self.completedTrips : completedTrips // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,assignedVehicle: null == assignedVehicle ? _self.assignedVehicle : assignedVehicle // ignore: cast_nullable_to_non_nullable
as AssignedVehicle,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DriverStatus,
  ));
}
/// Create a copy of DriverProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssignedVehicleCopyWith<$Res> get assignedVehicle {
  
  return $AssignedVehicleCopyWith<$Res>(_self.assignedVehicle, (value) {
    return _then(_self.copyWith(assignedVehicle: value));
  });
}
}


/// Adds pattern-matching-related methods to [DriverProfile].
extension DriverProfilePatterns on DriverProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverProfile value)  $default,){
final _that = this;
switch (_that) {
case _DriverProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverProfile value)?  $default,){
final _that = this;
switch (_that) {
case _DriverProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String driverId,  String fullName,  String driverCode,  String phone,  String? photoUrl,  double rating,  int completedTrips,  double completionRate,  AssignedVehicle assignedVehicle,  DateTime joinedAt,  DriverStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverProfile() when $default != null:
return $default(_that.driverId,_that.fullName,_that.driverCode,_that.phone,_that.photoUrl,_that.rating,_that.completedTrips,_that.completionRate,_that.assignedVehicle,_that.joinedAt,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String driverId,  String fullName,  String driverCode,  String phone,  String? photoUrl,  double rating,  int completedTrips,  double completionRate,  AssignedVehicle assignedVehicle,  DateTime joinedAt,  DriverStatus status)  $default,) {final _that = this;
switch (_that) {
case _DriverProfile():
return $default(_that.driverId,_that.fullName,_that.driverCode,_that.phone,_that.photoUrl,_that.rating,_that.completedTrips,_that.completionRate,_that.assignedVehicle,_that.joinedAt,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String driverId,  String fullName,  String driverCode,  String phone,  String? photoUrl,  double rating,  int completedTrips,  double completionRate,  AssignedVehicle assignedVehicle,  DateTime joinedAt,  DriverStatus status)?  $default,) {final _that = this;
switch (_that) {
case _DriverProfile() when $default != null:
return $default(_that.driverId,_that.fullName,_that.driverCode,_that.phone,_that.photoUrl,_that.rating,_that.completedTrips,_that.completionRate,_that.assignedVehicle,_that.joinedAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriverProfile implements DriverProfile {
  const _DriverProfile({required this.driverId, required this.fullName, required this.driverCode, required this.phone, this.photoUrl, required this.rating, required this.completedTrips, required this.completionRate, required this.assignedVehicle, required this.joinedAt, required this.status});
  factory _DriverProfile.fromJson(Map<String, dynamic> json) => _$DriverProfileFromJson(json);

@override final  String driverId;
@override final  String fullName;
@override final  String driverCode;
@override final  String phone;
@override final  String? photoUrl;
@override final  double rating;
@override final  int completedTrips;
@override final  double completionRate;
@override final  AssignedVehicle assignedVehicle;
@override final  DateTime joinedAt;
@override final  DriverStatus status;

/// Create a copy of DriverProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverProfileCopyWith<_DriverProfile> get copyWith => __$DriverProfileCopyWithImpl<_DriverProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriverProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverProfile&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.driverCode, driverCode) || other.driverCode == driverCode)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.completedTrips, completedTrips) || other.completedTrips == completedTrips)&&(identical(other.completionRate, completionRate) || other.completionRate == completionRate)&&(identical(other.assignedVehicle, assignedVehicle) || other.assignedVehicle == assignedVehicle)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,driverId,fullName,driverCode,phone,photoUrl,rating,completedTrips,completionRate,assignedVehicle,joinedAt,status);
}

@override
String toString() {
    return 'DriverProfile(driverId: $driverId, fullName: $fullName, driverCode: $driverCode, phone: $phone, photoUrl: $photoUrl, rating: $rating, completedTrips: $completedTrips, completionRate: $completionRate, assignedVehicle: $assignedVehicle, joinedAt: $joinedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$DriverProfileCopyWith<$Res> implements $DriverProfileCopyWith<$Res> {
  factory _$DriverProfileCopyWith(_DriverProfile value, $Res Function(_DriverProfile) _then) = __$DriverProfileCopyWithImpl;
@override @useResult
$Res call({
 String driverId, String fullName, String driverCode, String phone, String? photoUrl, double rating, int completedTrips, double completionRate, AssignedVehicle assignedVehicle, DateTime joinedAt, DriverStatus status
});


@override $AssignedVehicleCopyWith<$Res> get assignedVehicle;

}
/// @nodoc
class __$DriverProfileCopyWithImpl<$Res>
    implements _$DriverProfileCopyWith<$Res> {
  __$DriverProfileCopyWithImpl(this._self, this._then);

  final _DriverProfile _self;
  final $Res Function(_DriverProfile) _then;

/// Create a copy of DriverProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? driverId = null,Object? fullName = null,Object? driverCode = null,Object? phone = null,Object? photoUrl = freezed,Object? rating = null,Object? completedTrips = null,Object? completionRate = null,Object? assignedVehicle = null,Object? joinedAt = null,Object? status = null,}) {
  return _then(_DriverProfile(
driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,driverCode: null == driverCode ? _self.driverCode : driverCode // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,completedTrips: null == completedTrips ? _self.completedTrips : completedTrips // ignore: cast_nullable_to_non_nullable
as int,completionRate: null == completionRate ? _self.completionRate : completionRate // ignore: cast_nullable_to_non_nullable
as double,assignedVehicle: null == assignedVehicle ? _self.assignedVehicle : assignedVehicle // ignore: cast_nullable_to_non_nullable
as AssignedVehicle,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DriverStatus,
  ));
}

/// Create a copy of DriverProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssignedVehicleCopyWith<$Res> get assignedVehicle {
  
  return $AssignedVehicleCopyWith<$Res>(_self.assignedVehicle, (value) {
    return _then(_self.copyWith(assignedVehicle: value));
  });
}
}

// dart format on
