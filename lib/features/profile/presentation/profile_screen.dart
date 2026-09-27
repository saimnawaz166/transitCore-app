import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/secure_screen.dart';
import 'profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(myProfileProvider);

    return SecureScreen(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.push('/settings'),
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: profileAsync.when(
          data: (profile) => ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: AppColors.surface,
                      child: const Icon(Icons.person, size: 48, color: AppColors.gold),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(profile.fullName, style: AppTextStyles.headline),
                    const SizedBox(height: 4),
                    Text(profile.driverCode, style: AppTextStyles.bodyMuted),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: _StatTile(
                      icon: Icons.star_rounded,
                      value: profile.rating.toStringAsFixed(1),
                      label: 'Rating',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _StatTile(
                      icon: Icons.check_circle_outline,
                      value: '${profile.completedTrips}',
                      label: 'Trips',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _StatTile(
                      icon: Icons.trending_up_rounded,
                      value: '${(profile.completionRate * 100).round()}%',
                      label: 'Completion',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Assigned Vehicle', style: AppTextStyles.label),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Row(
                  children: [
                    const Icon(Icons.directions_car_filled_outlined, color: AppColors.gold, size: 28),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${profile.assignedVehicle.make} ${profile.assignedVehicle.model}', style: AppTextStyles.title),
                          const SizedBox(height: 2),
                          Text(
                            '${profile.assignedVehicle.category} · ${profile.assignedVehicle.plateNumber}',
                            style: AppTextStyles.bodyMuted,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Contact', style: AppTextStyles.label),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  children: [
                    _InfoRow(icon: Icons.phone_outlined, label: 'Phone', value: profile.phone),
                    const Divider(height: 24),
                    _InfoRow(icon: Icons.event_outlined, label: 'Joined', value: Formatters.date(profile.joinedAt)),
                  ],
                ),
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.gold)),
          error: (e, st) => Center(child: Text('Could not load profile', style: AppTextStyles.bodyMuted)),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.icon, required this.value, required this.label});
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.sm),
      child: Column(
        children: [
          Icon(icon, color: AppColors.gold, size: 20),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.title),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textMuted),
        const SizedBox(width: AppSpacing.md),
        Text(label, style: AppTextStyles.bodyMuted),
        const Spacer(),
        Text(value, style: AppTextStyles.body),
      ],
    );
  }
}
