import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';
import '../../../../features/auth/providers/auth_state_provider.dart';

class PatientInfoCard extends ConsumerWidget {
  const PatientInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user;
    return BaseCard(
      child: Column(
        children: [
          _buildInfoRow('Patient Name', user?.name ?? 'John Doe'),
          const Divider(height: AppSpacing.lg, color: AppColors.primaryLight),
          _buildInfoRow('Age', user?.age != null ? '${user!.age} Years' : '68 Years'),
          const Divider(height: AppSpacing.lg, color: AppColors.primaryLight),
          _buildInfoRow('Gender', user?.gender ?? 'Male'),
          const Divider(height: AppSpacing.lg, color: AppColors.primaryLight),
          _buildInfoRow('Blood Group', 'O+'),
          const Divider(height: AppSpacing.lg, color: AppColors.primaryLight),
          _buildInfoRow('Emergency Contact', user?.emergencyContact ?? 'Sarah Doe'),
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
