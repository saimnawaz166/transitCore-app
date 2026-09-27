import 'dart:async';

import '../domain/ride_models.dart';
import '../domain/ride_repository.dart';
import '../domain/ride_status.dart';

/// In-memory fake implementation of [RideRepository].
///
/// Simulates a single logged-in driver ("driver-001") who can only ever
/// see rides assigned to them. Mutations update the in-memory store and
/// re-emit on the broadcast stream, mimicking how a push-based backend
/// (websocket/FCM) would drive updates once wired up.
class FakeRideRepository implements RideRepository {
  FakeRideRepository() {
    _rides = _seedRides();
  }

  static const _currentDriverId = 'driver-001';

  late final List<Ride> _rides;
  final StreamController<List<Ride>> _updates = StreamController<List<Ride>>.broadcast();

  @override
  Stream<List<Ride>> watchMyRides() {
    // Stream.multi so every new listener (e.g. each rideByIdProvider.family
    // instance) gets the current snapshot immediately instead of only the
    // very first ever subscriber — a plain broadcast StreamController never
    // replays past events to late listeners.
    return Stream<List<Ride>>.multi((controller) {
      controller.add(List.unmodifiable(_rides));
      final sub = _updates.stream.listen(controller.add, onError: controller.addError);
      controller.onCancel = sub.cancel;
    }).map(
      // Defensive filter: even in the fake store, never surface another
      // driver's rides — keeps the UI's access assumption honest.
      (rides) => rides.where((r) => r.driverId == _currentDriverId).toList(),
    );
  }

  @override
  Stream<Ride?> watchRide(String rideId) {
    return watchMyRides().map(
      (rides) => rides.where((r) => r.id == rideId).cast<Ride?>().firstOrNull,
    );
  }

  @override
  Future<void> acceptRide(String rideId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mutate(rideId, RideStatus.accepted);
  }

