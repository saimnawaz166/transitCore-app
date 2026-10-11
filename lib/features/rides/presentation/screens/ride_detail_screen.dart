import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/api_error.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/gold_button.dart';
import '../../../../core/widgets/secure_screen.dart';
import '../../../../core/widgets/slide_action.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/ride_models.dart';
import '../../domain/ride_status.dart';
import '../providers/ride_providers.dart';
import '../widgets/report_issue_sheet.dart';

class RideDetailScreen extends ConsumerWidget {
  const RideDetailScreen({super.key, required this.rideId});

  final String rideId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideAsync = ref.watch(rideByIdProvider(rideId));

    return SecureScreen(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: rideAsync.when(
          data: (ride) {
            if (ride == null) {
              return const Center(child: _NotFound());
            }
            return _RideDetailBody(ride: ride);
          },
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.gold)),
          error: (e, st) => Center(child: Text('Something went wrong', style: AppTextStyles.bodyMuted)),
        ),
      ),
    );
  }
}

class _NotFound extends StatelessWidget {
  const _NotFound();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back, color: AppColors.textMuted),
        ),
        Text('Ride not found', style: AppTextStyles.body),
      ],
    );
  }
}

class _RideDetailBody extends ConsumerStatefulWidget {
  const _RideDetailBody({required this.ride});
  final Ride ride;

  @override
  ConsumerState<_RideDetailBody> createState() => _RideDetailBodyState();
}

class _RideDetailBodyState extends ConsumerState<_RideDetailBody> {
  bool _isActing = false;

  Future<void> _handlePrimaryAction() async {
    setState(() => _isActing = true);
    final actions = ref.read(rideActionsProvider);
    final ride = widget.ride;
    try {
      switch (ride.status) {
        case RideStatus.incoming:
          await actions.accept(ride.id);
        case RideStatus.accepted:
          await actions.updateStatus(ride.id, RideStatus.enRouteToPickup);
        case RideStatus.enRouteToPickup:
          await actions.updateStatus(ride.id, RideStatus.arrived);
        case RideStatus.arrived:
          await actions.updateStatus(ride.id, RideStatus.inProgress);
        case RideStatus.inProgress:
          await actions.updateStatus(ride.id, RideStatus.completed);
        case RideStatus.completed:
        case RideStatus.cancelled:
          break;
      }
    } on DioException catch (e) {
      // Without this, a rejected action (e.g. the backend's own validation
      // rules) just silently resets the button with zero explanation —
      // which reads as "stuck", not as an error.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(extractApiErrorMessage(e) ?? "Couldn't update this job — please try again.")),
        );
      }
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  String get _primaryLabel => switch (widget.ride.status) {
        RideStatus.incoming => 'Accept Job',
        RideStatus.accepted => 'Start Trip',
        RideStatus.enRouteToPickup => 'Mark Arrived',
        RideStatus.arrived => 'Begin Trip',
        RideStatus.inProgress => 'Arrived at Destination',
        RideStatus.completed || RideStatus.cancelled => '',
      };

  bool get _showNavigate =>
      widget.ride.status == RideStatus.accepted ||
      widget.ride.status == RideStatus.enRouteToPickup ||
      widget.ride.status == RideStatus.arrived ||
      widget.ride.status == RideStatus.inProgress;

  bool get _showLiveTracking =>
      widget.ride.status == RideStatus.accepted ||
      widget.ride.status == RideStatus.enRouteToPickup ||
      widget.ride.status == RideStatus.arrived ||
      widget.ride.status == RideStatus.inProgress;

  bool get _canCancel =>
      widget.ride.status != RideStatus.completed && widget.ride.status != RideStatus.cancelled;

  Future<void> _callPassenger(String phone) => _launchUri(Uri(scheme: 'tel', path: phone));

  Future<void> _messagePassenger(String phone) => _launchUri(Uri(scheme: 'sms', path: phone));

