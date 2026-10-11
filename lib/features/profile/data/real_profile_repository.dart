import 'dart:async';

import 'package:dio/dio.dart';

import '../../../core/services/api_client.dart';
import '../../rides/domain/ride_models.dart';
import '../domain/driver_profile.dart';
import '../domain/driver_status.dart';
import '../domain/profile_repository.dart';

/// Polls `GET /driver/auth/me` — the same honest polling bridge used by
/// [RealRideRepository], since there's no push mechanism on the backend.
class RealProfileRepository implements ProfileRepository {
  RealProfileRepository(this._apiClient) {
    _refresh();
    _timer = Timer.periodic(_pollInterval, (_) => _refresh());
  }

  static const _pollInterval = Duration(seconds: 30);

  final ApiClient _apiClient;
  final StreamController<DriverProfile> _updates = StreamController<DriverProfile>.broadcast();
  DriverProfile? _cache;
  Timer? _timer;

  Future<void> _refresh() async {
    try {
      final response = await _apiClient.dio.get('/auth/me');
      final profile = _mapProfile((response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>);
      _cache = profile;
      _updates.add(profile);
    } on DioException {
      // Keep serving the last known profile on a transient network blip.
    }
  }

  @override
  Stream<DriverProfile> watchMyProfile() {
    return Stream<DriverProfile>.multi((controller) {
      final cached = _cache;
      if (cached != null) controller.add(cached);
      final sub = _updates.stream.listen(controller.add, onError: controller.addError);
      controller.onCancel = sub.cancel;
    });
  }

  @override
  Future<void> setStatus(DriverStatus status) async {
    await _apiClient.dio.post('/status', data: {'status': status.wireValue});
    await _refresh();
  }

  DriverProfile _mapProfile(Map<String, dynamic> json) {
    final vehicleDetails = json['vehicleDetails'] as Map<String, dynamic>?;

    return DriverProfile(
      driverId: json['driverId'].toString(),
      fullName: json['name'] as String? ?? '',
      driverCode: json['id'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      completedTrips: json['completedTrips'] as int? ?? 0,
      completionRate: (json['completionRate'] as num?)?.toDouble() ?? 1.0,
      assignedVehicle: vehicleDetails == null
          ? const AssignedVehicle(make: '—', model: '—', plateNumber: '—', category: '—')
          : AssignedVehicle(
              make: vehicleDetails['make'] as String? ?? '—',
              model: vehicleDetails['model'] as String? ?? '—',
              plateNumber: vehicleDetails['registration'] as String? ?? '—',
              category: vehicleDetails['type'] as String? ?? '—',
            ),
      joinedAt: json['joined'] != null ? DateTime.parse(json['joined'] as String) : DateTime.now(),
      status: DriverStatus.fromWire(json['status'] as String? ?? 'unavailable'),
    );
  }

  void dispose() {
    _timer?.cancel();
    _updates.close();
  }
}
