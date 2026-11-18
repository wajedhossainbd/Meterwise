import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// A signature visual: a meter dial drawn in code, showing this tenant's share
/// of the main meter. No image asset, no gradient — just a precise arc.
class MeterGauge extends StatelessWidget {
  const MeterGauge({required this.fraction, super.key, this.size = 88});

  final double fraction;
  final double size;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: fraction.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 700),
      curve: AppTokens.easing,
      builder: (context, value, _) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _GaugePainter(value),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(value * 100).round()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppTokens.textTitle,
                    fontWeight: AppTokens.weightSemibold,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const Text(
                  'of meter',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: AppTokens.weightMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter(this.fraction);

  final double fraction;

  static const double _start = 0.75 * math.pi; // 135°
  static const double _sweep = 1.5 * math.pi; // 270°

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - 12) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final track = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, _start, _sweep, false, track);

    if (fraction <= 0) return;
    final arc = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, _start, _sweep * fraction, false, arc);
  }

  @override
  bool shouldRepaint(_GaugePainter old) => old.fraction != fraction;
}
