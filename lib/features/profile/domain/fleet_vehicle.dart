/// A vehicle in the driver's fleet, selectable when going Active.
class FleetVehicle {
  const FleetVehicle({
    required this.id,
    required this.make,
    required this.model,
    required this.plateNumber,
    required this.passengerCapacity,
    required this.luggageCapacity,
    required this.isAvailable,
  });

  final String id;
  final String make;
  final String model;
  final String plateNumber;
  final int passengerCapacity;
  final int luggageCapacity;
  final bool isAvailable;

  String get displayName => '${make.toUpperCase()} ${model.toUpperCase()}';
}
