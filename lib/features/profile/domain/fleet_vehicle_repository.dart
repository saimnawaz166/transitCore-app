import 'fleet_vehicle.dart';

abstract class FleetVehicleRepository {
  /// Vehicles this driver could pick when going Active: free fleet
  /// vehicles plus whichever one is already theirs.
  Future<List<FleetVehicle>> listSelectable();

  /// Persists the driver's vehicle choice server-side.
  Future<void> select(String vehicleId);
}
