import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/presentation/auth_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1400), _navigateNext);
  }

  Future<void> _navigateNext() async {
    if (!mounted) return;
    final session = await ref.read(sessionProvider.future);
    if (!mounted) return;
    context.go(session != null ? '/home' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.35),
                    blurRadius: 28,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.local_taxi_rounded, color: AppColors.background, size: 44),
            ),
            const SizedBox(height: 24),
            Text('FLEETOPS', style: AppTextStyles.displayLarge.copyWith(letterSpacing: 4)),
            const SizedBox(height: 6),
            Text('DRIVER', style: AppTextStyles.label.copyWith(letterSpacing: 6, color: AppColors.gold)),
            const SizedBox(height: 48),
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.gold),
            ),
          ],
        ),
      ),
    );
  }
}
