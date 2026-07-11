import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class RoadmapCard extends StatelessWidget {
  final String featureName;
  final IconData icon;

  const RoadmapCard({
    super.key,
    required this.featureName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(featureName, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text('Coming Soon', style: AppTypography.bodySmall.copyWith(color: AppColors.secondary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
