import 'package:intl/intl.dart';

/// Centralized number / currency / date formatting.
///
/// Kept in one place so the whole app (screens *and* the PDF invoice) renders
/// values identically.
class Formatters {
  const Formatters._();

  /// Common currency symbols. Falls back to the raw code with a trailing space.
  static const Map<String, String> _symbols = {
    'BDT': '৳', // ৳
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'INR': '₹',
    'PKR': 'Rs ',
  };

  static String currencySymbol(String currencyCode) =>
      _symbols[currencyCode.toUpperCase()] ?? '$currencyCode ';

  /// Formats a monetary amount, e.g. `৳1,234.50`.
  static String money(num amount, {String currencyCode = 'BDT'}) {
    final formatter = NumberFormat.currency(
      symbol: currencySymbol(currencyCode),
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Formats a unit (kWh) value with up to two decimals, e.g. `112.5`.
  static String units(num value) {
    final formatter = NumberFormat('#,##0.##');
    return formatter.format(value);
  }

  /// `28 Feb 2026`
  static String date(DateTime date) => DateFormat('dd MMM yyyy').format(date);

  /// `February 2026`
  static String monthYear(DateTime date) =>
      DateFormat('MMMM yyyy').format(date);

  /// `Feb` — short month label for charts.
  static String monthShort(DateTime date) => DateFormat('MMM').format(date);

  /// `2026-02` — stable key for grouping/selecting a billing month.
  static String monthKey(DateTime date) => DateFormat('yyyy-MM').format(date);
}
