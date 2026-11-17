import 'package:drift/drift.dart';

/// An electricity utility / tariff profile (e.g. "DPDC LT-A").
///
/// Deliberately *not* hardcoded anywhere in the engine — providers are data, so
/// the app works for any utility worldwide. A provider owns a set of
/// [TariffSlabs] plus the flat charges applied on top of energy cost.
class ElectricityProviders extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 120)();

  /// VAT applied on the energy cost, as a percentage (e.g. 5.0 == 5%).
  RealColumn get vatPercent => real().withDefault(const Constant(0))();

  /// Prompt-payment rebate, as a percentage of energy cost.
  RealColumn get rebatePercent => real().withDefault(const Constant(0))();

  /// Fixed monthly meter rent (absolute currency amount).
  RealColumn get meterRent => real().withDefault(const Constant(0))();

  /// Demand charge per kW of sanctioned load (absolute amount per kW).
  RealColumn get demandChargePerKw => real().withDefault(const Constant(0))();

  TextColumn get currencyCode =>
      text().withLength(min: 3, max: 3).nullable()();

  /// Marks the provider seeded as the app default (DPDC LT-A).
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
