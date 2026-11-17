// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tariff_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tariffRepository)
final tariffRepositoryProvider = TariffRepositoryProvider._();

final class TariffRepositoryProvider
    extends
        $FunctionalProvider<
          TariffRepository,
          TariffRepository,
          TariffRepository
        >
    with $Provider<TariffRepository> {
  TariffRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tariffRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tariffRepositoryHash();

  @$internal
  @override
  $ProviderElement<TariffRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TariffRepository create(Ref ref) {
    return tariffRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TariffRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TariffRepository>(value),
    );
  }
}

String _$tariffRepositoryHash() => r'c4fdc40531ebfb5af4f401e5c7aff6a8bdd6c10a';

/// The current tariff used for billing. Invalidate after editing in Settings.

@ProviderFor(currentTariff)
final currentTariffProvider = CurrentTariffProvider._();

/// The current tariff used for billing. Invalidate after editing in Settings.

final class CurrentTariffProvider
    extends $FunctionalProvider<AsyncValue<Tariff>, Tariff, FutureOr<Tariff>>
    with $FutureModifier<Tariff>, $FutureProvider<Tariff> {
  /// The current tariff used for billing. Invalidate after editing in Settings.
  CurrentTariffProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentTariffProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentTariffHash();

  @$internal
  @override
  $FutureProviderElement<Tariff> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Tariff> create(Ref ref) {
    return currentTariff(ref);
  }
}

String _$currentTariffHash() => r'36f19552d73b3d7c033bc52125da34e35eba1c89';
