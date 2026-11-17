// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the user's selected [ThemeMode].
///
/// Kept intentionally simple for Phase 1 (in-memory only). Phase 5 / Settings
/// will persist this to local storage and hydrate it on startup; because the UI
/// only ever reads/writes through this controller, that change will not touch
/// any widget code.

@ProviderFor(ThemeModeController)
final themeModeControllerProvider = ThemeModeControllerProvider._();

/// Holds the user's selected [ThemeMode].
///
/// Kept intentionally simple for Phase 1 (in-memory only). Phase 5 / Settings
/// will persist this to local storage and hydrate it on startup; because the UI
/// only ever reads/writes through this controller, that change will not touch
/// any widget code.
final class ThemeModeControllerProvider
    extends $NotifierProvider<ThemeModeController, ThemeMode> {
  /// Holds the user's selected [ThemeMode].
  ///
  /// Kept intentionally simple for Phase 1 (in-memory only). Phase 5 / Settings
  /// will persist this to local storage and hydrate it on startup; because the UI
  /// only ever reads/writes through this controller, that change will not touch
  /// any widget code.
  ThemeModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeControllerHash();

  @$internal
  @override
  ThemeModeController create() => ThemeModeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeControllerHash() =>
    r'2af83a4e290dae323a22d1a5727ca50f70886b5b';

/// Holds the user's selected [ThemeMode].
///
/// Kept intentionally simple for Phase 1 (in-memory only). Phase 5 / Settings
/// will persist this to local storage and hydrate it on startup; because the UI
/// only ever reads/writes through this controller, that change will not touch
/// any widget code.

abstract class _$ThemeModeController extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
