import 'dart:async';

import '../../rides/domain/ride_models.dart';
import '../domain/driver_profile.dart';
import '../domain/profile_repository.dart';

class FakeProfileRepository implements ProfileRepository {
  FakeProfileRepository() {
    _controller = StreamController<DriverProfile>.broadcast(
      onListen: () => _controller.add(_profile),
    );
  }

  late final StreamController<DriverProfile> _controller;

  final DriverProfile _profile = DriverProfile(
    driverId: 'driver-001',
    fullName: 'Mudassar Hussain',
    driverCode: 'DRV-77219',
    phone: '+966 55 900 1122',
    rating: 4.9,
    completedTrips: 812,
    completionRate: 0.98,
    assignedVehicle: const AssignedVehicle(
      make: 'Mercedes-Benz',
      model: 'E-Class',
      plateNumber: '7353 VKR',
      category: 'Business Sedan',
    ),
    joinedAt: DateTime(2022, 3, 14),
  );

  @override
  Stream<DriverProfile> watchMyProfile() => _controller.stream;

  void dispose() => _controller.close();
}
