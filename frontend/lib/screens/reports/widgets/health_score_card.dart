import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class HealthScoreCard extends StatelessWidget {
  final String score;
  final String status;
  final String description;

  const HealthScoreCard({
    super.key,
    required this.score,
    required this.status,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      backgroundColor: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Health Score', style: AppTypography.bodyLarge.copyWith(color: AppColors.textInverse)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.successLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Text(status, style: AppTypography.bodySmall.copyWith(color: AppColors.successLight, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(score, style: AppTypography.h1.copyWith(color: AppColors.textInverse)),
          const SizedBox(height: AppSpacing.md),
          Text(description, style: AppTypography.bodyMedium.copyWith(color: AppColors.textInverse.withOpacity(0.9))),
        ],
      ),
    );
  }
}
