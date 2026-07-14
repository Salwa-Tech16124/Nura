import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';

class ContactProfileCard extends StatelessWidget {
  final String name;
  final String relationship;
  final String phoneNumber;
  final VoidCallback? onCall;

  const ContactProfileCard({
    super.key,
    required this.name,
    required this.relationship,
    required this.phoneNumber,
    this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // In dark mode, use a deeper green with white text. In light mode, use light green with black text.
    final cardBgColor = isDark ? const Color(0xFF1E3A1E) : const Color(0xFFC3F3C0);
    final primaryTextColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;
    final iconColor = isDark ? Colors.white : Colors.black87;
    final buttonBgColor = isDark ? const Color(0xFF2C4C2C) : Colors.white;
    final borderColor = isDark ? Colors.white24 : Colors.black;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1.8),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.white10 : Colors.black,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 1.8),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: isDark ? const Color(0xFF2C4C2C) : Colors.white,
              child: Text(
                name[0], 
                style: TextStyle(
                  fontWeight: FontWeight.w900, 
                  color: primaryTextColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name, 
                  style: TextStyle(
                    fontWeight: FontWeight.w900, 
                    color: primaryTextColor,
                    fontSize: 15,
                  ),
                ),
                Text(
                  relationship, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: secondaryTextColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  phoneNumber, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: secondaryTextColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Neobrutalist circular phone button
          GestureDetector(
            onTap: onCall,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: buttonBgColor,
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 1.8),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.white10 : Colors.black,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              child: Icon(Icons.phone, color: iconColor, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
