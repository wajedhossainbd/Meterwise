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

  // Nested radii: controls 12, cards 16, large surfaces 20, chips 8.
  static const double radiusChip = 8;
  static const double radiusControl = 12;
  static const double radiusCard = 16;
  static const double radiusSurface = 20;
  static const double radiusPill = 999;

  // Sizes.
  static const double buttonHeight = 48;
  static const double iconButtonSize = 40;
  static const double chipHeight = 28;
  static const double iconSmall = 18;
  static const double iconMedium = 20;
  static const double iconLarge = 24;
  static const double hairline = 1;

  // Type scale — two weights plus semibold for emphasis only.
  static const double textCaption = 12;
  static const double textBody = 14;
  static const double textTitle = 16;
  static const double textHeading = 20;
  static const double textDisplay = 28;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemibold = FontWeight.w600;

  // One easing family, short for feedback.
  static const Duration durationShort = Duration(milliseconds: 150);
  static const Duration durationMedium = Duration(milliseconds: 250);
  static const Curve easing = Curves.easeOutCubic;
}
