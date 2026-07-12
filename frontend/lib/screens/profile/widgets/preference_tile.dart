import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PreferenceTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? value;
  final bool? isToggle;
  final bool toggleValue;
  final ValueChanged<bool>? onToggleChanged;
  final VoidCallback? onTap;

  const PreferenceTile({
    super.key,
    required this.title,
    this.subtitle,
    this.value,
    this.isToggle = false,
    this.toggleValue = false,
    this.onToggleChanged,
    this.onTap,
  });

  @override
  State<PreferenceTile> createState() => _PreferenceTileState();
}

class _PreferenceTileState extends State<PreferenceTile> {
  late bool _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.toggleValue;
  }

  @override
  void didUpdateWidget(PreferenceTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.toggleValue != widget.toggleValue) {
      _currentValue = widget.toggleValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget content = Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title, 
                  style: AppTypography.bodyLarge.copyWith(
                    color: isDark ? Colors.white : null,
                  ),
                ),
                if (widget.subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle!, 
                    style: AppTypography.bodySmall.copyWith(
                      color: isDark ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (widget.isToggle == true)
            Switch(
              value: _currentValue,
              onChanged: (val) {
                setState(() {
                  _currentValue = val;
                });
                if (widget.onToggleChanged != null) {
                  widget.onToggleChanged!(val);
                }
              },
              activeColor: AppColors.primary,
            )
          else if (widget.value != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.value!, 
                  style: AppTypography.bodyMedium.copyWith(
                    color: isDark ? Colors.white70 : AppColors.textSecondary, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.onTap != null) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right, 
                    size: 16, 
                    color: isDark ? Colors.white54 : AppColors.textSecondary,
                  ),
                ],
              ],
            ),
        ],
      ),
    );

    if (widget.onTap != null && widget.isToggle != true) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: content,
      );
    }
    return content;
  }
}
