import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/soft_ui.dart';

/// The signature visual: a meter dial, recessed into a white tile or set into
/// the gradient hero. Its arc is drawn in code — no stock art, no raster.
class MeterGauge extends StatelessWidget {
  const MeterGauge({
    required this.fraction,
    super.key,
    this.size = 88,
    this.onColor = false,
  });

  final double fraction;
  final double size;

  /// True when placed on the coloured gradient hero.
  final bool onColor;

  @override
  Widget build(BuildContext context) {
    final accent = onColor ? Colors.white : Soft.accentInk(context);
    final track = onColor
        ? Colors.white.withValues(alpha: 0.32)
        : Soft.isDark(context)
            ? AppColors.lightShadowDark
            : AppColors.darkShadowLight;
    final textColor = onColor ? Colors.white : Soft.text(context);
    final captionColor =
        onColor ? Colors.white.withValues(alpha: 0.88) : Soft.muted(context);

    final dial = TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: fraction.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 700),
      curve: AppTokens.easing,
      builder: (context, value, _) => SizedBox(
        width: size - AppTokens.s4,
        height: size - AppTokens.s4,
        child: CustomPaint(
          painter: _GaugePainter(value, accent: accent, track: track),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(value * 100).round()}%',
                  style: TextStyle(
                    color: textColor,
                    fontSize: AppTokens.textTitle,
                    fontWeight: AppTokens.weightSemibold,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                Text(
                  'of meter',
                  style: TextStyle(
                    color: captionColor,
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

    if (onColor) {
      return Container(
        padding: const EdgeInsets.all(AppTokens.s2),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          shape: BoxShape.circle,
        ),
        child: dial,
      );
    }

    return SoftSurface(
      inset: true,
      depth: SoftDepth.subtle,
      padding: const EdgeInsets.all(AppTokens.s2),
      borderRadius: Soft.circle,
      child: dial,
    );
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter(this.fraction, {required this.accent, required this.track});

  final double fraction;
  final Color accent;
  final Color track;

  static const double _start = 0.75 * math.pi;
  static const double _sweep = 1.5 * math.pi;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - 10) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      _start,
      _sweep,
      false,
      Paint()
        ..color = track
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );
    if (fraction <= 0) return;
    canvas.drawArc(
      rect,
      _start,
      _sweep * fraction,
      false,
      Paint()
        ..color = accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      old.fraction != fraction || old.accent != accent;
}
