import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_session.freezed.dart';

@freezed
abstract class DriverSession with _$DriverSession {
  const factory DriverSession({
    required String driverId,
    required String token,
  }) = _DriverSession;
}
