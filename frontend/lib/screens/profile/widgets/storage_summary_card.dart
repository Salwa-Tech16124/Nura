import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class StorageSummaryCard extends StatelessWidget {
  const StorageSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BaseCard(
      backgroundColor: isDark ? const Color(0xFF1D2235) : AppColors.primaryLight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Documents',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDark ? Colors.white70 : null,
                ),
              ),
              Text(
                '24',
                style: AppTypography.h3.copyWith(
                  color: isDark ? Colors.white : AppColors.primary,
                ),
              ),
            ],
          ),
          Divider(
            height: AppSpacing.lg,
            color: isDark ? Colors.white24 : AppColors.surface,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reports',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDark ? Colors.white70 : null,
                ),
              ),
              Text(
                '15',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Prescriptions',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDark ? Colors.white70 : null,
                ),
              ),
              Text(
                '6',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lab Reports',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDark ? Colors.white70 : null,
                ),
              ),
              Text(
                '3',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : null,
                ),
              ),
            ],
          ),
          Divider(
            height: AppSpacing.lg,
            color: isDark ? Colors.white24 : AppColors.surface,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Storage Used',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDark ? Colors.white70 : null,
                ),
              ),
              Text(
                '18 MB',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDark ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
