import 'package:flutter/material.dart';
import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class BaseBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const BaseBadge({super.key, required this.label, required this.backgroundColor, required this.textColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(label, style: AppTypography.bodySmall.copyWith(color: textColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class SuccessBadge extends StatelessWidget {
  final String label;
  const SuccessBadge({super.key, required this.label});
  
  @override
  Widget build(BuildContext context) {
    return BaseBadge(label: label, backgroundColor: AppColors.successLight, textColor: AppColors.success, icon: Icons.check_circle);
  }
}

class WarningBadge extends StatelessWidget {
  final String label;
  const WarningBadge({super.key, required this.label});
  
  @override
  Widget build(BuildContext context) {
    return BaseBadge(label: label, backgroundColor: AppColors.warningLight, textColor: AppColors.warning, icon: Icons.warning);
  }
}

class ErrorBadge extends StatelessWidget {
  final String label;
  const ErrorBadge({super.key, required this.label});
  
  @override
  Widget build(BuildContext context) {
    return BaseBadge(label: label, backgroundColor: AppColors.errorLight, textColor: AppColors.error, icon: Icons.error);
  }
}

class PendingBadge extends StatelessWidget {
  final String label;
  const PendingBadge({super.key, required this.label});
  
  @override
  Widget build(BuildContext context) {
    return BaseBadge(label: label, backgroundColor: AppColors.primaryLight, textColor: AppColors.primary, icon: Icons.schedule);
  }
}
