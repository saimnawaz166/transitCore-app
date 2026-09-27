import 'package:flutter/material.dart';

import '../../features/rides/domain/ride_status.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final RideStatus status;

  Color get _color => switch (status) {
        RideStatus.incoming => AppColors.gold,
        RideStatus.accepted => AppColors.live,
        RideStatus.enRouteToPickup => AppColors.live,
        RideStatus.arrived => AppColors.live,
        RideStatus.inProgress => AppColors.live,
        RideStatus.completed => AppColors.success,
        RideStatus.cancelled => AppColors.danger,
      };

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

/// Teal pulsing "LIVE" pill used on in-progress rides.
class LiveBadge extends StatelessWidget {
  const LiveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.live.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.live.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.podcasts, size: 12, color: AppColors.live),
          const SizedBox(width: 6),
          Text(
            'LIVE TRACKING',
            style: AppTextStyles.caption.copyWith(color: AppColors.live, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