  @override
  Future<void> updateStatus(String rideId, RideStatus newStatus) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mutate(rideId, newStatus);
  }

  @override
  Future<void> cancelRide(String rideId, {String? reason}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mutate(rideId, RideStatus.cancelled, notes: reason);
  }

  @override
  Future<void> reportIssue(String rideId, {required String reason, String? note}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // No backend concept in the fake store — the real repository is the one
    // that actually files this; here it's just acknowledged.
  }

  void _mutate(String rideId, RideStatus status, {String? notes}) {
    final index = _rides.indexWhere((r) => r.id == rideId);
    if (index == -1) return;
    _rides[index] = _rides[index].copyWith(
      status: status,
      notes: notes ?? _rides[index].notes,
    );
    _updates.add(List.unmodifiable(_rides));
  }

  List<Ride> _seedRides() {
    final now = DateTime.now();
    return [
      Ride(
        id: 'ride-1001',
        jobId: 'JOB-1001',
        scheduledAt: now.add(const Duration(hours: 2)),
        status: RideStatus.incoming,
        pickup: const RideLocation(
          label: 'Jabal Omar Hyatt Regency',
          address: 'Jabal Omar Hyatt Regency Makkah, Al Hajlah, Makkah 24231, Saudi Arabia',
          lat: 21.4187,
          lng: 39.8256,
        ),
        dropoff: const RideLocation(
          label: 'King Abdulaziz Intl Airport',
          address: 'King Abdulaziz International Airport, Jeddah 21589, Saudi Arabia',
          lat: 21.6796,
          lng: 39.1565,
        ),
        passenger: const Passenger(
          name: 'Ahmed Al-Farsi',
          phone: '+966 55 123 4567',
        ),
        vehicle: const AssignedVehicle(
          make: 'Mercedes-Benz',
          model: 'E-Class',
          plateNumber: '7353 VKR',
          category: 'Business Sedan',
        ),
        fare: const FareBreakdown(
          baseFare: 120,
          distanceFare: 340,
          surcharge: 25,
          driverPayout: 372.5,
          currency: 'SAR',
        ),
        driverId: _currentDriverId,
        passengerCount: 2,
        luggageCount: 3,
        pickupInstructions: 'Meet at the main lobby entrance, ask the concierge for the airport transfer desk.',
        voucherCode: 'FD-72881-AH',
        distanceKm: 79.4,
        pickupSignedBy: null,
        tollFeesAllowed: true,
        extrasAllowed: true,
        pinRequired: false,
      ),
      Ride(
        id: 'ride-1002',
        jobId: 'JOB-1002',
        scheduledAt: now.add(const Duration(minutes: 40)),
        status: RideStatus.accepted,
        pickup: const RideLocation(
          label: 'Sofitel Shahd Al Madinah',
          address: 'Sofitel Shahd Al Madinah, King Fahd Rd, Medina 42311, Saudi Arabia',
          lat: 24.4672,
          lng: 39.6111,
        ),
        dropoff: const RideLocation(
          label: 'Prince Mohammad Airport',
          address: 'Prince Mohammad Bin Abdulaziz Airport, Medina, Saudi Arabia',
          lat: 24.5534,
          lng: 39.7051,
        ),
        passenger: const Passenger(
          name: 'Layla Haddad',
          phone: '+966 50 987 6543',
        ),
        vehicle: const AssignedVehicle(
          make: 'Toyota',
          model: 'Hiace',
          plateNumber: '3130 NRA',
          category: 'Minibus',
        ),
        fare: const FareBreakdown(
          baseFare: 90,
          distanceFare: 210,
          surcharge: 0,
          driverPayout: 255.0,
          currency: 'SAR',
        ),
        driverId: _currentDriverId,
        passengerCount: 6,
        luggageCount: 6,
        pickupInstructions: 'Group booking — driver to call 10 minutes before arrival, gather at the hotel valet bay.',
        voucherCode: 'FD-62628-LH',
        distanceKm: 438.13,
        pickupSignedBy: null,
        tollFeesAllowed: false,
        extrasAllowed: false,
        pinRequired: false,
      ),
      Ride(
        id: 'ride-1003',
        jobId: 'JOB-1003',
        scheduledAt: now.subtract(const Duration(minutes: 15)),
        status: RideStatus.inProgress,
        pickup: const RideLocation(
          label: 'Ritz-Carlton Riyadh',
          address: 'Ritz-Carlton, Al Hada, Riyadh 12511, Saudi Arabia',
          lat: 24.6584,
          lng: 46.6931,
        ),
        dropoff: const RideLocation(
          label: 'King Khalid Intl Airport',
          address: 'King Khalid International Airport, Riyadh, Saudi Arabia',
          lat: 24.9576,
          lng: 46.6988,
        ),
        passenger: const Passenger(
          name: 'Omar Nasser',
          phone: '+966 54 222 1188',
        ),
        vehicle: const AssignedVehicle(
          make: 'BMW',
          model: '7 Series',
          plateNumber: '9021 LMK',
          category: 'Luxury Sedan',
        ),
        fare: const FareBreakdown(
          baseFare: 150,
          distanceFare: 280,
          surcharge: 40,
          driverPayout: 411.0,
          currency: 'SAR',
        ),
        driverId: _currentDriverId,
        passengerCount: 1,
        luggageCount: 2,
        pickupInstructions: 'VIP guest — pickup from the private lounge, not the main entrance.',
        voucherCode: 'FD-90112-ON',
        distanceKm: 41.7,
        pickupSignedBy: 'Omar Nasser',
        tollFeesAllowed: true,
        extrasAllowed: true,
        pinRequired: true,
      ),
      Ride(
        id: 'ride-1004',
        jobId: 'JOB-1004',
        scheduledAt: now.subtract(const Duration(days: 1, hours: 3)),
        status: RideStatus.completed,
        pickup: const RideLocation(
          label: 'Jabal Omar Hyatt Regency',
          address: 'Jabal Omar Hyatt Regency Makkah, Helipad Kaaba, 6915, Makkah 24231, Saudi Arabia',
          lat: 21.4187,
          lng: 39.8256,
        ),
        dropoff: const RideLocation(
          label: 'Sofitel Shahd Al Madinah',
          address: 'Sofitel Shahd Al Madinah, King Fahd Rd, Bada\'ah, Building 2943, Medina 42311, Saudi Arabia',
          lat: 24.4672,
          lng: 39.6111,
        ),
        passenger: const Passenger(
          name: 'Fatima Zahra',
          phone: '+966 56 334 7789',
        ),
        vehicle: const AssignedVehicle(
          make: 'Mitsubishi',
          model: 'Xpander',
          plateNumber: '7353 VKR',
          category: 'Economy MPV',
        ),
        fare: const FareBreakdown(
          baseFare: 100,
          distanceFare: 320,
          surcharge: 0,
          driverPayout: 378.0,
          currency: 'SAR',
        ),
        driverId: _currentDriverId,
        passengerCount: 3,
        luggageCount: 4,
        voucherCode: 'FD-11004-FZ',
        distanceKm: 358.2,
        pickupSignedBy: 'Fatima Zahra',
      ),
      Ride(
        id: 'ride-1005',
        jobId: 'JOB-1005',
        scheduledAt: now.subtract(const Duration(days: 3)),
        status: RideStatus.completed,
        pickup: const RideLocation(
          label: 'Four Seasons Riyadh',
          address: 'Four Seasons Hotel, Kingdom Centre, Riyadh, Saudi Arabia',
          lat: 24.7115,
          lng: 46.6748,
        ),
        dropoff: const RideLocation(
          label: 'King Khalid Intl Airport',
          address: 'King Khalid International Airport, Riyadh, Saudi Arabia',
          lat: 24.9576,
          lng: 46.6988,
        ),
        passenger: const Passenger(
          name: 'Yousef Al-Amin',
          phone: '+966 53 887 6612',
        ),
        vehicle: const AssignedVehicle(
          make: 'BMW',
          model: '7 Series',
          plateNumber: '9021 LMK',
          category: 'Luxury Sedan',
        ),
        fare: const FareBreakdown(
          baseFare: 150,
          distanceFare: 260,
          surcharge: 0,
          driverPayout: 369.0,
          currency: 'SAR',
        ),
        driverId: _currentDriverId,
        passengerCount: 2,
        luggageCount: 2,
        voucherCode: 'FD-11005-YA',
        distanceKm: 46.3,
        pickupSignedBy: 'Yousef Al-Amin',
      ),
      Ride(
        id: 'ride-1006',
        jobId: 'JOB-1006',
        scheduledAt: now.subtract(const Duration(hours: 5)),
        status: RideStatus.cancelled,
        pickup: const RideLocation(
          label: 'Al Faisaliah Hotel',
          address: 'Al Faisaliah Hotel, King Fahd Rd, Riyadh, Saudi Arabia',
          lat: 24.6912,
          lng: 46.6852,
        ),
        dropoff: const RideLocation(
          label: 'King Khalid Intl Airport',
          address: 'King Khalid International Airport, Riyadh, Saudi Arabia',
          lat: 24.9576,
          lng: 46.6988,
        ),
        passenger: const Passenger(
          name: 'Sara Idris',
          phone: '+966 58 445 2200',
        ),
        vehicle: const AssignedVehicle(
          make: 'Mercedes-Benz',
          model: 'E-Class',
          plateNumber: '7353 VKR',
          category: 'Business Sedan',
        ),
        fare: const FareBreakdown(
          baseFare: 120,
          distanceFare: 300,
          surcharge: 0,
          driverPayout: 0,
          currency: 'SAR',
        ),
        driverId: _currentDriverId,
        passengerCount: 1,
        luggageCount: 1,
        notes: 'Passenger cancelled before pickup',
      ),
    ];
  }

  void dispose() => _updates.close();
}
