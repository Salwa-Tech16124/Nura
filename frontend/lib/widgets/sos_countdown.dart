import 'package:flutter/material.dart';
import 'dart:async';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

class SosCountdown extends StatefulWidget {
  final VoidCallback? onComplete;

  const SosCountdown({super.key, this.onComplete});

  @override
  State<SosCountdown> createState() => _SosCountdownState();
}

class _SosCountdownState extends State<SosCountdown> with SingleTickerProviderStateMixin {
  int _count = 3;
  Timer? _timer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_count > 1) {
        setState(() {
          _count--;
        });
      } else {
        timer.cancel();
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.error.withOpacity(0.5 + (_pulseController.value * 0.5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '3... 2... 1...',
                style: AppTypography.h1.copyWith(color: AppColors.textInverse, fontSize: 36),
              ),
              const SizedBox(height: 8),
              Text(
                'Sending Alert Now!',
                style: AppTypography.bodyLarge.copyWith(color: AppColors.textInverse),
              ),
            ],
          ),
        );
      }
    );
  }
}
