import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Imports a landlord Drive packet into this device's local database.
///
/// Matching is by natural keys (name / date / value) so repeated syncs are
/// idempotent — a tenant can refresh any number of times without duplicates.
class PacketImportService {
  PacketImportService(this._db);

  final AppDatabase _db;

  Future<int> import(Map<String, dynamic> packet) async {
    var added = 0;
    final property = packet['property'] as Map<String, dynamic>? ?? {};

    // Property (singleton on this device).
    final existingProperty = await (_db.select(_db.properties)
          ..limit(1))
        .getSingleOrNull();
    final propertyId = existingProperty?.id ??
        await _db.into(_db.properties).insert(PropertiesCompanion.insert(
              name: property['name'] as String? ?? 'MeterWise',
              address: Value(property['address'] as String?),
              currencyCode: Value(property['currency'] as String? ?? 'BDT'),
            ));

    // Provider + main meter (singleton).
    final provider = await _db
        .into(_db.electricityProviders)
        .insert(ElectricityProvidersCompanion.insert(
          name: property['provider'] as String? ?? 'DPDC',
        ));
    final existingMeter = await (_db.select(_db.mainMeters)..limit(1))
        .getSingleOrNull();
    final meterId = existingMeter?.id ??
        await _db.into(_db.mainMeters).insert(MainMetersCompanion.insert(
              propertyId: propertyId,
              providerId: provider,
              name: 'Main',
            ));

    // Tenants by name.
    final nameToId = <String, int>{};
    for (final t in (packet['tenants'] as List<dynamic>? ?? [])) {
      final map = t as Map<String, dynamic>;
      final name = map['name'] as String;
      final found = await (_db.select(_db.tenants)
            ..where((x) => x.name.equals(name))
            ..limit(1))
          .getSingleOrNull();
      nameToId[name] = found?.id ??
          await _db.into(_db.tenants).insert(TenantsCompanion.insert(
                mainMeterId: meterId,
                name: name,
                phone: Value(map['phone'] as String?),
                billingMode: Value(map['billingMode'] as String? ?? 'shared'),
                fixedRate: Value((map['fixedRate'] as num?)?.toDouble()),
              ));
    }

    // Readings: skip any already present for the same meter/date/value.
    for (final r in (packet['readings'] as List<dynamic>? ?? [])) {
      final map = r as Map<String, dynamic>;
      final date = DateTime.parse(map['date'] as String);
      final value = (map['value'] as num).toDouble();
      final isMain = map['mainMeterId'] != null;
      final tenantId = isMain ? null : nameToId[_tenantNameFor(packet, map['tenantId'])];
      if (!isMain && tenantId == null) continue;
      final duplicate = await (_db.select(_db.meterReadings)
            ..where((x) =>
                x.readingDate.equals(date) &
                x.readingValue.equals(value) &
                (isMain
                    ? x.mainMeterId.equals(meterId)
                    : x.mainMeterId.isNull()) &
                (tenantId == null
                    ? x.tenantId.isNull()
                    : x.tenantId.equals(tenantId)))
            ..limit(1))
          .getSingleOrNull();
      if (duplicate != null) continue;
      await _db.into(_db.meterReadings).insert(MeterReadingsCompanion.insert(
            mainMeterId: isMain ? Value(meterId) : const Value.absent(),
            tenantId: tenantId == null ? const Value.absent() : Value(tenantId),
            readingDate: date,
            readingValue: value,
          ));
      added++;
    }

    // Recharges: match on date + amount + payer.
    for (final r in (packet['recharges'] as List<dynamic>? ?? [])) {
      final map = r as Map<String, dynamic>;
      final date = DateTime.parse(map['date'] as String);
      final amount = (map['amount'] as num).toDouble();
      final paidBy = map['paidBy'] as String?;
      final duplicate = await (_db.select(_db.recharges)
            ..where((x) =>
                x.rechargeDate.equals(date) &
                x.amount.equals(amount) &
                x.paidBy.equals(paidBy ?? ''))
            ..limit(1))
          .getSingleOrNull();
      if (duplicate != null) continue;
      await _db.into(_db.recharges).insert(RechargesCompanion.insert(
            mainMeterId: meterId,
            rechargeDate: date,
            amount: amount,
            agentFee: Value((map['agentFee'] as num?)?.toDouble() ?? 0),
            otherExpenses:
                Value((map['otherExpenses'] as num?)?.toDouble() ?? 0),
            paidBy: Value(paidBy),
          ));
      added++;
    }
    return added;
  }

  String? _tenantNameFor(Map<String, dynamic> packet, dynamic id) {
    for (final t in (packet['tenants'] as List<dynamic>? ?? [])) {
      final map = t as Map<String, dynamic>;
      if (map['id'] == id) return map['name'] as String?;
    }
    return null;
  }
}
