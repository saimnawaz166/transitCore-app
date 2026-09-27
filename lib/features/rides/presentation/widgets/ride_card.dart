import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/route_pins.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/ride_models.dart';
import '../../domain/ride_status.dart';

class RideCard extends StatelessWidget {
  const RideCard({super.key, required this.ride, required this.onTap});

  final Ride ride;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      goldAccent: true,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(ride.jobId, style: AppTextStyles.label),
              ),
              StatusBadge(status: ride.status),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.schedule, size: 15, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Text(
                '${Formatters.relativeDay(ride.scheduledAt)} · ${Formatters.time(ride.scheduledAt)}',
                style: AppTextStyles.body,
              ),
              if (ride.passengerCount != null) ...[
                const SizedBox(width: 10),
                const Icon(Icons.person_outline, size: 15, color: AppColors.textMuted),
                const SizedBox(width: 3),
                Text('${ride.passengerCount}', style: AppTextStyles.bodyMuted),
              ],
              if (ride.luggageCount != null) ...[
                const SizedBox(width: 10),
                const Icon(Icons.work_outline, size: 15, color: AppColors.textMuted),
                const SizedBox(width: 3),
                Text('${ride.luggageCount}', style: AppTextStyles.bodyMuted),
              ],
            ],
          ),
          if (ride.status == RideStatus.inProgress) ...[
            const SizedBox(height: 8),
            const LiveBadge(),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.directions_car_filled_outlined, size: 15, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${ride.vehicle.category} · ${ride.vehicle.make} ${ride.vehicle.model} · ${ride.vehicle.plateNumber}',
                  style: AppTextStyles.bodyMuted,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          RoutePinRow(
            pickupLabel: ride.pickup.label,
            pickupAddress: ride.pickup.address,
            dropoffLabel: ride.dropoff.label,
            dropoffAddress: ride.dropoff.address,
          ),
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  ride.passenger.name,
                  style: AppTextStyles.body,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                Formatters.currency(ride.fare.driverPayout, ride.fare.currency),
                style: AppTextStyles.title.copyWith(color: AppColors.gold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
