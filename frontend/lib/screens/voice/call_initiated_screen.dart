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
    return Scaffold(
      backgroundColor: const Color(0xFFE8F1F5), // Light sky-blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const Text(
                'Call\nInitiated',
                style: TextStyle(
                  color: Color(0xFF1E244A),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFEDE7F6), // Lilac glow base
                    ),
                    child: const Icon(Icons.person, size: 100, color: Color(0xFF1E244A)), // Dummy photo
                  ),
                ),
              ),
              const Spacer(flex: 1),
              
              const Text(
                'CALLING:',
                style: TextStyle(
                  color: Color(0xFFD84315),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                'David (Son)',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  VoiceWaveAnimation(color: Color(0xFF2E7D32), height: 24),
                  SizedBox(width: AppSpacing.md),
                  Text(
                    '00:03',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  VoiceWaveAnimation(color: Color(0xFF2E7D32), height: 24),
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
                    side: const BorderSide(color: Colors.black, width: 1.8),
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
