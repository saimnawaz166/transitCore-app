import 'dart:async';

import 'package:dio/dio.dart';

import '../../../core/services/api_client.dart';
import '../domain/app_notification.dart';
import '../domain/notification_repository.dart';

/// Polls `GET /driver/notifications` on a timer — the same honest polling
/// bridge used by [RealRideRepository]/[RealProfileRepository], since the
/// backend has no push/websocket mechanism for this feed either.
class RealNotificationRepository implements NotificationRepository {
  RealNotificationRepository(this._apiClient) {
    _refresh();
    _timer = Timer.periodic(_pollInterval, (_) => _refresh());
  }

  static const _pollInterval = Duration(seconds: 15);

  final ApiClient _apiClient;
  final StreamController<List<AppNotification>> _updates = StreamController<List<AppNotification>>.broadcast();
  List<AppNotification> _cache = [];
  Timer? _timer;

  Future<void> _refresh() async {
    try {
      final response = await _apiClient.dio.get('/notifications');
      final rows = (response.data as Map<String, dynamic>)['data'] as List;
      _cache = rows.map((row) => _mapNotification(row as Map<String, dynamic>)).toList();
      _updates.add(List.unmodifiable(_cache));
    } on DioException {
      // Keep serving the last known snapshot rather than clearing the
      // driver's notification list on a transient network blip.
    }
  }

  @override
  Stream<List<AppNotification>> watchMyNotifications() {
    return Stream<List<AppNotification>>.multi((controller) {
      controller.add(List.unmodifiable(_cache));
      final sub = _updates.stream.listen(controller.add, onError: controller.addError);
      controller.onCancel = sub.cancel;
    });
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _apiClient.dio.post('/notifications/$notificationId/read');
    await _refresh();
  }

  @override
  Future<void> markAllAsRead() async {
    await _apiClient.dio.post('/notifications/read-all');
    await _refresh();
  }

  AppNotification _mapNotification(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      type: _mapType(json['type'] as String?),
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      relatedRideId: json['relatedRideId'] as String?,
    );
  }

  // The backend's notification `type` strings (new_assignment, status_change)
  // are the raw values NotificationService::notifyDriver() is called with —
  // they don't match the enum's generated camelCase JSON names, so this maps
  // by hand rather than relying on AppNotification.fromJson().
  NotificationType _mapType(String? type) => switch (type) {
        'new_assignment' => NotificationType.newAssignment,
        'status_change' => NotificationType.statusChange,
        _ => NotificationType.system,
      };

  void dispose() {
    _timer?.cancel();
    _updates.close();
  }
}
