import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

/// Holds the user's selected [ThemeMode].
///
/// Kept intentionally simple for Phase 1 (in-memory only). Phase 5 / Settings
/// will persist this to local storage and hydrate it on startup; because the UI
/// only ever reads/writes through this controller, that change will not touch
/// any widget code.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ThemeMode.system;

  /// Set an explicit theme mode (system / light / dark).
  void setThemeMode(ThemeMode mode) => state = mode;

  /// Convenience toggle for a binary "dark mode" switch in Settings.
  void setDarkMode({required bool enabled}) =>
      state = enabled ? ThemeMode.dark : ThemeMode.light;
}
