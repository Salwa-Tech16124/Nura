import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';

class PersonalInfoCard extends StatelessWidget {
  final Map<String, String> infoData;
  final Color backgroundColor;

  const PersonalInfoCard({
    super.key,
    required this.infoData,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black, width: 1.8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: infoData.entries.map((entry) {
          final isLast = infoData.entries.last.key == entry.key;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.key, 
                      style: const TextStyle(
                        fontSize: 13, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    flex: 3,
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 13, 
                        fontWeight: FontWeight.w900, 
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              if (!isLast)
                Divider(
                  height: AppSpacing.lg, 
                  color: Colors.black.withAlpha(20),
                  thickness: 1.0,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
