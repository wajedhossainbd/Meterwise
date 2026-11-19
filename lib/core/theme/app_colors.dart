import 'package:flutter/material.dart';

/// Light-orange electricity palette on a cool near-white base.
///
/// The dominant accent is a warm light orange (the bolt); utility and semantic
/// inks are deliberately deeper so icons and small labels stay legible on the
/// white, cool-toned tiles. Depth still comes from paired shadows, not colour.
class AppColors {
  const AppColors._();

  // ---- Soft base: cool near-white ----
  static const Color baseLight = Color(0xFFF7F9FC);
  static const Color lightShadowLight = Color(0xFFFFFFFF);
  static const Color darkShadowLight = Color(0xFFD2DBE6);
  static const Color insetLight = Color(0xFFE9EEF5);

  // ---- Soft base: cool dark ----
  static const Color baseDark = Color(0xFF232A35);
  static const Color lightShadowDark = Color(0xFF313A48);
  static const Color darkShadowDark = Color(0xFF151A22);
  static const Color insetDark = Color(0xFF1C222C);

  // ---- Text ----
  static const Color textLight = Color(0xFF253247);
  static const Color textMutedLight = Color(0xFF5C6B80);
  static const Color textDark = Color(0xFFE7ECF5);
  static const Color textMutedDark = Color(0xFFA7B4C6);

  // ---- Light-orange accent ----
  /// Dominant fill accent — light orange (primary buttons, selection, dial).
  static const Color seed = Color(0xFFF4A24C);
  /// Brighter accent for dark surfaces.
  static const Color seedDark = Color(0xFFFFBC70);
  /// Deep orange ink for icons and text on light surfaces.
  static const Color accentInk = Color(0xFFC96A12);
  static const Color accentInkDark = Color(0xFFFFC78A);

  // ---- Utility inks (deeper for visibility) ----
  static const Color accentOrange = Color(0xFFD97A22);
  static const Color powerYellow = Color(0xFFC9962E);
  static const Color cyan = Color(0xFF4E86A8);
  static const Color teal = Color(0xFF268A7E);
  static const Color accentTeal = teal;
  static const Color violet = Color(0xFF6C59B8);
  static const Color lightBlue = Color(0xFF4E86A8);

  // ---- Semantic ----
  static const Color credit = Color(0xFF2F8A5E);
  static const Color creditDark = Color(0xFF63C79C);
  static const Color due = Color(0xFFC85A48);
  static const Color dueDark = Color(0xFFF08E80);
  static const Color info = accentInk;
  static const Color warning = Color(0xFFC97A22);

  /// Dark ink used on the light-orange filled buttons.
  static const Color onAccent = Color(0xFF33240F);

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
