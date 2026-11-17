// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exposes the singleton [AppDatabase] to the Riverpod graph.
///
/// `keepAlive` because the database lives for the whole app session; it is
/// disposed only when the provider container is torn down. Repositories read
/// the database through this provider, never by constructing `AppDatabase()`
/// directly — this keeps a single connection and makes test overrides trivial.

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// Exposes the singleton [AppDatabase] to the Riverpod graph.
///
/// `keepAlive` because the database lives for the whole app session; it is
/// disposed only when the provider container is torn down. Repositories read
/// the database through this provider, never by constructing `AppDatabase()`
/// directly — this keeps a single connection and makes test overrides trivial.

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Exposes the singleton [AppDatabase] to the Riverpod graph.
  ///
  /// `keepAlive` because the database lives for the whole app session; it is
  /// disposed only when the provider container is torn down. Repositories read
  /// the database through this provider, never by constructing `AppDatabase()`
  /// directly — this keeps a single connection and makes test overrides trivial.
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'44154e51c3f3079ee293d8ad0ebd1e17cca871ed';
