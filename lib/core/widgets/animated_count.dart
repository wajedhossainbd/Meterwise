import 'package:flutter/material.dart';

/// A number that smoothly counts to its new value whenever it changes.
class AnimatedCount extends StatelessWidget {
  const AnimatedCount({
    required this.value,
    required this.formatter,
    this.style,
    this.duration = const Duration(milliseconds: 650),
    super.key,
  });

  final double value;
  final String Function(double value) formatter;
  final TextStyle? style;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Text(formatter(v), style: style),
    );
  }
}

/// Fades + slides its child in once, with a per-index stagger. Cheap,
/// dependency-free entrance animation for list sections.
class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({required this.child, this.index = 0, super.key});

  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 320 + (index.clamp(0, 8)) * 70),
      curve: Curves.easeOutCubic,
      builder: (context, t, c) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, 18 * (1 - t)),
          child: c,
        ),
      ),
      child: child,
    );
  }
}