  Future<void> _launchUri(Uri uri) async {
    final launched = await launchUrl(uri);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No app found to handle this action.')),
      );
    }
  }

  Future<void> _confirmCancel() async {
    final reason = await showDialog<String>(
      context: context,
      builder: (context) => _CancelDialog(),
    );
    if (reason == null) return;
    try {
      await ref.read(rideActionsProvider).cancel(widget.ride.id, reason: reason);
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(extractApiErrorMessage(e) ?? "Couldn't cancel this job — please try again.")),
        );
      }
    }
  }

  Future<void> _reportIssue() async {
    final reason = await ReportIssueSheet.show(context);
    if (reason == null || !mounted) return;
    try {
      await ref.read(rideActionsProvider).reportIssue(widget.ride.id, reason: reason.label);
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(extractApiErrorMessage(e) ?? "Couldn't report this issue — please try again.")),
        );
      }
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reported: ${reason.label}')),
    );
  }

  void _showPickupInstructions(String instructions) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Pickup instructions'),
        content: Text(instructions, style: AppTextStyles.body),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showVoucher(String code) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Voucher: $code')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ride = widget.ride;

    return Column(
      children: [
        Expanded(child: _buildScrollBody(context, ride)),
        _buildActionBar(context),
      ],
    );
  }

  Widget _buildScrollBody(BuildContext context, Ride ride) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.background,
          pinned: true,
          expandedHeight: 200,
          title: Text(ride.jobId, style: AppTextStyles.title),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.lg),
              child: OutlinedButton(
                onPressed: _reportIssue,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.danger,
                  side: BorderSide(color: AppColors.danger.withValues(alpha: 0.5)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: const Text('REPORT AN ISSUE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
          flexibleSpace: const FlexibleSpaceBar(background: _RouteMapPlaceholder()),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverList.list(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Formatters.relativeDay(ride.scheduledAt), style: AppTextStyles.label),
                  StatusBadge(status: ride.status),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(Formatters.time(ride.scheduledAt), style: AppTextStyles.displayLarge.copyWith(fontSize: 26)),
                  const SizedBox(width: AppSpacing.md),
                  if (ride.passengerCount != null) ...[
                    const Icon(Icons.person_outline, size: 18, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text('${ride.passengerCount}', style: AppTextStyles.body),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  if (ride.luggageCount != null) ...[
                    const Icon(Icons.work_outline, size: 18, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text('${ride.luggageCount}', style: AppTextStyles.body),
                  ],
                ],
              ),
              if (_showLiveTracking) ...[
                const SizedBox(height: AppSpacing.sm),
                const LiveBadge(),
              ],
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  const Icon(Icons.directions_car_filled_outlined, size: 18, color: AppColors.textMuted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${ride.vehicle.category} · ${ride.vehicle.make} ${ride.vehicle.model} · ${ride.vehicle.plateNumber}',
                      style: AppTextStyles.bodyMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const Divider(height: 1),
              const SizedBox(height: AppSpacing.lg),

              // Pickup
              _LocationRow(label: ride.pickup.label, address: ride.pickup.address),
              if (ride.pickupInstructions != null) ...[
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: GestureDetector(
                    onTap: () => _showPickupInstructions(ride.pickupInstructions!),
                    child: Text(
                      'PICKUP INSTRUCTIONS',
                      style: AppTextStyles.caption.copyWith(color: AppColors.gold, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person_outline, size: 16, color: AppColors.textMuted),
                              const SizedBox(width: 8),
                              Expanded(child: Text(ride.passenger.name, style: AppTextStyles.body)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.phone_outlined, size: 16, color: AppColors.textMuted),
                              const SizedBox(width: 8),
                              Text(ride.passenger.phone, style: AppTextStyles.bodyMuted),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => _messagePassenger(ride.passenger.phone),
                      icon: const Icon(Icons.message_outlined, color: AppColors.gold),
                      style: IconButton.styleFrom(side: BorderSide(color: AppColors.gold.withValues(alpha: 0.5)), shape: const CircleBorder()),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _callPassenger(ride.passenger.phone),
                      icon: const Icon(Icons.call_outlined, color: AppColors.gold),
                      style: IconButton.styleFrom(side: BorderSide(color: AppColors.gold.withValues(alpha: 0.5)), shape: const CircleBorder()),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Dropoff
              _LocationRow(label: ride.dropoff.label, address: ride.dropoff.address),

              const SizedBox(height: AppSpacing.lg),
              const Divider(height: 1),
              const SizedBox(height: AppSpacing.lg),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Booking details', style: AppTextStyles.label),
                  if (ride.voucherCode != null)
                    OutlinedButton(
                      onPressed: () => _showVoucher(ride.voucherCode!),
                      style: OutlinedButton.styleFrom(foregroundColor: AppColors.gold, side: const BorderSide(color: AppColors.gold)),
                      child: const Text('VOUCHER', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              if (ride.passengerCount != null)
                _IconTextRow(icon: Icons.person_outline, text: '${ride.passengerCount} passengers'),
              if (ride.luggageCount != null)
                _IconTextRow(icon: Icons.work_outline, text: '${ride.luggageCount} pieces of luggage'),

              const SizedBox(height: AppSpacing.lg),
              Text('Pickup type', style: AppTextStyles.label),
              const SizedBox(height: AppSpacing.sm),
              const _IconTextRow(icon: Icons.location_on_outlined, text: 'Regular'),
              _IconTextRow(
                icon: Icons.toll_outlined,
                text: ride.tollFeesAllowed ? 'Toll fees are allowed' : 'Toll fees are not allowed',
              ),
              _IconTextRow(
                icon: Icons.star_border,
                text: ride.extrasAllowed ? 'Extras allowed via FleetOps' : 'No extras via FleetOps',
              ),
              _IconTextRow(
                icon: Icons.pin_outlined,
                text: ride.pinRequired ? 'PIN required' : 'No PIN required',
              ),

              if (ride.distanceKm != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text('Payment details', style: AppTextStyles.label),
                const SizedBox(height: AppSpacing.sm),
                _IconTextRow(icon: Icons.route_outlined, text: '${ride.distanceKm!.toStringAsFixed(2)} km'),
              ],

              const SizedBox(height: AppSpacing.lg),
              Text('Pickup sign', style: AppTextStyles.label),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  const Icon(Icons.draw_outlined, size: 18, color: AppColors.textMuted),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      ride.pickupSignedBy ?? 'Not yet signed',
                      style: AppTextStyles.body,
                    ),
                  ),
                  if (ride.pickupSignedBy != null)
                    const Icon(Icons.chevron_right, color: AppColors.textMuted),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),
              Text('Fare Breakdown', style: AppTextStyles.label),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  children: [
                    _FareRow(label: 'Base fare', value: ride.fare.baseFare, currency: ride.fare.currency),
                    _FareRow(label: 'Distance fare', value: ride.fare.distanceFare, currency: ride.fare.currency),
                    if (ride.fare.surcharge > 0)
                      _FareRow(label: 'Surcharge', value: ride.fare.surcharge, currency: ride.fare.currency),
                    const Divider(height: 24),
                    _FareRow(
                      label: 'Your payout',
                      value: ride.fare.driverPayout,
                      currency: ride.fare.currency,
                      emphasize: true,
                    ),
                  ],
                ),
              ),

              if (ride.notes != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text('Notes', style: AppTextStyles.label),
                const SizedBox(height: AppSpacing.sm),
                AppCard(child: Text(ride.notes!, style: AppTextStyles.body)),
              ],
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionBar(BuildContext context) {
    if (_primaryLabel.isEmpty && !_canCancel) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_showNavigate) ...[
              GoldOutlinedButton(
                label: 'Navigate',
                icon: Icons.navigation_outlined,
                onPressed: () {},
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (_primaryLabel.isNotEmpty)
              SlideAction(
                label: _primaryLabel,
                isLoading: _isActing,
                onConfirmed: _handlePrimaryAction,
              ),
            if (_canCancel) ...[
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: _confirmCancel,
                style: TextButton.styleFrom(foregroundColor: AppColors.danger),
                child: const Text('Cancel Job'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow({required this.label, required this.address});

  final String label;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.apartment_outlined, size: 18, color: AppColors.gold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.title),
              const SizedBox(height: 2),
              Text(address, style: AppTextStyles.bodyMuted),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconTextRow extends StatelessWidget {
  const _IconTextRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textMuted),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}

class _FareRow extends StatelessWidget {
  const _FareRow({
    required this.label,
    required this.value,
    required this.currency,
    this.emphasize = false,
  });

  final String label;
  final double value;
  final String currency;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final style = emphasize
        ? AppTextStyles.title.copyWith(color: AppColors.gold)
        : AppTextStyles.body;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: emphasize ? AppTextStyles.title : AppTextStyles.bodyMuted),
          Text(Formatters.currency(value, currency), style: style),
        ],
      ),
    );
  }
}

/// Styled route preview shown at the top of Job Details in place of a live
/// map — avoids requiring a Google Maps API key while matching the
/// reference app's layout: a night-map background, A/B pins, and a car
/// animating along the route from pickup to drop-off.
class _RouteMapPlaceholder extends StatefulWidget {
  const _RouteMapPlaceholder();

  @override
  State<_RouteMapPlaceholder> createState() => _RouteMapPlaceholderState();
}

class _RouteMapPlaceholderState extends State<_RouteMapPlaceholder> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF161F2E),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _StreetsPainter()),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => CustomPaint(painter: _RoutePainter(progress: _controller.value)),
          ),
          const Positioned(bottom: 10, left: 10, child: _MapAttribution()),
        ],
      ),
    );
  }
}

