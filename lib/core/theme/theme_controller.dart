import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

/// Parses the persisted theme string; unknown values fall back to system.
ThemeMode themeModeFromStorage(String value) => switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

/// Storage form of a [ThemeMode], written to `AppSettings.themeMode`.
String themeModeToStorage(ThemeMode mode) => switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

/// Holds the user's selected [ThemeMode] for the running session.
///
/// `main()` hydrates this from `AppSettings.themeMode` at startup and the
/// Settings screen writes every change back, so the in-memory state is simply
/// the live mirror of the persisted preference. No widget reads storage directly.
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
