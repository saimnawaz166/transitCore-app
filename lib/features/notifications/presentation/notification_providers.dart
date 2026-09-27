import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/real_notification_repository.dart';
import '../domain/app_notification.dart';
import '../domain/notification_repository.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return RealNotificationRepository();
});

final myNotificationsProvider = StreamProvider<List<AppNotification>>((ref) {
  return ref.watch(notificationRepositoryProvider).watchMyNotifications();
});

final unreadNotificationCountProvider = Provider<int>((ref) {
  final items = ref.watch(myNotificationsProvider).value ?? [];
  return items.where((n) => !n.isRead).length;
});
