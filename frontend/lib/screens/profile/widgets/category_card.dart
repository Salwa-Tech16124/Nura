import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String fileCount;
  final IconData icon;

  const CategoryCard({
    super.key,
    required this.title,
    required this.fileCount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BaseCard(
      child: Row(
        children: [
          Icon(icon, color: isDark ? Colors.white70 : AppColors.primary, size: 24),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              title,
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : null,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1D2235) : AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text(
              '$fileCount Files',
              style: AppTypography.bodySmall.copyWith(
                color: isDark ? Colors.white70 : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
