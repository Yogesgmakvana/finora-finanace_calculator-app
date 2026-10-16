import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CircularPercentageGauge extends StatelessWidget {
  final double percentage; // e.g. 5.2 or 94.8
  final String label;
  final String amount;
  final Color activeColor;
  final Color trackColor;
  final double size;

  const CircularPercentageGauge({
    super.key,
    required this.percentage,
    required this.label,
    required this.amount,
    this.activeColor = AppColors.btnEmeraldGreen,
    this.trackColor = const Color(0xFFE5E7EB),
    this.size = 110.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _GaugePainter(
              percentage: percentage,
              activeColor: activeColor,
              trackColor: trackColor,
              strokeWidth: 9.0,
            ),
            child: Center(
              child: Text(
                '${percentage.toStringAsFixed(percentage.truncateToDouble() == percentage ? 0 : 1)}%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textBlack,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.btnEmeraldGreen,
          ),
        ),
      ],
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double percentage;
  final Color activeColor;
  final Color trackColor;
  final double strokeWidth;

  _GaugePainter({
    required this.percentage,
    required this.activeColor,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background track ring
    canvas.drawCircle(center, radius, trackPaint);

    // Draw active arc from top (-pi / 2)
    final sweepAngle = 2 * pi * (percentage.clamp(0.0, 100.0) / 100.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.trackColor != trackColor;
  }
}
