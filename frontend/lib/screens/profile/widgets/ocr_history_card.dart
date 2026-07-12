import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class OcrHistoryCard extends StatelessWidget {
  final String title;
  final String status;

  const OcrHistoryCard({
    super.key,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BaseCard(
      child: Row(
        children: [
          Icon(Icons.document_scanner, color: isDark ? Colors.white70 : AppColors.primary, size: 24),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              title,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : null,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: isDark ? Colors.green.withOpacity(0.2) : AppColors.successLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text(
              status,
              style: AppTypography.bodySmall.copyWith(
                color: isDark ? Colors.greenAccent : AppColors.success,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
