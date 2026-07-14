import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class ProgressComparisonCard extends StatelessWidget {
  final String title;
  final String status;
  final IconData icon;
  final Color statusColor;

  const ProgressComparisonCard({
    super.key,
    required this.title,
    required this.status,
    required this.icon,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Icon(icon, color: statusColor, size: 18),
              const SizedBox(width: AppSpacing.xs),
              Text(
                status,
                style: AppTypography.bodyMedium.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
