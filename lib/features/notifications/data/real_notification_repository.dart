import '../domain/app_notification.dart';
import '../domain/notification_repository.dart';

/// The backend has no push-notification source of data (same "no push
/// infra" gap already accepted for the rider side) — this returns an
/// honest always-empty stream rather than fabricating fake alerts.
class RealNotificationRepository implements NotificationRepository {
  @override
  Stream<List<AppNotification>> watchMyNotifications() => Stream.value(const []);

  @override
  Future<void> markAsRead(String notificationId) async {}

  @override
  Future<void> markAllAsRead() async {}
}
