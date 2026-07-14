import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class SecurityStatusCard extends StatelessWidget {
  const SecurityStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      backgroundColor: AppColors.successLight.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.security, color: AppColors.success, size: 28),
              const SizedBox(width: AppSpacing.md),
              Text('Security Status', style: AppTypography.h3.copyWith(color: AppColors.success)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _buildCheckItem('Your account is protected.'),
          const SizedBox(height: AppSpacing.xs),
          _buildCheckItem('All health records are encrypted locally.'),
          const SizedBox(height: AppSpacing.xs),
          _buildCheckItem('Biometric authentication is enabled.'),
          const SizedBox(height: AppSpacing.md),
          Text('This is only a frontend preview.', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check, color: AppColors.success, size: 20),
        const SizedBox(width: AppSpacing.xs),
        Expanded(child: Text(text, style: AppTypography.bodyMedium)),
      ],
    );
  }
}
