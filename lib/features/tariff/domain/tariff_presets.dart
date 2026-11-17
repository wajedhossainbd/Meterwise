import '../../billing/domain/models/tariff.dart';

/// A read-only, built-in tariff template the user can load (and then clone to
/// edit). Presets are never modified — users clone them into an editable
/// version.
class TariffPreset {
  const TariffPreset({
    required this.name,
    required this.description,
    required this.tariff,
  });

  final String name;
  final String description;
  final Tariff tariff;
}

/// Official BERC retail residential (LT-A) tariff, effective bill month
/// **June 2026** — verified against the official DPDC published tariff page
/// (dpdc.gov.bd, updated 07 Jun 2026). Bangladesh retail tariffs are uniform
/// across distribution utilities, so the same slabs apply to every provider.
///
/// Lifeline: consumers using ≤ 50 units pay 4.63 for the entire consumption.
/// Demand charge: ৳42 per kW of sanctioned load per month (a typical 2 kW
/// residential connection = ৳84 — edit after cloning to match your load).
const Tariff _bdResidentialJun2026 = Tariff(
  slabs: [
    TariffSlabRange(fromUnit: 0, toUnit: 75, rate: 5.26),
    TariffSlabRange(fromUnit: 76, toUnit: 200, rate: 8.50),
    TariffSlabRange(fromUnit: 201, toUnit: 300, rate: 9.10),
    TariffSlabRange(fromUnit: 301, toUnit: 400, rate: 9.62),
    TariffSlabRange(fromUnit: 401, toUnit: 600, rate: 15.01),
    TariffSlabRange(fromUnit: 601, toUnit: null, rate: 17.35),
  ],
  lifelineUpTo: 50,
  lifelineRate: 4.63,
  demandCharge: 84,
  meterRent: 40,
  vatPercent: 5,
  rebatePercent: 0.5,
);

/// The pre-2026 slab structure originally shipped with MeterWise, kept so
/// existing users can reproduce their historical bills.
const Tariff _bdResidentialLegacy = Tariff(
  slabs: [
    TariffSlabRange(fromUnit: 0, toUnit: 50, rate: 4.19),
    TariffSlabRange(fromUnit: 51, toUnit: 75, rate: 5.72),
    TariffSlabRange(fromUnit: 76, toUnit: 200, rate: 6.02),
    TariffSlabRange(fromUnit: 201, toUnit: 300, rate: 6.30),
    TariffSlabRange(fromUnit: 301, toUnit: 400, rate: 6.34),
    TariffSlabRange(fromUnit: 401, toUnit: 600, rate: 9.94),
    TariffSlabRange(fromUnit: 601, toUnit: null, rate: 11.46),
  ],
  demandCharge: 84,
  meterRent: 40,
  vatPercent: 5,
  rebatePercent: 0.5,
);

/// Bangladesh distribution utilities (uniform retail tariff nationwide).
const List<String> kBangladeshProviders = [
  'DPDC',
  'DESCO',
  'BPDB',
  'BREB',
  'NESCO',
  'WZPDCL',
];

/// Built-in presets: one per utility on the verified June-2026 structure,
/// plus the legacy pre-2026 structure.
final List<TariffPreset> kTariffPresets = [
  for (final p in kBangladeshProviders)
    TariffPreset(
      name: '$p Residential (Jun 2026)',
      description:
          'Official BERC LT-A residential tariff effective June 2026. '
          'Lifeline 4.63 (≤50 units). Demand ৳42/kW — adjust for your '
          'sanctioned load.',
      tariff: _bdResidentialJun2026,
    ),
  const TariffPreset(
    name: 'BD Residential (pre-2026 legacy)',
    description:
        'Previous slab structure (4.19–11.46) for reproducing older bills.',
    tariff: _bdResidentialLegacy,
  ),
];
