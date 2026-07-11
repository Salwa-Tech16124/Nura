import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';

class MedicineQueryScreen extends StatelessWidget {
  const MedicineQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F5), // Light sky-blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.black, width: 1.8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.medication, size: 90, color: Color(0xFF1E244A)),
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
              const Text(
                'Metformin',
                style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.w900),
              ),
              const Text(
                '(500mg) • 1 Pill',
                style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
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
                      color: const Color(0xFFC2F3F8), // Cyan
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1.8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(2, 2),
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
                  color: const Color(0xFFE5D5FF), // Lilac
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.zero,
                  ),
                  border: Border.all(color: Colors.black, width: 1.8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'You have one pill of Metformin due now, Sarah.',
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
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
