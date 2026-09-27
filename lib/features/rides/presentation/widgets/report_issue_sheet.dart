import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

enum RideIssueReason {
  accident('I had an accident', Icons.car_crash_outlined),
  breakdown('My car broke down', Icons.build_outlined),
  trafficJam("I'm stuck in traffic jam", Icons.traffic_outlined),
  bookingChanges('Booking changes requested', Icons.warning_amber_outlined),
  other('Other', Icons.more_horiz),
  technical('Technical issue', Icons.settings_outlined);

  const RideIssueReason(this.label, this.icon);
  final String label;
  final IconData icon;
}

/// Bottom sheet for reporting a job issue — matches the reference app's
/// "Report an issue" flow (dispatch-facing list of reasons).
class ReportIssueSheet extends StatelessWidget {
  const ReportIssueSheet({super.key});

  static Future<RideIssueReason?> show(BuildContext context) {
    return showModalBottomSheet<RideIssueReason>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const ReportIssueSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('CLOSE', style: AppTextStyles.buttonOutline.copyWith(color: AppColors.gold)),
              ),
            ),
            Text('Report an issue', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.sm),
            for (final reason in RideIssueReason.values)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(reason.icon, color: AppColors.gold),
                title: Text(reason.label, style: AppTextStyles.body.copyWith(color: AppColors.gold, fontWeight: FontWeight.w600)),
                onTap: () => Navigator.pop(context, reason),
              ),
          ],
        ),
      ),
    );
  }
}
