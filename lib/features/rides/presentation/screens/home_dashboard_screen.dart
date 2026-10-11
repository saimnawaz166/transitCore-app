import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/secure_screen.dart';
import '../../../profile/domain/driver_status.dart';
import '../../../profile/presentation/driver_status_provider.dart';
import '../../../profile/presentation/profile_providers.dart';
import '../../../profile/presentation/screens/select_car_screen.dart';
import '../../../profile/presentation/widgets/driver_status_sheet.dart';
import '../providers/ride_providers.dart';
import '../widgets/ride_card.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myProfileProvider).value;
    final driverStatus = ref.watch(driverStatusProvider);
    final incoming = ref.watch(incomingRidesProvider);
    final current = ref.watch(currentRidesProvider);
    final past = ref.watch(pastRidesProvider);

    final todaysPayout = [...current, ...past]
        .where((r) => Formatters.relativeDay(r.scheduledAt) == 'Today')
        .fold<double>(0, (sum, r) => sum + r.fare.driverPayout);

    return SecureScreen(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text('Hi, ${profile?.fullName.split(' ').first ?? 'Driver'}'),
          actions: [
            _DriverStatusChip(
              status: driverStatus,
              onTap: () async {
                final confirmed = await DriverStatusSheet.show(context);
                if (confirmed == DriverStatus.active && context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SelectCarScreen()),
                  );
                }
              },
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => context.push('/notifications'),
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: RefreshIndicator(
          color: AppColors.gold,
          backgroundColor: AppColors.surface,
          onRefresh: () => ref.read(rideRepositoryProvider).refresh(),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: "Today's Payout",
                      value: Formatters.currency(todaysPayout, 'SAR'),
                      icon: Icons.payments_outlined,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _StatCard(
                      label: 'Active Jobs',
                      value: '${current.length}',
                      icon: Icons.local_shipping_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              if (incoming.isNotEmpty) ...[
                Text('New Assignments', style: AppTextStyles.headline),
                const SizedBox(height: AppSpacing.md),
                ...incoming.take(2).map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: RideCard(ride: r, onTap: () => context.push('/rides/${r.id}')),
                      ),
                    ),
                const SizedBox(height: AppSpacing.lg),
              ],
              if (current.isNotEmpty) ...[
                Text('Current Ride', style: AppTextStyles.headline),
                const SizedBox(height: AppSpacing.md),
                ...current.take(1).map(
                      (r) => RideCard(ride: r, onTap: () => context.push('/rides/${r.id}')),
                    ),
              ],
              if (incoming.isEmpty && current.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                  child: Column(
                    children: [
                      const Icon(Icons.local_taxi_outlined, size: 56, color: AppColors.textMuted),
                      const SizedBox(height: AppSpacing.md),
                      Text('No active jobs right now', style: AppTextStyles.title),
                      const SizedBox(height: 4),
                      Text('New dispatcher assignments will appear here.', style: AppTextStyles.bodyMuted),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DriverStatusChip extends StatelessWidget {
  const _DriverStatusChip({required this.status, required this.onTap});

  final DriverStatus status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = driverStatusColor(status);
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text(status.label, style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.gold, size: 22),
          const SizedBox(height: AppSpacing.md),
          Text(value, style: AppTextStyles.headline),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
