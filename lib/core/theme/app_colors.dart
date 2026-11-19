import 'package:flutter/material.dart';

/// Light-orange electricity palette on a cool near-white base.
///
/// The dominant accent is a warm light orange (the bolt); utility and semantic
/// inks are deliberately deeper so icons and small labels stay legible on the
/// white, cool-toned tiles. Depth still comes from paired shadows, not colour.
class AppColors {
  const AppColors._();

  // ---- Soft base: cool near-white ----
  static const Color baseLight = Color(0xFFE07B28);
  /// Slightly lighter warm tile that sits on the orange-tinted canvas.
  static const Color surfaceLight = Color(0xFFF4A65E);
  static const Color lightShadowLight = Color(0xFFFFC68C);
  static const Color darkShadowLight = Color(0xFFA65312);
  static const Color insetLight = Color(0xFFD2732A);

  // ---- Soft base: cool dark ----
  static const Color baseDark = Color(0xFF232A35);
  static const Color lightShadowDark = Color(0xFF313A48);
  static const Color darkShadowDark = Color(0xFF151A22);
  static const Color insetDark = Color(0xFF1C222C);

  // ---- Text ----
  static const Color textLight = Color(0xFF2E1808);
  static const Color textMutedLight = Color(0xFF5E3515);
  static const Color textDark = Color(0xFFE7ECF5);
  static const Color textMutedDark = Color(0xFFA7B4C6);

  // ---- Light-orange accent ----
  /// Dominant fill accent — light orange (primary buttons, selection, dial).
  static const Color seed = Color(0xFFC25A0E);
  /// Brighter accent for dark surfaces.
  static const Color seedDark = Color(0xFFFFBC70);
  /// Deep orange ink for icons and text on light surfaces.
  static const Color accentInk = Color(0xFF7A3305);
  static const Color accentInkDark = Color(0xFFFFC78A);

  // ---- Utility inks (deeper for visibility) ----
  static const Color accentOrange = Color(0xFF9A4705);
  static const Color powerYellow = Color(0xFF8A5A00);
  static const Color cyan = Color(0xFF1E5A8A);
  static const Color teal = Color(0xFF0E6B63);
  static const Color accentTeal = teal;
  static const Color violet = Color(0xFF5B3E9E);
  static const Color lightBlue = Color(0xFF1E5A8A);

  // ---- Semantic ----
  static const Color credit = Color(0xFF1F7A54);
  static const Color creditDark = Color(0xFF63C79C);
  static const Color due = Color(0xFFA62D1E);
  static const Color dueDark = Color(0xFFF08E80);
  static const Color info = accentInk;
  static const Color warning = Color(0xFF8A4A0A);

  /// Dark ink used on the light-orange filled buttons.
  static const Color onAccent = Color(0xFFFFFFFF);

  // ---- Compatibility aliases ----
  static const Color lightGrey = baseLight;

  /// Muted multi-series palette: orange leads, cool tones support.
  static const List<Color> chartPalette = <Color>[
    accentInk,
    teal,
    lightBlue,
    powerYellow,
    violet,
    due,
  ];
}
