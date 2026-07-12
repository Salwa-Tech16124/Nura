import 'package:flutter/material.dart';
import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool showLogo;

  const CustomAppBar({super.key, required this.title, this.actions, this.showBackButton = true, this.showLogo = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : AppColors.textPrimary;
    final titleColor = isDark ? Colors.white : AppColors.textPrimary;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton ? IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: iconColor),
        onPressed: () => Navigator.maybePop(context),
      ) : null,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLogo) ...[
            Image.asset('assets/images/branding/nura_app_icon.png', height: 28),
            const SizedBox(width: AppSpacing.sm),
          ],
          Text(title, style: AppTypography.h2.copyWith(color: titleColor)),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigation({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.monitor_heart), label: 'Health'),
        BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Meds'),
        BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: 'Health & Wellness'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({super.key, required this.title, this.actionText, this.onActionTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.h3.copyWith(color: textColor)),
          if (actionText != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(actionText!, style: AppTypography.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}
