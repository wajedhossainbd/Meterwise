import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../billing/data/period_guard.dart';

/// Data access for [MeterReading] rows.
///
/// Readings are entered as a "session" (one date, one value per meter) but
/// stored as individual rows so the engine can derive consumption between any
/// two dates. Sessions are reconstructed for display by grouping on the date.
class ReadingRepository {
  ReadingRepository(this._db);

  final AppDatabase _db;
  late final PeriodGuard _guard = PeriodGuard(_db);

  /// All readings, newest first (reactive). Filtering by meter/tenant happens
  /// in Dart since the dataset for a single property is tiny.
  Stream<List<MeterReading>> watchAll() => (_db.select(_db.meterReadings)
        ..orderBy([
          (t) => OrderingTerm(
                expression: t.readingDate,
                mode: OrderingMode.desc,
              ),
        ]))
      .watch();

  /// Records a reading session: one main-meter reading plus one per tenant,
  /// all stamped with the same [date]. Written atomically.
  Future<void> addSession({
    required int mainMeterId,
    required DateTime date,
    required double mainReading,
    required Map<int, double> tenantReadings,
    String? notes,
    String? photoPath,
  }) async {
    await _guard.ensureMainMeterEditable(mainMeterId, date);
    await _db.transaction(() async {
      await _db.into(_db.meterReadings).insert(
            MeterReadingsCompanion.insert(
              mainMeterId: Value(mainMeterId),
              readingDate: date,
              readingValue: mainReading,
              notes: Value(notes),
              photoPath: Value(photoPath),
            ),
          );
      for (final entry in tenantReadings.entries) {
        await _db.into(_db.meterReadings).insert(
              MeterReadingsCompanion.insert(
                tenantId: Value(entry.key),
                readingDate: date,
                readingValue: entry.value,
                notes: Value(notes),
              ),
            );
      }
    });
  }

  /// Deletes every reading taken on [date] (the whole session).
  Future<void> deleteSession(DateTime date) async {
    await _guard.ensureReadingsOnDateEditable(date);
    await (_db.delete(_db.meterReadings)
          ..where((t) => t.readingDate.equals(date)))
        .go();
  }
}

final readingRepositoryProvider = Provider<ReadingRepository>(
  (ref) => ReadingRepository(ref.watch(appDatabaseProvider)),
);

/// All readings, newest first (reactive).
final readingListProvider = StreamProvider<List<MeterReading>>(
  (ref) => ref.watch(readingRepositoryProvider).watchAll(),
);
