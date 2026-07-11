import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PreferenceTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? value;
  final bool? isToggle;
  final bool toggleValue;

  const PreferenceTile({
    super.key,
    required this.title,
    this.subtitle,
    this.value,
    this.isToggle = false,
    this.toggleValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.bodyLarge),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                ],
              ],
            ),
          ),
          if (isToggle == true)
            Switch(
              value: toggleValue,
              onChanged: (val) {},
              activeColor: AppColors.primary,
            )
          else if (value != null)
            Text(value!, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
