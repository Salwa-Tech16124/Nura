import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class HealthRiskCard extends StatelessWidget {
  final String title;

  const HealthRiskCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      backgroundColor: AppColors.warningLight,
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppColors.warning, size: 24),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(title, style: AppTypography.bodyMedium)),
        ],
      ),
    );
  }
}
