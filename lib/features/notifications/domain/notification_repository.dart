import 'app_notification.dart';

abstract class NotificationRepository {
  /// Emits notifications belonging to the current driver only.
  Stream<List<AppNotification>> watchMyNotifications();

  Future<void> markAsRead(String notificationId);

  Future<void> markAllAsRead();
}
