// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'MeterWise';

  @override
  String get navDashboard => 'ড্যাশবোর্ড';

  @override
  String get navReadings => 'রিডিং';

  @override
  String get navRecharge => 'রিচার্জ';

  @override
  String get navBills => 'বিল';

  @override
  String get navSettings => 'সেটিংস';

  @override
  String get actionSave => 'সংরক্ষণ';

  @override
  String get actionCancel => 'বাতিল';

  @override
  String get actionDelete => 'মুছুন';

  @override
  String get actionEdit => 'সম্পাদনা';

  @override
  String get actionUndo => 'পূর্বাবস্থা';

  @override
  String get actionRetry => 'আবার চেষ্টা';

  @override
  String get actionGotIt => 'বুঝেছি';

  @override
  String get actionAdd => 'যোগ করুন';

  @override
  String get actionUse => 'ব্যবহার করুন';

  @override
  String get actionClone => 'কপি করুন';

  @override
  String get actionPreview => 'প্রিভিউ';

  @override
  String get actionArchive => 'আর্কাইভ';

  @override
  String get actionUnarchive => 'আর্কাইভ থেকে ফেরান';

  @override
  String get actionPrint => 'প্রিন্ট';

  @override
  String get actionShare => 'PDF শেয়ার';

  @override
  String get actionRemove => 'সরান';

  @override
  String get actionCamera => 'ক্যামেরা';

  @override
  String get actionGallery => 'গ্যালারি';

  @override
  String get commonNotSet => 'নির্ধারিত নয়';

  @override
  String get commonNotesOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get commonNotes => 'নোট';

  @override
  String get commonRequired => 'আবশ্যক';

  @override
  String get commonEnterNumber => 'একটি সংখ্যা লিখুন';

  @override
  String get commonEnterPositive => 'একটি ধনাত্মক পরিমাণ লিখুন';

  @override
  String get commonSomethingWrong => 'কিছু একটা ভুল হয়েছে';

  @override
  String get onboardingQuestion => 'আপনি কী পরিচালনা করতে চান?';

  @override
  String get onboardingSingle => 'একক মিটার';

  @override
  String get onboardingSingleDesc =>
      'আমার নিজের বাড়ি — একটি বিদ্যুৎ মিটার, কোনো ভাড়াটিয়া নেই। ব্যক্তিগত ব্যবহার ও খরচের ট্র্যাকার।';

  @override
  String get onboardingMulti => 'মাল্টি-টেন্যান্ট ভবন';

  @override
  String get onboardingMultiDesc =>
      'অ্যাপার্টমেন্ট, হোস্টেল, ভাড়া বা দোকান — একটি মূল মিটার ভাড়াটিয়াদের সাব-মিটার অনুযায়ী ন্যায্যভাবে ভাগ করুন।';

  @override
  String get onboardingChangeLater =>
      'আপনি পরে সেটিংস → বিলিং থেকে এটি পরিবর্তন করতে পারবেন।';

  @override
  String get tourSkip => 'এড়িয়ে যান';

  @override
  String get tourNext => 'পরবর্তী';

  @override
  String get tourIntroBody =>
      'আপনার ভবনের জন্য ন্যায্য, স্বয়ংক্রিয় বিদ্যুৎ বিলিং — রিডিং রেকর্ড করুন, বাকি হিসাব, স্ল্যাব ও ইনভয়েস MeterWise সামলাবে।';

  @override
  String get tourHowTitle => 'যেভাবে কাজ করে';

  @override
  String get tourStep1Title => 'মিটার রিডিং রেকর্ড করুন';

  @override
  String get tourStep1Body =>
      'প্রতি মাসে মূল মিটার ও প্রতিটি ভাড়াটিয়ার সাব-মিটার রিডিং যোগ করুন।';

  @override
  String get tourStep2Title => 'রিচার্জ লগ করুন';

  @override
  String get tourStep2Body =>
      'প্রতিটি প্রিপেইড রিচার্জ, তার ফি এবং কে পরিশোধ করেছে।';

  @override
  String get tourStep3Title => 'বিল চূড়ান্ত ও শেয়ার করুন';

  @override
  String get tourStep3Body =>
      'ন্যায্য স্ল্যাব-ভাগ বিল, স্থায়ী রেকর্ড হিসেবে লক এবং PDF ইনভয়েস হিসেবে শেয়ার।';

  @override
  String welcomeTitle(Object appName) {
    return '$appName-এ স্বাগতম';
  }

  @override
  String get setupSubtitle => 'বিলিং শুরু করতে দ্রুত সেটআপ সম্পন্ন করুন।';

  @override
  String get stepProperty => '১. আপনার সম্পত্তি যোগ করুন';

  @override
  String get stepMeter => '২. আপনার মূল মিটার যোগ করুন';

  @override
  String get stepTenants => '৩. ভাড়াটিয়া যোগ করুন';

  @override
  String get finishSetupTitle => 'আগে সেটআপ সম্পন্ন করুন';

  @override
  String get finishSetupMsg =>
      'তথ্য রেকর্ড করার আগে আপনার সম্পত্তি ও মূল মিটার (সেটিংস) যোগ করুন।';

  @override
  String get dashAvailableBalance => 'উপলব্ধ ব্যালেন্স';

  @override
  String get dashRemainingPrepaid => 'অবশিষ্ট প্রিপেইড ব্যালেন্স';

  @override
  String dashRechargedThisMonth(Object amount) {
    return 'এ মাসে রিচার্জ: $amount';
  }

  @override
  String get dashAddReading => 'রিডিং যোগ';

  @override
  String get dashAddRecharge => 'রিচার্জ যোগ';

  @override
  String get dashViewBills => 'বিল দেখুন';

  @override
  String get dashMainUnits => 'মূল মিটার ইউনিট';

  @override
  String get dashEstimatedBill => 'আনুমানিক বিল';

  @override
  String get dashOutstanding => 'বকেয়া';

  @override
  String get dashCommonArea => 'সাধারণ এলাকা';

  @override
  String get dashTenants => 'ভাড়াটিয়া';

  @override
  String get dashMonthlyOverview => 'মাসিক সারসংক্ষেপ';

  @override
  String get dashUsage => 'ব্যবহার';

  @override
  String get dashRecharge => 'রিচার্জ';

  @override
  String get dashBill => 'বিল';

  @override
  String get dashRecentActivity => 'সাম্প্রতিক কার্যকলাপ';

  @override
  String get dashLastReading => 'সর্বশেষ রিডিং';

  @override
  String get dashLastRecharge => 'সর্বশেষ রিচার্জ';

  @override
  String get dashNoData => 'এখনও কোনো তথ্য নেই';

  @override
  String get dashNone => 'এখনও নেই';

  @override
  String get dashTenantBills => 'ভাড়াটিয়া বিল';

  @override
  String get dashInCredit => 'ক্রেডিটে';

  @override
  String get dashDue => 'বকেয়া';

  @override
  String get settingsSetup => 'সেটআপ';

  @override
  String get settingsProperty => 'সম্পত্তি';

  @override
  String get settingsMainMeter => 'মূল মিটার';

  @override
  String get settingsTenants => 'ভাড়াটিয়া';

  @override
  String get settingsSettlements => 'সেটেলমেন্ট';

  @override
  String get settingsSettlementsSub => 'ভাড়াটিয়াদের মধ্যে সরাসরি পরিশোধ';

  @override
  String get settingsBilling => 'বিলিং';

  @override
  String get settingsTariff => 'ট্যারিফ ও চার্জ';

  @override
  String get settingsBackup => 'ব্যাকআপ ও পুনরুদ্ধার';

  @override
  String get settingsAppearance => 'চেহারা';

  @override
  String get settingsSystem => 'সিস্টেম ডিফল্ট';

  @override
  String get settingsLight => 'লাইট';

  @override
  String get settingsDark => 'ডার্ক';

  @override
  String get settingsCurrency => 'মুদ্রা';

  @override
  String get settingsLanguage => 'ভাষা';

  @override
  String get billsTitle => 'মাসিক বিল';

  @override
  String get billsMonthSummary => 'মাসিক সারসংক্ষেপ';

  @override
  String get billsTenantBills => 'ভাড়াটিয়া বিল';

  @override
  String get billsNoBillTitle => 'এই মাসের জন্য কোনো বিল নেই';

  @override
  String get billsNoBillMsg =>
      'বিল তৈরি করতে এই মাসে একটি মূল-মিটার রিডিং (এবং পূর্ববর্তী মাসে একটি) রেকর্ড করুন।';

  @override
  String get billsTotalBilled => 'মোট বিল';

  @override
  String get billsTotalRecharge => 'মোট রিচার্জ';

  @override
  String get billsOutstanding => 'বকেয়া';

  @override
  String get billsMarkPaid => 'পরিশোধিত চিহ্নিত করুন';

  @override
  String get billsUnmark => 'চিহ্ন সরান';

  @override
  String get billsPaid => 'পরিশোধিত';

  @override
  String get statusDraft => 'খসড়া';

  @override
  String get statusFinalized => 'চূড়ান্ত';

  @override
  String get periodFinalize => 'চূড়ান্ত করুন';

  @override
  String get periodUnlock => 'আনলক';

  @override
  String periodFinalizedOn(Object date) {
    return 'চূড়ান্ত করা হয়েছে $date';
  }

  @override
  String get periodDraftHint =>
      'খসড়া মাস সম্পাদনযোগ্য এবং তাৎক্ষণিকভাবে পুনর্গণনা হয়। চূড়ান্ত করলে এই মাসটি স্থায়ী রেকর্ড হিসেবে লক হয়ে যায়।';

  @override
  String get periodFinalizedToast => 'মাস চূড়ান্ত ও লক করা হয়েছে';

  @override
  String get periodCannotFinalize => 'এখনো চূড়ান্ত করা যাচ্ছে না';

  @override
  String get periodUnlockTitle => 'মাস আনলক করবেন?';

  @override
  String get periodUnlockWarning =>
      'এটি চূড়ান্ত বিল সম্পাদনের অনুমতি দেবে এবং ঐতিহাসিক হিসাব পরিবর্তন করতে পারে। পরে আপনাকে মাসটি আবার চূড়ান্ত করতে হবে।';

  @override
  String get periodLockedMessage =>
      'এই বিলিং পিরিয়ড চূড়ান্ত করা হয়েছে। পরিবর্তনের আগে মাসটি আনলক করুন।';

  @override
  String get periodFinalizedChip => 'চূড়ান্ত';

  @override
  String get readingsTitle => 'মিটার রিডিং';

  @override
  String get readingsEmptyTitle => 'এখনও কোনো রিডিং নেই';

  @override
  String get readingsEmptyMsg =>
      'আপনার প্রথম মূল ও ভাড়াটিয়া রিডিং রেকর্ড করুন।';

  @override
  String get readingAdd => 'রিডিং যোগ';

  @override
  String get readingSaved => 'রিডিং সংরক্ষিত';

  @override
  String get readingDeleted => 'রিডিং মুছে ফেলা হয়েছে';

  @override
  String get readingDeleteTitle => 'রিডিং মুছবেন?';

  @override
  String readingDeleteMsg(Object date) {
    return '$date তারিখের রিডিং মুছবেন?';
  }

  @override
  String get readingDate => 'তারিখ';

  @override
  String get readingMainMeter => 'মূল মিটার';

  @override
  String get readingCurrentReading => 'বর্তমান রিডিং';

  @override
  String get readingTenantSubmeters => 'ভাড়াটিয়া সাব-মিটার';

  @override
  String get readingNoTenants => 'এখনও কোনো ভাড়াটিয়া যোগ করা হয়নি।';

  @override
  String get readingMeterPhoto => 'মিটারের ছবি (ঐচ্ছিক)';

  @override
  String readingDuplicate(Object date) {
    return '$date তারিখের একটি রিডিং ইতিমধ্যে আছে। আগে সেটি মুছুন বা অন্য তারিখ নির্বাচন করুন।';
  }

  @override
  String readingMainLower(Object value, Object previous) {
    return 'মূল রিডিং ($value) পূর্ববর্তী রিডিং ($previous) এর চেয়ে কম।';
  }

  @override
  String readingTenantLower(Object value, Object previous) {
    return 'একটি ভাড়াটিয়া রিডিং ($value) তার পূর্ববর্তী রিডিং ($previous) এর চেয়ে কম।';
  }

  @override
  String get readingLockedMsg =>
      'এই মাস চূড়ান্ত করা হয়েছে। রিডিং যোগ করার আগে বিল থেকে আনলক করুন।';

  @override
  String get rechargeTitle => 'রিচার্জ লগ';

  @override
  String get rechargeEmptyTitle => 'এখনও কোনো রিচার্জ নেই';

  @override
  String get rechargeEmptyMsg =>
      'প্রিপেইড রিচার্জ ও কে পরিশোধ করেছে তা রেকর্ড করুন।';

  @override
  String get rechargeAdd => 'রিচার্জ যোগ';

  @override
  String get rechargeEditTitle => 'রিচার্জ সম্পাদনা';

  @override
  String get rechargeAddTitle => 'রিচার্জ যোগ';

  @override
  String get rechargeSaved => 'রিচার্জ সংরক্ষিত';

  @override
  String get rechargeUpdated => 'রিচার্জ আপডেট হয়েছে';

  @override
  String get rechargeDeleted => 'রিচার্জ মুছে ফেলা হয়েছে';

  @override
  String get rechargeDeleteTitle => 'রিচার্জ মুছবেন?';

  @override
  String get rechargeAmountPaid => 'পরিশোধিত পরিমাণ';

  @override
  String get rechargeAmount => 'রিচার্জ পরিমাণ';

  @override
  String get rechargePaidBy => 'পরিশোধ করেছেন';

  @override
  String get rechargePaidByName => 'নাম';

  @override
  String get rechargePaidByHelp =>
      'ব্যালেন্স ক্রেডিট করতে একটি ভাড়াটিয়ার নামের সাথে মেলান।';

  @override
  String get rechargeReceipt => 'রসিদ';

  @override
  String get rechargeBreakdown => 'খরচের বিভাজন (ঐচ্ছিক)';

  @override
  String get rechargeBreakdownSub => 'এনার্জি, ভ্যাট, ডিমান্ড, মিটার ভাড়া…';

  @override
  String get rechargeEnergy => 'এনার্জি খরচ';

  @override
  String get rechargeDemand => 'ডিমান্ড চার্জ';

  @override
  String get rechargeMeterRent => 'মিটার ভাড়া';

  @override
  String get rechargeVat => 'ভ্যাট';

  @override
  String get rechargeRebate => 'রিবেট';

  @override
  String get rechargeAgentFee => 'এজেন্ট ফি';

  @override
  String get rechargeOther => 'অন্যান্য খরচ';

  @override
  String get rechargeToken => 'টোকেন নম্বর';

  @override
  String get rechargeLockedMsg =>
      'এই মাস চূড়ান্ত করা হয়েছে। রিচার্জ সম্পাদনার আগে বিল থেকে আনলক করুন।';

  @override
  String rechargeBy(Object name) {
    return '$name দ্বারা';
  }

  @override
  String get tenantsTitle => 'ভাড়াটিয়া';

  @override
  String get tenantsEmptyTitle => 'এখনও কোনো ভাড়াটিয়া নেই';

  @override
  String get tenantsEmptyMsg =>
      'প্রথম ভাড়াটিয়া যোগ করতে \"ভাড়াটিয়া যোগ\" চাপুন।';

  @override
  String get tenantSetupFirstTitle => 'আগে মূল মিটার সেট করুন';

  @override
  String get tenantSetupFirstMsg =>
      'ভাড়াটিয়া যোগ করার আগে আপনার সম্পত্তি ও মূল মিটার তৈরি করুন।';

  @override
  String get tenantAdd => 'ভাড়াটিয়া যোগ';

  @override
  String get tenantEditTitle => 'ভাড়াটিয়া সম্পাদনা';

  @override
  String get tenantAddTitle => 'ভাড়াটিয়া যোগ';

  @override
  String get tenantSaved => 'ভাড়াটিয়া সংরক্ষিত';

  @override
  String get tenantDeleteTitle => 'ভাড়াটিয়া মুছবেন?';

  @override
  String tenantDeleteMsg(Object name) {
    return '$name কে মুছবেন? তাদের মিটার রিডিংও মুছে যাবে।';
  }

  @override
  String get tenantName => 'নাম';

  @override
  String get tenantApartment => 'অ্যাপার্টমেন্ট';

  @override
  String get tenantSubmeter => 'সাব-মিটার নম্বর';

  @override
  String get tenantPhone => 'ফোন';

  @override
  String get tenantEmail => 'ইমেইল';

  @override
  String tenantLastReading(Object value) {
    return 'সর্বশেষ রিডিং: $value';
  }

  @override
  String get tenantNoReadings => 'এখনও কোনো রিডিং নেই';

  @override
  String get tenantCall => 'কল';

  @override
  String get tenantWhatsapp => 'হোয়াটসঅ্যাপ';

  @override
  String get tenantNameRequired => 'নাম আবশ্যক';

  @override
  String get tenantBillingMode => 'বিলিং মোড';

  @override
  String get tenantModeShared => 'শেয়ারড স্ল্যাব';

  @override
  String get tenantModeSharedSub =>
      'প্রকৃত বিলের ন্যায্য অংশ পরিশোধ করেন (ডিফল্ট)';

  @override
  String get tenantModeFixed => 'নির্দিষ্ট ইউনিট রেট';

  @override
  String get tenantModeFixedSub => 'প্রতি ইউনিট নির্ধারিত মূল্য পরিশোধ করেন';

  @override
  String get tenantFixedRateLabel => 'প্রতি ইউনিট নির্দিষ্ট মূল্য';

  @override
  String get tenantFixedRateRequired => 'প্রতি ইউনিটের মূল্য লিখুন';

  @override
  String tenantFixedChip(Object rate) {
    return 'নির্দিষ্ট $rate/ইউনিট';
  }

  @override
  String get propertyTitle => 'সম্পত্তি';

  @override
  String get propertyName => 'সম্পত্তির নাম';

  @override
  String get propertyNameHint => 'যেমন রহমান ভিলা';

  @override
  String get propertyNameRequired => 'নাম আবশ্যক';

  @override
  String get propertyAddress => 'ঠিকানা';

  @override
  String get meterTitle => 'মূল মিটার';

  @override
  String get meterName => 'মিটারের নাম';

  @override
  String get meterNameHint => 'যেমন গ্রাউন্ড ফ্লোর DPDC';

  @override
  String get meterNameRequired => 'নাম আবশ্যক';

  @override
  String get meterNumber => 'মিটার নম্বর';

  @override
  String get meterCreatePropertyFirst => 'প্রথমে একটি সম্পত্তি তৈরি করুন।';

  @override
  String get tariffTitle => 'ট্যারিফ ম্যানেজার';

  @override
  String get tariffPresets => 'প্রিসেট';

  @override
  String get tariffVersions => 'সংস্করণ';

  @override
  String get tariffNoVersions => 'এখনও কোনো ট্যারিফ সংস্করণ নেই।';

  @override
  String get tariffAddVersion => 'সংস্করণ যোগ';

  @override
  String get tariffNewVersion => 'নতুন ট্যারিফ সংস্করণ';

  @override
  String get tariffEditVersion => 'ট্যারিফ সংস্করণ সম্পাদনা';

  @override
  String get tariffVersionLabel => 'সংস্করণের নাম';

  @override
  String get tariffEnterLabel => 'একটি নাম লিখুন';

  @override
  String get tariffEffectiveFrom => 'কার্যকর তারিখ থেকে';

  @override
  String tariffEffective(Object date) {
    return 'কার্যকর $date';
  }

  @override
  String get tariffArchived => 'আর্কাইভড';

  @override
  String get tariffSlabs => 'স্ল্যাব (প্রতি ইউনিট রেট)';

  @override
  String get tariffSlabFrom => 'থেকে';

  @override
  String get tariffSlabTo => 'পর্যন্ত';

  @override
  String get tariffSlabRate => 'রেট';

  @override
  String get tariffSlabHint =>
      'সর্বশেষ স্ল্যাবের \"পর্যন্ত\" খালি রাখুন উন্মুক্ত শীর্ষ স্তরের জন্য (যেমন ৬০১+)।';

  @override
  String get tariffLifeline => 'লাইফলাইন ট্যারিফ (ঐচ্ছিক)';

  @override
  String get tariffLifelineUpTo => 'লাইফলাইন সীমা (ইউনিট)';

  @override
  String get tariffLifelineRate => 'লাইফলাইন রেট';

  @override
  String get tariffLifelineHint =>
      'এটি যোগ্যতা-ভিত্তিক ট্যারিফ, কোনো স্ল্যাব নয়: মোট ইউনিট সীমার মধ্যে থাকলে সব ইউনিট এই রেটে বিল হবে। নাহলে এটি সম্পূর্ণ উপেক্ষিত হয়ে প্রথম স্ল্যাব থেকে বিলিং শুরু হবে।';

  @override
  String get tariffFixedCharges => 'নির্দিষ্ট চার্জ';

  @override
  String get tariffDemandCharge => 'ডিমান্ড চার্জ';

  @override
  String get tariffMeterRent => 'মিটার ভাড়া';

  @override
  String get tariffVat => 'ভ্যাট (%)';

  @override
  String get tariffRebate => 'রিবেট (%)';

  @override
  String get tariffSaveVersion => 'সংস্করণ সংরক্ষণ';

  @override
  String get tariffSaveChanges => 'পরিবর্তন সংরক্ষণ';

  @override
  String get tariffSavedToast => 'সংস্করণ সংরক্ষিত';

  @override
  String get tariffUpdatedToast => 'সংস্করণ আপডেট হয়েছে';

  @override
  String get tariffDeleteTitle => 'সংস্করণ মুছবেন?';

  @override
  String tariffDeleteMsg(Object label) {
    return '\"$label\" মুছবেন? এটি ফেরানো যাবে না। চূড়ান্ত বিল তাদের নিজস্ব স্ন্যাপশট রাখে এবং অপরিবর্তিত থাকে।';
  }

  @override
  String get billingTitle => 'বিলিং';

  @override
  String get billingMode => 'বিলিং মোড';

  @override
  String get billingModeSingle => 'একক মিটার';

  @override
  String get billingModeSingleSub =>
      'ব্যক্তিগত ব্যবহার — একটি মিটার, কোনো ভাড়াটিয়া নেই';

  @override
  String get billingModeMulti => 'মাল্টি-টেন্যান্ট ভবন';

  @override
  String get billingModeMultiSub =>
      'অ্যাপার্টমেন্ট, হোস্টেল, দোকান — বিল ভাগ করুন';

  @override
  String get billingMethod => 'বিলিং পদ্ধতি';

  @override
  String get billingMethodUsage => 'ব্যবহার ভিত্তিক (স্ল্যাব ট্যারিফ)';

  @override
  String get billingMethodUsageSub => 'প্রকৃত ব্যবহারের অনুপাতে';

  @override
  String get billingMethodFixed => 'নির্দিষ্ট ইউনিট রেট';

  @override
  String get billingMethodFixedSub => 'প্রতি ইউনিট একটি নির্দিষ্ট মূল্য';

  @override
  String get billingFixedPrice => 'প্রতি ইউনিট নির্দিষ্ট মূল্য';

  @override
  String get billingSavePrice => 'মূল্য সংরক্ষণ';

  @override
  String get billingSaved => 'সংরক্ষিত';

  @override
  String get calcModeTitle => 'বিলিং হিসাবের মোড';

  @override
  String get calcModeSharedSlab => 'শেয়ারড স্ল্যাব (বাড়িওয়ালা মোড)';

  @override
  String get calcModeSharedSlabSub =>
      'প্রত্যেক ভাড়াটিয়া শেয়ারড স্ল্যাবে স্বাধীনভাবে বিল হন। মোট আদায় ইউটিলিটি বিলের চেয়ে বেশি হতে পারে — পার্থক্যটি আপনার সুবিধা।';

  @override
  String get calcModeReconciled => 'রিকনসাইলড (ওজনভিত্তিক গড়)';

  @override
  String get calcModeReconciledSub =>
      'প্রকৃত মিটার বিল ব্যবহারের অনুপাতে ভাগ হয়। ভাড়াটিয়াদের মোট সবসময় বিলের সমান; সবাই একই গড় রেট দেন।';

  @override
  String get calcModeFixed => 'নির্দিষ্ট রেট';

  @override
  String get calcModeFixedSub =>
      'নির্দিষ্ট-রেট ভাড়াটিয়ারা আগে তাঁদের রেট দেন; বাকি প্রকৃত বিল শেয়ারড ভাড়াটিয়াদের মধ্যে ব্যবহার অনুযায়ী ভাগ হয়।';

  @override
  String get ownerSummaryTitle => 'মালিকের সারসংক্ষেপ';

  @override
  String get ownerMainBill => 'মূল মিটার বিল';

  @override
  String get ownerTenantTotal => 'ভাড়াটিয়া বিল মোট';

  @override
  String get ownerBenefit => 'মালিকের সুবিধা';

  @override
  String get ownerLoss => 'মালিকের ক্ষতি';

  @override
  String get ownerDifference => 'পার্থক্য';

  @override
  String get ownerCollectedFixed => 'আদায় (নির্দিষ্ট)';

  @override
  String get ownerRemainingShared => 'শেয়ারড ভাড়াটিয়া';

  @override
  String get ownerCollectionPct => 'আদায়ের হার';

  @override
  String get ownerAvgCost => 'গড় ইউনিট খরচ';

  @override
  String get ownerAvgSell => 'গড় বিক্রয় রেট';

  @override
  String get distributionTitle => 'নির্দিষ্ট চার্জ বণ্টন';

  @override
  String get distributionSub =>
      'ডিমান্ড চার্জ, মিটার ভাড়া ও ফি শেয়ারড ভাড়াটিয়াদের মধ্যে কীভাবে ভাগ হবে';

  @override
  String get distributionEqual => 'সমানভাবে';

  @override
  String get distributionEqualSub =>
      'প্রতি ভাড়াটিয়ায় সমান ভাগ (যেমন ভাড়া ৪০ → ২০ / ২০)';

  @override
  String get distributionUsage => 'ব্যবহার অনুযায়ী';

  @override
  String get distributionUsageSub => 'বিলকৃত ইউনিটের অনুপাতে ভাগ';

  @override
  String get billingPerTenantHint =>
      'প্রতিটি ভাড়াটিয়ার বিলিং মোড (শেয়ারড স্ল্যাব বা নির্দিষ্ট রেট) ভাড়াটিয়ার প্রোফাইলে নির্ধারণ করা হয়।';

  @override
  String get meterProvider => 'বিদ্যুৎ সরবরাহকারী';

  @override
  String get effectiveRateLabel => 'গড় রেট';

  @override
  String effectiveRateValue(Object rate) {
    return '$rate/ইউনিট';
  }

  @override
  String get invoiceBillingMode => 'বিলিং মোড';

  @override
  String get invoiceExpenseShare => 'খরচের অংশ';

  @override
  String get invoiceSharedAdjustment => 'স্ল্যাব-শেয়ারিং সমন্বয়';

  @override
  String get invoiceRechargeFees => 'রিচার্জ ফি পরিশোধ';

  @override
  String get invoiceEffectiveRate => 'কার্যকর রেট';

  @override
  String get invoiceSignature => 'অনুমোদিত স্বাক্ষর';

  @override
  String get invoiceBuildingBill => 'ভবনের বিল';

  @override
  String get invoicePreparing => 'ইনভয়েস প্রস্তুত হচ্ছে…';

  @override
  String get invoiceShareFailed =>
      'ইনভয়েস PDF তৈরি করা যায়নি। আবার চেষ্টা করুন।';

  @override
  String get settlementsTitle => 'সেটেলমেন্ট';

  @override
  String get settlementsEmptyTitle => 'এখনও কোনো সেটেলমেন্ট নেই';

  @override
  String get settlementsEmptyMsg =>
      'ভাড়াটিয়াদের মধ্যে সরাসরি একটি পরিশোধ রেকর্ড করুন।';

  @override
  String get settlementsNeedTwoTitle => 'অন্তত দুইজন ভাড়াটিয়া প্রয়োজন';

  @override
  String get settlementsNeedTwoMsg =>
      'সেটেলমেন্ট একজন ভাড়াটিয়া থেকে অন্যজনকে সরাসরি পরিশোধ রেকর্ড করে।';

  @override
  String get settlementAdd => 'সেটেলমেন্ট যোগ';

  @override
  String get settlementNew => 'নতুন সেটেলমেন্ট';

  @override
  String get settlementSaved => 'সেটেলমেন্ট সংরক্ষিত';

  @override
  String get settlementTransfer => 'স্থানান্তর';

  @override
  String get settlementFrom => 'থেকে (পরিশোধকারী — বকেয়ায়)';

  @override
  String get settlementTo => 'প্রতি (গ্রহীতা — ক্রেডিটে)';

  @override
  String get settlementAmount => 'পরিমাণ';

  @override
  String get settlementSameTenant => 'পরিশোধকারী ও গ্রহীতা আলাদা হতে হবে।';

  @override
  String get settlementSelectTenant => 'একজন ভাড়াটিয়া নির্বাচন করুন';

  @override
  String get settlementPaid => 'সেটেলমেন্ট পরিশোধ';

  @override
  String get settlementReceived => 'সেটেলমেন্ট প্রাপ্ত';

  @override
  String get backupTitle => 'ব্যাকআপ ও পুনরুদ্ধার';

  @override
  String get backupLocal => 'স্থানীয় ব্যাকআপ';

  @override
  String get backupDesc =>
      'আপনার ডাটাবেস, রসিদ ও মিটারের ছবিসহ একটি ব্যাকআপ ফাইল সংরক্ষণ করুন। এটি নিরাপদ স্থানে রাখুন (যেমন Google Drive, ইমেইল)।';

  @override
  String get backupNow => 'এখন ব্যাকআপ করুন';

  @override
  String get backupRestore => 'ফাইল থেকে পুনরুদ্ধার';

  @override
  String get backupRestoreTitle => 'ব্যাকআপ পুনরুদ্ধার করবেন?';

  @override
  String get backupRestoreWarning =>
      'এটি বর্তমান সব তথ্য ব্যাকআপ দিয়ে প্রতিস্থাপন করবে। এটি ফেরানো যাবে না।';

  @override
  String get backupRestoreStagedTitle => 'পুনরুদ্ধার প্রস্তুত';

  @override
  String get backupRestoreStagedMsg =>
      'ব্যাকআপ পুনরুদ্ধার হয়েছে। প্রয়োগ করতে অনুগ্রহ করে MeterWise সম্পূর্ণ বন্ধ করে আবার খুলুন।';

  @override
  String get backupChooseZip =>
      'অনুগ্রহ করে একটি MeterWise ব্যাকআপ (.zip) ফাইল নির্বাচন করুন।';

  @override
  String get backupNotValid => 'ফাইলটি MeterWise ব্যাকআপ বলে মনে হচ্ছে না।';

  @override
  String backupFailed(Object error) {
    return 'ব্যাকআপ ব্যর্থ: $error';
  }

  @override
  String backupRestoreFailed(Object error) {
    return 'পুনরুদ্ধার ব্যর্থ: $error';
  }

  @override
  String get backupDriveTitle => 'Google Drive সিঙ্ক';

  @override
  String get backupDriveSoon => 'শীঘ্রই আসছে';

  @override
  String get invoiceReadings => 'মিটার রিডিং';

  @override
  String get invoicePrevReading => 'পূর্ববর্তী রিডিং';

  @override
  String get invoiceCurrentReading => 'বর্তমান রিডিং';

  @override
  String get invoiceOwnConsumption => 'নিজস্ব ব্যবহার';

  @override
  String get invoiceCommonShare => 'সাধারণ এলাকার অংশ';

  @override
  String get invoiceBilledUnits => 'বিলকৃত ইউনিট';

  @override
  String get invoiceTariffBreakdown => 'ট্যারিফ বিভাজন';

  @override
  String get invoiceCharges => 'চার্জ';

  @override
  String get invoiceEnergyCost => 'এনার্জি খরচ';

  @override
  String get invoicePayment => 'পরিশোধ';

  @override
  String get invoicePreviousBalance => 'পূর্ববর্তী ব্যালেন্স';

  @override
  String get invoiceRechargePaid => 'রিচার্জ পরিশোধ';

  @override
  String get invoiceAvailableBalance => 'উপলব্ধ ব্যালেন্স';

  @override
  String get invoiceTotalBill => 'মোট বিল';

  @override
  String get invoiceCarryForward => 'ক্যারি ফরওয়ার্ড (ক্রেডিট)';

  @override
  String get invoiceAmountDue => 'বকেয়া পরিমাণ';

  @override
  String billsCreditAmount(Object amount) {
    return 'ক্রেডিট $amount';
  }

  @override
  String billsDueAmount(Object amount) {
    return 'বকেয়া $amount';
  }

  @override
  String billsRecharged(Object amount) {
    return 'রিচার্জ $amount';
  }

  @override
  String get chartUnitsPerMonth => 'প্রতি মাসে ইউনিট (kWh)';

  @override
  String chartAmountPerMonth(Object symbol) {
    return 'প্রতি মাসে অর্থ ($symbol)';
  }

  @override
  String tenantOpenFailed(Object scheme) {
    return '$scheme খোলা যায়নি';
  }

  @override
  String get validationRequired => 'আবশ্যক';

  @override
  String get validationInteger => 'পূর্ণসংখ্যা লিখুন';

  @override
  String get validationNumber => 'সঠিক সংখ্যা লিখুন';

  @override
  String get validateNoProperty => 'এখনো কোনো প্রপার্টি সেট করা হয়নি।';

  @override
  String get validateNoMeter => 'এখনো কোনো প্রধান মিটার সেট করা হয়নি।';

  @override
  String get validateNoClosingReading =>
      'এই মাসের জন্য কোনো ক্লোজিং মিটার রিডিং নেই।';

  @override
  String get validateDuplicateReading =>
      'একই তারিখে প্রধান মিটারের একাধিক রিডিং আছে।';

  @override
  String get validateNoOpeningReading =>
      'এই মাসের আগে কোনো ওপেনিং রিডিং পাওয়া যায়নি — আগের মাসে একটি বেসলাইন রিডিং দিন।';

  @override
  String validateClosingNotGreater(Object closing, Object opening) {
    return 'ক্লোজিং রিডিং ($closing) অবশ্যই ওপেনিং রিডিং ($opening) এর চেয়ে বেশি হতে হবে।';
  }

  @override
  String validateTenantLowerReading(Object tenant) {
    return 'ভাড়াটে \"$tenant\": ক্লোজিং রিডিং আগের রিডিংয়ের চেয়ে কম।';
  }

  @override
  String get validateRechargeAmount =>
      'এই মাসের একটি রিচার্জের অর্থ শূন্য বা ঋণাত্মক।';

  @override
  String validateFixedRateMissing(Object tenant) {
    return 'ভাড়াটে \"$tenant\" ফিক্সড রেটে আছেন কিন্তু প্রতি ইউনিট মূল্য নেই। ভাড়াটে সম্পাদনা করে মূল্য সেট করুন।';
  }

  @override
  String get validateBillCompute => 'এই মাসের বিল গণনা করা যায়নি।';

  @override
  String get invoiceTitle => 'বিদ্যুৎ বিল';

  @override
  String get invoiceDraftBanner => 'খসড়া';

  @override
  String get invoiceStatus => 'অবস্থা';

  @override
  String get invoiceProvider => 'বিদ্যুৎ সরবরাহকারী';

  @override
  String get invoiceTariff => 'ট্যারিফ';

  @override
  String get invoiceGenerated => 'তৈরি হয়েছে';

  @override
  String get invoiceBilledTo => 'বিল প্রাপক';

  @override
  String get invoiceFooter => 'MeterWise দ্বারা তৈরি';

  @override
  String get invoiceLanguage => 'বিলের ভাষা';

  @override
  String get invoiceLanguageAuto => 'অ্যাপের ভাষা অনুসরণ করুন';

  @override
  String get invoiceLanguageEn => 'ইংরেজি';

  @override
  String get invoiceLanguageBn => 'বাংলা';

  @override
  String get invoiceFallbackNotice =>
      'এই ডিভাইসে বাংলা পিডিএফ পাওয়া যায়নি। পরিবর্তে ইংরেজি বিল তৈরি করা হয়েছে।';

  @override
  String get invoiceRetryBangla => 'বাংলা আবার চেষ্টা করুন';

  @override
  String get chartRateCaption => 'প্রতি ইউনিট গড় বিক্রয় মূল্য';

  @override
  String chartRateValue(Object value) {
    return '$value / ইউনিট';
  }

  @override
  String get tenantInviteTitle => 'ভাড়াটিয়াকে আমন্ত্রণ';

  @override
  String get tenantMeterCode => 'মিটার কোড';

  @override
  String get tenantInviteHint =>
      'এই কোড বা কিউআর ভাড়াটিয়ার সাথে শেয়ার করুন। তারা মিটার অ্যাকাউন্টে যোগ দিতে পারবেন।';

  @override
  String get tenantJoinTitle => 'মিটার অ্যাকাউন্টে যোগ দিন';

  @override
  String get tenantScanQr => 'QR কোড স্ক্যান করুন';

  @override
  String get tenantEnterCode => 'মিটার কোড লিখুন';

  @override
  String get tenantChooseName => 'আপনার নাম বেছে নিন';

  @override
  String get tenantJoinRequest => 'যোগদানের অনুরোধ';

  @override
  String get tenantPendingApproval =>
      'মিটার মালিক আপনার যোগদানের অনুমোদনের অপেক্ষায়।';

  @override
  String get tenantApprove => 'অনুমোদন';

  @override
  String get tenantJoined => 'মিটারে যোগ দিয়েছেন';

  @override
  String get tenantRoleLandlord => 'আমি মিটার পরিচালনা করি';

  @override
  String get tenantRoleTenant => 'আমি ভাড়াটে';

  @override
  String get tenantSwitchView => 'ভিউ বদলান';

  @override
  String get tenantLeave => 'মিটার ছেড়ে দিন';

  @override
  String get tenantNotApproved =>
      'মিটার মালিক এখনো আপনার যোগদান অনুমোদন করেননি।';

  @override
  String get tenantNoSubMeter => 'কোনো সাব-মিটার নেই — খরচ সমান ভাগে বণ্টন হবে';

  @override
  String get tenantHomeTitle => 'আমার মিটার';

  @override
  String get tenantCodeMismatch => 'এই ডিভাইসে ওই মিটার কোড পাওয়া যায়নি';

  @override
  String get tenantAddReading => 'আমার রিডিং যোগ করুন';

  @override
  String get tenantAddRecharge => 'আমার রিচার্জ যোগ করুন';

  @override
  String get tenantMarkPayment => 'পরিশোধ রেকর্ড করুন';

  @override
  String get tenantReadingValue => 'সাব-মিটার রিডিং';

  @override
  String get tenantAmount => 'অর্থ';

  @override
  String get tenantPaidTo => 'কে দিয়েছেন';

  @override
  String get tenantReceivedFrom => 'কাছ থেকে পেয়েছেন';

  @override
  String get tenantSaveEntry => 'এন্ট্রি সংরক্ষণ';

  @override
  String get tenantEntrySaved => 'এন্ট্রি সংরক্ষিত';

  @override
  String get tenantSelectTenant => 'ভাড়াটে বেছে নিন';

  @override
  String get tenantReadingTooLow => 'রিডিং আগের চেয়ে বেশি হতে হবে';

  @override
  String get tenantSelfEntry => 'আমার এন্ট্রি';

  @override
  String get tenantBuildingTotal => 'বিল্ডিং মোট';

  @override
  String get driveSyncTitle => 'ড্রাইভ সিঙ্ক';

  @override
  String get driveSignIn => 'Google দিয়ে সাইন ইন';

  @override
  String get driveBackup => 'ড্রাইভে ব্যাকআপ';

  @override
  String get driveSyncNow => 'ড্রাইভ থেকে সিঙ্ক';

  @override
  String get driveSignOut => 'সাইন আউট';

  @override
  String get driveSignedInAs => 'সাইন ইন করা আছে';

  @override
  String get driveBackupDone => 'ব্যাকআপ আপলোড হয়েছে';

  @override
  String driveSyncDone(Object count) {
    return '$count টি নতুন এন্ট্রি সিঙ্ক হয়েছে';
  }

  @override
  String get driveNoPacket => 'এই মিটার কোডের জন্য কোনো প্যাকেট পাওয়া যায়নি';

  @override
  String get settingsPrivacy => 'গোপনীয়তা নীতি';

  @override
  String updateAvailable(Object version) {
    return 'আপডেট পাওয়া গেছে: v$version';
  }

  @override
  String get updateBody =>
      'GitHub-এ একটি নতুন সংস্করণ পাওয়া গেছে। অ্যাপের ভেতর থেকে ডাউনলোড হবে এবং ইনস্টলের জন্য Android আপনাকে জিজ্ঞেস করবে।';

  @override
  String get updateLater => 'পরে';

  @override
  String get updateInstall => 'ডাউনলোড ও ইনস্টল';

  @override
  String get updateFailed => 'আপডেট ডাউনলোড করা যায়নি। পরে আবার চেষ্টা করুন।';
}
