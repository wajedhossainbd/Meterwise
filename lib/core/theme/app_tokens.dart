import 'package:flutter/material.dart';

/// Single source of truth for spacing, radii, type and motion.
///
/// Every screen uses these values instead of one-off numbers, so the app reads
/// as one designed product rather than a collection of widgets.
abstract final class AppTokens {
  // 4px spacing scale.
  static const double s1 = 4;
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s5 = 20;
  static const double s6 = 24;
  static const double s8 = 32;

  // Soft, generous radii: the softer UI language uses larger curves than the
  // old Material look. Controls 14, cards 20, large surfaces 26, chips 10.
  static const double radiusChip = 10;
  static const double radiusControl = 14;
  static const double radiusCard = 20;
  static const double radiusSurface = 26;
  static const double radiusPill = 999;

  // Sizes.
  static const double buttonHeight = 50;
  static const double iconButtonSize = 42;
  static const double chipHeight = 30;
  static const double iconSmall = 18;
  static const double iconMedium = 20;
  static const double iconLarge = 24;
  static const double hairline = 1;

  // Type scale — restrained weights, generous tracking on display figures.
  static const double textCaption = 12;
  static const double textBody = 14;
  static const double textTitle = 16;
  static const double textHeading = 20;
  static const double textDisplay = 30;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemibold = FontWeight.w600;

  // Soft-UI shadow geometry. Paired light/dark offsets create the extruded
  // look; inset shadows create the pressed / well look.
  static const double softDistance = 6;
  static const double softBlur = 14;
  static const double softSpread = 0;

  // One easing family, short for feedback.
  static const Duration durationShort = Duration(milliseconds: 150);
  static const Duration durationMedium = Duration(milliseconds: 250);
  static const Curve easing = Curves.easeOutCubic;
}
