import 'package:flutter/material.dart';

/// Clean neutral canvas with colourful elements.
///
/// The background stays a light cool grey-blue (never orange, never stark
/// white) and the tiles are a soft lifted neutral. Colour lives in the icons,
/// controls, status, charts and selected states — a small palette of distinct
/// hues, with orange as the electricity-brand accent.
class AppColors {
  const AppColors._();

  // ---- Neutral canvas / tiles ----
  static const Color baseLight = Color(0xFFEDF1F7);
  static const Color surfaceLight = Color(0xFFF8FAFD);
  static const Color lightShadowLight = Color(0xFFFFFFFF);
  static const Color darkShadowLight = Color(0xFFCDD6E3);
  static const Color insetLight = Color(0xFFE2E8F1);

  // ---- Dark canvas / tiles ----
  static const Color baseDark = Color(0xFF232A35);
  static const Color lightShadowDark = Color(0xFF313A48);
  static const Color darkShadowDark = Color(0xFF151A22);
  static const Color insetDark = Color(0xFF1C222C);

  // ---- Text ----
  static const Color textLight = Color(0xFF253247);
  static const Color textMutedLight = Color(0xFF5C6B80);
  static const Color textDark = Color(0xFFE7ECF5);
  static const Color textMutedDark = Color(0xFFA7B4C6);

  // ---- Brand orange ----
  static const Color seed = Color(0xFFEE9336);
  static const Color seedDark = Color(0xFFFFBC70);
  static const Color accentInk = Color(0xFFC4630C);
  static const Color accentInkDark = Color(0xFFFFC78A);
  static const Color onAccent = Color(0xFF33240F);

  // ---- Colourful element palette ----
  static const Color cyan = Color(0xFF2E7DB8);
  static const Color teal = Color(0xFF168C7E);
  static const Color accentTeal = teal;
  static const Color violet = Color(0xFF6C4FC0);
  static const Color powerYellow = Color(0xFFC88A1A);
  static const Color lightBlue = Color(0xFF2E7DB8);

  // ---- Semantic ----
  static const Color accentOrange = Color(0xFFC4630C);
  static const Color credit = Color(0xFF2F8A5E);
  static const Color creditDark = Color(0xFF63C79C);
  static const Color due = Color(0xFFC85A48);
  static const Color dueDark = Color(0xFFF08E80);
  static const Color warning = Color(0xFFB8761B);
  static const Color info = cyan;

  static const Color lightGrey = baseLight;

  /// Chart series — distinct hues so a multi-series view reads at a glance.
  static const List<Color> chartPalette = <Color>[
    cyan,
    accentInk,
    teal,
    powerYellow,
    violet,
    due,
  ];
}
