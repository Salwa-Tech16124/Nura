import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialization;
  final String hospital;
  final String phone;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialization,
    required this.hospital,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.pastelBlue,
            child: Text(name.split(' ').length > 1 ? name.split(' ')[1][0] : name[0], style: AppTypography.h2.copyWith(color: AppColors.primary)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.h3),
                const SizedBox(height: AppSpacing.xs),
                Text(specialization, style: AppTypography.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(Icons.local_hospital, color: AppColors.textSecondary, size: 16),
                    const SizedBox(width: AppSpacing.xs),
                    Text(hospital, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(Icons.phone, color: AppColors.textSecondary, size: 16),
                    const SizedBox(width: AppSpacing.xs),
                    Text(phone, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
