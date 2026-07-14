import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class ExportOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ExportOptionCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
          ),
          const Icon(Icons.file_download, color: AppColors.textSecondary, size: 20),
        ],
      ),
    );
  }
}
