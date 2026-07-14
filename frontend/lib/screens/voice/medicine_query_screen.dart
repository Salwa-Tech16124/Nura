import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';

class MedicineQueryScreen extends StatelessWidget {
  const MedicineQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : const Color(0xFFE8F1F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pills Illustration
              Expanded(
                flex: 3,
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF121625) : Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.white10 : Colors.black,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.medication, size: 90, color: isDark ? Colors.white : const Color(0xFF1E244A)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              
              const Text(
                'TAKE NOW:',
                style: TextStyle(color: Color(0xFFD84315), fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Metformin',
                style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 36, fontWeight: FontWeight.w900),
              ),
              Text(
                '(500mg) • 1 Pill',
                style: TextStyle(color: isDark ? Colors.white70 : Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Water Glass Icon Action
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.push('/voice-hydration'),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC2F3F8),
                      shape: BoxShape.circle,
                      border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.white10 : Colors.black,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.local_drink, color: Colors.black, size: 28),
                  ),
                ),
              ),
              
              const Spacer(flex: 1),
              
              // Voice Response Bubble
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C1E3F) : const Color(0xFFE5D5FF),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.zero,
                  ),
                  border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.white10 : Colors.black,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Text(
                  'You have one pill of Metformin due now, Sarah.',
                  style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
