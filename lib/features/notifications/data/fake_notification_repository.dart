import 'dart:async';

import '../domain/app_notification.dart';
import '../domain/notification_repository.dart';

class FakeNotificationRepository implements NotificationRepository {
  FakeNotificationRepository() {
    _items = _seed();
    _controller = StreamController<List<AppNotification>>.broadcast(
      onListen: () => _controller.add(List.unmodifiable(_items)),
    );
  }

  late final List<AppNotification> _items;
  late final StreamController<List<AppNotification>> _controller;

  @override
  Stream<List<AppNotification>> watchMyNotifications() => _controller.stream;

  @override
  Future<void> markAsRead(String notificationId) async {
    final index = _items.indexWhere((n) => n.id == notificationId);
    if (index == -1) return;
    _items[index] = _items[index].copyWith(isRead: true);
    _controller.add(List.unmodifiable(_items));
  }

  @override
  Future<void> markAllAsRead() async {
    for (var i = 0; i < _items.length; i++) {
      _items[i] = _items[i].copyWith(isRead: true);
    }
    _controller.add(List.unmodifiable(_items));
  }

  List<AppNotification> _seed() {
    final now = DateTime.now();
    return [
      AppNotification(
        id: 'n-1',
        type: NotificationType.newAssignment,
        title: 'New ride assigned',
        body: 'Job JOB-1001 — pickup at Jabal Omar Hyatt Regency, 2:00 PM.',
        createdAt: now.subtract(const Duration(minutes: 5)),
        isRead: false,
        relatedRideId: 'ride-1001',
      ),
      AppNotification(
        id: 'n-2',
        type: NotificationType.statusChange,
        title: 'Trip started',
        body: 'JOB-1003 marked as in progress.',
        createdAt: now.subtract(const Duration(hours: 1)),
        isRead: false,
        relatedRideId: 'ride-1003',
      ),
      AppNotification(
        id: 'n-3',
        type: NotificationType.statusChange,
        title: 'Ride cancelled',
        body: 'Passenger cancelled JOB-1006 before pickup.',
        createdAt: now.subtract(const Duration(hours: 5)),
        isRead: true,
        relatedRideId: 'ride-1006',
      ),
      AppNotification(
        id: 'n-4',
        type: NotificationType.system,
        title: 'App update available',
        body: 'Version 1.1.0 brings improved navigation handoff.',
        createdAt: now.subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];
  }

  void dispose() => _controller.close();
}
