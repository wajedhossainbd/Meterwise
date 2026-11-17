// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the user's selected [ThemeMode] for the running session.
///
/// `main()` hydrates this from `AppSettings.themeMode` at startup and the
/// Settings screen writes every change back, so the in-memory state is simply
/// the live mirror of the persisted preference. No widget reads storage directly.

@ProviderFor(ThemeModeController)
final themeModeControllerProvider = ThemeModeControllerProvider._();

/// Holds the user's selected [ThemeMode] for the running session.
///
/// `main()` hydrates this from `AppSettings.themeMode` at startup and the
/// Settings screen writes every change back, so the in-memory state is simply
/// the live mirror of the persisted preference. No widget reads storage directly.
final class ThemeModeControllerProvider
    extends $NotifierProvider<ThemeModeController, ThemeMode> {
  /// Holds the user's selected [ThemeMode] for the running session.
  ///
  /// `main()` hydrates this from `AppSettings.themeMode` at startup and the
  /// Settings screen writes every change back, so the in-memory state is simply
  /// the live mirror of the persisted preference. No widget reads storage directly.
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

/// Holds the user's selected [ThemeMode] for the running session.
///
/// `main()` hydrates this from `AppSettings.themeMode` at startup and the
/// Settings screen writes every change back, so the in-memory state is simply
/// the live mirror of the persisted preference. No widget reads storage directly.

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
