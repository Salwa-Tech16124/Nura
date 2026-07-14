import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../core/constants/app_spacing.dart';
import '../../widgets/map_placeholder.dart';
import '../../widgets/location_ripple.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class SosSendingLocationScreen extends StatefulWidget {
  const SosSendingLocationScreen({super.key});

  @override
  State<SosSendingLocationScreen> createState() => _SosSendingLocationScreenState();
}

class _SosSendingLocationScreenState extends State<SosSendingLocationScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.pushReplacement('/sos-family-alerted');
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          const MapPlaceholder(),
          
          Center(
            child: LocationRipple(
              color: AppColors.error,
              size: 240.0,
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF121625) : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  border: Border.all(color: isDark ? Colors.white24 : Colors.transparent),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.white10 : Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Alert Activated!\nLocating...',
                      style: AppTypography.h3.copyWith(color: isDark ? Colors.white : AppColors.textPrimary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    LinearProgressIndicator(
                      value: null,
                      backgroundColor: isDark ? Colors.white12 : AppColors.border,
                      color: AppColors.error,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Your real-time GPS location\n(Accurate to 5m) is being transmitted.',
                      style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white70 : AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
