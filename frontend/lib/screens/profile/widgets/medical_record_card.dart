import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class MedicalRecordCard extends StatelessWidget {
  final String title;
  final String category;
  final String date;

  const MedicalRecordCard({
    super.key,
    required this.title,
    required this.category,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(title),
            content: Text('Document: $title\nCategory: $category\nUploaded: $date\n\nThis record is securely stored.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: BaseCard(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1D2235) : AppColors.pastelBlue,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(Icons.description, color: isDark ? Colors.white : AppColors.primary, size: 28),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : null,
                    ),
                  ),
                  Text(
                    category,
                    style: AppTypography.bodySmall.copyWith(
                      color: isDark ? Colors.white70 : AppColors.primary,
                    ),
                  ),
                  Text(
                    'Uploaded: $date',
                    style: AppTypography.bodySmall.copyWith(
                      color: isDark ? Colors.white54 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: isDark ? Colors.white54 : AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
