# MeterWise Billing Engine v2.1 — Formula Documentation

*Engine: `lib/features/billing/domain/billing_engine.dart` (pure Dart, no Flutter/DB imports).*
*Tests: `test/billing_engine_test.dart`, `test/billing_periods_test.dart`, `test/migration_test.dart`.*

## The core rule (v2.2 — matches the reference spreadsheet exactly)

> **Every shared tenant receives an EQUAL SHARE of every DPDC slab: the
> per-tenant slab boundaries are the original cumulative upper bounds ÷ the
> number of shared tenants (floored to whole units). Each shared tenant walks
> that per-tenant ladder independently with only their own units; the
> open-ended top slab absorbs the remainder.**

There is no building-bill proration and no post-hoc cost redistribution. The
building's actual utility bill is still computed and reported
(`MonthlyBill.buildingBill`) for summaries.

Reference: *Personal Finance – Noman Electric bill.csv* (both tenant columns
are reproduced exactly by unit tests, to the last decimal).

## 1. Consumption

```
mainUnits        = max(0, mainClosing − mainOpening)
ownUnits_i       = max(0, tenantClosing_i − tenantOpening_i)
commonUnits      = max(0, mainUnits − Σ ownUnits)
usageShare_i     = ownUnits_i / Σ ownUnits          (equal split if Σ = 0)
billedUnits_i    = mainUnits × usageShare_i          (own + common share)
```

Opening reading = the reading immediately **before** the month's closing
reading (any date), so a month with two readings bills its true consumption.

## 2. The building bill (what DPDC actually charges)

```
energy(units):
    if lifelineUpTo set AND 0 < units ≤ lifelineUpTo:
        units × lifelineRate                          # official lifeline block
    else:
        walk the cumulative slab ladder once

buildingSubtotal = energy(mainUnits) + demandCharge + meterRent
buildingBill     = buildingSubtotal × (1 + VAT% − rebate%) + monthFees
monthFees        = Σ (recharge agent fees + other expenses) this month
```

## 3. Fixed-rate tenants (Mode 2)

```
charge_i = billedUnits_i × fixedRate_i        # all-inclusive, no VAT/fees added
```

Fixed-rate tenants **never consume slab capacity** and are excluded from the
shared-slab multiplier.

## 4. The per-tenant shared ladder (equal slab shares)

```
N = number of SHARED-mode tenants (fixed-rate tenants excluded)
per-tenant slab boundaries = floor(original cumulative upper bounds ÷ N)
   (each tenant gets ~1/N of every slab's capacity; the open-ended top slab
    stays open-ended; the LIFELINE threshold is NEVER divided)
```

Example (DPDC Jun-2026 ladder, N = 2): bounds 75/200/300/400/600 → 37/100/150/
200/300, i.e. per-tenant slab shares **37 / 63 / 50 / 50 / 100 / ∞**.
N = 3 → 25 / 41 / 34 / 33 / 67 / ∞. N = 4 → 18 / 32 / 25 / 25 / 50 / ∞.

Nothing is hardcoded — the slabs are read from the tariff version stored in
the database, so future government tariff changes work automatically. Invoices
show the ORIGINAL slab ranges with the tenant's units that fell in each.

## 5. Shared-slab tenants (Mode 1, default)

Each shared tenant walks their per-tenant ladder independently with their own
billedUnits:

```
w_i (fixed-charge weight) = 1/N              (distribution = Equal, default)
                          = billedUnits_i/Σ  (distribution = By usage)

energy_i    = energy(billedUnits_i, tariff, share = N)
fixedShare_i= (demandCharge + meterRent) × w_i
expense_i   = monthFees × w_i
subtotal_i  = energy_i + fixedShare_i + expense_i
vat_i       = subtotal_i × VAT%              # VAT base INCLUDES expenses
rebate_i    = subtotal_i × rebate%
totalBill_i = subtotal_i + vat_i − rebate_i
```

Worked example (N = 2, from the spreadsheet, demand 84 / rent 40 / fees 80):
- Tenant 1, 377 units → 37@5.26 + 63@8.50 + 50@9.10 + 50@9.62 + 100@15.01 +
  77@17.35 = **4503.07**; + rent 20 + demand 42 + fees 40 = 4605.07;
  VAT 230.2535 − rebate 23.02535 → **4812.29815**.
- Tenant 2, 204 units → 37 + 63 + 50 + 50 + 4 = **1726.16** → **1910.4272**.

```
effectiveRate_i = totalBill_i / billedUnits_i        # shown on dashboard + invoice
```

`sharedAdjustment` is always 0 (kept in snapshots for backward compatibility
with earlier finalized months).

## 6. Recharges (prepaid credits)

```
Recharge record: amount (energy credit) + agentFee + otherExpenses
actualPaid      = amount + fees
payer ledger   += actualPaid          # their real money out
monthFees      += fees                # redistributed via §2/§5
```

Invoices show *Recharge* (energy credit) and *Fees paid* as separate lines.

## 7. Settlements (tenant → tenant)

```
balance[from] += amount     # payer's due shrinks
balance[to]   −= amount     # receiver's credit shrinks
```

Net-zero across tenants; a real ledger transaction, never a fake recharge.

## 8. Carry-forward (ledger)

```
available_i = previousBalance_i + rechargePaid_i + settlementsPaid_i − settlementsReceived_i
balance_i   = available_i − totalBill_i      # carried into next month
```

Finalized months freeze the whole `MonthlyBill` as a JSON snapshot
(`BillingPeriods.calculationSnapshot`); the next month opens from the
snapshot's closing balances. Draft months recompute live. Finalized months are
immutable at the repository layer (`PeriodGuard`).

## 9. Tariff resolution

Versions are selected purely by **effective date** (latest `effectiveFrom ≤`
the month's first day; archived versions excluded; duplicate effective dates
rejected). Presets ship the official BERC LT-A residential tariff effective
**June 2026** (verified on dpdc.gov.bd, 07 Jun 2026): lifeline ≤50 @ 4.63,
0–75 @ 5.26, 76–200 @ 8.50, 201–300 @ 9.10, 301–400 @ 9.62, 401–600 @ 15.01,
601+ @ 17.35; demand ৳42/kW/month. Rates are uniform across DPDC / DESCO /
BPDB / BREB / NESCO / WZPDCL.

## Worked example (mixed contracts)

Building 500 units, flat-10 test tariff (demand 300, rent 100).
T1 fixed @8, 200 units ⇒ **1600** (all-inclusive, unchanged by anything else).
T2 shared, 300 units ⇒ 300 × 10 energy + 400 fixed charges = **3400**,
effective rate **11.33/unit**. Each contract is computed independently.
✓ (encoded as a unit test)

## Database changes (v2.0 = schema v7)

| Change | Purpose |
|---|---|
| `Tenants.billingMode` ('shared' default) | per-tenant contract |
| `Tenants.fixedRate` (nullable) | negotiated per-unit price |
| `AppSettings.fixedChargeDistribution` ('equal' default) | §5 weight |
| Migration | legacy *global* fixed-rate setting → per-tenant fixed contracts |

All migrations additive; verified by automated upgrade tests (v3→current,
v4→current, v6→v7 including the data migration). v1 finalized snapshots decode
unchanged (new fields default).
