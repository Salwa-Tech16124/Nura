import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/map_placeholder.dart';
import '../../widgets/sos_button.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class SosInitialMapScreen extends StatelessWidget {
  const SosInitialMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapPlaceholder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Urban Park', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                const Icon(Icons.location_on, size: 48, color: AppColors.textPrimary),
              ],
            ),
          ),
          
          Positioned(
            left: 0,
            right: 0,
            bottom: AppSpacing.xxl * 2,
            child: Center(
              child: SosButton(
                onLongPress: () => context.push('/sos-activation'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
