import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_tokens.dart';

/// Centralized "Soft Modern" theme.
///
/// A single neutral base is shared by the scaffold and every surface; depth
/// comes from the paired shadows applied by [SoftSurface]/[SoftCard] and from
/// the component shadows set here. Component styling lives in this file rather
/// than in individual widgets, so a change propagates app-wide.
class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final base = isLight ? AppColors.baseLight : AppColors.baseDark;
    final surface = isLight ? AppColors.surfaceLight : AppColors.baseDark;
    final inset = isLight ? AppColors.insetLight : AppColors.insetDark;
    final accent = isLight ? AppColors.seed : AppColors.seedDark;
    final text = isLight ? AppColors.textLight : AppColors.textDark;
    final muted = isLight ? AppColors.textMutedLight : AppColors.textMutedDark;
    final shadow = isLight
        ? AppColors.darkShadowLight
        : AppColors.darkShadowDark;
    final onAccent = isLight ? AppColors.onAccent : AppColors.textLight;
    final accentInk = isLight ? AppColors.accentInk : AppColors.seedDark;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
    ).copyWith(
      primary: accent,
      onPrimary: onAccent,
      primaryContainer: accent.withValues(alpha: 0.14),
      onPrimaryContainer: accentInk,
      secondary: accent,
      onSecondary: onAccent,
      secondaryContainer: accent.withValues(alpha: 0.10),
      onSecondaryContainer: accentInk,
      tertiary: AppColors.accentTeal,
      onTertiary: Colors.white,
      surface: surface,
      onSurface: text,
      surfaceContainerLowest: base,
      surfaceContainerLow: base,
      surfaceContainer: base,
      surfaceContainerHigh: base,
      surfaceContainerHighest: inset,
      onSurfaceVariant: muted,
      outline: muted.withValues(alpha: 0.45),
      outlineVariant: muted.withValues(alpha: 0.24),
      surfaceTint: Colors.transparent,
      inverseSurface: isLight ? AppColors.textLight : AppColors.baseLight,
      onInverseSurface: isLight ? AppColors.baseLight : AppColors.textLight,
      error: isLight ? AppColors.due : AppColors.dueDark,
      onError: Colors.white,
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTokens.radiusControl),
    );
    final buttonText = const TextStyle(
      fontSize: AppTokens.textBody,
      fontWeight: AppTokens.weightSemibold,
      letterSpacing: 0.1,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: base,
      canvasColor: base,
      visualDensity: VisualDensity.standard,
      textTheme: _textTheme(text, muted),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: base,
        foregroundColor: text,
        iconTheme: IconThemeData(color: accentInk),
        titleTextStyle: TextStyle(
          fontSize: AppTokens.textHeading,
          fontWeight: AppTokens.weightSemibold,
          color: text,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: onAccent,
          disabledBackgroundColor: inset,
          disabledForegroundColor: muted,
          elevation: 2,
          shadowColor: shadow.withValues(alpha: 0.35),
          minimumSize: const Size(88, AppTokens.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.s5),
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: base,
          foregroundColor: text,
          disabledForegroundColor: muted,
          side: BorderSide.none,
          elevation: 3,
          shadowColor: shadow.withValues(alpha: 0.30),
          minimumSize: const Size(88, AppTokens.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.s5),
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          minimumSize: const Size(64, AppTokens.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.s4),
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: accent,
          minimumSize: const Size(AppTokens.iconButtonSize,
              AppTokens.iconButtonSize),
          shape: const CircleBorder(),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inset,
        hintStyle: TextStyle(color: muted.withValues(alpha: 0.8)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusControl),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusControl),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusControl),
          borderSide: BorderSide(color: accentInk.withValues(alpha: 0.75), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusControl),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.s4,
          vertical: AppTokens.s3,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 76,
        backgroundColor: base,
        surfaceTintColor: Colors.transparent,
        indicatorColor: accent.withValues(alpha: isLight ? 0.14 : 0.22),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? AppTokens.weightSemibold
                : AppTokens.weightMedium,
            color: states.contains(WidgetState.selected) ? accentInk : muted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? accentInk : muted,
            size: AppTokens.iconLarge,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: base,
        elevation: 0,
        indicatorColor: accent.withValues(alpha: isLight ? 0.12 : 0.20),
        selectedIconTheme: IconThemeData(color: accentInk),
        unselectedIconTheme: IconThemeData(color: muted),
        selectedLabelTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: AppTokens.weightSemibold,
          color: accentInk,
        ),
        unselectedLabelTextStyle: TextStyle(fontSize: 12, color: muted),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: onAccent,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusControl),
        ),
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusSurface),
        ),
        titleTextStyle: TextStyle(
          fontSize: AppTokens.textHeading,
          fontWeight: AppTokens.weightSemibold,
          color: text,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        elevation: 12,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTokens.radiusSurface),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusChip),
        ),
        side: BorderSide.none,
        backgroundColor: accent.withValues(alpha: 0.18),
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
          backgroundColor: base,
          foregroundColor: muted,
          selectedBackgroundColor: accent,
          selectedForegroundColor: onAccent,
          visualDensity: VisualDensity.compact,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTokens.radiusControl),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accent,
        linearTrackColor: inset,
        circularTrackColor: inset,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: AppTokens.s4),
        iconColor: accent,
        titleTextStyle: TextStyle(
          fontSize: AppTokens.textBody,
          fontWeight: AppTokens.weightMedium,
          color: text,
        ),
        subtitleTextStyle: TextStyle(fontSize: AppTokens.textCaption, color: muted),
      ),
      dividerTheme: DividerThemeData(
        color: muted.withValues(alpha: 0.18),
        space: 1,
        thickness: 1,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(AppTokens.radiusChip),
        ),
        textStyle: TextStyle(
          color: colorScheme.onInverseSurface,
          fontSize: AppTokens.textCaption,
        ),
      ),
    );
  }

  static TextTheme _textTheme(Color text, Color muted) => TextTheme(
        displayLarge: TextStyle(
            fontSize: 36, fontWeight: AppTokens.weightSemibold,
            color: text, letterSpacing: -0.6),
        displayMedium: TextStyle(
            fontSize: 32, fontWeight: AppTokens.weightSemibold,
            color: text, letterSpacing: -0.5),
        headlineLarge: TextStyle(
            fontSize: 30, fontWeight: AppTokens.weightSemibold,
            color: text, letterSpacing: -0.5),
        headlineSmall: TextStyle(
            fontSize: 24, fontWeight: AppTokens.weightSemibold,
            color: text, letterSpacing: -0.3),
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: AppTokens.weightSemibold, color: text),
        titleMedium: TextStyle(
            fontSize: 16, fontWeight: AppTokens.weightSemibold, color: text),
        titleSmall: TextStyle(
            fontSize: 14, fontWeight: AppTokens.weightSemibold, color: text),
        bodyLarge: TextStyle(fontSize: 15, color: text, height: 1.35),
        bodyMedium: TextStyle(fontSize: 14, color: text, height: 1.35),
        bodySmall: TextStyle(fontSize: 12, color: muted, height: 1.3),
        labelLarge: TextStyle(
            fontSize: 14, fontWeight: AppTokens.weightSemibold, color: text),
        labelMedium: TextStyle(
            fontSize: 12, fontWeight: AppTokens.weightMedium, color: muted),
        labelSmall: TextStyle(
            fontSize: 11, fontWeight: AppTokens.weightMedium, color: muted),
      );
}
