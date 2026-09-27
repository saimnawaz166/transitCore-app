import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import 'notification_providers.dart';
import '../domain/app_notification.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  IconData _iconFor(NotificationType type) => switch (type) {
        NotificationType.newAssignment => Icons.assignment_outlined,
        NotificationType.statusChange => Icons.sync_alt_rounded,
        NotificationType.system => Icons.info_outline,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(myNotificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () => ref.read(notificationRepositoryProvider).markAllAsRead(),
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: notificationsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Text('No notifications yet', style: AppTextStyles.bodyMuted),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final n = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: AppCard(
                  goldAccent: !n.isRead,
                  onTap: () {
                    ref.read(notificationRepositoryProvider).markAsRead(n.id);
                    if (n.relatedRideId != null) {
                      context.push('/rides/${n.relatedRideId}');
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(_iconFor(n.type), color: AppColors.gold, size: 22),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(n.title, style: AppTextStyles.title),
                            const SizedBox(height: 4),
                            Text(n.body, style: AppTextStyles.bodyMuted),
                            const SizedBox(height: 6),
                            Text(Formatters.relativeTimeAgo(n.createdAt), style: AppTextStyles.caption),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, st) => Center(child: Text('Could not load notifications', style: AppTextStyles.bodyMuted)),
      ),
    );
  }
}
