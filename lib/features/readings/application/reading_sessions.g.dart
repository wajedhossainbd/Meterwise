// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_sessions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Groups raw readings back into sessions for display, newest first.

@ProviderFor(readingSessions)
final readingSessionsProvider = ReadingSessionsProvider._();

/// Groups raw readings back into sessions for display, newest first.

final class ReadingSessionsProvider
    extends
        $FunctionalProvider<
          List<ReadingSession>,
          List<ReadingSession>,
          List<ReadingSession>
        >
    with $Provider<List<ReadingSession>> {
  /// Groups raw readings back into sessions for display, newest first.
  ReadingSessionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readingSessionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readingSessionsHash();

  @$internal
  @override
  $ProviderElement<List<ReadingSession>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ReadingSession> create(Ref ref) {
    return readingSessions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ReadingSession> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ReadingSession>>(value),
    );
  }
}

String _$readingSessionsHash() => r'47f9e333d51fd73c4f156a3a7b38a3c7a3e1bddc';
