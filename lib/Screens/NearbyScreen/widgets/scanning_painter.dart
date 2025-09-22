import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScanningPainter extends CustomPainter {
  final double scanningAngle;
  final double pulseScale;

  ScanningPainter({required this.scanningAngle, required this.pulseScale});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2.5;

    // Draw concentric circles (radar rings)
    final circlePaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, (maxRadius / 4) * i * pulseScale, circlePaint);
    }

    // Draw scanning line
    final scanLinePaint = Paint()
      ..color = Colors.red.withOpacity(0.8)
      ..strokeWidth = 3;

    final scanEndX = center.dx + math.cos(scanningAngle) * maxRadius;
    final scanEndY = center.dy + math.sin(scanningAngle) * maxRadius;

    canvas.drawLine(center, Offset(scanEndX, scanEndY), scanLinePaint);

    // Draw scanning arc/sweep
    final sweepPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.red.withOpacity(0.4), Colors.red.withOpacity(0.1), Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: maxRadius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: maxRadius),
      scanningAngle - math.pi / 4,
      math.pi / 2,
      true,
      sweepPaint,
    );

    // Draw center point
    final centerPaint = Paint()..color = Colors.red;
    canvas.drawCircle(center, 8, centerPaint);

    final centerInnerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 4, centerInnerPaint);
  }

  @override
  bool shouldRepaint(ScanningPainter oldDelegate) {
    return oldDelegate.scanningAngle != scanningAngle || oldDelegate.pulseScale != pulseScale;
  }
}
