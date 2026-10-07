// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get languageName => 'العربية';

  @override
  String get themeLabel => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get languageSystem => 'لغة النظام';

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get ok => 'حسنًا';

  @override
  String get loading => 'جارٍ التحميل…';

  @override
  String get search => 'بحث';

  @override
  String get clearSearch => 'مسح البحث';

  @override
  String get noOptions => 'لا توجد خيارات متاحة';

  @override
  String noResultsFor(String query) {
    return 'لا توجد نتائج لـ «$query»';
  }

  @override
  String get errorTitle => 'حدث خطأ ما';

  @override
  String get errorUnknown => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get errorServer =>
      'تعذّر على الخادم إكمال طلبك. يرجى المحاولة مرة أخرى.';

  @override
  String get errorNoConnection =>
      'يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.';

  @override
  String get errorTimeout => 'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.';

  @override
  String get errorSessionExpired =>
      'انتهت صلاحية جلستك. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get notFoundTitle => 'الصفحة غير موجودة';

  @override
  String get notFoundMessage => 'الصفحة التي تبحث عنها غير موجودة.';

  @override
  String get goBack => 'رجوع';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get acceptToContinue => 'يرجى الموافقة للمتابعة';

  @override
  String get showPassword => 'إظهار كلمة المرور';

  @override
  String get hidePassword => 'إخفاء كلمة المرور';

  @override
  String get validationFieldRequired => 'هذا الحقل مطلوب';

  @override
  String validationRequired(String field) {
    return '$field مطلوب';
  }

  @override
  String get validationEmailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get validationEmailInvalid => 'أدخل بريدًا إلكترونيًا صالحًا';

  @override
  String get validationPasswordRequired => 'كلمة المرور مطلوبة';

  @override
  String validationPasswordTooShort(int min) {
    return 'يجب ألا تقل كلمة المرور عن $min أحرف';
  }

  @override
  String get loginTitle => 'مرحبًا بعودتك';

  @override
  String get loginSubtitle => 'سجّل الدخول للمتابعة';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get signOutConfirmTitle => 'تسجيل الخروج؟';

  @override
  String get signOutConfirmMessage =>
      'ستحتاج إلى تسجيل الدخول مرة أخرى لاستخدام التطبيق.';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String homeGreeting(String name) {
    return 'مرحبًا، $name 👋';
  }

  @override
  String get homeGreetingGuest => 'مرحبًا 👋';

  @override
  String get pushTitle => 'الإشعارات الفورية';

  @override
  String get pushConfigured => 'مُهيّأ';

  @override
  String get pushNotConfigured => 'غير مُهيّأ';

  @override
  String get pushConfiguredMessage => 'تمت تهيئة Firebase.';

  @override
  String get pushNotConfiguredMessage =>
      'لم يتم إعداد Firebase. راجع قسم \"Firebase setup\" في ملف README.';

  @override
  String get pushCopyToken => 'نسخ رمز FCM';

  @override
  String get pushTokenCopied => 'تم نسخ رمز FCM';

  @override
  String get pushEnable => 'تفعيل الإشعارات';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get back => 'رجوع';

  @override
  String get onboardingClubTag => 'نادي بروكلين للتدريب';

  @override
  String get onboardingCardTitle1 => 'أهدافك. بإيقاعك.';

  @override
  String get onboardingChipMemberships => 'العضويات';

  @override
  String get onboardingChipClasses => 'الحصص';

  @override
  String get onboardingChipPersonalTraining => 'تدريب شخصي';

  @override
  String get onboardingLabel1 => 'اكتشف قوتك';

  @override
  String get onboardingTitle1 => 'مستواك التالي.\nيبدأ هنا.';

  @override
  String get onboardingSubtitle1 =>
      'اكتشف عضويات النادي والحصص والتدريب الشخصي المصمم حول أهدافك.';

  @override
  String get onboardingLabel2 => 'معدات للتمارين';

  @override
  String get onboardingTitle2 => 'جلسات رائعة.\nأساسيات مميزة.';

  @override
  String get onboardingSubtitle2 =>
      'تسوق الملابس والمعدات ومعدات الاستشفاء. كل ما تحتاجه مع استلام مجاني من النادي.';

  @override
  String get onboardingEverydayLineup => 'تشكيلة اليوم';

  @override
  String get onboardingProductBottle => 'قارورة FORM';

  @override
  String get onboardingProductTee => 'تيشيرت التدريب';

  @override
  String get onboardingProductResistance => 'طقم المقاومة';

  @override
  String get onboardingProductRoller => 'أسطوانة الاستشفاء';

  @override
  String get onboardingLabel3 => 'نادٍ واحد. كل يومك.';

  @override
  String get onboardingTitle3 => 'احجز. تسوق.\nاحضر.';

  @override
  String get onboardingSubtitle3 =>
      'احجز جلستك القادمة واشترِ أساسياتك في مكان واحد.';

  @override
  String get onboardingNextMove => 'خطوتك التالية';

  @override
  String get onboardingBookAClass => 'احجز حصة';

  @override
  String get onboardingClassName => 'حصة القوة';

  @override
  String get onboardingClassMeta => 'غداً · 7:00 صباحاً · 45 دقيقة';

  @override
  String get onboardingClassPrice => '28 \\\$ / حصة';

  @override
  String get onboardingPickupTag => 'استلم من النادي';

  @override
  String get onboardingBottleMeta => '750 مل · فحمي';

  @override
  String get onboardingBottlePrice => '32 \\\$';

  @override
  String get onboardingCartNote => 'سلة واحدة. دفع سهل.';

  @override
  String get loginHeroTitle => 'تدريبك. أساسياتك.';

  @override
  String get loginTagLine => 'عودة إلى يومك';

  @override
  String get loginHeadline => 'مرحباً بعودتك.';

  @override
  String get loginBody =>
      'سجل الدخول لحجز جلستك القادمة وإدارة عضويتك وتسوق أساسياتك.';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get newToForm => 'جديد في FORM؟';

  @override
  String get createAccount => 'أنشئ حساباً';

  @override
  String get orContinueWith => 'أو تابع مع';

  @override
  String get exploreAsGuest => 'استكشف FORM كضيف';

  @override
  String get registerStepCreate => 'إنشاء حساب';

  @override
  String get registerStepVerify => 'تأكيد البريد';

  @override
  String get registerTagLine => 'نادٍ واحد. كل يومك.';

  @override
  String get registerHeadline => 'مستواك التالي.\nيبدأ هنا.';

  @override
  String get registerBody =>
      'أنشئ حسابك للتدريب والحصص والأساسيات. كلها في مكان واحد.';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get passwordHint => 'استخدم 8 أحرف على الأقل، تتضمن رقماً.';

  @override
  String get agreeToTerms =>
      'أوافق على شروط الخدمة وسياسة الخصوصية الخاصة بـ FORM.';

  @override
  String get registerNextNote => 'بعد ذلك، سنرسل لك رمزاً للتحقق من حسابك.';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get logIn => 'سجل الدخول';

  @override
  String get forgotPasswordHeroTitle => 'إعادة سريعة.\nعد إلى روتينك.';

  @override
  String get forgotPasswordTagLine => 'لنعد بك';

  @override
  String get forgotPasswordHeadline => 'نسيت كلمة\nالمرور؟';

  @override
  String get forgotPasswordBody =>
      'لا بأس. أدخل البريد المرتبط بحساب FORM وسنرسل لك رابط إعادة التعيين.';

  @override
  String get sendResetLink => 'أرسل رابط الإعادة';

  @override
  String get resetLinkNote =>
      'إذا كان الحساب موجوداً، ستتلقى رابطاً. تحقق من بريدك الوارد والرسائل غير المرغوب فيها. تنتهي صلاحية الرابط خلال 30 دقيقة.';

  @override
  String get rememberPassword => 'تتذكر كلمة المرور؟';

  @override
  String get cantAccessEmail => 'لا يمكنك الوصول لبريدك؟ تواصل مع النادي';

  @override
  String get trainHardLiveWell => 'تدرب بجد. عش بصحة.';

  @override
  String verifyTagLine(String name) {
    return 'محاولة أخيرة، $name';
  }

  @override
  String get verifyHeadline => 'تحقق من\nحسابك.';

  @override
  String get verifyBody =>
      'أدخل الرمز المكون من 6 أرقام الذي أرسلناه لإتمام إنشاء حساب FORM الخاص بك.';

  @override
  String get verifyCodeSentTo => 'تم إرسال الرمز إلى';

  @override
  String get changeEmail => 'غيّر البريد';

  @override
  String get verificationCodeLabel => 'رمز التحقق';

  @override
  String get codeValidFor => 'رمزك صالح لمدة 10 دقائق.';

  @override
  String get verifyAndCreate => 'تحقق وأنشئ الحساب';

  @override
  String get didntReceiveCode => 'لم يصلك الرمز؟';

  @override
  String resendCodeIn(String seconds) {
    return 'أعد الإرسال خلال $seconds';
  }

  @override
  String get resendCode => 'أعد إرسال الرمز';

  @override
  String get checkSpamNote =>
      'تحقق من مجلد الرسائل غير المرغوب فيها، أو غيّر بريدك أعلاه إذا لم يكن صحيحاً.';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navTrain => 'تدرب';

  @override
  String get navShop => 'تسوق';

  @override
  String get navCart => 'السلة';

  @override
  String get navYou => 'حسابك';

  @override
  String homeGreetingMorning(String name) {
    return 'صباح الخير، $name';
  }

  @override
  String get homeHeadline => 'ابنِ يومك المعتاد.';

  @override
  String get homeHeroTag => 'تدرب بجد. عش بصحة.';

  @override
  String get homeHeroTitle => 'أكثر من مجرد نادٍ.\nمستواك التالي.';

  @override
  String get homeHeroCta => 'اعثر على إيقاع تدريبك';

  @override
  String get homeCategoryMemberships => 'العضويات';

  @override
  String get homeCategoryCoaching => 'التدريب';

  @override
  String get homeCategoryGear => 'المعدات';

  @override
  String get homeNextMove => 'خطوتك التالية';

  @override
  String get homeExploreAll => 'استكشف الكل';

  @override
  String get homeClubNote => 'نادٍ واحد. تدريبك + أساسياتك.';

  @override
  String get trainTitle => 'تدرب في FORM';

  @override
  String get trainHeadline => 'اكتشف قوتك.';

  @override
  String get trainSubtitle => 'تدريب خبير. طاقة أفضل. خطة تناسبك.';

  @override
  String get trainFilterAll => 'الكل';

  @override
  String get trainFilterClasses => 'الحصص';

  @override
  String get trainFilterCoaching => 'التدريب';

  @override
  String get trainFilterMemberships => 'العضويات';

  @override
  String trainClubMeta(String club, int count) {
    return 'نادي $club · $count طرق للتدريب';
  }

  @override
  String get trainTagGroupClass => 'حصة جماعية';

  @override
  String get trainTagCoaching => 'تدريب 1:1';

  @override
  String get trainTagMembership => 'عضوية';

  @override
  String get trainClassName => 'حصة القوة';

  @override
  String get trainClassMeta => '45 دقيقة · قوة ولياقة';

  @override
  String get trainClassCoach => 'جميع المستويات · المدربة مايا';

  @override
  String get trainClassPrice => '28 \\\$ / حصة';

  @override
  String get trainClassNext => 'غداً، 7:00 صباحاً · 6 أماكن متبقية';

  @override
  String get trainPtName => 'تدريب شخصي';

  @override
  String get trainPtMeta => '60 دقيقة · أهدافك، خطتك';

  @override
  String get trainPtCoach => 'مع مدرب FORM معتمد';

  @override
  String get trainPtPrice => '85 \\\$ / جلسة';

  @override
  String get trainPtNext => 'الموعد التالي: الخميس 8 أكتوبر · 10:00 صباحاً';

  @override
  String get trainMembershipName => 'وصول غير محدود';

  @override
  String get trainMembershipMeta => 'نادٍ مفتوح + حصص غير محدودة';

  @override
  String get trainMembershipPlan => 'شهري · بدون التزام سنوي';

  @override
  String get trainMembershipPrice => '149 \\\$ / شهر';

  @override
  String get trainMembershipNext => 'ابدأ أي يوم · مفتوح 5 صباحاً–11 مساءً';

  @override
  String get classDetailsTitle => 'تفاصيل الحصة';

  @override
  String get classRating => '4.9 (128)';

  @override
  String get classDescription =>
      'ابنِ قوتك بمزيج لكامل الجسم من الأثقال واللياقة. احضر فحسب. نحن نجلب الطاقة.';

  @override
  String get classDuration => '45 دقيقة';

  @override
  String get classLevel => 'جميع المستويات';

  @override
  String get classCoach => 'المدربة مايا';

  @override
  String get classPickSession => 'اختر جلستك';

  @override
  String classSpotsLeft(int spots, String club) {
    return '$spots أماكن متبقية · نادي $club، استوديو 01';
  }

  @override
  String get classTicketLabel => 'حصة واحدة · شخص واحد';

  @override
  String get classTicketNote => 'الأعضاء غير المحدودين: مشمول';

  @override
  String classReserveCta(String price) {
    return 'احجز وأضف للسلة · $price';
  }

  @override
  String get classCancelNote =>
      'ادفع عند الدفع. ألغِ مجاناً حتى 12 ساعة قبل الحصة.';

  @override
  String get reservationTitle => 'الحجز';

  @override
  String get reservationHeadline => 'مكانك.\nمحفوظ لك.';

  @override
  String reservationBody(String className) {
    return '$className في سلتك. أكمل الدفع لتأكيد حجزك.';
  }

  @override
  String get reservationTagPending => 'حجز · الدفع معلق';

  @override
  String get reservationWhen => 'متى';

  @override
  String get reservationWhere => 'أين';

  @override
  String get reservationWith => 'مع من';

  @override
  String get reservationSingleClass => 'حصة واحدة';

  @override
  String get reservationNote =>
      'احضر قبل 10 دقائق. أحضر الماء وحذاء التدريب.\nتظهر بطاقة الدخول بعد الدفع.';

  @override
  String get reservationUpsellTitle => 'أحضر أفضل ما لديك.';

  @override
  String get reservationUpsellMeta => 'ماء بارد. كل تكرار. · 32 \\\$';

  @override
  String get reservationUpsellCta => 'تسوق الأساسيات';

  @override
  String reservationGoToCart(int count) {
    return 'إلى السلة · $count عنصر';
  }

  @override
  String get reservationKeepExploring => 'تابع الاستكشاف';

  @override
  String get shopTitle => 'أساسيات FORM';

  @override
  String get shopHeadline => 'معدات للتمارين.';

  @override
  String get shopSubtitle => 'صُنعت لجلستك. ولكل ما بعدها.';

  @override
  String get shopSearchHint => 'ابحث عن معدات وملابس واستشفاء';

  @override
  String get shopFilterAll => 'كل المعدات';

  @override
  String get shopFilterApparel => 'الملابس';

  @override
  String get shopFilterEquipment => 'المعدات';

  @override
  String get shopFilterRecovery => 'الاستشفاء';

  @override
  String shopMeta(int count) {
    return '$count أساسيات · متوفرة';
  }

  @override
  String get shopTagBestseller => 'الأكثر مبيعاً';

  @override
  String get shopTagNew => 'جديد';

  @override
  String get shopTagTraining => 'تدريب';

  @override
  String get shopTagRecovery => 'استشفاء';

  @override
  String get shopBottleMeta => '750 مل · فحمي';

  @override
  String get shopTeeMeta => 'للجنسين · مقاسات XS–XXL';

  @override
  String get shopResistanceMeta => '3 أربطة · خفيف إلى ثقيل';

  @override
  String get shopRollerMeta => 'دعم قوي · 33 سم';

  @override
  String get shopPickupNote =>
      'استلام مجاني من النادي. احصل على معداتك قبل التدريب.';

  @override
  String get productDetailsTitle => 'تفاصيل المنتج';

  @override
  String get productTagEssentials => 'أساسيات FORM';

  @override
  String get productBottleName => 'قارورة FORM';

  @override
  String get productBottleDescription =>
      'ترطيبك اليومي، مطوّر. الفولاذ المزدوج يحافظ على برودة المشروبات 24 ساعة.';

  @override
  String get productColorLabel => 'اللون: فحمي · 750 مل';

  @override
  String get productInStock => 'متوفر · جاهز للاستلام من النادي';

  @override
  String get productFulfillmentNote =>
      'استلم مجاناً من بروكلين أو اشحن مقابل 5 \\\$. اختر طريقة الاستلام في سلتك.';

  @override
  String productAddToCart(String price) {
    return 'أضف إلى السلة · $price';
  }

  @override
  String get productFeatures =>
      'مانع للتسرب · خالٍ من BPA · ملمس سهل الإمساك · إرجاع خلال 30 يوماً';

  @override
  String get cartTitle => 'سلتك';

  @override
  String get cartHeadline => 'سلة واحدة. كل شيء.';

  @override
  String cartMeta(int count) {
    return '$count عناصر · جلستك + أساسياتك';
  }

  @override
  String get cartTagService => 'خدمة · شخص واحد';

  @override
  String get cartTagProduct => 'منتج مادي';

  @override
  String get cartEntryPassNote => 'تُسلّم بطاقة الدخول في التطبيق بعد الدفع.';

  @override
  String get cartRemove => 'إزالة';

  @override
  String get cartClubPickup => 'استلام من النادي · مجاناً';

  @override
  String get cartShipToMe => 'اشحن لي · 5 \\\$';

  @override
  String get cartPickupNote => 'جاهز غداً في استقبال بروكلين.';

  @override
  String get cartPromoCode => 'لديك رمز ترويجي؟';

  @override
  String get cartSubtotal => 'المجموع الفرعي';

  @override
  String get cartPickupFree => 'استلام من النادي';

  @override
  String get cartFree => 'مجاناً';

  @override
  String get cartEstimatedTax => 'الضريبة التقديرية';

  @override
  String get cartTotal => 'الإجمالي';

  @override
  String get cartPayWith => 'ادفع بفيزا •••• 4242';

  @override
  String cartBillingSaved(String name) {
    return '$name · تفاصيل الفوترة محفوظة';
  }

  @override
  String get cartChange => 'تغيير';

  @override
  String cartPayCta(String total) {
    return 'ادفع وأكّد · $total';
  }

  @override
  String get cartTerms =>
      'دفع آمن. بإتمام طلبك، أنت توافق على شروط حجز FORM وسياسة إرجاع المنتجات خلال 30 يوماً.';

  @override
  String get orderCompleteTitle => 'اكتمل الدفع';

  @override
  String get orderStepCart => 'السلة';

  @override
  String get orderStepPayment => 'الدفع';

  @override
  String get orderStepConfirmed => 'مؤكد';

  @override
  String orderHeadline(String name) {
    return 'كل شيء جاهز،\n$name.';
  }

  @override
  String get orderBody =>
      'تم حجز حصتك. معداتك في الطريق إلى النادي.\nلنبدأ العمل.';

  @override
  String get orderNumber => 'طلب #FRM-10482';

  @override
  String get orderPaid => 'مدفوع';

  @override
  String get orderTotalPaid => 'الإجمالي المدفوع';

  @override
  String get orderPaymentMeta =>
      'فيزا •••• 4242 · يشمل ضريبة 4.80 \\\$\nأُرسل الإيصال إلى alex.morgan@email.com';

  @override
  String get orderClassConfirmed => 'حصة القوة · مؤكدة';

  @override
  String get orderClassMeta =>
      'الأربعاء 7 أكتوبر · 7:00–7:45 صباحاً\nالمدربة مايا · بروكلين، استوديو 01';

  @override
  String get orderViewEntryPass => 'عرض بطاقة الدخول';

  @override
  String get orderPickupTitle => 'قارورة FORM · استلام من النادي';

  @override
  String get orderPickupMeta =>
      'جاهزة الأربعاء 7 أكتوبر من 6:30 صباحاً\nFORM بروكلين · 68 شارع ويث\nأظهر رقم طلبك في الاستقبال.';

  @override
  String get orderViewBookingCta => 'عرض حجزي وطلبي';

  @override
  String get orderNeedHelp => 'تحتاج مساعدة؟ تواصل مع النادي';
}
