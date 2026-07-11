import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';

class QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color iconBgColor;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.iconBgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1.8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.8),
              ),
              child: Icon(icon, color: Colors.black, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                title, 
                style: const TextStyle(
                  fontWeight: FontWeight.w900, 
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black87, size: 16),
          ],
        ),
      ),
    );
  }
}
