import '../../../core/services/api_client.dart';
import '../domain/fleet_vehicle.dart';
import '../domain/fleet_vehicle_repository.dart';

class RealFleetVehicleRepository implements FleetVehicleRepository {
  RealFleetVehicleRepository(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<FleetVehicle>> listSelectable() async {
    final response = await _apiClient.dio.get('/vehicles');
    final rows = (response.data as Map<String, dynamic>)['data'] as List;
    return rows.map((row) => _mapVehicle(row as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> select(String vehicleId) async {
    // The id is a plate number (e.g. "B-TC 4471") — encode it, since plates
    // routinely contain spaces.
    await _apiClient.dio.post('/vehicles/${Uri.encodeComponent(vehicleId)}/select');
  }

  FleetVehicle _mapVehicle(Map<String, dynamic> json) {
    return FleetVehicle(
      id: json['id'] as String,
      make: json['make'] as String? ?? '',
      model: json['model'] as String? ?? '',
      plateNumber: json['plateNumber'] as String? ?? '',
      passengerCapacity: json['passengerCapacity'] as int? ?? 0,
      luggageCapacity: json['luggageCapacity'] as int? ?? 0,
      isAvailable: json['isAvailable'] as bool? ?? false,
    );
  }
}
