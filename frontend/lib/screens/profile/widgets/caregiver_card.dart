import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class CaregiverCard extends StatelessWidget {
  final String name;
  final String relationship;
  final String phone;

  const CaregiverCard({
    super.key,
    required this.name,
    required this.relationship,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BaseCard(
      backgroundColor: isDark ? const Color(0xFF1A2340) : AppColors.primaryLight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primary,
            child: Text(name[0], style: AppTypography.h2.copyWith(color: AppColors.textInverse)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.h3.copyWith(color: isDark ? Colors.white : null)),
                Text(relationship, style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white60 : AppColors.textSecondary)),
                const SizedBox(height: AppSpacing.xs),
                Text(phone, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : null)),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Text('Primary Caregiver', style: AppTypography.bodySmall.copyWith(color: AppColors.success, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: AppColors.success, size: 28),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling $name at $phone...'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
