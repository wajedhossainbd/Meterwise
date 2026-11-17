import 'package:drift/drift.dart';

import '../../constants/app_constants.dart';

/// A building / premises owned or managed by the user.
///
/// Top of the domain hierarchy: a [Property] owns one or more main meters.
class Properties extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 120)();

  TextColumn get address => text().nullable()();

  TextColumn get notes => text().nullable()();

  /// ISO-4217 currency code (e.g. BDT, USD). Defaults to the app default.
  TextColumn get currencyCode =>
      text().withLength(min: 3, max: 3).withDefault(
            const Constant(AppConstants.defaultCurrencyCode),
          )();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
