import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/secure_screen.dart';
import '../../domain/ride_models.dart';
import '../providers/ride_providers.dart';
import '../widgets/ride_card.dart';

class RidesListScreen extends ConsumerStatefulWidget {
  const RidesListScreen({super.key});

  @override
  ConsumerState<RidesListScreen> createState() => _RidesListScreenState();
}

class _RidesListScreenState extends ConsumerState<RidesListScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SecureScreen(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Your Jobs'),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: false,
            labelColor: AppColors.gold,
            unselectedLabelColor: AppColors.textMuted,
            indicatorColor: AppColors.gold,
            labelStyle: AppTextStyles.title.copyWith(fontSize: 13),
            tabs: const [
              Tab(text: 'Incoming'),
              Tab(text: 'Current'),
              Tab(text: 'Past'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            _RideTabList(providerToWatch: _TabKind.incoming),
            _RideTabList(providerToWatch: _TabKind.current),
            _RideTabList(providerToWatch: _TabKind.past),
            _RideTabList(providerToWatch: _TabKind.cancelled),
          ],
        ),
      ),
    );
  }
}

enum _TabKind { incoming, current, past, cancelled }

class _RideTabList extends ConsumerWidget {
  const _RideTabList({required this.providerToWatch});

  final _TabKind providerToWatch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rides = switch (providerToWatch) {
      _TabKind.incoming => ref.watch(incomingRidesProvider),
      _TabKind.current => ref.watch(currentRidesProvider),
      _TabKind.past => ref.watch(pastRidesProvider),
      _TabKind.cancelled => ref.watch(cancelledRidesProvider),
    };

    if (rides.isEmpty) {
      return _EmptyState(kind: providerToWatch);
    }

    // ListView.builder keeps only visible cards materialized — safe even
    // for drivers with a long ride history.
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final Ride ride = rides[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: RideCard(ride: ride, onTap: () => context.push('/rides/${ride.id}')),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.kind});

  final _TabKind kind;

  (IconData, String, String) get _content => switch (kind) {
        _TabKind.incoming => (Icons.inbox_outlined, 'No new assignments', 'Dispatch will notify you when a job comes in.'),
        _TabKind.current => (Icons.local_taxi_outlined, 'No active job', 'Accept an incoming job to start a trip.'),
        _TabKind.past => (Icons.history, 'No completed jobs yet', 'Your trip history will show up here.'),
        _TabKind.cancelled => (Icons.block_outlined, 'No cancelled jobs', 'Cancelled assignments will appear here.'),
      };

  @override
  Widget build(BuildContext context) {
    final (icon, title, subtitle) = _content;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: AppColors.textMuted),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: AppTextStyles.title),
            const SizedBox(height: 4),
            Text(subtitle, textAlign: TextAlign.center, style: AppTextStyles.bodyMuted),
          ],
        ),
      ),
    );
  }
}
