// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RideLocation {

 String get label; String get address; double get lat; double get lng;
/// Create a copy of RideLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideLocationCopyWith<RideLocation> get copyWith => _$RideLocationCopyWithImpl<RideLocation>(this as RideLocation, _$identity);

  /// Serializes this RideLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RideLocation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideLocation&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RideLocation;
  return Object.hash(runtimeType,_this.label,_this.address,_this.lat,_this.lng);
}

@override
String toString() {
  final _this = this as RideLocation;
  return 'RideLocation(label: ${_this.label}, address: ${_this.address}, lat: ${_this.lat}, lng: ${_this.lng})';
}


}

/// @nodoc
abstract mixin class $RideLocationCopyWith<$Res>  {
  factory $RideLocationCopyWith(RideLocation value, $Res Function(RideLocation) _then) = _$RideLocationCopyWithImpl;
@useResult
$Res call({
 String label, String address, double lat, double lng
});




}
/// @nodoc
class _$RideLocationCopyWithImpl<$Res>
    implements $RideLocationCopyWith<$Res> {
  _$RideLocationCopyWithImpl(this._self, this._then);

  final RideLocation _self;
  final $Res Function(RideLocation) _then;

/// Create a copy of RideLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? address = null,Object? lat = null,Object? lng = null,}) {
  return _then(RideLocation(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RideLocation].
extension RideLocationPatterns on RideLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RideLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RideLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RideLocation value)  $default,){
final _that = this;
switch (_that) {
case _RideLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RideLocation value)?  $default,){
final _that = this;
switch (_that) {
case _RideLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String address,  double lat,  double lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RideLocation() when $default != null:
return $default(_that.label,_that.address,_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String address,  double lat,  double lng)  $default,) {final _that = this;
switch (_that) {
case _RideLocation():
return $default(_that.label,_that.address,_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String address,  double lat,  double lng)?  $default,) {final _that = this;
switch (_that) {
case _RideLocation() when $default != null:
return $default(_that.label,_that.address,_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RideLocation implements RideLocation {
  const _RideLocation({required this.label, required this.address, required this.lat, required this.lng});
  factory _RideLocation.fromJson(Map<String, dynamic> json) => _$RideLocationFromJson(json);

@override final  String label;
@override final  String address;
@override final  double lat;
@override final  double lng;

/// Create a copy of RideLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideLocationCopyWith<_RideLocation> get copyWith => __$RideLocationCopyWithImpl<_RideLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RideLocationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RideLocation&&(identical(other.label, label) || other.label == label)&&(identical(other.address, address) || other.address == address)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,label,address,lat,lng);
}

@override
String toString() {
    return 'RideLocation(label: $label, address: $address, lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$RideLocationCopyWith<$Res> implements $RideLocationCopyWith<$Res> {
  factory _$RideLocationCopyWith(_RideLocation value, $Res Function(_RideLocation) _then) = __$RideLocationCopyWithImpl;
@override @useResult
$Res call({
 String label, String address, double lat, double lng
});




}
/// @nodoc
class __$RideLocationCopyWithImpl<$Res>
    implements _$RideLocationCopyWith<$Res> {
  __$RideLocationCopyWithImpl(this._self, this._then);

  final _RideLocation _self;
  final $Res Function(_RideLocation) _then;

/// Create a copy of RideLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? address = null,Object? lat = null,Object? lng = null,}) {
  return _then(_RideLocation(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Passenger {

 String get name; String get phone; String? get photoUrl;
/// Create a copy of Passenger
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PassengerCopyWith<Passenger> get copyWith => _$PassengerCopyWithImpl<Passenger>(this as Passenger, _$identity);

  /// Serializes this Passenger to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Passenger;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Passenger&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Passenger;
  return Object.hash(runtimeType,_this.name,_this.phone,_this.photoUrl);
}

@override
String toString() {
  final _this = this as Passenger;
  return 'Passenger(name: ${_this.name}, phone: ${_this.phone}, photoUrl: ${_this.photoUrl})';
}


}

/// @nodoc
abstract mixin class $PassengerCopyWith<$Res>  {
  factory $PassengerCopyWith(Passenger value, $Res Function(Passenger) _then) = _$PassengerCopyWithImpl;
@useResult
$Res call({
 String name, String phone, String? photoUrl
});




}
/// @nodoc
class _$PassengerCopyWithImpl<$Res>
    implements $PassengerCopyWith<$Res> {
  _$PassengerCopyWithImpl(this._self, this._then);

  final Passenger _self;
  final $Res Function(Passenger) _then;

/// Create a copy of Passenger
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? phone = null,Object? photoUrl = freezed,}) {
  return _then(Passenger(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Passenger].
extension PassengerPatterns on Passenger {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Passenger value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Passenger() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Passenger value)  $default,){
final _that = this;
switch (_that) {
case _Passenger():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Passenger value)?  $default,){
final _that = this;
switch (_that) {
case _Passenger() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String phone,  String? photoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Passenger() when $default != null:
return $default(_that.name,_that.phone,_that.photoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String phone,  String? photoUrl)  $default,) {final _that = this;
switch (_that) {
case _Passenger():
return $default(_that.name,_that.phone,_that.photoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String phone,  String? photoUrl)?  $default,) {final _that = this;
switch (_that) {
case _Passenger() when $default != null:
return $default(_that.name,_that.phone,_that.photoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Passenger implements Passenger {
  const _Passenger({required this.name, required this.phone, this.photoUrl});
  factory _Passenger.fromJson(Map<String, dynamic> json) => _$PassengerFromJson(json);

@override final  String name;
@override final  String phone;
@override final  String? photoUrl;

/// Create a copy of Passenger
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PassengerCopyWith<_Passenger> get copyWith => __$PassengerCopyWithImpl<_Passenger>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PassengerToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Passenger&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,phone,photoUrl);
}

@override
String toString() {
    return 'Passenger(name: $name, phone: $phone, photoUrl: $photoUrl)';
}


}

/// @nodoc
abstract mixin class _$PassengerCopyWith<$Res> implements $PassengerCopyWith<$Res> {
  factory _$PassengerCopyWith(_Passenger value, $Res Function(_Passenger) _then) = __$PassengerCopyWithImpl;
@override @useResult
$Res call({
 String name, String phone, String? photoUrl
});




}
/// @nodoc
class __$PassengerCopyWithImpl<$Res>
    implements _$PassengerCopyWith<$Res> {
  __$PassengerCopyWithImpl(this._self, this._then);

  final _Passenger _self;
  final $Res Function(_Passenger) _then;

/// Create a copy of Passenger
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = null,Object? photoUrl = freezed,}) {
  return _then(_Passenger(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AssignedVehicle {

 String get make; String get model; String get plateNumber; String get category;
/// Create a copy of AssignedVehicle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignedVehicleCopyWith<AssignedVehicle> get copyWith => _$AssignedVehicleCopyWithImpl<AssignedVehicle>(this as AssignedVehicle, _$identity);

  /// Serializes this AssignedVehicle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AssignedVehicle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssignedVehicle&&(identical(other.make, _this.make) || other.make == _this.make)&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.plateNumber, _this.plateNumber) || other.plateNumber == _this.plateNumber)&&(identical(other.category, _this.category) || other.category == _this.category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AssignedVehicle;
  return Object.hash(runtimeType,_this.make,_this.model,_this.plateNumber,_this.category);
}

@override
String toString() {
  final _this = this as AssignedVehicle;
  return 'AssignedVehicle(make: ${_this.make}, model: ${_this.model}, plateNumber: ${_this.plateNumber}, category: ${_this.category})';
}


}

/// @nodoc
abstract mixin class $AssignedVehicleCopyWith<$Res>  {
  factory $AssignedVehicleCopyWith(AssignedVehicle value, $Res Function(AssignedVehicle) _then) = _$AssignedVehicleCopyWithImpl;
@useResult
$Res call({
 String make, String model, String plateNumber, String category
});




}
/// @nodoc
class _$AssignedVehicleCopyWithImpl<$Res>
    implements $AssignedVehicleCopyWith<$Res> {
  _$AssignedVehicleCopyWithImpl(this._self, this._then);

  final AssignedVehicle _self;
  final $Res Function(AssignedVehicle) _then;

/// Create a copy of AssignedVehicle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? make = null,Object? model = null,Object? plateNumber = null,Object? category = null,}) {
  return _then(AssignedVehicle(
make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,plateNumber: null == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AssignedVehicle].
extension AssignedVehiclePatterns on AssignedVehicle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssignedVehicle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssignedVehicle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssignedVehicle value)  $default,){
final _that = this;
switch (_that) {
case _AssignedVehicle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssignedVehicle value)?  $default,){
final _that = this;
switch (_that) {
case _AssignedVehicle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String make,  String model,  String plateNumber,  String category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssignedVehicle() when $default != null:
return $default(_that.make,_that.model,_that.plateNumber,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String make,  String model,  String plateNumber,  String category)  $default,) {final _that = this;
switch (_that) {
case _AssignedVehicle():
return $default(_that.make,_that.model,_that.plateNumber,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String make,  String model,  String plateNumber,  String category)?  $default,) {final _that = this;
switch (_that) {
case _AssignedVehicle() when $default != null:
return $default(_that.make,_that.model,_that.plateNumber,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssignedVehicle implements AssignedVehicle {
  const _AssignedVehicle({required this.make, required this.model, required this.plateNumber, required this.category});
  factory _AssignedVehicle.fromJson(Map<String, dynamic> json) => _$AssignedVehicleFromJson(json);

@override final  String make;
@override final  String model;
@override final  String plateNumber;
@override final  String category;

/// Create a copy of AssignedVehicle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssignedVehicleCopyWith<_AssignedVehicle> get copyWith => __$AssignedVehicleCopyWithImpl<_AssignedVehicle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssignedVehicleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssignedVehicle&&(identical(other.make, make) || other.make == make)&&(identical(other.model, model) || other.model == model)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,make,model,plateNumber,category);
}

@override
String toString() {
    return 'AssignedVehicle(make: $make, model: $model, plateNumber: $plateNumber, category: $category)';
}


}

/// @nodoc
abstract mixin class _$AssignedVehicleCopyWith<$Res> implements $AssignedVehicleCopyWith<$Res> {
  factory _$AssignedVehicleCopyWith(_AssignedVehicle value, $Res Function(_AssignedVehicle) _then) = __$AssignedVehicleCopyWithImpl;
@override @useResult
$Res call({
 String make, String model, String plateNumber, String category
});




}
/// @nodoc
class __$AssignedVehicleCopyWithImpl<$Res>
    implements _$AssignedVehicleCopyWith<$Res> {
  __$AssignedVehicleCopyWithImpl(this._self, this._then);

  final _AssignedVehicle _self;
  final $Res Function(_AssignedVehicle) _then;

/// Create a copy of AssignedVehicle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? make = null,Object? model = null,Object? plateNumber = null,Object? category = null,}) {
  return _then(_AssignedVehicle(
make: null == make ? _self.make : make // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,plateNumber: null == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FareBreakdown {

 double get baseFare; double get distanceFare; double get surcharge; double get driverPayout; String get currency;
/// Create a copy of FareBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FareBreakdownCopyWith<FareBreakdown> get copyWith => _$FareBreakdownCopyWithImpl<FareBreakdown>(this as FareBreakdown, _$identity);

  /// Serializes this FareBreakdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FareBreakdown;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FareBreakdown&&(identical(other.baseFare, _this.baseFare) || other.baseFare == _this.baseFare)&&(identical(other.distanceFare, _this.distanceFare) || other.distanceFare == _this.distanceFare)&&(identical(other.surcharge, _this.surcharge) || other.surcharge == _this.surcharge)&&(identical(other.driverPayout, _this.driverPayout) || other.driverPayout == _this.driverPayout)&&(identical(other.currency, _this.currency) || other.currency == _this.currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FareBreakdown;
  return Object.hash(runtimeType,_this.baseFare,_this.distanceFare,_this.surcharge,_this.driverPayout,_this.currency);
}

@override
String toString() {
  final _this = this as FareBreakdown;
  return 'FareBreakdown(baseFare: ${_this.baseFare}, distanceFare: ${_this.distanceFare}, surcharge: ${_this.surcharge}, driverPayout: ${_this.driverPayout}, currency: ${_this.currency})';
}


}

/// @nodoc
abstract mixin class $FareBreakdownCopyWith<$Res>  {
  factory $FareBreakdownCopyWith(FareBreakdown value, $Res Function(FareBreakdown) _then) = _$FareBreakdownCopyWithImpl;
@useResult
$Res call({
 double baseFare, double distanceFare, double surcharge, double driverPayout, String currency
});




}
/// @nodoc
class _$FareBreakdownCopyWithImpl<$Res>
    implements $FareBreakdownCopyWith<$Res> {
  _$FareBreakdownCopyWithImpl(this._self, this._then);

  final FareBreakdown _self;
  final $Res Function(FareBreakdown) _then;

/// Create a copy of FareBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseFare = null,Object? distanceFare = null,Object? surcharge = null,Object? driverPayout = null,Object? currency = null,}) {
  return _then(FareBreakdown(
baseFare: null == baseFare ? _self.baseFare : baseFare // ignore: cast_nullable_to_non_nullable
as double,distanceFare: null == distanceFare ? _self.distanceFare : distanceFare // ignore: cast_nullable_to_non_nullable
as double,surcharge: null == surcharge ? _self.surcharge : surcharge // ignore: cast_nullable_to_non_nullable
as double,driverPayout: null == driverPayout ? _self.driverPayout : driverPayout // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FareBreakdown].
extension FareBreakdownPatterns on FareBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FareBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FareBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FareBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _FareBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FareBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _FareBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double baseFare,  double distanceFare,  double surcharge,  double driverPayout,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FareBreakdown() when $default != null:
return $default(_that.baseFare,_that.distanceFare,_that.surcharge,_that.driverPayout,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double baseFare,  double distanceFare,  double surcharge,  double driverPayout,  String currency)  $default,) {final _that = this;
switch (_that) {
case _FareBreakdown():
return $default(_that.baseFare,_that.distanceFare,_that.surcharge,_that.driverPayout,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double baseFare,  double distanceFare,  double surcharge,  double driverPayout,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _FareBreakdown() when $default != null:
return $default(_that.baseFare,_that.distanceFare,_that.surcharge,_that.driverPayout,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FareBreakdown extends FareBreakdown {
  const _FareBreakdown({required this.baseFare, required this.distanceFare, required this.surcharge, required this.driverPayout, required this.currency}): super._();
  factory _FareBreakdown.fromJson(Map<String, dynamic> json) => _$FareBreakdownFromJson(json);

@override final  double baseFare;
@override final  double distanceFare;
@override final  double surcharge;
@override final  double driverPayout;
@override final  String currency;

/// Create a copy of FareBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FareBreakdownCopyWith<_FareBreakdown> get copyWith => __$FareBreakdownCopyWithImpl<_FareBreakdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FareBreakdownToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FareBreakdown&&(identical(other.baseFare, baseFare) || other.baseFare == baseFare)&&(identical(other.distanceFare, distanceFare) || other.distanceFare == distanceFare)&&(identical(other.surcharge, surcharge) || other.surcharge == surcharge)&&(identical(other.driverPayout, driverPayout) || other.driverPayout == driverPayout)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,baseFare,distanceFare,surcharge,driverPayout,currency);
}

@override
String toString() {
    return 'FareBreakdown(baseFare: $baseFare, distanceFare: $distanceFare, surcharge: $surcharge, driverPayout: $driverPayout, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$FareBreakdownCopyWith<$Res> implements $FareBreakdownCopyWith<$Res> {
  factory _$FareBreakdownCopyWith(_FareBreakdown value, $Res Function(_FareBreakdown) _then) = __$FareBreakdownCopyWithImpl;
@override @useResult
$Res call({
 double baseFare, double distanceFare, double surcharge, double driverPayout, String currency
});




}
/// @nodoc
class __$FareBreakdownCopyWithImpl<$Res>
    implements _$FareBreakdownCopyWith<$Res> {
  __$FareBreakdownCopyWithImpl(this._self, this._then);

  final _FareBreakdown _self;
  final $Res Function(_FareBreakdown) _then;

/// Create a copy of FareBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseFare = null,Object? distanceFare = null,Object? surcharge = null,Object? driverPayout = null,Object? currency = null,}) {
  return _then(_FareBreakdown(
baseFare: null == baseFare ? _self.baseFare : baseFare // ignore: cast_nullable_to_non_nullable
as double,distanceFare: null == distanceFare ? _self.distanceFare : distanceFare // ignore: cast_nullable_to_non_nullable
as double,surcharge: null == surcharge ? _self.surcharge : surcharge // ignore: cast_nullable_to_non_nullable
as double,driverPayout: null == driverPayout ? _self.driverPayout : driverPayout // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Ride {

 String get id; String get jobId; DateTime get scheduledAt; RideStatus get status; RideLocation get pickup; RideLocation get dropoff; Passenger get passenger; AssignedVehicle get vehicle; FareBreakdown get fare; String get driverId; int? get passengerCount; int? get luggageCount; String? get notes; String? get pickupInstructions; String? get voucherCode; double? get distanceKm; String? get pickupSignedBy; bool get tollFeesAllowed; bool get extrasAllowed; bool get pinRequired;
/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideCopyWith<Ride> get copyWith => _$RideCopyWithImpl<Ride>(this as Ride, _$identity);

  /// Serializes this Ride to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Ride;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ride&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.scheduledAt, _this.scheduledAt) || other.scheduledAt == _this.scheduledAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.pickup, _this.pickup) || other.pickup == _this.pickup)&&(identical(other.dropoff, _this.dropoff) || other.dropoff == _this.dropoff)&&(identical(other.passenger, _this.passenger) || other.passenger == _this.passenger)&&(identical(other.vehicle, _this.vehicle) || other.vehicle == _this.vehicle)&&(identical(other.fare, _this.fare) || other.fare == _this.fare)&&(identical(other.driverId, _this.driverId) || other.driverId == _this.driverId)&&(identical(other.passengerCount, _this.passengerCount) || other.passengerCount == _this.passengerCount)&&(identical(other.luggageCount, _this.luggageCount) || other.luggageCount == _this.luggageCount)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.pickupInstructions, _this.pickupInstructions) || other.pickupInstructions == _this.pickupInstructions)&&(identical(other.voucherCode, _this.voucherCode) || other.voucherCode == _this.voucherCode)&&(identical(other.distanceKm, _this.distanceKm) || other.distanceKm == _this.distanceKm)&&(identical(other.pickupSignedBy, _this.pickupSignedBy) || other.pickupSignedBy == _this.pickupSignedBy)&&(identical(other.tollFeesAllowed, _this.tollFeesAllowed) || other.tollFeesAllowed == _this.tollFeesAllowed)&&(identical(other.extrasAllowed, _this.extrasAllowed) || other.extrasAllowed == _this.extrasAllowed)&&(identical(other.pinRequired, _this.pinRequired) || other.pinRequired == _this.pinRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Ride;
  return Object.hashAll([runtimeType,_this.id,_this.jobId,_this.scheduledAt,_this.status,_this.pickup,_this.dropoff,_this.passenger,_this.vehicle,_this.fare,_this.driverId,_this.passengerCount,_this.luggageCount,_this.notes,_this.pickupInstructions,_this.voucherCode,_this.distanceKm,_this.pickupSignedBy,_this.tollFeesAllowed,_this.extrasAllowed,_this.pinRequired]);
}

@override
String toString() {
  final _this = this as Ride;
  return 'Ride(id: ${_this.id}, jobId: ${_this.jobId}, scheduledAt: ${_this.scheduledAt}, status: ${_this.status}, pickup: ${_this.pickup}, dropoff: ${_this.dropoff}, passenger: ${_this.passenger}, vehicle: ${_this.vehicle}, fare: ${_this.fare}, driverId: ${_this.driverId}, passengerCount: ${_this.passengerCount}, luggageCount: ${_this.luggageCount}, notes: ${_this.notes}, pickupInstructions: ${_this.pickupInstructions}, voucherCode: ${_this.voucherCode}, distanceKm: ${_this.distanceKm}, pickupSignedBy: ${_this.pickupSignedBy}, tollFeesAllowed: ${_this.tollFeesAllowed}, extrasAllowed: ${_this.extrasAllowed}, pinRequired: ${_this.pinRequired})';
}


}

/// @nodoc
abstract mixin class $RideCopyWith<$Res>  {
  factory $RideCopyWith(Ride value, $Res Function(Ride) _then) = _$RideCopyWithImpl;
@useResult
$Res call({
 String id, String jobId, DateTime scheduledAt, RideStatus status, RideLocation pickup, RideLocation dropoff, Passenger passenger, AssignedVehicle vehicle, FareBreakdown fare, String driverId, int? passengerCount, int? luggageCount, String? notes, String? pickupInstructions, String? voucherCode, double? distanceKm, String? pickupSignedBy, bool tollFeesAllowed, bool extrasAllowed, bool pinRequired
});


$RideLocationCopyWith<$Res> get pickup;$RideLocationCopyWith<$Res> get dropoff;$PassengerCopyWith<$Res> get passenger;$AssignedVehicleCopyWith<$Res> get vehicle;$FareBreakdownCopyWith<$Res> get fare;

}
/// @nodoc
class _$RideCopyWithImpl<$Res>
    implements $RideCopyWith<$Res> {
  _$RideCopyWithImpl(this._self, this._then);

  final Ride _self;
  final $Res Function(Ride) _then;

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobId = null,Object? scheduledAt = null,Object? status = null,Object? pickup = null,Object? dropoff = null,Object? passenger = null,Object? vehicle = null,Object? fare = null,Object? driverId = null,Object? passengerCount = freezed,Object? luggageCount = freezed,Object? notes = freezed,Object? pickupInstructions = freezed,Object? voucherCode = freezed,Object? distanceKm = freezed,Object? pickupSignedBy = freezed,Object? tollFeesAllowed = null,Object? extrasAllowed = null,Object? pinRequired = null,}) {
  return _then(Ride(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RideStatus,pickup: null == pickup ? _self.pickup : pickup // ignore: cast_nullable_to_non_nullable
as RideLocation,dropoff: null == dropoff ? _self.dropoff : dropoff // ignore: cast_nullable_to_non_nullable
as RideLocation,passenger: null == passenger ? _self.passenger : passenger // ignore: cast_nullable_to_non_nullable
as Passenger,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as AssignedVehicle,fare: null == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as FareBreakdown,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,passengerCount: freezed == passengerCount ? _self.passengerCount : passengerCount // ignore: cast_nullable_to_non_nullable
as int?,luggageCount: freezed == luggageCount ? _self.luggageCount : luggageCount // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,pickupInstructions: freezed == pickupInstructions ? _self.pickupInstructions : pickupInstructions // ignore: cast_nullable_to_non_nullable
as String?,voucherCode: freezed == voucherCode ? _self.voucherCode : voucherCode // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,pickupSignedBy: freezed == pickupSignedBy ? _self.pickupSignedBy : pickupSignedBy // ignore: cast_nullable_to_non_nullable
as String?,tollFeesAllowed: null == tollFeesAllowed ? _self.tollFeesAllowed : tollFeesAllowed // ignore: cast_nullable_to_non_nullable
as bool,extrasAllowed: null == extrasAllowed ? _self.extrasAllowed : extrasAllowed // ignore: cast_nullable_to_non_nullable
as bool,pinRequired: null == pinRequired ? _self.pinRequired : pinRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideLocationCopyWith<$Res> get pickup {
  
  return $RideLocationCopyWith<$Res>(_self.pickup, (value) {
    return _then(_self.copyWith(pickup: value));
  });
}/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideLocationCopyWith<$Res> get dropoff {
  
  return $RideLocationCopyWith<$Res>(_self.dropoff, (value) {
    return _then(_self.copyWith(dropoff: value));
  });
}/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PassengerCopyWith<$Res> get passenger {
  
  return $PassengerCopyWith<$Res>(_self.passenger, (value) {
    return _then(_self.copyWith(passenger: value));
  });
}/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssignedVehicleCopyWith<$Res> get vehicle {
  
  return $AssignedVehicleCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FareBreakdownCopyWith<$Res> get fare {
  
  return $FareBreakdownCopyWith<$Res>(_self.fare, (value) {
    return _then(_self.copyWith(fare: value));
  });
}
}


/// Adds pattern-matching-related methods to [Ride].
extension RidePatterns on Ride {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ride value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ride() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ride value)  $default,){
final _that = this;
switch (_that) {
case _Ride():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ride value)?  $default,){
final _that = this;
switch (_that) {
case _Ride() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jobId,  DateTime scheduledAt,  RideStatus status,  RideLocation pickup,  RideLocation dropoff,  Passenger passenger,  AssignedVehicle vehicle,  FareBreakdown fare,  String driverId,  int? passengerCount,  int? luggageCount,  String? notes,  String? pickupInstructions,  String? voucherCode,  double? distanceKm,  String? pickupSignedBy,  bool tollFeesAllowed,  bool extrasAllowed,  bool pinRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ride() when $default != null:
return $default(_that.id,_that.jobId,_that.scheduledAt,_that.status,_that.pickup,_that.dropoff,_that.passenger,_that.vehicle,_that.fare,_that.driverId,_that.passengerCount,_that.luggageCount,_that.notes,_that.pickupInstructions,_that.voucherCode,_that.distanceKm,_that.pickupSignedBy,_that.tollFeesAllowed,_that.extrasAllowed,_that.pinRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jobId,  DateTime scheduledAt,  RideStatus status,  RideLocation pickup,  RideLocation dropoff,  Passenger passenger,  AssignedVehicle vehicle,  FareBreakdown fare,  String driverId,  int? passengerCount,  int? luggageCount,  String? notes,  String? pickupInstructions,  String? voucherCode,  double? distanceKm,  String? pickupSignedBy,  bool tollFeesAllowed,  bool extrasAllowed,  bool pinRequired)  $default,) {final _that = this;
switch (_that) {
case _Ride():
return $default(_that.id,_that.jobId,_that.scheduledAt,_that.status,_that.pickup,_that.dropoff,_that.passenger,_that.vehicle,_that.fare,_that.driverId,_that.passengerCount,_that.luggageCount,_that.notes,_that.pickupInstructions,_that.voucherCode,_that.distanceKm,_that.pickupSignedBy,_that.tollFeesAllowed,_that.extrasAllowed,_that.pinRequired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jobId,  DateTime scheduledAt,  RideStatus status,  RideLocation pickup,  RideLocation dropoff,  Passenger passenger,  AssignedVehicle vehicle,  FareBreakdown fare,  String driverId,  int? passengerCount,  int? luggageCount,  String? notes,  String? pickupInstructions,  String? voucherCode,  double? distanceKm,  String? pickupSignedBy,  bool tollFeesAllowed,  bool extrasAllowed,  bool pinRequired)?  $default,) {final _that = this;
switch (_that) {
case _Ride() when $default != null:
return $default(_that.id,_that.jobId,_that.scheduledAt,_that.status,_that.pickup,_that.dropoff,_that.passenger,_that.vehicle,_that.fare,_that.driverId,_that.passengerCount,_that.luggageCount,_that.notes,_that.pickupInstructions,_that.voucherCode,_that.distanceKm,_that.pickupSignedBy,_that.tollFeesAllowed,_that.extrasAllowed,_that.pinRequired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ride implements Ride {
  const _Ride({required this.id, required this.jobId, required this.scheduledAt, required this.status, required this.pickup, required this.dropoff, required this.passenger, required this.vehicle, required this.fare, required this.driverId, this.passengerCount, this.luggageCount, this.notes, this.pickupInstructions, this.voucherCode, this.distanceKm, this.pickupSignedBy, this.tollFeesAllowed = true, this.extrasAllowed = true, this.pinRequired = false});
  factory _Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);

@override final  String id;
@override final  String jobId;
@override final  DateTime scheduledAt;
@override final  RideStatus status;
@override final  RideLocation pickup;
@override final  RideLocation dropoff;
@override final  Passenger passenger;
@override final  AssignedVehicle vehicle;
@override final  FareBreakdown fare;
@override final  String driverId;
@override final  int? passengerCount;
@override final  int? luggageCount;
@override final  String? notes;
@override final  String? pickupInstructions;
@override final  String? voucherCode;
@override final  double? distanceKm;
@override final  String? pickupSignedBy;
@override@JsonKey() final  bool tollFeesAllowed;
@override@JsonKey() final  bool extrasAllowed;
@override@JsonKey() final  bool pinRequired;

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideCopyWith<_Ride> get copyWith => __$RideCopyWithImpl<_Ride>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RideToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ride&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.pickup, pickup) || other.pickup == pickup)&&(identical(other.dropoff, dropoff) || other.dropoff == dropoff)&&(identical(other.passenger, passenger) || other.passenger == passenger)&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle)&&(identical(other.fare, fare) || other.fare == fare)&&(identical(other.driverId, driverId) || other.driverId == driverId)&&(identical(other.passengerCount, passengerCount) || other.passengerCount == passengerCount)&&(identical(other.luggageCount, luggageCount) || other.luggageCount == luggageCount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.pickupInstructions, pickupInstructions) || other.pickupInstructions == pickupInstructions)&&(identical(other.voucherCode, voucherCode) || other.voucherCode == voucherCode)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.pickupSignedBy, pickupSignedBy) || other.pickupSignedBy == pickupSignedBy)&&(identical(other.tollFeesAllowed, tollFeesAllowed) || other.tollFeesAllowed == tollFeesAllowed)&&(identical(other.extrasAllowed, extrasAllowed) || other.extrasAllowed == extrasAllowed)&&(identical(other.pinRequired, pinRequired) || other.pinRequired == pinRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,jobId,scheduledAt,status,pickup,dropoff,passenger,vehicle,fare,driverId,passengerCount,luggageCount,notes,pickupInstructions,voucherCode,distanceKm,pickupSignedBy,tollFeesAllowed,extrasAllowed,pinRequired]);
}

@override
String toString() {
    return 'Ride(id: $id, jobId: $jobId, scheduledAt: $scheduledAt, status: $status, pickup: $pickup, dropoff: $dropoff, passenger: $passenger, vehicle: $vehicle, fare: $fare, driverId: $driverId, passengerCount: $passengerCount, luggageCount: $luggageCount, notes: $notes, pickupInstructions: $pickupInstructions, voucherCode: $voucherCode, distanceKm: $distanceKm, pickupSignedBy: $pickupSignedBy, tollFeesAllowed: $tollFeesAllowed, extrasAllowed: $extrasAllowed, pinRequired: $pinRequired)';
}


}

/// @nodoc
abstract mixin class _$RideCopyWith<$Res> implements $RideCopyWith<$Res> {
  factory _$RideCopyWith(_Ride value, $Res Function(_Ride) _then) = __$RideCopyWithImpl;
@override @useResult
$Res call({
 String id, String jobId, DateTime scheduledAt, RideStatus status, RideLocation pickup, RideLocation dropoff, Passenger passenger, AssignedVehicle vehicle, FareBreakdown fare, String driverId, int? passengerCount, int? luggageCount, String? notes, String? pickupInstructions, String? voucherCode, double? distanceKm, String? pickupSignedBy, bool tollFeesAllowed, bool extrasAllowed, bool pinRequired
});


@override $RideLocationCopyWith<$Res> get pickup;@override $RideLocationCopyWith<$Res> get dropoff;@override $PassengerCopyWith<$Res> get passenger;@override $AssignedVehicleCopyWith<$Res> get vehicle;@override $FareBreakdownCopyWith<$Res> get fare;

}
/// @nodoc
class __$RideCopyWithImpl<$Res>
    implements _$RideCopyWith<$Res> {
  __$RideCopyWithImpl(this._self, this._then);

  final _Ride _self;
  final $Res Function(_Ride) _then;

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobId = null,Object? scheduledAt = null,Object? status = null,Object? pickup = null,Object? dropoff = null,Object? passenger = null,Object? vehicle = null,Object? fare = null,Object? driverId = null,Object? passengerCount = freezed,Object? luggageCount = freezed,Object? notes = freezed,Object? pickupInstructions = freezed,Object? voucherCode = freezed,Object? distanceKm = freezed,Object? pickupSignedBy = freezed,Object? tollFeesAllowed = null,Object? extrasAllowed = null,Object? pinRequired = null,}) {
  return _then(_Ride(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RideStatus,pickup: null == pickup ? _self.pickup : pickup // ignore: cast_nullable_to_non_nullable
as RideLocation,dropoff: null == dropoff ? _self.dropoff : dropoff // ignore: cast_nullable_to_non_nullable
as RideLocation,passenger: null == passenger ? _self.passenger : passenger // ignore: cast_nullable_to_non_nullable
as Passenger,vehicle: null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as AssignedVehicle,fare: null == fare ? _self.fare : fare // ignore: cast_nullable_to_non_nullable
as FareBreakdown,driverId: null == driverId ? _self.driverId : driverId // ignore: cast_nullable_to_non_nullable
as String,passengerCount: freezed == passengerCount ? _self.passengerCount : passengerCount // ignore: cast_nullable_to_non_nullable
as int?,luggageCount: freezed == luggageCount ? _self.luggageCount : luggageCount // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,pickupInstructions: freezed == pickupInstructions ? _self.pickupInstructions : pickupInstructions // ignore: cast_nullable_to_non_nullable
as String?,voucherCode: freezed == voucherCode ? _self.voucherCode : voucherCode // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,pickupSignedBy: freezed == pickupSignedBy ? _self.pickupSignedBy : pickupSignedBy // ignore: cast_nullable_to_non_nullable
as String?,tollFeesAllowed: null == tollFeesAllowed ? _self.tollFeesAllowed : tollFeesAllowed // ignore: cast_nullable_to_non_nullable
as bool,extrasAllowed: null == extrasAllowed ? _self.extrasAllowed : extrasAllowed // ignore: cast_nullable_to_non_nullable
as bool,pinRequired: null == pinRequired ? _self.pinRequired : pinRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideLocationCopyWith<$Res> get pickup {
  
  return $RideLocationCopyWith<$Res>(_self.pickup, (value) {
    return _then(_self.copyWith(pickup: value));
  });
}/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RideLocationCopyWith<$Res> get dropoff {
  
  return $RideLocationCopyWith<$Res>(_self.dropoff, (value) {
    return _then(_self.copyWith(dropoff: value));
  });
}/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PassengerCopyWith<$Res> get passenger {
  
  return $PassengerCopyWith<$Res>(_self.passenger, (value) {
    return _then(_self.copyWith(passenger: value));
  });
}/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssignedVehicleCopyWith<$Res> get vehicle {
  
  return $AssignedVehicleCopyWith<$Res>(_self.vehicle, (value) {
    return _then(_self.copyWith(vehicle: value));
  });
}/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FareBreakdownCopyWith<$Res> get fare {
  
  return $FareBreakdownCopyWith<$Res>(_self.fare, (value) {
    return _then(_self.copyWith(fare: value));
  });
}
}

// dart format on
