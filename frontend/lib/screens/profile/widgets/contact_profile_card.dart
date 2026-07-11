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
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFC3F3C0), // Vibrant Green
        borderRadius: BorderRadius.circular(24),
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1.8),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Text(
                name[0], 
                style: const TextStyle(
                  fontWeight: FontWeight.w900, 
                  color: Colors.black,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w900, 
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Text(
                  relationship, 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                Text(
                  phoneNumber, 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: Colors.black54,
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
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.phone, color: Colors.black87, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
