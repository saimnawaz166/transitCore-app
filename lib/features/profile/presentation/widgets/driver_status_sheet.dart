import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/gold_button.dart';
import '../../domain/driver_status.dart';
import '../driver_status_provider.dart';

Color driverStatusColor(DriverStatus status) => switch (status) {
      DriverStatus.active => AppColors.success,
      DriverStatus.onBreak => AppColors.warning,
      DriverStatus.unavailable => AppColors.danger,
    };

/// Bottom sheet for the driver to switch their availability — inspired by
/// the reference app's "Choose your status" flow, restyled for this app's
/// black & gold theme.
class DriverStatusSheet extends ConsumerStatefulWidget {
  const DriverStatusSheet({super.key});

  /// Returns the newly confirmed status, or null if dismissed without
  /// confirming a change.
  static Future<DriverStatus?> show(BuildContext context) {
    return showModalBottomSheet<DriverStatus>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const DriverStatusSheet(),
    );
  }

  @override
  ConsumerState<DriverStatusSheet> createState() => _DriverStatusSheetState();
}

class _DriverStatusSheetState extends ConsumerState<DriverStatusSheet> {
  late DriverStatus _selected = ref.read(driverStatusProvider);
  bool _saving = false;

  Future<void> _confirm() async {
    setState(() => _saving = true);
    try {
      await ref.read(driverStatusProvider.notifier).setStatus(_selected);
      if (mounted) Navigator.pop(context, _selected);
    } catch (_) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't update your status — please try again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = ref.watch(driverStatusProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.textMuted),
                ),
                Expanded(
                  child: Text('Choose your status', style: AppTextStyles.headline, textAlign: TextAlign.center),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            for (final status in DriverStatus.values) ...[
              _StatusOption(
                status: status,
                isCurrent: status == current,
                isSelected: status == _selected,
                onTap: () => setState(() => _selected = status),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            const SizedBox(height: AppSpacing.sm),
            GoldButton(
              label: 'Confirm Status',
              isLoading: _saving,
              onPressed: _selected == current ? null : _confirm,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  const _StatusOption({
    required this.status,
    required this.isCurrent,
    required this.isSelected,
    required this.onTap,
  });

  final DriverStatus status;
  final bool isCurrent;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = driverStatusColor(status);
    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: isSelected ? AppColors.gold : AppColors.surfaceBorder, width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(status.label, style: AppTextStyles.title),
                      if (isCurrent) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text('CURRENT', style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(status.description, style: AppTextStyles.bodyMuted),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.gold : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
