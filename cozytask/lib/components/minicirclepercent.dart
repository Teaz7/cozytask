import 'package:flutter/material.dart';

class MiniCirclePercent extends StatelessWidget {
  final double percent, radius, ringWidth;
  final Color ringColor;
  const MiniCirclePercent({
    super.key,
    required this.percent,
    this.radius = 50,
    this.ringWidth = 8,
    this.ringColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: CustomPaint(
        painter: _RingPainter(
          percent: percent,
          color: ringColor,
          strokeWidth: ringWidth,
        ),
        child: Center(
          child: Text(
            ""
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percent, strokeWidth;
  final Color color;
  _RingPainter({
    required this.percent,
    required this.color,
    required this.strokeWidth,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = (size.shortestSide - strokeWidth) / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    paint.color = color.withOpacity(.2);
    canvas.drawCircle(c, r, paint);
    paint.color = color;
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: r),
      -90 * 0.0174533,
      360 * percent * 0.0174533,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}