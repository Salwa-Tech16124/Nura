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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0A0C16), const Color(0xFF0D1020), const Color(0xFF121625)]
                : [const Color(0xFFE8F1F5), const Color(0xFFE0F7FA), const Color(0xFFEDE7F6)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),
                
                // Title Header
                Text(
                  'NURA Voice AI -\nReady to Listen.',
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF1E244A),
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
                            color: const Color(0xFF00E5FF).withAlpha(50),
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
                            color: const Color(0xFFF50057).withAlpha(50),
                            width: 1.5,
                          ),
                        ),
                      ),
                      
                      // Floating Orbital Pins
                      Positioned(
                        left: 45,
                        top: 45,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC2F3F8),
                            shape: BoxShape.circle,
                            border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.5),
                          ),
                          child: const Icon(Icons.wb_cloudy_rounded, color: Colors.black, size: 12),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 120,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5D5FF),
                            shape: BoxShape.circle,
                            border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.5),
                          ),
                          child: const Icon(Icons.sentiment_satisfied_alt_rounded, color: Colors.black, size: 14),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        bottom: 45,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDCBE0),
                            shape: BoxShape.circle,
                            border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.5),
                          ),
                          child: const Icon(Icons.favorite_rounded, color: Colors.black, size: 12),
                        ),
                      ),
  
                      // Center Robot Assistant Avatar
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: isDark ? Colors.white10 : Colors.black26,
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/branding/nura_standby_robot.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Helper Instructions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: Text(
                    'Our AI-powered voice assistant is here to listen, guide, and support your healthcare — anytime, anywhere.',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: AppSpacing.md),
                
                // Try speech hint
                Text(
                  'Try saying:',
                  style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '"What medicine now?"',
                  style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1E244A), fontSize: 18, fontWeight: FontWeight.w900),
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
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: isDark ? Colors.white54 : Colors.black54,
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
                            color: isDark ? const Color(0xFF121625) : Colors.white,
                            borderRadius: BorderRadius.circular(34),
                            border: Border.all(
                              color: isDark ? Colors.white24 : Colors.black,
                              width: 1.8,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark ? Colors.white10 : Colors.black,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.keyboard_double_arrow_up_rounded, 
                                color: isDark ? Colors.white54 : Colors.black54, 
                                size: 20,
                              ),
                              const Spacer(),
                              // Glowing inner circular button
                              Container(
                                width: 54,
                                height: 54,
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFC2F3F8),
                                  border: Border.all(color: isDark ? Colors.white24 : Colors.black, width: 1.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isDark ? Colors.white10 : Colors.black,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Go',
                                    style: TextStyle(
                                      color: Colors.black,
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
                      Text(
                        '1/6',
                        style: TextStyle(
                          color: isDark ? Colors.white54 : Colors.black54,
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
