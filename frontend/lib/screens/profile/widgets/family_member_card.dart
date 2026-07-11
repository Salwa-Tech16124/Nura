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
    return BaseCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.pastelBlue,
            child: Text(name[0], style: AppTypography.h3.copyWith(color: AppColors.primary)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text(relationship, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                Text(phone, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.message, color: AppColors.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: AppColors.success),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
