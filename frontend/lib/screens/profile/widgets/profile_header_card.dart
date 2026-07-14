import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String bloodGroup;
  final VoidCallback? onEdit;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.bloodGroup,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFC2F3F8), // Vibrant Cyan
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black, width: 1.8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1.8),
                    ),
                    child: const CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.black87, size: 40),
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
                            fontSize: 20, 
                            fontWeight: FontWeight.w900, 
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '$age • $gender • $bloodGroup', 
                          style: const TextStyle(
                            fontSize: 13, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.black),
                onPressed: onEdit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
