import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/reading_repository.dart';

part 'reading_sessions.g.dart';

/// A reconstructed reading session: the values entered together on one date.
class ReadingSession {
  ReadingSession({
    required this.date,
    required this.mainReading,
    required this.tenantReadings,
    this.notes,
  });

  final DateTime date;
  final double? mainReading;

  /// tenantId → reading value.
  final Map<int, double> tenantReadings;
  final String? notes;
}

/// Groups raw readings back into sessions for display, newest first.
@riverpod
List<ReadingSession> readingSessions(Ref ref) {
  final readings = ref.watch(readingListProvider).value ?? const [];

  final byDate = groupBy(readings, (r) => r.readingDate);
  final sessions = <ReadingSession>[];

  for (final entry in byDate.entries) {
    final rows = entry.value;
    final mainRow =
        rows.firstWhereOrNull((r) => r.mainMeterId != null);
    final tenantReadings = <int, double>{
      for (final r in rows)
        if (r.tenantId != null) r.tenantId!: r.readingValue,
    };
    sessions.add(
      ReadingSession(
        date: entry.key,
        mainReading: mainRow?.readingValue,
        tenantReadings: tenantReadings,
        notes: rows.first.notes,
      ),
    );
  }

  sessions.sort((a, b) => b.date.compareTo(a.date));
  return sessions;
}
