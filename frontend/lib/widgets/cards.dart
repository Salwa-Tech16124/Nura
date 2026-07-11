import 'package:flutter/material.dart';
import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  const BaseCard({super.key, required this.child, this.backgroundColor = AppColors.surface, this.onTap, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: child,
      ),
    );
  }
}

class HealthCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;

  const HealthCard({super.key, required this.title, required this.value, required this.icon, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      backgroundColor: accentColor,
      child: Row(
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 28),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary)),
              Text(value, style: AppTypography.h3),
            ],
          ),
        ],
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  final String name;
  final String dosage;
  final String time;
  final bool isTaken;
  final VoidCallback? onTap;
  final Widget? statusBadge;

  const MedicineCard({super.key, required this.name, required this.dosage, required this.time, this.isTaken = false, this.statusBadge, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.medication, color: isTaken ? AppColors.success : AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                  Text(dosage, style: AppTypography.bodySmall),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(time, style: AppTypography.bodyMedium),
              if (statusBadge != null) ...[
                const SizedBox(height: AppSpacing.xs),
                statusBadge!,
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  final String message;
  final VoidCallback onAction;

  const AlertCard({super.key, required this.message, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      backgroundColor: AppColors.error,
      child: Column(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.textInverse, size: 48),
          const SizedBox(height: AppSpacing.sm),
          Text(message, style: AppTypography.bodyLarge.copyWith(color: AppColors.textInverse), textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.textInverse, foregroundColor: AppColors.error),
            onPressed: onAction,
            child: const Text('Resolve'),
          )
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback onDownload;

  const ReportCard({super.key, required this.title, required this.status, required this.onDownload});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
              Text(status, style: AppTypography.bodySmall.copyWith(color: AppColors.secondary)),
            ],
          ),
          IconButton(icon: const Icon(Icons.download, color: AppColors.primary), onPressed: onDownload),
        ],
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  final String title;
  final String description;

  const InformationCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.h3),
          const SizedBox(height: AppSpacing.xs),
          Text(description, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
