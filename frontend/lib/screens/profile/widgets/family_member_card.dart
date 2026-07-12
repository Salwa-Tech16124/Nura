import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class FamilyMemberCard extends StatelessWidget {
  final String name;
  final String relationship;
  final String phone;

  const FamilyMemberCard({
    super.key,
    required this.name,
    required this.relationship,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BaseCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: isDark ? const Color(0xFF1A2340) : AppColors.pastelBlue,
            child: Text(name[0], style: AppTypography.h3.copyWith(color: isDark ? Colors.white : AppColors.primary)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : null)),
                Text(relationship, style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white54 : AppColors.textSecondary)),
                Text(phone, style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white54 : AppColors.textSecondary)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.message, color: AppColors.primary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Messaging $name...'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: AppColors.success),
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
