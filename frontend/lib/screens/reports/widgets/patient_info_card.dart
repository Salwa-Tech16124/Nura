import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class PatientInfoCard extends StatelessWidget {
  const PatientInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        children: [
          _buildInfoRow('Patient Name', 'John Doe'),
          const Divider(height: AppSpacing.lg, color: AppColors.primaryLight),
          _buildInfoRow('Age', '68 Years'),
          const Divider(height: AppSpacing.lg, color: AppColors.primaryLight),
          _buildInfoRow('Gender', 'Male'),
          const Divider(height: AppSpacing.lg, color: AppColors.primaryLight),
          _buildInfoRow('Blood Group', 'O+'),
          const Divider(height: AppSpacing.lg, color: AppColors.primaryLight),
          _buildInfoRow('Emergency Contact', 'Sarah Doe'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
        Text(value, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
