import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_tokens.dart';

/// Builds the Material 3 [ColorScheme] from the brand seed and overlays the
/// power-yellow / light-blue accents so they're available app-wide.

/// Centralized Material 3 theme definitions.
///
/// Both the light and dark themes are generated from a single seed color so the
/// app stays visually consistent and WCAG-contrast safe. Component-level tweaks
/// (rounded cards, large touch targets, filled inputs) are applied uniformly
/// here rather than scattered across widgets.
class AppTheme {
  const AppTheme._();

  static const double _radius = AppTokens.radiusCard;

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
      secondary: AppColors.accentOrange,
      tertiary: AppColors.powerYellow,
    );

    final scaffoldBg =
        isLight ? AppColors.lightGrey : colorScheme.surface;
    final cardColor =
        isLight ? Colors.white : colorScheme.surfaceContainerHigh;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBg,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 2,
        backgroundColor: scaffoldBg,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        // Soft, modern shadow rather than Material's tonal tint.
        elevation: isLight ? 1 : 0,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        clipBehavior: Clip.antiAlias,
        color: cardColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(88, AppTokens.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.s5),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(AppTokens.radiusControl)),
          ),
          textStyle: const TextStyle(
            fontSize: AppTokens.textBody,
            fontWeight: AppTokens.weightSemibold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(88, AppTokens.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.s5),
          side: BorderSide(color: colorScheme.outlineVariant),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(AppTokens.radiusControl)),
          ),
          textStyle: const TextStyle(
            fontSize: AppTokens.textBody,
            fontWeight: AppTokens.weightSemibold,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(64, AppTokens.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.s3),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(AppTokens.radiusControl)),
          ),
          textStyle: const TextStyle(
            fontSize: AppTokens.textBody,
            fontWeight: AppTokens.weightSemibold,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(AppTokens.iconButtonSize,
              AppTokens.iconButtonSize),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(AppTokens.radiusControl)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusControl),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.s4,
          vertical: AppTokens.s3,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 72,
        backgroundColor: cardColor,
        indicatorColor: colorScheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusControl),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSurface),
        ),
        backgroundColor: cardColor,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusChip),
        ),
        side: BorderSide.none,
        backgroundColor: colorScheme.secondaryContainer,
        labelStyle: const TextStyle(
          fontSize: AppTokens.textCaption,
          fontWeight: AppTokens.weightSemibold,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.s2,
          vertical: AppTokens.s1,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: colorScheme.primary,
          selectedForegroundColor: colorScheme.onPrimary,
          visualDensity: VisualDensity.compact,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.primaryContainer.withValues(alpha: 0.4),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        space: 1,
        thickness: 1,
      ),
    );
  }
}
