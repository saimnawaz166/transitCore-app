import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../data/real_fleet_vehicle_repository.dart';
import '../domain/fleet_vehicle.dart';
import '../domain/fleet_vehicle_repository.dart';
import 'profile_providers.dart';

final fleetVehicleRepositoryProvider = Provider<FleetVehicleRepository>((ref) {
  return RealFleetVehicleRepository(ref.watch(apiClientProvider));
});

final fleetVehiclesProvider = FutureProvider<List<FleetVehicle>>((ref) {
  return ref.watch(fleetVehicleRepositoryProvider).listSelectable();
});

/// Which vehicle is highlighted while browsing the picker — purely local
/// until "Confirm Selection" actually calls the API, so tapping around
/// doesn't fire a network request per tap.
class SelectedVehicleNotifier extends Notifier<String?> {
  @override
  String? build() {
    final plate = ref.read(myProfileProvider).asData?.value.assignedVehicle.plateNumber;
    return (plate == null || plate == '—') ? null : plate;
  }

  void select(String vehicleId) => state = vehicleId;
}

final selectedVehicleIdProvider = NotifierProvider<SelectedVehicleNotifier, String?>(SelectedVehicleNotifier.new);