class _MapAttribution extends StatelessWidget {
  const _MapAttribution();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text('Live map coming soon', style: AppTextStyles.caption),
    );
  }
}

Path _routePath(Size size) {
  final start = Offset(size.width * 0.22, size.height * 0.24);
  final end = Offset(size.width * 0.74, size.height * 0.78);
  final control1 = Offset(size.width * 0.1, size.height * 0.6);
  final control2 = Offset(size.width * 0.9, size.height * 0.42);
  return Path()
    ..moveTo(start.dx, start.dy)
    ..cubicTo(control1.dx, control1.dy, control2.dx, control2.dy, end.dx, end.dy);
}

/// Stylized night-map backdrop (blocks, a park, a river, and streets) so
/// the placeholder reads as an actual map image rather than a blank panel.
class _StreetsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Base gradient, like a map tile catching light from one corner.
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
        ).createShader(Offset.zero & size),
    );

    // City blocks.
    final blockPaint = Paint()..color = Colors.white.withValues(alpha: 0.04);
    final blocks = [
      Rect.fromLTWH(size.width * 0.02, size.height * 0.05, size.width * 0.2, size.height * 0.18),
      Rect.fromLTWH(size.width * 0.6, size.height * 0.06, size.width * 0.16, size.height * 0.14),
      Rect.fromLTWH(size.width * 0.78, size.height * 0.55, size.width * 0.2, size.height * 0.22),
      Rect.fromLTWH(size.width * 0.02, size.height * 0.6, size.width * 0.14, size.height * 0.3),
    ];
    for (final block in blocks) {
      canvas.drawRRect(RRect.fromRectAndRadius(block, const Radius.circular(4)), blockPaint);
    }

    // Park patch.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.32, size.height * 0.02, size.width * 0.22, size.height * 0.16),
        const Radius.circular(10),
      ),
      Paint()..color = AppColors.pickup.withValues(alpha: 0.08),
    );

    // River.
    final river = Path()
      ..moveTo(-10, size.height * 0.95)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.82, size.width * 0.55, size.height * 0.98)
      ..quadraticBezierTo(size.width * 0.7, size.height * 1.1, size.width + 10, size.height * 0.9);
    canvas.drawPath(
      river,
      Paint()
        ..color = AppColors.live.withValues(alpha: 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.height * 0.12,
    );

    // Streets.
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.07)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final streets = <List<Offset>>[
      [Offset(-20, size.height * 0.15), Offset(size.width + 20, size.height * 0.08)],
      [Offset(-20, size.height * 0.42), Offset(size.width + 20, size.height * 0.5)],
      [Offset(-20, size.height * 0.78), Offset(size.width + 20, size.height * 0.7)],
      [Offset(size.width * 0.12, -20), Offset(size.width * 0.2, size.height + 20)],
      [Offset(size.width * 0.5, -20), Offset(size.width * 0.42, size.height + 20)],
      [Offset(size.width * 0.85, -20), Offset(size.width * 0.78, size.height + 20)],
    ];
    for (final street in streets) {
      canvas.drawLine(street[0], street[1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoutePainter extends CustomPainter {
  _RoutePainter({required this.progress});

  /// 0..1 animation value driving the car's position along the route.
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _routePath(size);
    final metric = path.computeMetrics().first;
    final start = metric.getTangentForOffset(0)!.position;
    final end = metric.getTangentForOffset(metric.length)!.position;

    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.textPrimary.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round,
    );

    _drawPin(canvas, start, AppColors.pickup, 'A');
    _drawPin(canvas, end, AppColors.dropoff, 'B');

    // Keep the car clear of both pins while it travels the route.
    final carDistance = metric.length * (0.08 + progress * 0.84);
    final carTangent = metric.getTangentForOffset(carDistance);
    if (carTangent != null) {
      _drawCar(canvas, carTangent.position, carTangent.angle);
    }
  }

  void _drawPin(Canvas canvas, Offset center, Color color, String letter) {
    canvas.drawCircle(center, 11, Paint()..color = color.withValues(alpha: 0.25));
    canvas.drawCircle(center, 7, Paint()..color = color);

    final textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  void _drawCar(Canvas canvas, Offset center, double angle) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);

    canvas.drawCircle(Offset.zero, 12, Paint()..color = AppColors.background.withValues(alpha: 0.85));

    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(Icons.directions_car.codePoint),
        style: TextStyle(
          fontSize: 16,
          fontFamily: Icons.directions_car.fontFamily,
          package: Icons.directions_car.fontPackage,
          color: AppColors.gold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    // Icon glyphs point "up" by default; rotate an extra quarter turn so
    // the car visually faces along its direction of travel.
    canvas.rotate(1.5708);
    iconPainter.paint(canvas, Offset(-iconPainter.width / 2, -iconPainter.height / 2));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) => oldDelegate.progress != progress;
}

class _CancelDialog extends StatefulWidget {
  @override
  State<_CancelDialog> createState() => _CancelDialogState();
}

class _CancelDialogState extends State<_CancelDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text('Cancel this job?'),
      content: TextField(
        controller: _controller,
        style: AppTextStyles.body,
        decoration: const InputDecoration(hintText: 'Reason (optional)'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Back')),
        TextButton(
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          child: const Text('Confirm Cancel'),
        ),
      ],
    );
  }
}
