import 'package:flutter/material.dart';
import 'dart:math' as math;

class RadarLoadingPainter extends CustomPainter {
  final double radarAngle;
  final double pulseScale;

  RadarLoadingPainter({required this.radarAngle, required this.pulseScale});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.green.withOpacity(0.3)
      ..strokeWidth = 1;

    // Vertical and horizontal lines
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), gridPaint);
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), gridPaint);

    // Draw concentric circles
    final circlePaint = Paint()
      ..color = Colors.green.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 1; i <= 3; i++) {
      canvas.drawCircle(center, (maxRadius / 3) * i * pulseScale, circlePaint);
    }

    // Draw scanning line
    final scanPaint = Paint()
      ..color = Colors.green.withOpacity(0.9)
      ..strokeWidth = 3;

    final scanEndX = center.dx + math.cos(radarAngle) * maxRadius;
    final scanEndY = center.dy + math.sin(radarAngle) * maxRadius;

    canvas.drawLine(center, Offset(scanEndX, scanEndY), scanPaint);

    // Draw scanning sweep
    final sweepPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.green.withOpacity(0.3), Colors.green.withOpacity(0.1), Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: maxRadius),
      radarAngle - math.pi / 3,
      math.pi / 3,
      true,
      sweepPaint,
    );

    // Draw center point
    final centerPaint = Paint()..color = Colors.green;
    canvas.drawCircle(center, 6, centerPaint);

    // Add some random blips
    final blipPaint = Paint()..color = Colors.green;
    final blipPositions = [
      Offset(center.dx + 30, center.dy - 20),
      Offset(center.dx - 40, center.dy + 35),
      Offset(center.dx + 20, center.dy + 40),
    ];

    for (var pos in blipPositions) {
      canvas.drawCircle(pos, 3 * pulseScale, blipPaint);
    }
  }

  @override
  bool shouldRepaint(RadarLoadingPainter oldDelegate) {
    return oldDelegate.radarAngle != radarAngle || oldDelegate.pulseScale != pulseScale;
  }
}
