import 'dart:async';

import 'package:dio/dio.dart';

import '../../../core/services/api_client.dart';
import '../domain/ride_models.dart';
import '../domain/ride_repository.dart';
import '../domain/ride_status.dart';

/// Polls `GET /driver/bookings` on a timer and bridges it onto the
/// stream-based [RideRepository] contract — the backend has no
/// push/websocket mechanism, so this is an honest bridge, not a fabricated
/// real-time claim. Every mutation triggers an immediate re-poll so the UI
/// reflects the change without waiting for the next tick.
class RealRideRepository implements RideRepository {
  RealRideRepository(this._apiClient) {
    _refresh();
    _timer = Timer.periodic(_pollInterval, (_) => _refresh());
  }

  static const _pollInterval = Duration(seconds: 8);

  final ApiClient _apiClient;
  final StreamController<List<Ride>> _updates = StreamController<List<Ride>>.broadcast();
  List<Ride> _cache = [];
  Timer? _timer;

  Future<void> _refresh() async {
    try {
      final response = await _apiClient.dio.get('/bookings', queryParameters: {'per_page': 100});
      final rows = (response.data as Map<String, dynamic>)['data'] as List;
      _cache = rows.map((row) => _mapBooking(row as Map<String, dynamic>)).toList();
      _updates.add(List.unmodifiable(_cache));
    } on DioException {
      // Keep serving the last known snapshot rather than clearing the
      // driver's job list on a transient network blip.
    }
  }

  @override
  Stream<List<Ride>> watchMyRides() {
    // Stream.multi so every new listener (e.g. each rideByIdProvider.family
    // instance) gets the current snapshot immediately, matching the fake
    // implementation's behaviour.
    return Stream<List<Ride>>.multi((controller) {
      controller.add(List.unmodifiable(_cache));
      final sub = _updates.stream.listen(controller.add, onError: controller.addError);
      controller.onCancel = sub.cancel;
    });
  }

  @override
  Stream<Ride?> watchRide(String rideId) {
    return watchMyRides().map(
      (rides) => rides.where((r) => r.id == rideId).cast<Ride?>().firstOrNull,
    );
  }

  @override
  Future<void> acceptRide(String rideId) async {
    await _apiClient.dio.post('/bookings/$rideId/advance');
    await _refresh();
  }

  @override
  Future<void> updateStatus(String rideId, RideStatus newStatus) async {
    // The backend drives a fixed accepted -> en_route -> arrived ->
    // in_progress sequence itself via a single /advance endpoint — the UI
    // already only ever asks for the next step, never a specific target
    // state, so newStatus only needs to distinguish "advance" from
    // "complete" (a separate endpoint since it also moves the booking's tab).
    final path = newStatus == RideStatus.completed ? 'complete' : 'advance';
    await _apiClient.dio.post('/bookings/$rideId/$path');
    await _refresh();
  }

  @override
  Future<void> cancelRide(String rideId, {String? reason}) async {
    await _apiClient.dio.post('/bookings/$rideId/cancel', data: {
      if (reason != null) 'reason': reason,
    });
    await _refresh();
  }

  @override
  Future<void> reportIssue(String rideId, {required String reason, String? note}) async {
    await _apiClient.dio.post('/bookings/$rideId/report-issue', data: {
      'reason': reason,
      if (note != null) 'note': note,
    });
    await _refresh();
  }

  Ride _mapBooking(Map<String, dynamic> json) {
    final pickup = json['pickup'] as Map<String, dynamic>;
    final dropoff = json['dropoff'] as Map<String, dynamic>;
    final passenger = json['passenger'] as Map<String, dynamic>;
    final driver = json['driver'] as Map<String, dynamic>;
    final vehicleDetails = driver['vehicleDetails'] as Map<String, dynamic>?;
    final gross = (json['gross'] as num?)?.toDouble() ?? 0.0;
    final payout = (json['payout'] as num?)?.toDouble() ?? 0.0;

    return Ride(
      id: json['id'] as String,
      jobId: json['id'] as String,
      scheduledAt: _parseScheduledAt(json['date'] as String?, json['pickupTime'] as String?),
      status: _mapStatus(json['tab'] as String, json['driverProgress'] as String?),
      // No map/geocoding integration anywhere in this app by design (see
      // _RouteMapPlaceholder) — lat/lng are required by the model but never
      // actually read by any widget.
      pickup: RideLocation(label: pickup['name'] as String? ?? '', address: pickup['address'] as String? ?? '', lat: 0.0, lng: 0.0),
      dropoff: RideLocation(label: dropoff['name'] as String? ?? '', address: dropoff['address'] as String? ?? '', lat: 0.0, lng: 0.0),
      passenger: Passenger(name: passenger['name'] as String? ?? '', phone: passenger['phone'] as String? ?? ''),
      vehicle: vehicleDetails == null
          ? const AssignedVehicle(make: '—', model: '—', plateNumber: '—', category: '—')
          : AssignedVehicle(
              make: vehicleDetails['make'] as String? ?? '—',
              model: vehicleDetails['model'] as String? ?? '—',
              plateNumber: vehicleDetails['registration'] as String? ?? '—',
              category: vehicleDetails['type'] as String? ?? '—',
            ),
      // The backend's fare is genuinely flat (gross/payout only) — no
      // base/distance/surcharge split exists, so the surcharge row this UI
      // already hides when zero stays hidden here too.
      fare: FareBreakdown(baseFare: gross, distanceFare: 0, surcharge: 0, driverPayout: payout, currency: 'SAR'),
      // Unused outside the fake store's own filtering (the server already
      // scopes /bookings to the authenticated driver) — never read by UI.
      driverId: 'me',
      passengerCount: passenger['passengers'] as int?,
      luggageCount: passenger['luggage'] as int?,
      notes: passenger['notes'] as String?,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      pinRequired: json['pinRequired'] as bool? ?? false,
    );
  }

  DateTime _parseScheduledAt(String? date, String? time) {
    if (date == null) return DateTime.now();
    final d = DateTime.parse(date);
    final parts = (time ?? '00:00').split(':');
    final hour = int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 0;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0;
    return DateTime(d.year, d.month, d.day, hour, minute);
  }

  RideStatus _mapStatus(String tab, String? driverProgress) {
    if (tab == 'cancelled') return RideStatus.cancelled;
    if (tab == 'past') return RideStatus.completed;
    return switch (driverProgress) {
      'accepted' => RideStatus.accepted,
      'en_route' => RideStatus.enRouteToPickup,
      'arrived' => RideStatus.arrived,
      'in_progress' => RideStatus.inProgress,
      _ => RideStatus.incoming,
    };
  }

  void dispose() {
    _timer?.cancel();
    _updates.close();
  }
}
