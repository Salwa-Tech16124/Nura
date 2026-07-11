import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class PermissionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String status;

  const PermissionCard({
    super.key,
    required this.title,
    required this.icon,
    this.status = 'Granted',
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.successLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text(status, style: AppTypography.bodySmall.copyWith(color: AppColors.success, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
