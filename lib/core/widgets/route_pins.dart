import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Pickup (green) / drop-off (red) address rows connected by a dotted
/// vertical line, matching the reference app's route layout.
class RoutePinRow extends StatelessWidget {
  const RoutePinRow({
    super.key,
    required this.pickupLabel,
    required this.pickupAddress,
    required this.dropoffLabel,
    required this.dropoffAddress,
  });

  final String pickupLabel;
  final String pickupAddress;
  final String dropoffLabel;
  final String dropoffAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PinRow(color: AppColors.pickup, label: pickupLabel, address: pickupAddress),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: SizedBox(
            height: 20,
            child: CustomPaint(painter: _DottedLinePainter()),
          ),
        ),
        _PinRow(color: AppColors.dropoff, label: dropoffLabel, address: dropoffAddress),
      ],
    );
  }
}

class _PinRow extends StatelessWidget {
  const _PinRow({required this.color, required this.label, required this.address});

  final Color color;
  final String label;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.35), width: 3),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.title),
              const SizedBox(height: 2),
              Text(address, style: AppTextStyles.bodyMuted, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textMuted.withValues(alpha: 0.4)
      ..strokeWidth = 1.5;
    const dashHeight = 3.0;
    const dashSpace = 3.0;
    double y = 0;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(0, y + dashHeight), paint);
      y += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
