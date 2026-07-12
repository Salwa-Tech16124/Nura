import 'package:flutter/material.dart';
import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class ReusableIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const ReusableIconButton({super.key, required this.icon, required this.onPressed, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }
}

class CustomFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const CustomFAB({super.key, required this.icon, required this.onPressed, this.backgroundColor = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusXl)),
      child: Icon(icon, color: AppColors.textInverse),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const CustomProgressIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: AppColors.border,
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
      minHeight: 8,
      borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isLast;
  final bool? isSuccess;
  final Widget? trailing;

  const TimelineItem({super.key, required this.title, required this.subtitle, this.isLast = false, this.isSuccess = true, this.trailing});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color nodeColor = AppColors.primary;
    IconData nodeIcon = Icons.schedule;
    
    if (isSuccess == true) {
      nodeColor = AppColors.success;
      nodeIcon = Icons.check;
    } else if (isSuccess == false) {
      nodeColor = AppColors.error;
      nodeIcon = Icons.close;
    }

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: nodeColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(nodeIcon, color: AppColors.textInverse, size: 16),
              ),
              if (!isLast)
                Expanded(child: Container(width: 2, color: isDark ? Colors.white24 : AppColors.border)),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTypography.bodyLarge.copyWith(color: isDark ? Colors.white : null)),
                        const SizedBox(height: AppSpacing.xs),
                        Text(subtitle, style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white70 : null)),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;

  const SettingTile({super.key, required this.title, this.subtitle, required this.icon, required this.onTap, this.trailing});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ReusableIconButton(icon: icon, onPressed: () {}, color: isDark ? Colors.white54 : AppColors.textSecondary),
      title: Text(title, style: AppTypography.bodyLarge.copyWith(color: isDark ? Colors.white : null)),
      subtitle: subtitle != null ? Text(subtitle!, style: AppTypography.bodySmall.copyWith(color: isDark ? Colors.white54 : AppColors.textSecondary)) : null,
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.white54 : AppColors.textSecondary),
      onTap: onTap,
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final Widget? trailing;

  const CustomListTile({super.key, required this.title, required this.subtitle, this.leading, this.trailing});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: leading,
      title: Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : null)),
      subtitle: Text(subtitle, style: AppTypography.bodyMedium.copyWith(color: isDark ? Colors.white70 : null)),
      trailing: trailing,
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.border,
      thickness: 1,
      height: AppSpacing.lg * 2,
    );
  }
}
