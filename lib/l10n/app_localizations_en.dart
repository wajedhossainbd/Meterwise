// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'MeterWise';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navReadings => 'Readings';

  @override
  String get navRecharge => 'Recharge';

  @override
  String get navBills => 'Bills';

  @override
  String get navSettings => 'Settings';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionUndo => 'Undo';

  @override
  String get actionRetry => 'Retry';

  @override
  String get actionGotIt => 'Got it';

  @override
  String get actionAdd => 'Add';

  @override
  String get actionUse => 'Use';

  @override
  String get actionClone => 'Clone';

  @override
  String get actionPreview => 'Preview';

  @override
  String get actionArchive => 'Archive';

  @override
  String get actionUnarchive => 'Unarchive';

  @override
  String get actionPrint => 'Print';

  @override
  String get actionShare => 'Share PDF';

  @override
  String get actionRemove => 'Remove';

  @override
  String get actionCamera => 'Camera';

  @override
  String get actionGallery => 'Gallery';

  @override
  String get commonNotSet => 'Not set';

  @override
  String get commonNotesOptional => 'Notes (optional)';

  @override
  String get commonNotes => 'Notes';

  @override
  String get commonRequired => 'Required';

  @override
  String get commonEnterNumber => 'Enter a number';

  @override
  String get commonEnterPositive => 'Enter a positive amount';

  @override
  String get commonSomethingWrong => 'Something went wrong';

  @override
  String get onboardingQuestion => 'What would you like to manage?';

  @override
  String get onboardingSingle => 'Single meter';

  @override
  String get onboardingSingleDesc =>
      'My own house — one electricity meter, no tenants. A personal usage & cost tracker.';

  @override
  String get onboardingMulti => 'Multi-tenant building';

  @override
  String get onboardingMultiDesc =>
      'Apartment, hostel, rental or shops — split one main meter fairly across tenant sub-meters.';

  @override
  String get onboardingChangeLater =>
      'You can change this later in Settings → Billing.';

  @override
  String get tourSkip => 'Skip';

  @override
  String get tourNext => 'Next';

  @override
  String get tourIntroBody =>
      'Fair, automatic electricity billing for your building — record readings, and MeterWise handles the maths, the slabs and the invoices.';

  @override
  String get tourHowTitle => 'How it works';

  @override
  String get tourStep1Title => 'Record meter readings';

  @override
  String get tourStep1Body =>
      'Add the main meter and each tenant\'s sub-meter reading every month.';

  @override
  String get tourStep2Title => 'Log recharges';

  @override
  String get tourStep2Body =>
      'Every prepaid top-up with its fees, and who paid it.';

  @override
  String get tourStep3Title => 'Finalize & share bills';

  @override
  String get tourStep3Body =>
      'Fair slab-shared bills, locked as permanent records and shared as PDF invoices.';

  @override
  String welcomeTitle(Object appName) {
    return 'Welcome to $appName';
  }

  @override
  String get setupSubtitle => 'Finish a quick setup to start billing.';

  @override
  String get stepProperty => '1. Add your property';

  @override
  String get stepMeter => '2. Add your main meter';

  @override
  String get stepTenants => '3. Add tenants';

  @override
  String get finishSetupTitle => 'Finish setup first';

  @override
  String get finishSetupMsg =>
      'Add your property and main meter (Settings) before recording data.';

  @override
  String get dashAvailableBalance => 'Available balance';

  @override
  String get dashRemainingPrepaid => 'Remaining prepaid balance';

  @override
  String dashRechargedThisMonth(Object amount) {
    return 'Recharged this month: $amount';
  }

  @override
  String get dashAddReading => 'Add reading';

  @override
  String get dashAddRecharge => 'Add recharge';

  @override
  String get dashViewBills => 'View bills';

  @override
  String get dashMainUnits => 'Main meter units';

  @override
  String get dashEstimatedBill => 'Estimated bill';

  @override
  String get dashOutstanding => 'Outstanding';

  @override
  String get dashCommonArea => 'Common area';

  @override
  String get dashTenants => 'Tenants';

  @override
  String get dashMonthlyOverview => 'Monthly overview';

  @override
  String get dashUsage => 'Usage';

  @override
  String get dashRecharge => 'Recharge';

  @override
  String get dashBill => 'Bill';

  @override
  String get dashRecentActivity => 'Recent activity';

  @override
  String get dashLastReading => 'Last reading';

  @override
  String get dashLastRecharge => 'Last recharge';

  @override
  String get dashNoData => 'No data yet';

  @override
  String get dashNone => 'None yet';

  @override
  String get dashTenantBills => 'Tenant bills';

  @override
  String get dashInCredit => 'in credit';

  @override
  String get dashDue => 'due';

  @override
  String get settingsSetup => 'Setup';

  @override
  String get settingsProperty => 'Property';

  @override
  String get settingsMainMeter => 'Main meter';

  @override
  String get settingsTenants => 'Tenants';

  @override
  String get settingsSettlements => 'Settlements';

  @override
  String get settingsSettlementsSub => 'Direct tenant-to-tenant payments';

  @override
  String get settingsBilling => 'Billing';

  @override
  String get settingsTariff => 'Tariff & charges';

  @override
  String get settingsBackup => 'Backup & restore';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsSystem => 'System default';

  @override
  String get settingsLight => 'Light';

  @override
  String get settingsDark => 'Dark';

  @override
  String get settingsCurrency => 'Currency';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get billsTitle => 'Monthly Bills';

  @override
  String get billsMonthSummary => 'Month summary';

  @override
  String get billsTenantBills => 'Tenant bills';

  @override
  String get billsNoBillTitle => 'No bill for this month';

  @override
  String get billsNoBillMsg =>
      'Record a main-meter reading in this month (and one in a previous month) to generate bills.';

  @override
  String get billsTotalBilled => 'Total billed';

  @override
  String get billsTotalRecharge => 'Total recharge';

  @override
  String get billsOutstanding => 'Outstanding';

  @override
  String get billsMarkPaid => 'Mark paid';

  @override
  String get billsUnmark => 'Unmark';

  @override
  String get billsPaid => 'Paid';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusFinalized => 'Finalized';

  @override
  String get periodFinalize => 'Finalize';

  @override
  String get periodUnlock => 'Unlock';

  @override
  String periodFinalizedOn(Object date) {
    return 'Finalized on $date';
  }

  @override
  String get periodDraftHint =>
      'Draft months are editable and recalculated live. Finalizing locks this month as a permanent record.';

  @override
  String get periodFinalizedToast => 'Month finalized and locked';

  @override
  String get periodCannotFinalize => 'Cannot finalize yet';

  @override
  String get periodUnlockTitle => 'Unlock month?';

  @override
  String get periodUnlockWarning =>
      'This will allow editing finalized bills and may change historical calculations. You will need to finalize the month again afterwards.';

  @override
  String get periodLockedMessage =>
      'This billing period has been finalized. Unlock the month before making changes.';

  @override
  String get periodFinalizedChip => 'Finalized';

  @override
  String get readingsTitle => 'Meter Readings';

  @override
  String get readingsEmptyTitle => 'No readings yet';

  @override
  String get readingsEmptyMsg => 'Record your first main + tenant readings.';

  @override
  String get readingAdd => 'Add reading';

  @override
  String get readingSaved => 'Reading saved';

  @override
  String get readingDeleted => 'Reading deleted';

  @override
  String get readingDeleteTitle => 'Delete reading?';

  @override
  String readingDeleteMsg(Object date) {
    return 'Delete the reading from $date?';
  }

  @override
  String get readingDate => 'Date';

  @override
  String get readingMainMeter => 'Main meter';

  @override
  String get readingCurrentReading => 'Current reading';

  @override
  String get readingTenantSubmeters => 'Tenant sub-meters';

  @override
  String get readingNoTenants => 'No tenants added yet.';

  @override
  String get readingMeterPhoto => 'Meter photo (optional)';

  @override
  String readingDuplicate(Object date) {
    return 'A reading for $date already exists. Delete it first or pick another date.';
  }

  @override
  String readingMainLower(Object value, Object previous) {
    return 'Main reading ($value) is lower than the previous reading ($previous).';
  }

  @override
  String readingTenantLower(Object value, Object previous) {
    return 'A tenant reading ($value) is lower than its previous reading ($previous).';
  }

  @override
  String get readingLockedMsg =>
      'This month is finalized. Unlock it in Bills before adding readings.';

  @override
  String get rechargeTitle => 'Recharge Log';

  @override
  String get rechargeEmptyTitle => 'No recharges yet';

  @override
  String get rechargeEmptyMsg => 'Record prepaid recharges and who paid them.';

  @override
  String get rechargeAdd => 'Add recharge';

  @override
  String get rechargeEditTitle => 'Edit recharge';

  @override
  String get rechargeAddTitle => 'Add recharge';

  @override
  String get rechargeSaved => 'Recharge saved';

  @override
  String get rechargeUpdated => 'Recharge updated';

  @override
  String get rechargeDeleted => 'Recharge deleted';

  @override
  String get rechargeDeleteTitle => 'Delete recharge?';

  @override
  String get rechargeAmountPaid => 'Amount paid';

  @override
  String get rechargeAmount => 'Recharge amount';

  @override
  String get rechargePaidBy => 'Paid by';

  @override
  String get rechargePaidByName => 'Name';

  @override
  String get rechargePaidByHelp =>
      'Match a tenant name to credit their balance.';

  @override
  String get rechargeReceipt => 'Receipt';

  @override
  String get rechargeBreakdown => 'Cost breakdown (optional)';

  @override
  String get rechargeBreakdownSub => 'Energy, VAT, demand, meter rent…';

  @override
  String get rechargeEnergy => 'Energy cost';

  @override
  String get rechargeDemand => 'Demand charge';

  @override
  String get rechargeMeterRent => 'Meter rent';

  @override
  String get rechargeVat => 'VAT';

  @override
  String get rechargeRebate => 'Rebate';

  @override
  String get rechargeAgentFee => 'Agent fee';

  @override
  String get rechargeOther => 'Other expense';

  @override
  String get rechargeToken => 'Token number';

  @override
  String get rechargeLockedMsg =>
      'This month is finalized. Unlock it in Bills before editing recharges.';

  @override
  String rechargeBy(Object name) {
    return 'by $name';
  }

  @override
  String get tenantsTitle => 'Tenants';

  @override
  String get tenantsEmptyTitle => 'No tenants yet';

  @override
  String get tenantsEmptyMsg => 'Tap \"Add tenant\" to add your first tenant.';

  @override
  String get tenantSetupFirstTitle => 'Set up the main meter first';

  @override
  String get tenantSetupFirstMsg =>
      'Create your property and main meter before adding tenants.';

  @override
  String get tenantAdd => 'Add tenant';

  @override
  String get tenantEditTitle => 'Edit tenant';

  @override
  String get tenantAddTitle => 'Add tenant';

  @override
  String get tenantSaved => 'Tenant saved';

  @override
  String get tenantDeleteTitle => 'Delete tenant?';

  @override
  String tenantDeleteMsg(Object name) {
    return 'Delete $name? Their meter readings will also be removed.';
  }

  @override
  String get tenantName => 'Name';

  @override
  String get tenantApartment => 'Apartment';

  @override
  String get tenantSubmeter => 'Sub-meter number';

  @override
  String get tenantPhone => 'Phone';

  @override
  String get tenantEmail => 'Email';

  @override
  String tenantLastReading(Object value) {
    return 'Last reading: $value';
  }

  @override
  String get tenantNoReadings => 'No readings yet';

  @override
  String get tenantCall => 'Call';

  @override
  String get tenantWhatsapp => 'WhatsApp';

  @override
  String get tenantNameRequired => 'Name is required';

  @override
  String get tenantBillingMode => 'Billing mode';

  @override
  String get tenantModeShared => 'Shared slab';

  @override
  String get tenantModeSharedSub =>
      'Pays a fair share of the actual bill (default)';

  @override
  String get tenantModeFixed => 'Fixed unit rate';

  @override
  String get tenantModeFixedSub => 'Pays a negotiated flat price per unit';

  @override
  String get tenantFixedRateLabel => 'Fixed price per unit';

  @override
  String get tenantFixedRateRequired => 'Enter the per-unit price';

  @override
  String tenantFixedChip(Object rate) {
    return 'Fixed $rate/unit';
  }

  @override
  String get propertyTitle => 'Property';

  @override
  String get propertyName => 'Property name';

  @override
  String get propertyNameHint => 'e.g. Rahman Villa';

  @override
  String get propertyNameRequired => 'Name is required';

  @override
  String get propertyAddress => 'Address';

  @override
  String get meterTitle => 'Main Meter';

  @override
  String get meterName => 'Meter name';

  @override
  String get meterNameHint => 'e.g. Ground Floor DPDC';

  @override
  String get meterNameRequired => 'Name is required';

  @override
  String get meterNumber => 'Meter number';

  @override
  String get meterCreatePropertyFirst => 'Please create a property first.';

  @override
  String get tariffTitle => 'Tariff Manager';

  @override
  String get tariffPresets => 'Presets';

  @override
  String get tariffVersions => 'Versions';

  @override
  String get tariffNoVersions => 'No tariff versions yet.';

  @override
  String get tariffAddVersion => 'Add version';

  @override
  String get tariffNewVersion => 'New tariff version';

  @override
  String get tariffEditVersion => 'Edit tariff version';

  @override
  String get tariffVersionLabel => 'Version label';

  @override
  String get tariffEnterLabel => 'Enter a label';

  @override
  String get tariffEffectiveFrom => 'Effective from';

  @override
  String tariffEffective(Object date) {
    return 'Effective $date';
  }

  @override
  String get tariffArchived => 'Archived';

  @override
  String get tariffSlabs => 'Slabs (per unit rate)';

  @override
  String get tariffSlabFrom => 'From';

  @override
  String get tariffSlabTo => 'To';

  @override
  String get tariffSlabRate => 'Rate';

  @override
  String get tariffSlabHint =>
      'Leave the last slab\'s \"To\" empty for an open-ended top tier (e.g. 601+).';

  @override
  String get tariffLifeline => 'Lifeline tariff (optional)';

  @override
  String get tariffLifelineUpTo => 'Lifeline threshold (units)';

  @override
  String get tariffLifelineRate => 'Lifeline rate';

  @override
  String get tariffLifelineHint =>
      'Eligibility tariff, not a slab: if total units are within the threshold, ALL units are charged at this rate. Otherwise it is ignored and billing starts from the first slab.';

  @override
  String get tariffFixedCharges => 'Fixed charges';

  @override
  String get tariffDemandCharge => 'Demand charge';

  @override
  String get tariffMeterRent => 'Meter rent';

  @override
  String get tariffVat => 'VAT (%)';

  @override
  String get tariffRebate => 'Rebate (%)';

  @override
  String get tariffSaveVersion => 'Save version';

  @override
  String get tariffSaveChanges => 'Save changes';

  @override
  String get tariffSavedToast => 'Version saved';

  @override
  String get tariffUpdatedToast => 'Version updated';

  @override
  String get tariffDeleteTitle => 'Delete version?';

  @override
  String tariffDeleteMsg(Object label) {
    return 'Delete \"$label\"? This cannot be undone. Finalized bills keep their own snapshot and are unaffected.';
  }

  @override
  String get billingTitle => 'Billing';

  @override
  String get billingMode => 'Billing mode';

  @override
  String get billingModeSingle => 'Single meter';

  @override
  String get billingModeSingleSub => 'Personal use — one meter, no tenants';

  @override
  String get billingModeMulti => 'Multi-tenant building';

  @override
  String get billingModeMultiSub => 'Apartment, hostel, shops — split bills';

  @override
  String get billingMethod => 'Billing method';

  @override
  String get billingMethodUsage => 'Usage based (slab tariff)';

  @override
  String get billingMethodUsageSub => 'Proportional to actual usage';

  @override
  String get billingMethodFixed => 'Fixed unit rate';

  @override
  String get billingMethodFixedSub => 'A flat price per unit';

  @override
  String get billingFixedPrice => 'Fixed price per unit';

  @override
  String get billingSavePrice => 'Save price';

  @override
  String get billingSaved => 'Saved';

  @override
  String get calcModeTitle => 'Billing calculation mode';

  @override
  String get calcModeSharedSlab => 'Shared Slab (Landlord Mode)';

  @override
  String get calcModeSharedSlabSub =>
      'Each tenant is billed independently on shared slabs. The total may exceed the utility bill — the difference is your benefit.';

  @override
  String get calcModeReconciled => 'Reconciled (Weighted Average)';

  @override
  String get calcModeReconciledSub =>
      'The actual meter bill is split by usage. Tenant total always equals the bill; every shared tenant pays the same average rate.';

  @override
  String get calcModeFixed => 'Fixed Rate';

  @override
  String get calcModeFixedSub =>
      'Fixed-rate tenants pay their rate first; the remaining actual bill is split among shared tenants by usage.';

  @override
  String get ownerSummaryTitle => 'Owner summary';

  @override
  String get ownerMainBill => 'Main meter bill';

  @override
  String get ownerTenantTotal => 'Tenant bill total';

  @override
  String get ownerBenefit => 'Owner benefit';

  @override
  String get ownerLoss => 'Owner loss';

  @override
  String get ownerDifference => 'Difference';

  @override
  String get ownerCollectedFixed => 'Collected (fixed)';

  @override
  String get ownerRemainingShared => 'Shared tenants';

  @override
  String get ownerCollectionPct => 'Collection';

  @override
  String get ownerAvgCost => 'Avg unit cost';

  @override
  String get ownerAvgSell => 'Avg selling rate';

  @override
  String get distributionTitle => 'Fixed charge distribution';

  @override
  String get distributionSub =>
      'How demand charge, meter rent and fees are split among shared tenants';

  @override
  String get distributionEqual => 'Equal';

  @override
  String get distributionEqualSub =>
      'Split equally per tenant (e.g. rent 40 → 20 / 20)';

  @override
  String get distributionUsage => 'By usage';

  @override
  String get distributionUsageSub => 'Split in proportion to billed units';

  @override
  String get billingPerTenantHint =>
      'Each tenant\'s billing mode (shared slab or fixed rate) is set on the tenant\'s profile.';

  @override
  String get meterProvider => 'Electricity provider';

  @override
  String get effectiveRateLabel => 'Avg rate';

  @override
  String effectiveRateValue(Object rate) {
    return '$rate/unit';
  }

  @override
  String get invoiceBillingMode => 'Billing mode';

  @override
  String get invoiceExpenseShare => 'Expense share';

  @override
  String get invoiceSharedAdjustment => 'Slab-sharing adjustment';

  @override
  String get invoiceRechargeFees => 'Recharge fees paid';

  @override
  String get invoiceEffectiveRate => 'Effective rate';

  @override
  String get invoiceSignature => 'Authorized signature';

  @override
  String get invoiceBuildingBill => 'Building bill';

  @override
  String get invoicePreparing => 'Preparing invoice…';

  @override
  String get invoiceShareFailed =>
      'Could not create the invoice PDF. Please try again.';

  @override
  String get settlementsTitle => 'Settlements';

  @override
  String get settlementsEmptyTitle => 'No settlements yet';

  @override
  String get settlementsEmptyMsg => 'Record a direct payment between tenants.';

  @override
  String get settlementsNeedTwoTitle => 'Need at least two tenants';

  @override
  String get settlementsNeedTwoMsg =>
      'Settlements record a direct payment from one tenant to another.';

  @override
  String get settlementAdd => 'Add settlement';

  @override
  String get settlementNew => 'New settlement';

  @override
  String get settlementSaved => 'Settlement saved';

  @override
  String get settlementTransfer => 'Transfer';

  @override
  String get settlementFrom => 'From (payer — in due)';

  @override
  String get settlementTo => 'To (receiver — in credit)';

  @override
  String get settlementAmount => 'Amount';

  @override
  String get settlementSameTenant => 'Payer and receiver must be different.';

  @override
  String get settlementSelectTenant => 'Select a tenant';

  @override
  String get settlementPaid => 'Settlement paid';

  @override
  String get settlementReceived => 'Settlement received';

  @override
  String get backupTitle => 'Backup & Restore';

  @override
  String get backupLocal => 'Local backup';

  @override
  String get backupDesc =>
      'Save a backup file containing your database, receipts and meter photos. Keep it somewhere safe (e.g. Google Drive, email).';

  @override
  String get backupNow => 'Back up now';

  @override
  String get backupRestore => 'Restore from file';

  @override
  String get backupRestoreTitle => 'Restore backup?';

  @override
  String get backupRestoreWarning =>
      'This will replace all current data with the backup. This cannot be undone.';

  @override
  String get backupRestoreStagedTitle => 'Restore staged';

  @override
  String get backupRestoreStagedMsg =>
      'Backup restored. Please fully close and reopen MeterWise to apply the restored data.';

  @override
  String get backupChooseZip => 'Please choose a MeterWise backup (.zip) file.';

  @override
  String get backupNotValid =>
      'That file does not look like a MeterWise backup.';

  @override
  String backupFailed(Object error) {
    return 'Backup failed: $error';
  }

  @override
  String backupRestoreFailed(Object error) {
    return 'Restore failed: $error';
  }

  @override
  String get backupDriveTitle => 'Google Drive sync';

  @override
  String get backupDriveSoon => 'Coming soon';

  @override
  String get invoiceReadings => 'Meter readings';

  @override
  String get invoicePrevReading => 'Previous reading';

  @override
  String get invoiceCurrentReading => 'Current reading';

  @override
  String get invoiceOwnConsumption => 'Own consumption';

  @override
  String get invoiceCommonShare => 'Common-area share';

  @override
  String get invoiceBilledUnits => 'Billed units';

  @override
  String get invoiceTariffBreakdown => 'Tariff breakdown';

  @override
  String get invoiceCharges => 'Charges';

  @override
  String get invoiceEnergyCost => 'Energy cost';

  @override
  String get invoicePayment => 'Payment';

  @override
  String get invoicePreviousBalance => 'Previous balance';

  @override
  String get invoiceRechargePaid => 'Recharge paid';

  @override
  String get invoiceAvailableBalance => 'Available balance';

  @override
  String get invoiceTotalBill => 'Total bill';

  @override
  String get invoiceCarryForward => 'Carry forward (credit)';

  @override
  String get invoiceAmountDue => 'Amount due';

  @override
  String billsCreditAmount(Object amount) {
    return 'Credit $amount';
  }

  @override
  String billsDueAmount(Object amount) {
    return 'Due $amount';
  }

  @override
  String billsRecharged(Object amount) {
    return 'Recharged $amount';
  }

  @override
  String get chartUnitsPerMonth => 'Units (kWh) per month';

  @override
  String chartAmountPerMonth(Object symbol) {
    return 'Amount ($symbol) per month';
  }

  @override
  String tenantOpenFailed(Object scheme) {
    return 'Could not open $scheme';
  }

  @override
  String get validationRequired => 'Required';

  @override
  String get validationInteger => 'Enter a whole number';

  @override
  String get validationNumber => 'Enter a valid number';

  @override
  String get validateNoProperty => 'No property has been set up yet.';

  @override
  String get validateNoMeter => 'No main meter has been set up yet.';

  @override
  String get validateNoClosingReading =>
      'No closing meter reading recorded for this month.';

  @override
  String get validateDuplicateReading =>
      'Duplicate main-meter readings on the same date.';

  @override
  String get validateNoOpeningReading =>
      'No opening reading found before this month — record a baseline reading in a prior month first.';

  @override
  String validateClosingNotGreater(Object closing, Object opening) {
    return 'Closing reading ($closing) must be greater than the opening reading ($opening).';
  }

  @override
  String validateTenantLowerReading(Object tenant) {
    return 'Tenant \"$tenant\": closing reading is lower than the previous reading.';
  }

  @override
  String get validateRechargeAmount =>
      'A recharge in this month has a zero or negative amount.';

  @override
  String validateFixedRateMissing(Object tenant) {
    return 'Tenant \"$tenant\" is on a fixed unit rate but has no per-unit price set. Edit the tenant to set it.';
  }

  @override
  String get validateBillCompute => 'Could not compute a bill for this month.';

  @override
  String get invoiceTitle => 'Electricity Invoice';

  @override
  String get invoiceDraftBanner => 'DRAFT';

  @override
  String get invoiceStatus => 'Status';

  @override
  String get invoiceProvider => 'Provider';

  @override
  String get invoiceTariff => 'Tariff';

  @override
  String get invoiceGenerated => 'Generated';

  @override
  String get invoiceBilledTo => 'BILLED TO';

  @override
  String get invoiceFooter => 'Generated by MeterWise';

  @override
  String get invoiceLanguage => 'Invoice language';

  @override
  String get invoiceLanguageAuto => 'Follow app language';

  @override
  String get invoiceLanguageEn => 'English';

  @override
  String get invoiceLanguageBn => 'Bangla';

  @override
  String get invoiceFallbackNotice =>
      'Bangla PDF is unavailable on this device. An English invoice was created instead.';

  @override
  String get invoiceRetryBangla => 'Retry Bangla';

  @override
  String get chartRateCaption => 'Average selling rate per unit';

  @override
  String chartRateValue(Object value) {
    return '$value / unit';
  }

  @override
  String get tenantInviteTitle => 'Invite a tenant';

  @override
  String get tenantMeterCode => 'Meter code';

  @override
  String get tenantInviteHint =>
      'Share this code or QR with your tenant. They join from Join meter account.';

  @override
  String get tenantJoinTitle => 'Join meter account';

  @override
  String get tenantScanQr => 'Scan QR code';

  @override
  String get tenantEnterCode => 'Enter meter code';

  @override
  String get tenantChooseName => 'Choose your name';

  @override
  String get tenantJoinRequest => 'Join request';

  @override
  String get tenantPendingApproval =>
      'Waiting for the meter owner to approve your join request.';

  @override
  String get tenantApprove => 'Approve';

  @override
  String get tenantJoined => 'Joined meter';

  @override
  String get tenantRoleLandlord => 'I manage a meter';

  @override
  String get tenantRoleTenant => 'I am a tenant';

  @override
  String get tenantSwitchView => 'Switch view';

  @override
  String get tenantLeave => 'Leave meter';

  @override
  String get tenantNotApproved =>
      'Your meter owner has not approved your join yet.';

  @override
  String get tenantNoSubMeter => 'No sub-meter — your share is split equally';

  @override
  String get tenantHomeTitle => 'My meter';

  @override
  String get tenantCodeMismatch =>
      'That meter code was not found on this device';

  @override
  String get tenantAddReading => 'Add my reading';

  @override
  String get tenantAddRecharge => 'Add my recharge';

  @override
  String get tenantMarkPayment => 'Record payment';

  @override
  String get tenantReadingValue => 'Sub-meter reading';

  @override
  String get tenantAmount => 'Amount';

  @override
  String get tenantPaidTo => 'Paid to';

  @override
  String get tenantReceivedFrom => 'Received from';

  @override
  String get tenantSaveEntry => 'Save entry';

  @override
  String get tenantEntrySaved => 'Entry saved';

  @override
  String get tenantSelectTenant => 'Select tenant';

  @override
  String get tenantReadingTooLow => 'Reading must be higher than the last one';

  @override
  String get tenantSelfEntry => 'My entries';

  @override
  String get tenantBuildingTotal => 'Building total';

  @override
  String get driveSyncTitle => 'Drive sync';

  @override
  String get driveSignIn => 'Sign in with Google';

  @override
  String get driveBackup => 'Back up to Drive';

  @override
  String get driveSyncNow => 'Sync from Drive';

  @override
  String get driveSignOut => 'Sign out';

  @override
  String get driveSignedInAs => 'Signed in as';

  @override
  String get driveBackupDone => 'Backup uploaded';

  @override
  String driveSyncDone(Object count) {
    return 'Synced $count new entries';
  }

  @override
  String get driveNoPacket => 'No landlord packet found for this meter code';

  @override
  String get settingsPrivacy => 'Privacy policy';

  @override
  String updateAvailable(Object version) {
    return 'Update available: v$version';
  }

  @override
  String get updateBody =>
      'A newer version is available on GitHub. It will be downloaded in-app and Android will ask you to confirm the install.';

  @override
  String get updateLater => 'Later';

  @override
  String get updateInstall => 'Download & install';

  @override
  String get updateFailed =>
      'Could not download the update. Please try again later.';

  @override
  String get tenantSwitchLandlord => 'Switch to landlord view';

  @override
  String get tenantCheckStatus => 'Check approval status';
}
