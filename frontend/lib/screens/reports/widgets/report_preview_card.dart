import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class ReportPreviewCard extends StatelessWidget {
  final String title;
  final String date;
  final String pages;
  final String format;

  const ReportPreviewCard({
    super.key,
    required this.title,
    required this.date,
    required this.pages,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: const Icon(Icons.description, color: AppColors.primary, size: 40),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.h3),
                const SizedBox(height: AppSpacing.xs),
                Text('Date: $date', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                Text('Pages: $pages', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                Text('Type: $format', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
