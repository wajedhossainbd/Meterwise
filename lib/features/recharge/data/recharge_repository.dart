import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../billing/data/period_guard.dart';

/// Mutable fields of a recharge, shared by create and update.
typedef RechargeDraft = ({
  DateTime date,
  double amount,
  double energyCost,
  double demandCharge,
  double meterRent,
  double vat,
  double rebate,
  double agentFee,
  double otherExpenses,
  String? paidBy,
  String? tokenNumber,
  String? notes,
  String? receiptPath,
});

/// Data access for [Recharge] records.
class RechargeRepository {
  RechargeRepository(this._db);

  final AppDatabase _db;
  late final PeriodGuard _guard = PeriodGuard(_db);

  Future<Recharge?> _byId(int id) =>
      (_db.select(_db.recharges)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<List<Recharge>> watchAll() => (_db.select(_db.recharges)
        ..orderBy([
          (t) => OrderingTerm(
                expression: t.rechargeDate,
                mode: OrderingMode.desc,
              ),
        ]))
      .watch();

  Future<List<Recharge>> getAll() => _db.select(_db.recharges).get();

  Future<int> create(int mainMeterId, RechargeDraft d) async {
    await _guard.ensureMainMeterEditable(mainMeterId, d.date);
    return _db.into(_db.recharges).insert(
          RechargesCompanion.insert(
            mainMeterId: mainMeterId,
            rechargeDate: d.date,
            amount: d.amount,
            energyCost: Value(d.energyCost),
            demandCharge: Value(d.demandCharge),
            meterRent: Value(d.meterRent),
            vat: Value(d.vat),
            rebate: Value(d.rebate),
            agentFee: Value(d.agentFee),
            otherExpenses: Value(d.otherExpenses),
            paidBy: Value(d.paidBy),
            tokenNumber: Value(d.tokenNumber),
            notes: Value(d.notes),
            receiptPath: Value(d.receiptPath),
          ),
        );
  }

  Future<void> updateRecharge(int id, RechargeDraft d) async {
    final existing = await _byId(id);
    if (existing != null) {
      // Block if either the original or the new month is finalized.
      await _guard.ensureMainMeterEditable(
          existing.mainMeterId, existing.rechargeDate);
      await _guard.ensureMainMeterEditable(existing.mainMeterId, d.date);
    }
    await (_db.update(_db.recharges)..where((t) => t.id.equals(id))).write(
      RechargesCompanion(
        rechargeDate: Value(d.date),
        amount: Value(d.amount),
        energyCost: Value(d.energyCost),
        demandCharge: Value(d.demandCharge),
        meterRent: Value(d.meterRent),
        vat: Value(d.vat),
        rebate: Value(d.rebate),
        agentFee: Value(d.agentFee),
        otherExpenses: Value(d.otherExpenses),
        paidBy: Value(d.paidBy),
        tokenNumber: Value(d.tokenNumber),
        notes: Value(d.notes),
        receiptPath: Value(d.receiptPath),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> delete(int id) async {
    final existing = await _byId(id);
    if (existing != null) {
      await _guard.ensureMainMeterEditable(
          existing.mainMeterId, existing.rechargeDate);
    }
    await (_db.delete(_db.recharges)..where((t) => t.id.equals(id))).go();
  }
}

final rechargeRepositoryProvider = Provider<RechargeRepository>(
  (ref) => RechargeRepository(ref.watch(appDatabaseProvider)),
);

/// All recharges, newest first (reactive).
final rechargeListProvider = StreamProvider<List<Recharge>>(
  (ref) => ref.watch(rechargeRepositoryProvider).watchAll(),
);
