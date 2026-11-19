import 'package:flutter/material.dart';

/// Monochromatic soft-UI palette.
///
/// "Soft Modern" uses a single neutral base for both the app background and its
/// surfaces — depth comes from paired light/dark shadows, not colour or
/// gradients. Accents are used sparingly and only where they carry meaning.
/// Every token is brightness-aware via [Soft] in `soft_ui.dart`.
class AppColors {
  const AppColors._();

  // ---- Soft base: light ----
  static const Color baseLight = Color(0xFFE6EBF2);
  static const Color lightShadowLight = Color(0xFFFFFFFF);
  static const Color darkShadowLight = Color(0xFFB4C0D0);
  static const Color insetLight = Color(0xFFDDE3EC);

  // ---- Soft base: dark ----
  static const Color baseDark = Color(0xFF242B38);
  static const Color lightShadowDark = Color(0xFF323B4B);
  static const Color darkShadowDark = Color(0xFF141922);
  static const Color insetDark = Color(0xFF1C222E);

  // ---- Text ----
  static const Color textLight = Color(0xFF2B3547);
  static const Color textMutedLight = Color(0xFF6C7A90);
  static const Color textDark = Color(0xFFE7ECF5);
  static const Color textMutedDark = Color(0xFF9AA7BC);

  // ---- Accents (restrained, monochromatic-friendly) ----
  /// Primary accent — a calm indigo.
  static const Color seed = Color(0xFF5866D8);
  /// Brighter primary accent for dark surfaces.
  static const Color seedDark = Color(0xFF94A0FF);
  static const Color accentTeal = Color(0xFF2E9C8E);
  static const Color accentOrange = Color(0xFFD08A3E);
  static const Color powerYellow = Color(0xFFC9A445);

  // ---- Semantic ----
  static const Color credit = Color(0xFF3E9E73);
  static const Color creditDark = Color(0xFF63C79C);
  static const Color due = Color(0xFFD96A5E);
  static const Color dueDark = Color(0xFFF08E80);
  static const Color info = seed;
  static const Color warning = accentOrange;

  // ---- Compatibility aliases (kept so call sites keep compiling) ----
  static const Color violet = Color(0xFF7E6BD1);
  static const Color teal = accentTeal;
  static const Color cyan = Color(0xFF4B9CC7);
  static const Color lightGrey = baseLight;
  static const Color lightBlue = seed;

  /// Ordered palette for multi-series charts — all muted, no neon.
  static const List<Color> chartPalette = <Color>[
    seed,
    accentTeal,
    accentOrange,
    powerYellow,
    violet,
    due,
  ];
}
