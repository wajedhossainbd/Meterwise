import 'package:drift/drift.dart';

import 'electricity_providers_table.dart';

/// A single price tier within a provider's tariff.
///
/// Example (DPDC LT-A): `0–50 → 4.19`, `51–75 → 5.72`, ... `601+ → 11.46`.
///
/// [toUnit] is nullable to represent the unbounded final slab (`601+`). Slabs
/// are ordered by [sortOrder] and are expected to be contiguous; validation of
/// that contract lives in the domain layer (Phase 2), not the database.
class TariffSlabs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get providerId =>
      integer().references(ElectricityProviders, #id, onDelete: KeyAction.cascade)();

  /// Inclusive lower bound of the slab in kWh (units).
  IntColumn get fromUnit => integer()();

  /// Inclusive upper bound in kWh, or `null` for the final open-ended slab.
  IntColumn get toUnit => integer().nullable()();

  /// Per-unit price within this slab.
  RealColumn get rate => real()();

  /// Display / evaluation order (ascending).
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
