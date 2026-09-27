import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/fleet_vehicle.dart';

const _fleetVehicles = [
  FleetVehicle(
    id: 'veh-1',
    make: 'Hyundai',
    model: 'Staria',
    plateNumber: '8663 EXA',
    passengerCapacity: 6,
    luggageCapacity: 6,
    isAvailable: true,
  ),
  FleetVehicle(
    id: 'veh-2',
    make: 'Hyundai',
    model: 'Staria',
    plateNumber: '4648 ATA',
    passengerCapacity: 6,
    luggageCapacity: 6,
    isAvailable: true,
  ),
  FleetVehicle(
    id: 'veh-3',
    make: 'Hyundai',
    model: 'Staria',
    plateNumber: '2854 JXA',
    passengerCapacity: 6,
    luggageCapacity: 6,
    isAvailable: true,
  ),
  FleetVehicle(
    id: 'veh-4',
    make: 'Toyota',
    model: 'Hiace',
    plateNumber: '3719 NRA',
    passengerCapacity: 12,
    luggageCapacity: 12,
    isAvailable: true,
  ),
  FleetVehicle(
    id: 'veh-5',
    make: 'Toyota',
    model: 'Hiace',
    plateNumber: '9296 SSA',
    passengerCapacity: 11,
    luggageCapacity: 11,
    isAvailable: false,
  ),
];

final fleetVehiclesProvider = Provider<List<FleetVehicle>>((ref) => _fleetVehicles);

class SelectedVehicleNotifier extends Notifier<String?> {
  @override
  String? build() => _fleetVehicles.first.id;

  void select(String vehicleId) => state = vehicleId;
}

final selectedVehicleIdProvider = NotifierProvider<SelectedVehicleNotifier, String?>(SelectedVehicleNotifier.new);
