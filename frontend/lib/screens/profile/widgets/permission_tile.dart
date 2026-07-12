import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../widgets/cards.dart';

class PermissionTile extends StatefulWidget {
  final String title;
  final bool isEnabled;
  final ValueChanged<bool>? onChanged;

  const PermissionTile({
    super.key,
    required this.title,
    this.isEnabled = true,
    this.onChanged,
  });

  @override
  State<PermissionTile> createState() => _PermissionTileState();
}

class _PermissionTileState extends State<PermissionTile> {
  late bool _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.isEnabled;
  }

  @override
  void didUpdateWidget(PermissionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isEnabled != widget.isEnabled) {
      _currentValue = widget.isEnabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BaseCard(
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
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : null,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _currentValue ? 'Enabled' : 'Disabled', 
                  style: AppTypography.bodySmall.copyWith(
                    color: _currentValue ? AppColors.success : (isDark ? Colors.white54 : AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _currentValue,
            onChanged: (val) {
              setState(() {
                _currentValue = val;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
