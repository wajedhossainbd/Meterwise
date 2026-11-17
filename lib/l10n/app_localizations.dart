import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'MeterWise'**
  String get appName;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navReadings.
  ///
  /// In en, this message translates to:
  /// **'Readings'**
  String get navReadings;

  /// No description provided for @navRecharge.
  ///
  /// In en, this message translates to:
  /// **'Recharge'**
  String get navRecharge;

  /// No description provided for @navBills.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get navBills;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// No description provided for @actionUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get actionUndo;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// No description provided for @actionGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get actionGotIt;

  /// No description provided for @actionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get actionAdd;

  /// No description provided for @actionUse.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get actionUse;

  /// No description provided for @actionClone.
  ///
  /// In en, this message translates to:
  /// **'Clone'**
  String get actionClone;

  /// No description provided for @actionPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get actionPreview;

  /// No description provided for @actionArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get actionArchive;

  /// No description provided for @actionUnarchive.
  ///
  /// In en, this message translates to:
  /// **'Unarchive'**
  String get actionUnarchive;

  /// No description provided for @actionPrint.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get actionPrint;

  /// No description provided for @actionShare.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get actionShare;

  /// No description provided for @actionRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get actionRemove;

  /// No description provided for @actionCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get actionCamera;

  /// No description provided for @actionGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get actionGallery;

  /// No description provided for @commonNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get commonNotSet;

  /// No description provided for @commonNotesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get commonNotesOptional;

  /// No description provided for @commonNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get commonNotes;

  /// No description provided for @commonRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get commonRequired;

  /// No description provided for @commonEnterNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a number'**
  String get commonEnterNumber;

  /// No description provided for @commonEnterPositive.
  ///
  /// In en, this message translates to:
  /// **'Enter a positive amount'**
  String get commonEnterPositive;

  /// No description provided for @commonSomethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonSomethingWrong;

  /// No description provided for @onboardingQuestion.
  ///
  /// In en, this message translates to:
  /// **'What would you like to manage?'**
  String get onboardingQuestion;

  /// No description provided for @onboardingSingle.
  ///
  /// In en, this message translates to:
  /// **'Single meter'**
  String get onboardingSingle;

  /// No description provided for @onboardingSingleDesc.
  ///
  /// In en, this message translates to:
  /// **'My own house — one electricity meter, no tenants. A personal usage & cost tracker.'**
  String get onboardingSingleDesc;

  /// No description provided for @onboardingMulti.
  ///
  /// In en, this message translates to:
  /// **'Multi-tenant building'**
  String get onboardingMulti;

  /// No description provided for @onboardingMultiDesc.
  ///
  /// In en, this message translates to:
  /// **'Apartment, hostel, rental or shops — split one main meter fairly across tenant sub-meters.'**
  String get onboardingMultiDesc;

  /// No description provided for @onboardingChangeLater.
  ///
  /// In en, this message translates to:
  /// **'You can change this later in Settings → Billing.'**
  String get onboardingChangeLater;

  /// No description provided for @tourSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get tourSkip;

  /// No description provided for @tourNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get tourNext;

  /// No description provided for @tourIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Fair, automatic electricity billing for your building — record readings, and MeterWise handles the maths, the slabs and the invoices.'**
  String get tourIntroBody;

  /// No description provided for @tourHowTitle.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get tourHowTitle;

  /// No description provided for @tourStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Record meter readings'**
  String get tourStep1Title;

  /// No description provided for @tourStep1Body.
  ///
  /// In en, this message translates to:
  /// **'Add the main meter and each tenant\'s sub-meter reading every month.'**
  String get tourStep1Body;

  /// No description provided for @tourStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Log recharges'**
  String get tourStep2Title;

  /// No description provided for @tourStep2Body.
  ///
  /// In en, this message translates to:
  /// **'Every prepaid top-up with its fees, and who paid it.'**
  String get tourStep2Body;

  /// No description provided for @tourStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Finalize & share bills'**
  String get tourStep3Title;

  /// No description provided for @tourStep3Body.
  ///
  /// In en, this message translates to:
  /// **'Fair slab-shared bills, locked as permanent records and shared as PDF invoices.'**
  String get tourStep3Body;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to {appName}'**
  String welcomeTitle(Object appName);

  /// No description provided for @setupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Finish a quick setup to start billing.'**
  String get setupSubtitle;

  /// No description provided for @stepProperty.
  ///
  /// In en, this message translates to:
  /// **'1. Add your property'**
  String get stepProperty;

  /// No description provided for @stepMeter.
  ///
  /// In en, this message translates to:
  /// **'2. Add your main meter'**
  String get stepMeter;

  /// No description provided for @stepTenants.
  ///
  /// In en, this message translates to:
  /// **'3. Add tenants'**
  String get stepTenants;

  /// No description provided for @finishSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish setup first'**
  String get finishSetupTitle;

  /// No description provided for @finishSetupMsg.
  ///
  /// In en, this message translates to:
  /// **'Add your property and main meter (Settings) before recording data.'**
  String get finishSetupMsg;

  /// No description provided for @dashAvailableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get dashAvailableBalance;

  /// No description provided for @dashRemainingPrepaid.
  ///
  /// In en, this message translates to:
  /// **'Remaining prepaid balance'**
  String get dashRemainingPrepaid;

  /// No description provided for @dashRechargedThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Recharged this month: {amount}'**
  String dashRechargedThisMonth(Object amount);

  /// No description provided for @dashAddReading.
  ///
  /// In en, this message translates to:
  /// **'Add reading'**
  String get dashAddReading;

  /// No description provided for @dashAddRecharge.
  ///
  /// In en, this message translates to:
  /// **'Add recharge'**
  String get dashAddRecharge;

  /// No description provided for @dashViewBills.
  ///
  /// In en, this message translates to:
  /// **'View bills'**
  String get dashViewBills;

  /// No description provided for @dashMainUnits.
  ///
  /// In en, this message translates to:
  /// **'Main meter units'**
  String get dashMainUnits;

  /// No description provided for @dashEstimatedBill.
  ///
  /// In en, this message translates to:
  /// **'Estimated bill'**
  String get dashEstimatedBill;

  /// No description provided for @dashOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Outstanding'**
  String get dashOutstanding;

  /// No description provided for @dashCommonArea.
  ///
  /// In en, this message translates to:
  /// **'Common area'**
  String get dashCommonArea;

  /// No description provided for @dashTenants.
  ///
  /// In en, this message translates to:
  /// **'Tenants'**
  String get dashTenants;

  /// No description provided for @dashMonthlyOverview.
  ///
  /// In en, this message translates to:
  /// **'Monthly overview'**
  String get dashMonthlyOverview;

  /// No description provided for @dashUsage.
  ///
  /// In en, this message translates to:
  /// **'Usage'**
  String get dashUsage;

  /// No description provided for @dashRecharge.
  ///
  /// In en, this message translates to:
  /// **'Recharge'**
  String get dashRecharge;

  /// No description provided for @dashBill.
  ///
  /// In en, this message translates to:
  /// **'Bill'**
  String get dashBill;

  /// No description provided for @dashRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get dashRecentActivity;

  /// No description provided for @dashLastReading.
  ///
  /// In en, this message translates to:
  /// **'Last reading'**
  String get dashLastReading;

  /// No description provided for @dashLastRecharge.
  ///
  /// In en, this message translates to:
  /// **'Last recharge'**
  String get dashLastRecharge;

  /// No description provided for @dashNoData.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get dashNoData;

  /// No description provided for @dashNone.
  ///
  /// In en, this message translates to:
  /// **'None yet'**
  String get dashNone;

  /// No description provided for @dashTenantBills.
  ///
  /// In en, this message translates to:
  /// **'Tenant bills'**
  String get dashTenantBills;

  /// No description provided for @dashInCredit.
  ///
  /// In en, this message translates to:
  /// **'in credit'**
  String get dashInCredit;

  /// No description provided for @dashDue.
  ///
  /// In en, this message translates to:
  /// **'due'**
  String get dashDue;

  /// No description provided for @settingsSetup.
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get settingsSetup;

  /// No description provided for @settingsProperty.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get settingsProperty;

  /// No description provided for @settingsMainMeter.
  ///
  /// In en, this message translates to:
  /// **'Main meter'**
  String get settingsMainMeter;

  /// No description provided for @settingsTenants.
  ///
  /// In en, this message translates to:
  /// **'Tenants'**
  String get settingsTenants;

  /// No description provided for @settingsSettlements.
  ///
  /// In en, this message translates to:
  /// **'Settlements'**
  String get settingsSettlements;

  /// No description provided for @settingsSettlementsSub.
  ///
  /// In en, this message translates to:
  /// **'Direct tenant-to-tenant payments'**
  String get settingsSettlementsSub;

  /// No description provided for @settingsBilling.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get settingsBilling;

  /// No description provided for @settingsTariff.
  ///
  /// In en, this message translates to:
  /// **'Tariff & charges'**
  String get settingsTariff;

  /// No description provided for @settingsBackup.
  ///
  /// In en, this message translates to:
  /// **'Backup & restore'**
  String get settingsBackup;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsSystem;

  /// No description provided for @settingsLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsLight;

  /// No description provided for @settingsDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsDark;

  /// No description provided for @settingsCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settingsCurrency;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @billsTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Bills'**
  String get billsTitle;

  /// No description provided for @billsMonthSummary.
  ///
  /// In en, this message translates to:
  /// **'Month summary'**
  String get billsMonthSummary;

  /// No description provided for @billsTenantBills.
  ///
  /// In en, this message translates to:
  /// **'Tenant bills'**
  String get billsTenantBills;

  /// No description provided for @billsNoBillTitle.
  ///
  /// In en, this message translates to:
  /// **'No bill for this month'**
  String get billsNoBillTitle;

  /// No description provided for @billsNoBillMsg.
  ///
  /// In en, this message translates to:
  /// **'Record a main-meter reading in this month (and one in a previous month) to generate bills.'**
  String get billsNoBillMsg;

  /// No description provided for @billsTotalBilled.
  ///
  /// In en, this message translates to:
  /// **'Total billed'**
  String get billsTotalBilled;

  /// No description provided for @billsTotalRecharge.
  ///
  /// In en, this message translates to:
  /// **'Total recharge'**
  String get billsTotalRecharge;

  /// No description provided for @billsOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Outstanding'**
  String get billsOutstanding;

  /// No description provided for @billsMarkPaid.
  ///
  /// In en, this message translates to:
  /// **'Mark paid'**
  String get billsMarkPaid;

  /// No description provided for @billsUnmark.
  ///
  /// In en, this message translates to:
  /// **'Unmark'**
  String get billsUnmark;

  /// No description provided for @billsPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get billsPaid;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusFinalized.
  ///
  /// In en, this message translates to:
  /// **'Finalized'**
  String get statusFinalized;

  /// No description provided for @periodFinalize.
  ///
  /// In en, this message translates to:
  /// **'Finalize'**
  String get periodFinalize;

  /// No description provided for @periodUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get periodUnlock;

  /// No description provided for @periodFinalizedOn.
  ///
  /// In en, this message translates to:
  /// **'Finalized on {date}'**
  String periodFinalizedOn(Object date);

  /// No description provided for @periodDraftHint.
  ///
  /// In en, this message translates to:
  /// **'Draft months are editable and recalculated live. Finalizing locks this month as a permanent record.'**
  String get periodDraftHint;

  /// No description provided for @periodFinalizedToast.
  ///
  /// In en, this message translates to:
  /// **'Month finalized and locked'**
  String get periodFinalizedToast;

  /// No description provided for @periodCannotFinalize.
  ///
  /// In en, this message translates to:
  /// **'Cannot finalize yet'**
  String get periodCannotFinalize;

  /// No description provided for @periodUnlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock month?'**
  String get periodUnlockTitle;

  /// No description provided for @periodUnlockWarning.
  ///
  /// In en, this message translates to:
  /// **'This will allow editing finalized bills and may change historical calculations. You will need to finalize the month again afterwards.'**
  String get periodUnlockWarning;

  /// No description provided for @periodLockedMessage.
  ///
  /// In en, this message translates to:
  /// **'This billing period has been finalized. Unlock the month before making changes.'**
  String get periodLockedMessage;

  /// No description provided for @periodFinalizedChip.
  ///
  /// In en, this message translates to:
  /// **'Finalized'**
  String get periodFinalizedChip;

  /// No description provided for @readingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Meter Readings'**
  String get readingsTitle;

  /// No description provided for @readingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No readings yet'**
  String get readingsEmptyTitle;

  /// No description provided for @readingsEmptyMsg.
  ///
  /// In en, this message translates to:
  /// **'Record your first main + tenant readings.'**
  String get readingsEmptyMsg;

  /// No description provided for @readingAdd.
  ///
  /// In en, this message translates to:
  /// **'Add reading'**
  String get readingAdd;

  /// No description provided for @readingSaved.
  ///
  /// In en, this message translates to:
  /// **'Reading saved'**
  String get readingSaved;

  /// No description provided for @readingDeleted.
  ///
  /// In en, this message translates to:
  /// **'Reading deleted'**
  String get readingDeleted;

  /// No description provided for @readingDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete reading?'**
  String get readingDeleteTitle;

  /// No description provided for @readingDeleteMsg.
  ///
  /// In en, this message translates to:
  /// **'Delete the reading from {date}?'**
  String readingDeleteMsg(Object date);

  /// No description provided for @readingDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get readingDate;

  /// No description provided for @readingMainMeter.
  ///
  /// In en, this message translates to:
  /// **'Main meter'**
  String get readingMainMeter;

  /// No description provided for @readingCurrentReading.
  ///
  /// In en, this message translates to:
  /// **'Current reading'**
  String get readingCurrentReading;

  /// No description provided for @readingTenantSubmeters.
  ///
  /// In en, this message translates to:
  /// **'Tenant sub-meters'**
  String get readingTenantSubmeters;

  /// No description provided for @readingNoTenants.
  ///
  /// In en, this message translates to:
  /// **'No tenants added yet.'**
  String get readingNoTenants;

  /// No description provided for @readingMeterPhoto.
  ///
  /// In en, this message translates to:
  /// **'Meter photo (optional)'**
  String get readingMeterPhoto;

  /// No description provided for @readingDuplicate.
  ///
  /// In en, this message translates to:
  /// **'A reading for {date} already exists. Delete it first or pick another date.'**
  String readingDuplicate(Object date);

  /// No description provided for @readingMainLower.
  ///
  /// In en, this message translates to:
  /// **'Main reading ({value}) is lower than the previous reading ({previous}).'**
  String readingMainLower(Object value, Object previous);

  /// No description provided for @readingTenantLower.
  ///
  /// In en, this message translates to:
  /// **'A tenant reading ({value}) is lower than its previous reading ({previous}).'**
  String readingTenantLower(Object value, Object previous);

  /// No description provided for @readingLockedMsg.
  ///
  /// In en, this message translates to:
  /// **'This month is finalized. Unlock it in Bills before adding readings.'**
  String get readingLockedMsg;

  /// No description provided for @rechargeTitle.
  ///
  /// In en, this message translates to:
  /// **'Recharge Log'**
  String get rechargeTitle;

  /// No description provided for @rechargeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No recharges yet'**
  String get rechargeEmptyTitle;

  /// No description provided for @rechargeEmptyMsg.
  ///
  /// In en, this message translates to:
  /// **'Record prepaid recharges and who paid them.'**
  String get rechargeEmptyMsg;

  /// No description provided for @rechargeAdd.
  ///
  /// In en, this message translates to:
  /// **'Add recharge'**
  String get rechargeAdd;

  /// No description provided for @rechargeEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit recharge'**
  String get rechargeEditTitle;

  /// No description provided for @rechargeAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add recharge'**
  String get rechargeAddTitle;

  /// No description provided for @rechargeSaved.
  ///
  /// In en, this message translates to:
  /// **'Recharge saved'**
  String get rechargeSaved;

  /// No description provided for @rechargeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Recharge updated'**
  String get rechargeUpdated;

  /// No description provided for @rechargeDeleted.
  ///
  /// In en, this message translates to:
  /// **'Recharge deleted'**
  String get rechargeDeleted;

  /// No description provided for @rechargeDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete recharge?'**
  String get rechargeDeleteTitle;

  /// No description provided for @rechargeAmountPaid.
  ///
  /// In en, this message translates to:
  /// **'Amount paid'**
  String get rechargeAmountPaid;

  /// No description provided for @rechargeAmount.
  ///
  /// In en, this message translates to:
  /// **'Recharge amount'**
  String get rechargeAmount;

  /// No description provided for @rechargePaidBy.
  ///
  /// In en, this message translates to:
  /// **'Paid by'**
  String get rechargePaidBy;

  /// No description provided for @rechargePaidByName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get rechargePaidByName;

  /// No description provided for @rechargePaidByHelp.
  ///
  /// In en, this message translates to:
  /// **'Match a tenant name to credit their balance.'**
  String get rechargePaidByHelp;

  /// No description provided for @rechargeReceipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get rechargeReceipt;

  /// No description provided for @rechargeBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Cost breakdown (optional)'**
  String get rechargeBreakdown;

  /// No description provided for @rechargeBreakdownSub.
  ///
  /// In en, this message translates to:
  /// **'Energy, VAT, demand, meter rent…'**
  String get rechargeBreakdownSub;

  /// No description provided for @rechargeEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy cost'**
  String get rechargeEnergy;

  /// No description provided for @rechargeDemand.
  ///
  /// In en, this message translates to:
  /// **'Demand charge'**
  String get rechargeDemand;

  /// No description provided for @rechargeMeterRent.
  ///
  /// In en, this message translates to:
  /// **'Meter rent'**
  String get rechargeMeterRent;

  /// No description provided for @rechargeVat.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get rechargeVat;

  /// No description provided for @rechargeRebate.
  ///
  /// In en, this message translates to:
  /// **'Rebate'**
  String get rechargeRebate;

  /// No description provided for @rechargeAgentFee.
  ///
  /// In en, this message translates to:
  /// **'Agent fee'**
  String get rechargeAgentFee;

  /// No description provided for @rechargeOther.
  ///
  /// In en, this message translates to:
  /// **'Other expense'**
  String get rechargeOther;

  /// No description provided for @rechargeToken.
  ///
  /// In en, this message translates to:
  /// **'Token number'**
  String get rechargeToken;

  /// No description provided for @rechargeLockedMsg.
  ///
  /// In en, this message translates to:
  /// **'This month is finalized. Unlock it in Bills before editing recharges.'**
  String get rechargeLockedMsg;

  /// No description provided for @rechargeBy.
  ///
  /// In en, this message translates to:
  /// **'by {name}'**
  String rechargeBy(Object name);

  /// No description provided for @tenantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tenants'**
  String get tenantsTitle;

  /// No description provided for @tenantsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No tenants yet'**
  String get tenantsEmptyTitle;

  /// No description provided for @tenantsEmptyMsg.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Add tenant\" to add your first tenant.'**
  String get tenantsEmptyMsg;

  /// No description provided for @tenantSetupFirstTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up the main meter first'**
  String get tenantSetupFirstTitle;

  /// No description provided for @tenantSetupFirstMsg.
  ///
  /// In en, this message translates to:
  /// **'Create your property and main meter before adding tenants.'**
  String get tenantSetupFirstMsg;

  /// No description provided for @tenantAdd.
  ///
  /// In en, this message translates to:
  /// **'Add tenant'**
  String get tenantAdd;

  /// No description provided for @tenantEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit tenant'**
  String get tenantEditTitle;

  /// No description provided for @tenantAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add tenant'**
  String get tenantAddTitle;

  /// No description provided for @tenantSaved.
  ///
  /// In en, this message translates to:
  /// **'Tenant saved'**
  String get tenantSaved;

  /// No description provided for @tenantDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete tenant?'**
  String get tenantDeleteTitle;

  /// No description provided for @tenantDeleteMsg.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}? Their meter readings will also be removed.'**
  String tenantDeleteMsg(Object name);

  /// No description provided for @tenantName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get tenantName;

  /// No description provided for @tenantApartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get tenantApartment;

  /// No description provided for @tenantSubmeter.
  ///
  /// In en, this message translates to:
  /// **'Sub-meter number'**
  String get tenantSubmeter;

  /// No description provided for @tenantPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get tenantPhone;

  /// No description provided for @tenantEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get tenantEmail;

  /// No description provided for @tenantLastReading.
  ///
  /// In en, this message translates to:
  /// **'Last reading: {value}'**
  String tenantLastReading(Object value);

  /// No description provided for @tenantNoReadings.
  ///
  /// In en, this message translates to:
  /// **'No readings yet'**
  String get tenantNoReadings;

  /// No description provided for @tenantCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get tenantCall;

  /// No description provided for @tenantWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get tenantWhatsapp;

  /// No description provided for @tenantNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get tenantNameRequired;

  /// No description provided for @tenantBillingMode.
  ///
  /// In en, this message translates to:
  /// **'Billing mode'**
  String get tenantBillingMode;

  /// No description provided for @tenantModeShared.
  ///
  /// In en, this message translates to:
  /// **'Shared slab'**
  String get tenantModeShared;

  /// No description provided for @tenantModeSharedSub.
  ///
  /// In en, this message translates to:
  /// **'Pays a fair share of the actual bill (default)'**
  String get tenantModeSharedSub;

  /// No description provided for @tenantModeFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed unit rate'**
  String get tenantModeFixed;

  /// No description provided for @tenantModeFixedSub.
  ///
  /// In en, this message translates to:
  /// **'Pays a negotiated flat price per unit'**
  String get tenantModeFixedSub;

  /// No description provided for @tenantFixedRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Fixed price per unit'**
  String get tenantFixedRateLabel;

  /// No description provided for @tenantFixedRateRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter the per-unit price'**
  String get tenantFixedRateRequired;

  /// No description provided for @tenantFixedChip.
  ///
  /// In en, this message translates to:
  /// **'Fixed {rate}/unit'**
  String tenantFixedChip(Object rate);

  /// No description provided for @propertyTitle.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get propertyTitle;

  /// No description provided for @propertyName.
  ///
  /// In en, this message translates to:
  /// **'Property name'**
  String get propertyName;

  /// No description provided for @propertyNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Rahman Villa'**
  String get propertyNameHint;

  /// No description provided for @propertyNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get propertyNameRequired;

  /// No description provided for @propertyAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get propertyAddress;

  /// No description provided for @meterTitle.
  ///
  /// In en, this message translates to:
  /// **'Main Meter'**
  String get meterTitle;

  /// No description provided for @meterName.
  ///
  /// In en, this message translates to:
  /// **'Meter name'**
  String get meterName;

  /// No description provided for @meterNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ground Floor DPDC'**
  String get meterNameHint;

  /// No description provided for @meterNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get meterNameRequired;

  /// No description provided for @meterNumber.
  ///
  /// In en, this message translates to:
  /// **'Meter number'**
  String get meterNumber;

  /// No description provided for @meterCreatePropertyFirst.
  ///
  /// In en, this message translates to:
  /// **'Please create a property first.'**
  String get meterCreatePropertyFirst;

  /// No description provided for @tariffTitle.
  ///
  /// In en, this message translates to:
  /// **'Tariff Manager'**
  String get tariffTitle;

  /// No description provided for @tariffPresets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get tariffPresets;

  /// No description provided for @tariffVersions.
  ///
  /// In en, this message translates to:
  /// **'Versions'**
  String get tariffVersions;

  /// No description provided for @tariffNoVersions.
  ///
  /// In en, this message translates to:
  /// **'No tariff versions yet.'**
  String get tariffNoVersions;

  /// No description provided for @tariffAddVersion.
  ///
  /// In en, this message translates to:
  /// **'Add version'**
  String get tariffAddVersion;

  /// No description provided for @tariffNewVersion.
  ///
  /// In en, this message translates to:
  /// **'New tariff version'**
  String get tariffNewVersion;

  /// No description provided for @tariffEditVersion.
  ///
  /// In en, this message translates to:
  /// **'Edit tariff version'**
  String get tariffEditVersion;

  /// No description provided for @tariffVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version label'**
  String get tariffVersionLabel;

  /// No description provided for @tariffEnterLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter a label'**
  String get tariffEnterLabel;

  /// No description provided for @tariffEffectiveFrom.
  ///
  /// In en, this message translates to:
  /// **'Effective from'**
  String get tariffEffectiveFrom;

  /// No description provided for @tariffEffective.
  ///
  /// In en, this message translates to:
  /// **'Effective {date}'**
  String tariffEffective(Object date);

  /// No description provided for @tariffArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get tariffArchived;

  /// No description provided for @tariffSlabs.
  ///
  /// In en, this message translates to:
  /// **'Slabs (per unit rate)'**
  String get tariffSlabs;

  /// No description provided for @tariffSlabFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get tariffSlabFrom;

  /// No description provided for @tariffSlabTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get tariffSlabTo;

  /// No description provided for @tariffSlabRate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get tariffSlabRate;

  /// No description provided for @tariffSlabHint.
  ///
  /// In en, this message translates to:
  /// **'Leave the last slab\'s \"To\" empty for an open-ended top tier (e.g. 601+).'**
  String get tariffSlabHint;

  /// No description provided for @tariffLifeline.
  ///
  /// In en, this message translates to:
  /// **'Lifeline tariff (optional)'**
  String get tariffLifeline;

  /// No description provided for @tariffLifelineUpTo.
  ///
  /// In en, this message translates to:
  /// **'Lifeline threshold (units)'**
  String get tariffLifelineUpTo;

  /// No description provided for @tariffLifelineRate.
  ///
  /// In en, this message translates to:
  /// **'Lifeline rate'**
  String get tariffLifelineRate;

  /// No description provided for @tariffLifelineHint.
  ///
  /// In en, this message translates to:
  /// **'Eligibility tariff, not a slab: if total units are within the threshold, ALL units are charged at this rate. Otherwise it is ignored and billing starts from the first slab.'**
  String get tariffLifelineHint;

  /// No description provided for @tariffFixedCharges.
  ///
  /// In en, this message translates to:
  /// **'Fixed charges'**
  String get tariffFixedCharges;

  /// No description provided for @tariffDemandCharge.
  ///
  /// In en, this message translates to:
  /// **'Demand charge'**
  String get tariffDemandCharge;

  /// No description provided for @tariffMeterRent.
  ///
  /// In en, this message translates to:
  /// **'Meter rent'**
  String get tariffMeterRent;

  /// No description provided for @tariffVat.
  ///
  /// In en, this message translates to:
  /// **'VAT (%)'**
  String get tariffVat;

  /// No description provided for @tariffRebate.
  ///
  /// In en, this message translates to:
  /// **'Rebate (%)'**
  String get tariffRebate;

  /// No description provided for @tariffSaveVersion.
  ///
  /// In en, this message translates to:
  /// **'Save version'**
  String get tariffSaveVersion;

  /// No description provided for @tariffSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get tariffSaveChanges;

  /// No description provided for @tariffSavedToast.
  ///
  /// In en, this message translates to:
  /// **'Version saved'**
  String get tariffSavedToast;

  /// No description provided for @tariffUpdatedToast.
  ///
  /// In en, this message translates to:
  /// **'Version updated'**
  String get tariffUpdatedToast;

  /// No description provided for @tariffDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete version?'**
  String get tariffDeleteTitle;

  /// No description provided for @tariffDeleteMsg.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{label}\"? This cannot be undone. Finalized bills keep their own snapshot and are unaffected.'**
  String tariffDeleteMsg(Object label);

  /// No description provided for @billingTitle.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get billingTitle;

  /// No description provided for @billingMode.
  ///
  /// In en, this message translates to:
  /// **'Billing mode'**
  String get billingMode;

  /// No description provided for @billingModeSingle.
  ///
  /// In en, this message translates to:
  /// **'Single meter'**
  String get billingModeSingle;

  /// No description provided for @billingModeSingleSub.
  ///
  /// In en, this message translates to:
  /// **'Personal use — one meter, no tenants'**
  String get billingModeSingleSub;

  /// No description provided for @billingModeMulti.
  ///
  /// In en, this message translates to:
  /// **'Multi-tenant building'**
  String get billingModeMulti;

  /// No description provided for @billingModeMultiSub.
  ///
  /// In en, this message translates to:
  /// **'Apartment, hostel, shops — split bills'**
  String get billingModeMultiSub;

  /// No description provided for @billingMethod.
  ///
  /// In en, this message translates to:
  /// **'Billing method'**
  String get billingMethod;

  /// No description provided for @billingMethodUsage.
  ///
  /// In en, this message translates to:
  /// **'Usage based (slab tariff)'**
  String get billingMethodUsage;

  /// No description provided for @billingMethodUsageSub.
  ///
  /// In en, this message translates to:
  /// **'Proportional to actual usage'**
  String get billingMethodUsageSub;

  /// No description provided for @billingMethodFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed unit rate'**
  String get billingMethodFixed;

  /// No description provided for @billingMethodFixedSub.
  ///
  /// In en, this message translates to:
  /// **'A flat price per unit'**
  String get billingMethodFixedSub;

  /// No description provided for @billingFixedPrice.
  ///
  /// In en, this message translates to:
  /// **'Fixed price per unit'**
  String get billingFixedPrice;

  /// No description provided for @billingSavePrice.
  ///
  /// In en, this message translates to:
  /// **'Save price'**
  String get billingSavePrice;

  /// No description provided for @billingSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get billingSaved;

  /// No description provided for @calcModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Billing calculation mode'**
  String get calcModeTitle;

  /// No description provided for @calcModeSharedSlab.
  ///
  /// In en, this message translates to:
  /// **'Shared Slab (Landlord Mode)'**
  String get calcModeSharedSlab;

  /// No description provided for @calcModeSharedSlabSub.
  ///
  /// In en, this message translates to:
  /// **'Each tenant is billed independently on shared slabs. The total may exceed the utility bill — the difference is your benefit.'**
  String get calcModeSharedSlabSub;

  /// No description provided for @calcModeReconciled.
  ///
  /// In en, this message translates to:
  /// **'Reconciled (Weighted Average)'**
  String get calcModeReconciled;

  /// No description provided for @calcModeReconciledSub.
  ///
  /// In en, this message translates to:
  /// **'The actual meter bill is split by usage. Tenant total always equals the bill; every shared tenant pays the same average rate.'**
  String get calcModeReconciledSub;

  /// No description provided for @calcModeFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed Rate'**
  String get calcModeFixed;

  /// No description provided for @calcModeFixedSub.
  ///
  /// In en, this message translates to:
  /// **'Fixed-rate tenants pay their rate first; the remaining actual bill is split among shared tenants by usage.'**
  String get calcModeFixedSub;

  /// No description provided for @ownerSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Owner summary'**
  String get ownerSummaryTitle;

  /// No description provided for @ownerMainBill.
  ///
  /// In en, this message translates to:
  /// **'Main meter bill'**
  String get ownerMainBill;

  /// No description provided for @ownerTenantTotal.
  ///
  /// In en, this message translates to:
  /// **'Tenant bill total'**
  String get ownerTenantTotal;

  /// No description provided for @ownerBenefit.
  ///
  /// In en, this message translates to:
  /// **'Owner benefit'**
  String get ownerBenefit;

  /// No description provided for @ownerLoss.
  ///
  /// In en, this message translates to:
  /// **'Owner loss'**
  String get ownerLoss;

  /// No description provided for @ownerDifference.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get ownerDifference;

  /// No description provided for @ownerCollectedFixed.
  ///
  /// In en, this message translates to:
  /// **'Collected (fixed)'**
  String get ownerCollectedFixed;

  /// No description provided for @ownerRemainingShared.
  ///
  /// In en, this message translates to:
  /// **'Shared tenants'**
  String get ownerRemainingShared;

  /// No description provided for @ownerCollectionPct.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get ownerCollectionPct;

  /// No description provided for @ownerAvgCost.
  ///
  /// In en, this message translates to:
  /// **'Avg unit cost'**
  String get ownerAvgCost;

  /// No description provided for @ownerAvgSell.
  ///
  /// In en, this message translates to:
  /// **'Avg selling rate'**
  String get ownerAvgSell;

  /// No description provided for @distributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Fixed charge distribution'**
  String get distributionTitle;

  /// No description provided for @distributionSub.
  ///
  /// In en, this message translates to:
  /// **'How demand charge, meter rent and fees are split among shared tenants'**
  String get distributionSub;

  /// No description provided for @distributionEqual.
  ///
  /// In en, this message translates to:
  /// **'Equal'**
  String get distributionEqual;

  /// No description provided for @distributionEqualSub.
  ///
  /// In en, this message translates to:
  /// **'Split equally per tenant (e.g. rent 40 → 20 / 20)'**
  String get distributionEqualSub;

  /// No description provided for @distributionUsage.
  ///
  /// In en, this message translates to:
  /// **'By usage'**
  String get distributionUsage;

  /// No description provided for @distributionUsageSub.
  ///
  /// In en, this message translates to:
  /// **'Split in proportion to billed units'**
  String get distributionUsageSub;

  /// No description provided for @billingPerTenantHint.
  ///
  /// In en, this message translates to:
  /// **'Each tenant\'s billing mode (shared slab or fixed rate) is set on the tenant\'s profile.'**
  String get billingPerTenantHint;

  /// No description provided for @meterProvider.
  ///
  /// In en, this message translates to:
  /// **'Electricity provider'**
  String get meterProvider;

  /// No description provided for @effectiveRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg rate'**
  String get effectiveRateLabel;

  /// No description provided for @effectiveRateValue.
  ///
  /// In en, this message translates to:
  /// **'{rate}/unit'**
  String effectiveRateValue(Object rate);

  /// No description provided for @invoiceBillingMode.
  ///
  /// In en, this message translates to:
  /// **'Billing mode'**
  String get invoiceBillingMode;

  /// No description provided for @invoiceExpenseShare.
  ///
  /// In en, this message translates to:
  /// **'Expense share'**
  String get invoiceExpenseShare;

  /// No description provided for @invoiceSharedAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Slab-sharing adjustment'**
  String get invoiceSharedAdjustment;

  /// No description provided for @invoiceRechargeFees.
  ///
  /// In en, this message translates to:
  /// **'Recharge fees paid'**
  String get invoiceRechargeFees;

  /// No description provided for @invoiceEffectiveRate.
  ///
  /// In en, this message translates to:
  /// **'Effective rate'**
  String get invoiceEffectiveRate;

  /// No description provided for @invoiceSignature.
  ///
  /// In en, this message translates to:
  /// **'Authorized signature'**
  String get invoiceSignature;

  /// No description provided for @invoiceBuildingBill.
  ///
  /// In en, this message translates to:
  /// **'Building bill'**
  String get invoiceBuildingBill;

  /// No description provided for @invoicePreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing invoice…'**
  String get invoicePreparing;

  /// No description provided for @invoiceShareFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not create the invoice PDF. Please try again.'**
  String get invoiceShareFailed;

  /// No description provided for @settlementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settlements'**
  String get settlementsTitle;

  /// No description provided for @settlementsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No settlements yet'**
  String get settlementsEmptyTitle;

  /// No description provided for @settlementsEmptyMsg.
  ///
  /// In en, this message translates to:
  /// **'Record a direct payment between tenants.'**
  String get settlementsEmptyMsg;

  /// No description provided for @settlementsNeedTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'Need at least two tenants'**
  String get settlementsNeedTwoTitle;

  /// No description provided for @settlementsNeedTwoMsg.
  ///
  /// In en, this message translates to:
  /// **'Settlements record a direct payment from one tenant to another.'**
  String get settlementsNeedTwoMsg;

  /// No description provided for @settlementAdd.
  ///
  /// In en, this message translates to:
  /// **'Add settlement'**
  String get settlementAdd;

  /// No description provided for @settlementNew.
  ///
  /// In en, this message translates to:
  /// **'New settlement'**
  String get settlementNew;

  /// No description provided for @settlementSaved.
  ///
  /// In en, this message translates to:
  /// **'Settlement saved'**
  String get settlementSaved;

  /// No description provided for @settlementTransfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get settlementTransfer;

  /// No description provided for @settlementFrom.
  ///
  /// In en, this message translates to:
  /// **'From (payer — in due)'**
  String get settlementFrom;

  /// No description provided for @settlementTo.
  ///
  /// In en, this message translates to:
  /// **'To (receiver — in credit)'**
  String get settlementTo;

  /// No description provided for @settlementAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get settlementAmount;

  /// No description provided for @settlementSameTenant.
  ///
  /// In en, this message translates to:
  /// **'Payer and receiver must be different.'**
  String get settlementSameTenant;

  /// No description provided for @settlementSelectTenant.
  ///
  /// In en, this message translates to:
  /// **'Select a tenant'**
  String get settlementSelectTenant;

  /// No description provided for @settlementPaid.
  ///
  /// In en, this message translates to:
  /// **'Settlement paid'**
  String get settlementPaid;

  /// No description provided for @settlementReceived.
  ///
  /// In en, this message translates to:
  /// **'Settlement received'**
  String get settlementReceived;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get backupTitle;

  /// No description provided for @backupLocal.
  ///
  /// In en, this message translates to:
  /// **'Local backup'**
  String get backupLocal;

  /// No description provided for @backupDesc.
  ///
  /// In en, this message translates to:
  /// **'Save a backup file containing your database, receipts and meter photos. Keep it somewhere safe (e.g. Google Drive, email).'**
  String get backupDesc;

  /// No description provided for @backupNow.
  ///
  /// In en, this message translates to:
  /// **'Back up now'**
  String get backupNow;

  /// No description provided for @backupRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore from file'**
  String get backupRestore;

  /// No description provided for @backupRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore backup?'**
  String get backupRestoreTitle;

  /// No description provided for @backupRestoreWarning.
  ///
  /// In en, this message translates to:
  /// **'This will replace all current data with the backup. This cannot be undone.'**
  String get backupRestoreWarning;

  /// No description provided for @backupRestoreStagedTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore staged'**
  String get backupRestoreStagedTitle;

  /// No description provided for @backupRestoreStagedMsg.
  ///
  /// In en, this message translates to:
  /// **'Backup restored. Please fully close and reopen MeterWise to apply the restored data.'**
  String get backupRestoreStagedMsg;

  /// No description provided for @backupChooseZip.
  ///
  /// In en, this message translates to:
  /// **'Please choose a MeterWise backup (.zip) file.'**
  String get backupChooseZip;

  /// No description provided for @backupNotValid.
  ///
  /// In en, this message translates to:
  /// **'That file does not look like a MeterWise backup.'**
  String get backupNotValid;

  /// No description provided for @backupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed: {error}'**
  String backupFailed(Object error);

  /// No description provided for @backupRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String backupRestoreFailed(Object error);

  /// No description provided for @backupDriveTitle.
  ///
  /// In en, this message translates to:
  /// **'Google Drive sync'**
  String get backupDriveTitle;

  /// No description provided for @backupDriveSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get backupDriveSoon;

  /// No description provided for @invoiceReadings.
  ///
  /// In en, this message translates to:
  /// **'Meter readings'**
  String get invoiceReadings;

  /// No description provided for @invoicePrevReading.
  ///
  /// In en, this message translates to:
  /// **'Previous reading'**
  String get invoicePrevReading;

  /// No description provided for @invoiceCurrentReading.
  ///
  /// In en, this message translates to:
  /// **'Current reading'**
  String get invoiceCurrentReading;

  /// No description provided for @invoiceOwnConsumption.
  ///
  /// In en, this message translates to:
  /// **'Own consumption'**
  String get invoiceOwnConsumption;

  /// No description provided for @invoiceCommonShare.
  ///
  /// In en, this message translates to:
  /// **'Common-area share'**
  String get invoiceCommonShare;

  /// No description provided for @invoiceBilledUnits.
  ///
  /// In en, this message translates to:
  /// **'Billed units'**
  String get invoiceBilledUnits;

  /// No description provided for @invoiceTariffBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Tariff breakdown'**
  String get invoiceTariffBreakdown;

  /// No description provided for @invoiceCharges.
  ///
  /// In en, this message translates to:
  /// **'Charges'**
  String get invoiceCharges;

  /// No description provided for @invoiceEnergyCost.
  ///
  /// In en, this message translates to:
  /// **'Energy cost'**
  String get invoiceEnergyCost;

  /// No description provided for @invoicePayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get invoicePayment;

  /// No description provided for @invoicePreviousBalance.
  ///
  /// In en, this message translates to:
  /// **'Previous balance'**
  String get invoicePreviousBalance;

  /// No description provided for @invoiceRechargePaid.
  ///
  /// In en, this message translates to:
  /// **'Recharge paid'**
  String get invoiceRechargePaid;

  /// No description provided for @invoiceAvailableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get invoiceAvailableBalance;

  /// No description provided for @invoiceTotalBill.
  ///
  /// In en, this message translates to:
  /// **'Total bill'**
  String get invoiceTotalBill;

  /// No description provided for @invoiceCarryForward.
  ///
  /// In en, this message translates to:
  /// **'Carry forward (credit)'**
  String get invoiceCarryForward;

  /// No description provided for @invoiceAmountDue.
  ///
  /// In en, this message translates to:
  /// **'Amount due'**
  String get invoiceAmountDue;

  /// No description provided for @billsCreditAmount.
  ///
  /// In en, this message translates to:
  /// **'Credit {amount}'**
  String billsCreditAmount(Object amount);

  /// No description provided for @billsDueAmount.
  ///
  /// In en, this message translates to:
  /// **'Due {amount}'**
  String billsDueAmount(Object amount);

  /// No description provided for @billsRecharged.
  ///
  /// In en, this message translates to:
  /// **'Recharged {amount}'**
  String billsRecharged(Object amount);

  /// No description provided for @chartUnitsPerMonth.
  ///
  /// In en, this message translates to:
  /// **'Units (kWh) per month'**
  String get chartUnitsPerMonth;

  /// No description provided for @chartAmountPerMonth.
  ///
  /// In en, this message translates to:
  /// **'Amount ({symbol}) per month'**
  String chartAmountPerMonth(Object symbol);

  /// No description provided for @tenantOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open {scheme}'**
  String tenantOpenFailed(Object scheme);

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get validationRequired;

  /// No description provided for @validationInteger.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number'**
  String get validationInteger;

  /// No description provided for @validationNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get validationNumber;

  /// No description provided for @validateNoProperty.
  ///
  /// In en, this message translates to:
  /// **'No property has been set up yet.'**
  String get validateNoProperty;

  /// No description provided for @validateNoMeter.
  ///
  /// In en, this message translates to:
  /// **'No main meter has been set up yet.'**
  String get validateNoMeter;

  /// No description provided for @validateNoClosingReading.
  ///
  /// In en, this message translates to:
  /// **'No closing meter reading recorded for this month.'**
  String get validateNoClosingReading;

  /// No description provided for @validateDuplicateReading.
  ///
  /// In en, this message translates to:
  /// **'Duplicate main-meter readings on the same date.'**
  String get validateDuplicateReading;

  /// No description provided for @validateNoOpeningReading.
  ///
  /// In en, this message translates to:
  /// **'No opening reading found before this month — record a baseline reading in a prior month first.'**
  String get validateNoOpeningReading;

  /// No description provided for @validateClosingNotGreater.
  ///
  /// In en, this message translates to:
  /// **'Closing reading ({closing}) must be greater than the opening reading ({opening}).'**
  String validateClosingNotGreater(Object closing, Object opening);

  /// No description provided for @validateTenantLowerReading.
  ///
  /// In en, this message translates to:
  /// **'Tenant \"{tenant}\": closing reading is lower than the previous reading.'**
  String validateTenantLowerReading(Object tenant);

  /// No description provided for @validateRechargeAmount.
  ///
  /// In en, this message translates to:
  /// **'A recharge in this month has a zero or negative amount.'**
  String get validateRechargeAmount;

  /// No description provided for @validateFixedRateMissing.
  ///
  /// In en, this message translates to:
  /// **'Tenant \"{tenant}\" is on a fixed unit rate but has no per-unit price set. Edit the tenant to set it.'**
  String validateFixedRateMissing(Object tenant);

  /// No description provided for @validateBillCompute.
  ///
  /// In en, this message translates to:
  /// **'Could not compute a bill for this month.'**
  String get validateBillCompute;

  /// No description provided for @invoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Electricity Invoice'**
  String get invoiceTitle;

  /// No description provided for @invoiceDraftBanner.
  ///
  /// In en, this message translates to:
  /// **'DRAFT'**
  String get invoiceDraftBanner;

  /// No description provided for @invoiceStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get invoiceStatus;

  /// No description provided for @invoiceProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get invoiceProvider;

  /// No description provided for @invoiceTariff.
  ///
  /// In en, this message translates to:
  /// **'Tariff'**
  String get invoiceTariff;

  /// No description provided for @invoiceGenerated.
  ///
  /// In en, this message translates to:
  /// **'Generated'**
  String get invoiceGenerated;

  /// No description provided for @invoiceBilledTo.
  ///
  /// In en, this message translates to:
  /// **'BILLED TO'**
  String get invoiceBilledTo;

  /// No description provided for @invoiceFooter.
  ///
  /// In en, this message translates to:
  /// **'Generated by MeterWise'**
  String get invoiceFooter;

  /// No description provided for @invoiceLanguage.
  ///
  /// In en, this message translates to:
  /// **'Invoice language'**
  String get invoiceLanguage;

  /// No description provided for @invoiceLanguageAuto.
  ///
  /// In en, this message translates to:
  /// **'Follow app language'**
  String get invoiceLanguageAuto;

  /// No description provided for @invoiceLanguageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get invoiceLanguageEn;

  /// No description provided for @invoiceLanguageBn.
  ///
  /// In en, this message translates to:
  /// **'Bangla'**
  String get invoiceLanguageBn;

  /// No description provided for @invoiceFallbackNotice.
  ///
  /// In en, this message translates to:
  /// **'Bangla PDF is unavailable on this device. An English invoice was created instead.'**
  String get invoiceFallbackNotice;

  /// No description provided for @invoiceRetryBangla.
  ///
  /// In en, this message translates to:
  /// **'Retry Bangla'**
  String get invoiceRetryBangla;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
