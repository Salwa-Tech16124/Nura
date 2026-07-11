import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/services/audio_service.dart';

class VoiceStandbyScreen extends StatefulWidget {
  const VoiceStandbyScreen({super.key});

  @override
  State<VoiceStandbyScreen> createState() => _VoiceStandbyScreenState();
}

class _VoiceStandbyScreenState extends State<VoiceStandbyScreen> {
  @override
  void initState() {
    super.initState();
    AudioService().playVoiceMicStart();
  }

  @override
  void dispose() {
    AudioService().stopVoiceMicStart();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F0B09), // Deep dark brown-black
              Color(0xFF070404), // Deep solid black
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),
                
                // Title Header
                const Text(
                  'MedReady Voice -\nReady to Listen.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Glowing Concentric Orbital Rings & Mic
                GestureDetector(
                  onTap: () => context.push('/voice-medicine-query'),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Ring
                      Container(
                        width: 270,
                        height: 270,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFD84315).withAlpha(20),
                            width: 1.5,
                          ),
                        ),
                      ),
                      
                      // Middle Ring
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFD84315).withAlpha(50),
                            width: 1.5,
                          ),
                        ),
                      ),
                      
                      // Floating Orbital Pins (to match Slide 1 details)
                      // Pin 1: Top-Left
                      Positioned(
                        left: 45,
                        top: 45,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD84315),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Icon(Icons.wb_cloudy, color: Colors.white, size: 12),
                        ),
                      ),
                      // Pin 2: Right
                      Positioned(
                        right: 20,
                        top: 120,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8A65),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Icon(Icons.sentiment_satisfied_alt_rounded, color: Colors.white, size: 14),
                        ),
                      ),
                      // Pin 3: Bottom-Left
                      Positioned(
                        left: 55,
                        bottom: 45,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD84315),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 12),
                        ),
                      ),
  
                      // Inner Mic Glowing Button
                      Container(
                        width: 110,
                        height: 110,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF8A65), Color(0xFFD84315)], // Copper-orange gradient
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFD84315),
                              blurRadius: 45,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.mic, color: Color(0xFF2C150A), size: 48),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Helper Instructions
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: Text(
                    'Our AI-powered voice assistant is here to listen, guide, and support your healthcare — anytime, anywhere.',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: AppSpacing.md),
                
                // Try speech hint
                const Text(
                  'Try saying:',
                  style: TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  '"What medicine now?"',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                ),
                
                const SizedBox(height: AppSpacing.md),
  
                // Bottom slider & controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip button leads back to home
                      TextButton(
                        onPressed: () => context.go('/home'),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
  
                      // Capsule "Go" Slider Widget
                      GestureDetector(
                        onTap: () => context.push('/voice-medicine-query'),
                        child: Container(
                          width: 68,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(8),
                            borderRadius: BorderRadius.circular(34),
                            border: Border.all(
                              color: const Color(0xFFD84315).withAlpha(50),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.keyboard_double_arrow_up_rounded, 
                                color: Color(0xFFFF8A65), 
                                size: 20,
                              ),
                              const Spacer(),
                              // Glowing inner circular button
                              Container(
                                width: 54,
                                height: 54,
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [Color(0xFFFF8A65), Color(0xFFD84315)],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFD84315),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Go',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
  
                      // Slide Index
                      const Text(
                        '1/6',
                        style: TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
