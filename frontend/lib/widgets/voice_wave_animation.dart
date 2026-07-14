import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import 'dart:math' as math;
import '../core/services/audio_service.dart';

class VoiceWaveAnimation extends StatefulWidget {
  final Color color;
  final double height;
  
  const VoiceWaveAnimation({
    super.key, 
    this.color = AppColors.primary,
    this.height = 60.0,
  });

  @override
  State<VoiceWaveAnimation> createState() => _VoiceWaveAnimationState();
}

class _VoiceWaveAnimationState extends State<VoiceWaveAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    
    // Play listening sound once when the wave animation mounts
    AudioService().playVoiceListeningSound();
  }

  @override
  void dispose() {
    _controller.dispose();
    // Stop the listening sound
    AudioService().stopVoiceListeningSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(7, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // Create a sine wave effect with different phases for each bar
              final sinValue = math.sin((_controller.value * 2 * math.pi) + (index * 1.5));
              // Map sine value (-1 to 1) to height multiplier (0.3 to 1.0)
              final heightMultiplier = 0.3 + (0.7 * ((sinValue + 1) / 2));
              
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: widget.height * heightMultiplier,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
