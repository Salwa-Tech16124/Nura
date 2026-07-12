import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/voice_wave_animation.dart';
import '../../core/services/audio_service.dart';

class CallInitiatedScreen extends StatefulWidget {
  const CallInitiatedScreen({super.key});

  @override
  State<CallInitiatedScreen> createState() => _CallInitiatedScreenState();
}

class _CallInitiatedScreenState extends State<CallInitiatedScreen> {
  @override
  void initState() {
    super.initState();
    // Play call connect sound once
    AudioService().playVoiceCallConnectSound();
  }

  @override
  void dispose() {
    // Stop the call connect sound
    AudioService().stopVoiceCallConnectSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C16) : const Color(0xFFE8F1F5), // Dynamic neobrutalist background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Call\nInitiated',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF1E244A),
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 1),
              
              // Glowing Avatar
              Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? const Color(0xFF2C1E3F) : const Color(0xFFEDE7F6), // Lilac glow base
                    ),
                    child: Icon(Icons.person, size: 100, color: isDark ? Colors.white : const Color(0xFF1E244A)), // Dummy photo
                  ),
                ),
              ),
              const Spacer(flex: 1),
              
              Text(
                'CALLING:',
                style: TextStyle(
                  color: isDark ? const Color(0xFFFF8A65) : const Color(0xFFD84315),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'David (Son)',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VoiceWaveAnimation(color: isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32), height: 24),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    '00:03',
                    style: TextStyle(
                      color: isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  VoiceWaveAnimation(color: isDark ? const Color(0xFF81C784) : const Color(0xFF2E7D32), height: 24),
                ],
              ),
              
              const Spacer(flex: 1),
              
              // End Call Button in pastel red neobrutalist style
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB3B3), // Light pastel red/pink
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                    side: BorderSide(color: isDark ? Colors.white24 : Colors.black, width: 1.8),
                  ),
                  elevation: 0,
                  shadowColor: Colors.black,
                ),
                onPressed: () {
                  AudioService().playVoiceCallEndSound();
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/voice');
                  }
                },
                child: const Text(
                  'END CALL', 
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
