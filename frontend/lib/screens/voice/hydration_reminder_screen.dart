import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';

class HydrationReminderScreen extends StatelessWidget {
  const HydrationReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F5), // Light sky-blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Hydration\nReminder Set.',
                style: TextStyle(
                  color: Color(0xFF1E244A),
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 1),
              
              // Glowing Water Glass Icon
              Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.local_drink, size: 90, color: Color(0xFF1E244A)),
                  ),
                ),
              ),
              
              const Spacer(flex: 1),
              const Text(
                'Hydration Reminder Set.',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              const Text(
                'Next Reminder:',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                '3:00 PM',
                style: TextStyle(
                  color: Color(0xFFD84315),
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 1),
              
              // Got It Button in pastel green neobrutalist style
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC3F3C0), // Green
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                    side: const BorderSide(color: Colors.black, width: 1.8),
                  ),
                  elevation: 0,
                  shadowColor: Colors.black,
                ),
                onPressed: () => context.push('/voice-language'),
                child: const Text(
                  'Got it!', 
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 18, 
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
