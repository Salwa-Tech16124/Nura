import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class RecommendationCard extends StatelessWidget {
  final String text;

  const RecommendationCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      backgroundColor: AppColors.pastelBlue,
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: AppColors.primary, size: 24),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(text, style: AppTypography.bodyMedium)),
        ],
      ),
    );
  }
}
