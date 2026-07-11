import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
class LocationRipple extends StatefulWidget {
  final double size;
  final Color color;

  const LocationRipple({
    super.key,
    this.size = 200.0,
    this.color = AppColors.error,
  });

  @override
  State<LocationRipple> createState() => _LocationRippleState();
}

class _LocationRippleState extends State<LocationRipple> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer ripple
            Container(
              width: widget.size * (0.5 + (_controller.value * 0.5)),
              height: widget.size * (0.5 + (_controller.value * 0.5)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(1 - _controller.value),
              ),
            ),
            // Inner ripple
            Container(
              width: widget.size * (0.3 + (_controller.value * 0.4)),
              height: widget.size * (0.3 + (_controller.value * 0.4)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(0.5 - (_controller.value * 0.5).clamp(0.0, 0.5)),
              ),
            ),
            // Center Marker
            Container(
              width: widget.size * 0.15,
              height: widget.size * 0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
                border: Border.all(color: AppColors.surface, width: 3),
              ),
            ),
          ],
        );
      },
    );
  }
}
