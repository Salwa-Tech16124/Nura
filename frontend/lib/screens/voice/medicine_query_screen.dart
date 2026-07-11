import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';

class MedicineQueryScreen extends StatelessWidget {
  const MedicineQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0B09), // Dark brown-black background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white70),
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
                      color: Colors.white.withAlpha(8),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: const Color(0xFFD84315).withAlpha(80), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD84315).withAlpha(30),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.medication, size: 90, color: Color(0xFFFF8A65)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              
              const Text(
                'TAKE NOW:',
                style: TextStyle(color: Color(0xFFFF8A65), fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 14),
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'Metformin',
                style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900),
              ),
              const Text(
                '(500mg) • 1 Pill',
                style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
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
                      color: const Color(0xFFD84315).withAlpha(40),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFD84315).withAlpha(100), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD84315).withAlpha(20),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.local_drink, color: Color(0xFFFF8A65), size: 28),
                  ),
                ),
              ),
              
              const Spacer(flex: 1),
              
              // Voice Response Bubble
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.zero,
                  ),
                  border: Border.all(color: Colors.white.withAlpha(10)),
                ),
                child: const Text(
                  'You have one pill of Metformin due now, Sarah.',
                  style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
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
