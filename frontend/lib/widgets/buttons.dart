import 'package:flutter/material.dart';
import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/services/audio_service.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({super.key, required this.text, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textInverse,
        disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusPill)),
        elevation: 2,
      ),
      onPressed: (isLoading || onPressed == null)
          ? null
          : () {
              AudioService().playButtonClick();
              onPressed!();
            },
      child: isLoading 
          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: AppColors.textInverse, strokeWidth: 2))
          : Text(text, style: AppTypography.button),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SecondaryButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textInverse,
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusPill)),
      ),
      onPressed: onPressed == null
          ? null
          : () {
              AudioService().playButtonClick();
              onPressed!();
            },
      child: Text(text, style: AppTypography.button),
    );
  }
}

class OutlinedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  const OutlinedButtonWidget({super.key, required this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ?? (isDark ? Colors.white : AppColors.primary);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: effectiveColor,
        side: BorderSide(color: effectiveColor, width: 2),
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusPill)),
      ),
      onPressed: onPressed == null
          ? null
          : () {
              AudioService().playButtonClick();
              onPressed!();
            },
      child: Text(text, style: AppTypography.button.copyWith(color: effectiveColor)),
    );
  }
}

class DangerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const DangerButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: AppColors.textInverse,
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusPill)),
        elevation: 4,
      ),
      onPressed: onPressed == null
          ? null
          : () {
              AudioService().playButtonClick();
              onPressed!();
            },
      child: Text(text, style: AppTypography.button),
    );
  }
}
