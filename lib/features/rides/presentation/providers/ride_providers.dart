import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/fake_ride_repository.dart';
import '../../domain/ride_models.dart';
import '../../domain/ride_repository.dart';
import '../../domain/ride_status.dart';

final rideRepositoryProvider = Provider<RideRepository>((ref) {
  final repo = FakeRideRepository();
  ref.onDispose(repo.dispose);
  return repo;
});

final myRidesProvider = StreamProvider<List<Ride>>((ref) {
  return ref.watch(rideRepositoryProvider).watchMyRides();
});

final rideByIdProvider = StreamProvider.family<Ride?, String>((ref, rideId) {
  return ref.watch(rideRepositoryProvider).watchRide(rideId);
});

final incomingRidesProvider = Provider<List<Ride>>((ref) {
  final rides = ref.watch(myRidesProvider).value ?? [];
  return rides.where((r) => r.status.isIncoming).toList()
    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
});

final currentRidesProvider = Provider<List<Ride>>((ref) {
  final rides = ref.watch(myRidesProvider).value ?? [];
  return rides.where((r) => r.status.isCurrent).toList()
    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
});

final pastRidesProvider = Provider<List<Ride>>((ref) {
  final rides = ref.watch(myRidesProvider).value ?? [];
  return rides.where((r) => r.status.isPast).toList()
    ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
});

final cancelledRidesProvider = Provider<List<Ride>>((ref) {
  final rides = ref.watch(myRidesProvider).value ?? [];
  return rides.where((r) => r.status.isCancelled).toList()
    ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
});

class RideActionsController {
  RideActionsController(this._repository);
  final RideRepository _repository;

  Future<void> accept(String rideId) => _repository.acceptRide(rideId);
  Future<void> updateStatus(String rideId, RideStatus status) =>
      _repository.updateStatus(rideId, status);
  Future<void> cancel(String rideId, {String? reason}) =>
      _repository.cancelRide(rideId, reason: reason);
}

final rideActionsProvider = Provider<RideActionsController>((ref) {
  return RideActionsController(ref.watch(rideRepositoryProvider));
});
