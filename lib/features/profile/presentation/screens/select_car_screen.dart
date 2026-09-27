import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/gold_button.dart';
import '../../domain/fleet_vehicle.dart';
import '../fleet_vehicle_provider.dart';

/// Vehicle picker shown when the driver goes Active — restyled for this
/// app's black & gold theme (reference app used a light theme).
class SelectCarScreen extends ConsumerStatefulWidget {
  const SelectCarScreen({super.key});

  @override
  ConsumerState<SelectCarScreen> createState() => _SelectCarScreenState();
}

class _SelectCarScreenState extends ConsumerState<SelectCarScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehicles = ref.watch(fleetVehiclesProvider);
    final selectedId = ref.watch(selectedVehicleIdProvider);

    final filtered = vehicles.where((v) {
      final q = _query.trim().toLowerCase();
      if (q.isEmpty) return true;
      return v.displayName.toLowerCase().contains(q) || v.plateNumber.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Text('Select your car', style: AppTextStyles.headline, textAlign: TextAlign.center),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('CLOSE', style: AppTextStyles.buttonOutline.copyWith(color: AppColors.gold)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _searchController,
                style: AppTextStyles.body,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close, color: AppColors.textMuted),
                          onPressed: () => setState(() {
                            _searchController.clear();
                            _query = '';
                          }),
                        ),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: filtered.isEmpty
                    ? Center(child: Text('No vehicles match your search', style: AppTextStyles.bodyMuted))
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final vehicle = filtered[index];
                          final isSelected = vehicle.id == selectedId;
                          return _VehicleTile(
                            vehicle: vehicle,
                            isSelected: isSelected,
                            onTap: vehicle.isAvailable
                                ? () => ref.read(selectedVehicleIdProvider.notifier).select(vehicle.id)
                                : null,
                          );
                        },
                      ),
              ),
              const SizedBox(height: AppSpacing.lg),
              GoldButton(
                label: 'Confirm Selection',
                onPressed: selectedId == null ? null : () => Navigator.pop(context, selectedId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VehicleTile extends StatelessWidget {
  const _VehicleTile({required this.vehicle, required this.isSelected, required this.onTap});

  final FleetVehicle vehicle;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = vehicle.isAvailable ? AppColors.success : AppColors.danger;

    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      onTap: onTap,
      child: Opacity(
        opacity: vehicle.isAvailable ? 1 : 0.5,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: isSelected ? AppColors.gold : AppColors.surfaceBorder, width: isSelected ? 1.5 : 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${vehicle.displayName} · ${vehicle.plateNumber}',
                      style: AppTextStyles.title,
                    ),
                  ),
                  if (isSelected) const Icon(Icons.check_circle, color: AppColors.gold, size: 20),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text('${vehicle.passengerCapacity}', style: AppTextStyles.bodyMuted),
                  const SizedBox(width: 16),
                  const Icon(Icons.work_outline, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text('${vehicle.luggageCapacity}', style: AppTextStyles.bodyMuted),
                  const Spacer(),
                  Icon(vehicle.isAvailable ? Icons.lock_open : Icons.lock_outline, size: 16, color: statusColor),
                  const SizedBox(width: 4),
                  Text(
                    vehicle.isAvailable ? 'Available' : 'Unavailable',
                    style: AppTextStyles.caption.copyWith(color: statusColor, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
