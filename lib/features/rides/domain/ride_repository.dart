import 'ride_models.dart';
import 'ride_status.dart';

/// Data-source contract for a driver's rides.
///
/// Streams are used (rather than one-shot futures) so a future push-based
/// backend (websocket/FCM-driven updates) can be swapped in without any
/// change to UI code — screens already subscribe, not poll.
abstract class RideRepository {
  /// Emits the full set of rides assigned to the *current* driver.
  /// Implementations must never include another driver's rides.
  Stream<List<Ride>> watchMyRides();

  Stream<Ride?> watchRide(String rideId);

  Future<void> acceptRide(String rideId);

  Future<void> updateStatus(String rideId, RideStatus newStatus);

  Future<void> cancelRide(String rideId, {String? reason});
}
