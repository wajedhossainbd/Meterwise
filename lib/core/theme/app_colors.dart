import 'package:flutter/material.dart';

/// Brand palette and semantic colors.
///
/// v1.3 "power" palette: an electric-blue primary with warm-orange / energy-
/// yellow accents on a very light grey / white surface. Bright, modern and
/// consumer-friendly (Google Wallet / Fit / Material 3 Expressive feel).
class AppColors {
  const AppColors._();

  /// Primary brand seed — electric blue.
  static const Color seed = Color(0xFF2962FF);

  /// Warm orange accent.
  static const Color accentOrange = Color(0xFFF57C00);

  /// Energy yellow accent.
  static const Color powerYellow = Color(0xFFFFB300);

  /// A lighter blue used in charts / info.
  static const Color lightBlue = Color(0xFF2962FF);

  /// Neutral very-light-grey app background (light mode).
  static const Color lightGrey = Color(0xFFF4F6FB);

  /// Positive / paid / credit.
  static const Color credit = Color(0xFF2E9E5B);

  /// Outstanding / due.
  static const Color due = Color(0xFFE8553C);

  /// Neutral "info" accent.
  static const Color info = seed;

  /// Warning accent.
  static const Color warning = accentOrange;

  /// Vivid violet used in gradients / chart accents.
  static const Color violet = Color(0xFF7C4DFF);

  /// Fresh teal accent.
  static const Color teal = Color(0xFF00BFA5);

  /// Cyan highlight used in the hero gradient.
  static const Color cyan = Color(0xFF00B0FF);

  /// Ordered palette used for multi-series charts.
  static const List<Color> chartPalette = <Color>[
    Color(0xFF2962FF), // electric blue
    Color(0xFFF57C00), // warm orange
    Color(0xFFFFB300), // energy yellow
    Color(0xFF2E9E5B), // green
    Color(0xFF8E5BE0), // purple
    Color(0xFFE8553C), // red-orange
  ];
}
