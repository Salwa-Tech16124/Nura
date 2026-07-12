import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';

class HydrationReminderScreen extends StatelessWidget {
  const HydrationReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : const Color(0xFFE8F1F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Hydration\nReminder Set.',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF1E244A),
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
                    color: isDark ? const Color(0xFF121625) : Colors.white,
                    border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 2.0),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.white10 : Colors.black26,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.local_drink, size: 90, color: isDark ? Colors.white : const Color(0xFF1E244A)),
                  ),
                ),
              ),
              
              const Spacer(flex: 1),
              Text(
                'Hydration Reminder Set.',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Next Reminder:',
                style: TextStyle(
                  color: isDark ? Colors.white54 : Colors.black54,
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
              
              // Got It Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC3F3C0),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                    side: BorderSide(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
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
