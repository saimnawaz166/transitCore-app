import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../data/real_notification_repository.dart';
import '../domain/app_notification.dart';
import '../domain/notification_repository.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final repo = RealNotificationRepository(ref.watch(apiClientProvider));
  ref.onDispose(repo.dispose);
  return repo;
});

final myNotificationsProvider = StreamProvider<List<AppNotification>>((ref) {
  return ref.watch(notificationRepositoryProvider).watchMyNotifications();
});

final unreadNotificationCountProvider = Provider<int>((ref) {
  final items = ref.watch(myNotificationsProvider).value ?? [];
  return items.where((n) => !n.isRead).length;
});
