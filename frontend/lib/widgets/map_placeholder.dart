import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
class MapPlaceholder extends StatelessWidget {
  final Widget? child;

  const MapPlaceholder({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.background,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _MapPainter(),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = AppColors.surface
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.4), roadPaint);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.6, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.6), roadPaint);

    final parkPaint = Paint()
      ..color = AppColors.pastelGreen
      ..style = PaintingStyle.fill;
    
    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.2);
    path.lineTo(size.width * 0.8, size.height * 0.25);
    path.lineTo(size.width * 0.7, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.6);
    path.close();
    canvas.drawPath(path, parkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
