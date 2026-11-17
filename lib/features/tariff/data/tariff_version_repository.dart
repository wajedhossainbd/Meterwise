import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../billing/domain/models/tariff.dart';
import 'tariff_repository.dart';

/// Raised on invalid tariff-version operations (duplicate effective date,
/// deleting the last version, …). The message is user-facing.
class TariffException implements Exception {
  const TariffException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Manages dated [TariffVersions]. Billing resolves the version effective on a
/// given month **by effective date**, never by creation order. Effective dates
/// are unique. Archived versions are excluded from resolution.
class TariffVersionRepository {
  TariffVersionRepository(this._db);

  final AppDatabase _db;

  Stream<List<TariffVersion>> watchAll() => (_db.select(_db.tariffVersions)
        ..orderBy([
          (t) => OrderingTerm(
              expression: t.effectiveFrom, mode: OrderingMode.desc),
        ]))
      .watch();

  Future<List<TariffVersion>> getAll() => (_db.select(_db.tariffVersions)
        ..orderBy([
          (t) => OrderingTerm(
              expression: t.effectiveFrom, mode: OrderingMode.desc),
        ]))
      .get();

  /// The active (non-archived) version effective on [date] — the latest
  /// effectiveFrom ≤ date — or the earliest active version if [date] predates
  /// all of them. Resolution is purely by effective date.
  Future<TariffVersion?> activeVersionForDate(DateTime date) async {
    final atOrBefore = await (_db.select(_db.tariffVersions)
          ..where((t) =>
              t.effectiveFrom.isSmallerOrEqualValue(date) &
              t.archived.equals(false))
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.effectiveFrom, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .getSingleOrNull();
    if (atOrBefore != null) return atOrBefore;
    return (_db.select(_db.tariffVersions)
          ..where((t) => t.archived.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.effectiveFrom)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// The [Tariff] effective on [date]. Falls back to a safe default if no
  /// versions exist yet (should not happen after seeding).
  Future<Tariff> tariffForDate(DateTime date) async {
    final version = await activeVersionForDate(date);
    if (version == null) {
      return const Tariff(
        slabs: [],
        demandCharge: 0,
        meterRent: 0,
        vatPercent: 0,
        rebatePercent: 0,
      );
    }
    return decode(version.tariffJson);
  }

  /// The most recent version's tariff (used to prefill a new version form).
  Future<Tariff?> latestTariff() async {
    final v = await (_db.select(_db.tariffVersions)
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.effectiveFrom, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .getSingleOrNull();
    return v == null ? null : decode(v.tariffJson);
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Future<void> _ensureUniqueDate(DateTime date, {int? excludeId}) async {
    final all = await getAll();
    final clash = all.any((v) =>
        v.id != excludeId && _sameDay(v.effectiveFrom, date));
    if (clash) {
      throw const TariffException(
          'Another tariff version already has this effective date. Each '
          'version must have a unique effective date.');
    }
  }

  Future<int> createVersion({
    required String label,
    required DateTime effectiveFrom,
    required Tariff tariff,
  }) async {
    await _ensureUniqueDate(effectiveFrom);
    return _db.into(_db.tariffVersions).insert(
          TariffVersionsCompanion.insert(
            label: label,
            effectiveFrom: effectiveFrom,
            tariffJson: jsonEncode(tariff.toJson()),
          ),
        );
  }

  /// Edits an existing version (rename / change date / change rates). Finalized
  /// bills are unaffected because they hold their own snapshot.
  Future<void> updateVersion({
    required int id,
    required String label,
    required DateTime effectiveFrom,
    required Tariff tariff,
  }) async {
    await _ensureUniqueDate(effectiveFrom, excludeId: id);
    await (_db.update(_db.tariffVersions)..where((t) => t.id.equals(id))).write(
      TariffVersionsCompanion(
        label: Value(label),
        effectiveFrom: Value(effectiveFrom),
        tariffJson: Value(jsonEncode(tariff.toJson())),
      ),
    );
  }

  Future<void> setArchived(int id, {required bool archived}) async {
    await (_db.update(_db.tariffVersions)..where((t) => t.id.equals(id)))
        .write(TariffVersionsCompanion(archived: Value(archived)));
  }

  Future<void> deleteVersion(int id) async {
    final all = await getAll();
    final activeCount = all.where((v) => !v.archived).length;
    final target = all.firstWhere((v) => v.id == id);
    if (!target.archived && activeCount <= 1) {
      throw const TariffException(
          'Cannot delete the only active tariff version. Add another version '
          'first, or archive this one instead.');
    }
    await (_db.delete(_db.tariffVersions)..where((t) => t.id.equals(id))).go();
  }

  /// Suggests the next version label, e.g. "Version 3".
  Future<String> nextLabel() async {
    final count = (await getAll()).length;
    return 'Version ${count + 1}';
  }

  /// Seeds "Version 1" from the legacy single tariff on first upgrade, so all
  /// pre-existing history resolves to a versioned tariff.
  Future<void> ensureSeeded() async {
    final existing =
        await (_db.select(_db.tariffVersions)..limit(1)).getSingleOrNull();
    if (existing != null) return;
    final legacy = await TariffRepository(_db).getTariff();
    await createVersion(
      label: 'Version 1',
      effectiveFrom: DateTime(2000),
      tariff: legacy,
    );
  }

  Tariff decode(String json) =>
      Tariff.fromJson(jsonDecode(json) as Map<String, dynamic>);
}

final tariffVersionRepositoryProvider = Provider<TariffVersionRepository>(
  (ref) => TariffVersionRepository(ref.watch(appDatabaseProvider)),
);

final tariffVersionsProvider = StreamProvider<List<TariffVersion>>(
  (ref) => ref.watch(tariffVersionRepositoryProvider).watchAll(),
);
