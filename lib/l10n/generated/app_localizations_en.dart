// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageName => 'English';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageSystem => 'System default';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get loading => 'Loading…';

  @override
  String get search => 'Search';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get noOptions => 'No options available';

  @override
  String noResultsFor(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get errorServer =>
      'The server couldn\'t complete your request. Please try again.';

  @override
  String get errorNoConnection =>
      'Please check your internet connection and try again.';

  @override
  String get errorTimeout => 'The request timed out. Please try again.';

  @override
  String get errorSessionExpired =>
      'Your session expired. Please sign in again.';

  @override
  String get notFoundTitle => 'Page not found';

  @override
  String get notFoundMessage => 'The page you\'re looking for doesn\'t exist.';

  @override
  String get goBack => 'Go back';

  @override
  String get tryAgain => 'Try again';

  @override
  String get acceptToContinue => 'Please accept to continue';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get validationFieldRequired => 'This field is required';

  @override
  String validationRequired(String field) {
    return '$field is required';
  }

  @override
  String get validationEmailRequired => 'Email is required';

  @override
  String get validationEmailInvalid => 'Enter a valid email address';

  @override
  String get validationPasswordRequired => 'Password is required';

  @override
  String validationPasswordTooShort(int min) {
    return 'Password must be at least $min characters';
  }

  @override
  String get loginTitle => 'Welcome back';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signIn => 'Sign in';

  @override
  String get signOut => 'Sign out';

  @override
  String get signOutConfirmTitle => 'Sign out?';

  @override
  String get signOutConfirmMessage =>
      'You will need to sign in again to use the app.';

  @override
  String get homeTitle => 'Home';

  @override
  String homeGreeting(String name) {
    return 'Hello, $name 👋';
  }

  @override
  String get homeGreetingGuest => 'Hello 👋';

  @override
  String get pushTitle => 'Push notifications';

  @override
  String get pushConfigured => 'Configured';

  @override
  String get pushNotConfigured => 'Not configured';

  @override
  String get pushConfiguredMessage => 'Firebase is configured.';

  @override
  String get pushNotConfiguredMessage =>
      'Firebase is not set up. See \"Firebase setup\" in the README.';

  @override
  String get pushCopyToken => 'Copy FCM token';

  @override
  String get pushTokenCopied => 'FCM token copied';

  @override
  String get pushEnable => 'Enable notifications';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get continueLabel => 'Continue';

  @override
  String get getStarted => 'Get started';

  @override
  String get back => 'Back';

  @override
  String get onboardingClubTag => 'BROOKLYN TRAINING CLUB';

  @override
  String get onboardingCardTitle1 => 'YOUR GOALS. YOUR PACE.';

  @override
  String get onboardingChipMemberships => 'Memberships';

  @override
  String get onboardingChipClasses => 'Classes';

  @override
  String get onboardingChipPersonalTraining => 'Personal training';

  @override
  String get onboardingLabel1 => 'FIND YOUR STRONG';

  @override
  String get onboardingTitle1 => 'YOUR NEXT LEVEL.\nSTARTS HERE.';

  @override
  String get onboardingSubtitle1 =>
      'Discover gym memberships, energising classes and personal training built around your goals.';

  @override
  String get onboardingLabel2 => 'GEAR FOR THE GRIND';

  @override
  String get onboardingTitle2 => 'GOOD SESSIONS.\nGREAT ESSENTIALS.';

  @override
  String get onboardingSubtitle2 =>
      'Shop apparel, equipment and recovery gear. Everything you need, with free club pickup.';

  @override
  String get onboardingEverydayLineup => 'THE EVERYDAY LINEUP';

  @override
  String get onboardingProductBottle => 'FORM Bottle';

  @override
  String get onboardingProductTee => 'Training Tee';

  @override
  String get onboardingProductResistance => 'Resistance Set';

  @override
  String get onboardingProductRoller => 'Recovery Roller';

  @override
  String get onboardingLabel3 => 'ONE CLUB. ALL YOUR EVERYDAY.';

  @override
  String get onboardingTitle3 => 'BOOK. SHOP.\nSHOW UP.';

  @override
  String get onboardingSubtitle3 =>
      'Book your next session and buy your essentials in one place. Less admin. More time for you.';

  @override
  String get onboardingNextMove => 'YOUR NEXT MOVE';

  @override
  String get onboardingBookAClass => 'BOOK A CLASS';

  @override
  String get onboardingClassName => 'Strength Circuit';

  @override
  String get onboardingClassMeta => 'Tomorrow · 7:00 AM · 45 min';

  @override
  String get onboardingClassPrice => '\\\$28 / class';

  @override
  String get onboardingPickupTag => 'PICK UP AT THE CLUB';

  @override
  String get onboardingBottleMeta => '750 ml · Charcoal';

  @override
  String get onboardingBottlePrice => '\\\$32';

  @override
  String get onboardingCartNote => 'One cart. One easy checkout.';

  @override
  String get loginHeroTitle => 'YOUR TRAINING. YOUR ESSENTIALS.';

  @override
  String get loginTagLine => 'BACK TO YOUR EVERYDAY';

  @override
  String get loginHeadline => 'WELCOME BACK.';

  @override
  String get loginBody =>
      'Log in to book your next session, manage your membership and shop your essentials.';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get newToForm => 'New to FORM?';

  @override
  String get createAccount => 'Create an account';

  @override
  String get orContinueWith => 'OR CONTINUE WITH';

  @override
  String get exploreAsGuest => 'Explore FORM as a guest';

  @override
  String get registerStepCreate => 'Create account';

  @override
  String get registerStepVerify => 'Verify email';

  @override
  String get registerTagLine => 'ONE CLUB. ALL YOUR EVERYDAY.';

  @override
  String get registerHeadline => 'YOUR NEXT LEVEL.\nSTARTS HERE.';

  @override
  String get registerBody =>
      'Create your account for training, classes and essentials. All in one place.';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get passwordHint => 'Use at least 8 characters, including a number.';

  @override
  String get agreeToTerms =>
      'I agree to FORM\'s Terms of Service and Privacy Policy.';

  @override
  String get registerNextNote =>
      'Next, we\'ll email you a code to verify your account.';

  @override
  String get alreadyHaveAccount => 'Already part of FORM?';

  @override
  String get logIn => 'Log in';

  @override
  String get forgotPasswordHeroTitle => 'A QUICK RESET.\nBACK TO YOUR ROUTINE.';

  @override
  String get forgotPasswordTagLine => 'LET\'S GET YOU BACK IN';

  @override
  String get forgotPasswordHeadline => 'FORGOT YOUR\nPASSWORD?';

  @override
  String get forgotPasswordBody =>
      'No sweat. Enter the email address linked to your FORM account and we\'ll send you a password reset link.';

  @override
  String get sendResetLink => 'Send reset link';

  @override
  String get resetLinkNote =>
      'If an account exists for this email, you\'ll receive a link. Check your inbox and spam folder. The link expires in 30 minutes.';

  @override
  String get rememberPassword => 'Remember your password?';

  @override
  String get cantAccessEmail => 'Can\'t access your email? Contact the club';

  @override
  String get trainHardLiveWell => 'TRAIN HARD. LIVE WELL.';

  @override
  String verifyTagLine(String name) {
    return 'ONE LAST REP, $name';
  }

  @override
  String get verifyHeadline => 'VERIFY YOUR\nACCOUNT.';

  @override
  String get verifyBody =>
      'Enter the 6-digit code we emailed you to finish creating your FORM account.';

  @override
  String get verifyCodeSentTo => 'Code sent to';

  @override
  String get changeEmail => 'Change email';

  @override
  String get verificationCodeLabel => 'Verification code';

  @override
  String get codeValidFor => 'Your code is valid for 10 minutes.';

  @override
  String get verifyAndCreate => 'Verify & create account';

  @override
  String get didntReceiveCode => 'Didn\'t receive a code?';

  @override
  String resendCodeIn(String seconds) {
    return 'Resend code in $seconds';
  }

  @override
  String get resendCode => 'Resend code';

  @override
  String get checkSpamNote =>
      'Check your spam folder, or change your email above if it isn\'t correct.';

  @override
  String get navHome => 'Home';

  @override
  String get navTrain => 'Train';

  @override
  String get navShop => 'Shop';

  @override
  String get navCart => 'Cart';

  @override
  String get navYou => 'You';

  @override
  String homeGreetingMorning(String name) {
    return 'GOOD MORNING, $name';
  }

  @override
  String get homeHeadline => 'BUILD YOUR EVERYDAY.';

  @override
  String get homeHeroTag => 'TRAIN HARD. LIVE WELL.';

  @override
  String get homeHeroTitle => 'MORE THAN A GYM.\nYOUR NEXT LEVEL.';

  @override
  String get homeHeroCta => 'Find your training rhythm';

  @override
  String get homeCategoryMemberships => 'Memberships';

  @override
  String get homeCategoryCoaching => 'Coaching';

  @override
  String get homeCategoryGear => 'Gear';

  @override
  String get homeNextMove => 'YOUR NEXT MOVE';

  @override
  String get homeExploreAll => 'Explore all';

  @override
  String get homeClubNote => 'One club. Your training + your essentials.';

  @override
  String get trainTitle => 'Train at FORM';

  @override
  String get trainHeadline => 'FIND YOUR STRONG.';

  @override
  String get trainSubtitle =>
      'Expert coaching. Better energy. A plan that fits you.';

  @override
  String get trainFilterAll => 'All';

  @override
  String get trainFilterClasses => 'Classes';

  @override
  String get trainFilterCoaching => 'Coaching';

  @override
  String get trainFilterMemberships => 'Memberships';

  @override
  String trainClubMeta(String club, int count) {
    return '$club club · $count ways to train';
  }

  @override
  String get trainTagGroupClass => 'GROUP CLASS';

  @override
  String get trainTagCoaching => '1:1 COACHING';

  @override
  String get trainTagMembership => 'MEMBERSHIP';

  @override
  String get trainClassName => 'Strength Circuit';

  @override
  String get trainClassMeta => '45 min · Strength + conditioning';

  @override
  String get trainClassCoach => 'All levels · Coach Maya';

  @override
  String get trainClassPrice => '\\\$28 / class';

  @override
  String get trainClassNext => 'Tomorrow, 7:00 AM · 6 spots left';

  @override
  String get trainPtName => 'Personal Training';

  @override
  String get trainPtMeta => '60 min · Your goals, your plan';

  @override
  String get trainPtCoach => 'With a certified FORM coach';

  @override
  String get trainPtPrice => '\\\$85 / session';

  @override
  String get trainPtNext => 'Next opening: Thu, 8 Oct · 10:00 AM';

  @override
  String get trainMembershipName => 'Unlimited Access';

  @override
  String get trainMembershipMeta => 'Open gym + unlimited classes';

  @override
  String get trainMembershipPlan => 'Monthly · No annual commitment';

  @override
  String get trainMembershipPrice => '\\\$149 / month';

  @override
  String get trainMembershipNext => 'Start any day · Open 5 AM–11 PM';

  @override
  String get classDetailsTitle => 'Class details';

  @override
  String get classRating => '4.9 (128)';

  @override
  String get classDescription =>
      'Build strength with a full-body mix of weights and conditioning. Show up. We\'ll bring the energy.';

  @override
  String get classDuration => '45 minutes';

  @override
  String get classLevel => 'All levels';

  @override
  String get classCoach => 'Coach Maya';

  @override
  String get classPickSession => 'PICK YOUR SESSION';

  @override
  String classSpotsLeft(int spots, String club) {
    return '$spots spots left · $club club, Studio 01';
  }

  @override
  String get classTicketLabel => 'Single class · 1 person';

  @override
  String get classTicketNote => 'Unlimited members: included';

  @override
  String classReserveCta(String price) {
    return 'Reserve & add to cart · $price';
  }

  @override
  String get classCancelNote =>
      'Pay at checkout. Cancel free up to 12 hours before class.';

  @override
  String get reservationTitle => 'Reservation';

  @override
  String get reservationHeadline => 'YOUR SPOT.\nHELD FOR YOU.';

  @override
  String reservationBody(String className) {
    return '$className is in your cart. Complete checkout to confirm your booking.';
  }

  @override
  String get reservationTagPending => 'RESERVATION · PAYMENT PENDING';

  @override
  String get reservationWhen => 'When';

  @override
  String get reservationWhere => 'Where';

  @override
  String get reservationWith => 'With';

  @override
  String get reservationSingleClass => 'Single class';

  @override
  String get reservationNote =>
      'Arrive 10 minutes early. Bring water and training shoes.\nYour entry pass appears after payment.';

  @override
  String get reservationUpsellTitle => 'BRING YOUR A-GAME.';

  @override
  String get reservationUpsellMeta => 'Cold water. Every rep. · \\\$32';

  @override
  String get reservationUpsellCta => 'Shop essentials';

  @override
  String reservationGoToCart(int count) {
    return 'Go to cart · $count item';
  }

  @override
  String get reservationKeepExploring => 'Keep exploring';

  @override
  String get shopTitle => 'FORM essentials';

  @override
  String get shopHeadline => 'GEAR FOR THE GRIND.';

  @override
  String get shopSubtitle => 'Made for your session. And everything after.';

  @override
  String get shopSearchHint => 'Search gear, apparel & recovery';

  @override
  String get shopFilterAll => 'All gear';

  @override
  String get shopFilterApparel => 'Apparel';

  @override
  String get shopFilterEquipment => 'Equipment';

  @override
  String get shopFilterRecovery => 'Recovery';

  @override
  String shopMeta(int count) {
    return '$count essentials · In stock';
  }

  @override
  String get shopTagBestseller => 'BESTSELLER';

  @override
  String get shopTagNew => 'NEW';

  @override
  String get shopTagTraining => 'TRAINING';

  @override
  String get shopTagRecovery => 'RECOVERY';

  @override
  String get shopBottleMeta => '750 ml · Charcoal';

  @override
  String get shopTeeMeta => 'Unisex · Sizes XS–XXL';

  @override
  String get shopResistanceMeta => '3 bands · Light to heavy';

  @override
  String get shopRollerMeta => 'Firm support · 33 cm';

  @override
  String get shopPickupNote =>
      'Free club pickup. Grab your gear before you train.';

  @override
  String get productDetailsTitle => 'Product details';

  @override
  String get productTagEssentials => 'FORM ESSENTIALS';

  @override
  String get productBottleName => 'FORM BOTTLE';

  @override
  String get productBottleDescription =>
      'Your daily hydration, upgraded. Double-wall steel keeps drinks cold for 24 hours. Built to go again.';

  @override
  String get productColorLabel => 'Color: Charcoal · 750 ml';

  @override
  String get productInStock => 'In stock · Ready for club pickup';

  @override
  String get productFulfillmentNote =>
      'Pick up free at Brooklyn or ship for \\\$5. Choose fulfillment in your cart.';

  @override
  String productAddToCart(String price) {
    return 'Add to cart · $price';
  }

  @override
  String get productFeatures =>
      'Leakproof · BPA-free · Easy-grip finish · 30-day returns';

  @override
  String get cartTitle => 'Your cart';

  @override
  String get cartHeadline => 'ONE CART. ALL IN.';

  @override
  String cartMeta(int count) {
    return '$count items · Your session + your essentials';
  }

  @override
  String get cartTagService => 'SERVICE · 1 PERSON';

  @override
  String get cartTagProduct => 'PHYSICAL PRODUCT';

  @override
  String get cartEntryPassNote => 'Entry pass delivered in app after payment.';

  @override
  String get cartRemove => 'Remove';

  @override
  String get cartClubPickup => 'Club pickup · FREE';

  @override
  String get cartShipToMe => 'Ship to me · \\\$5';

  @override
  String get cartPickupNote => 'Ready tomorrow at Brooklyn front desk.';

  @override
  String get cartPromoCode => 'Have a promo code?';

  @override
  String get cartSubtotal => 'Subtotal';

  @override
  String get cartPickupFree => 'Club pickup';

  @override
  String get cartFree => 'Free';

  @override
  String get cartEstimatedTax => 'Estimated tax';

  @override
  String get cartTotal => 'Total';

  @override
  String get cartPayWith => 'Pay with Visa •••• 4242';

  @override
  String cartBillingSaved(String name) {
    return '$name · Billing details saved';
  }

  @override
  String get cartChange => 'Change';

  @override
  String cartPayCta(String total) {
    return 'Pay & confirm · $total';
  }

  @override
  String get cartTerms =>
      'Secure checkout. By placing your order, you agree to FORM\'s booking terms and 30-day product return policy.';

  @override
  String get orderCompleteTitle => 'Checkout complete';

  @override
  String get orderStepCart => 'Cart';

  @override
  String get orderStepPayment => 'Payment';

  @override
  String get orderStepConfirmed => 'Confirmed';

  @override
  String orderHeadline(String name) {
    return 'YOU\'RE ALL SET,\n$name.';
  }

  @override
  String get orderBody =>
      'Your class is booked. Your gear is on its way to the club.\nLet\'s get to work.';

  @override
  String get orderNumber => 'ORDER #FRM-10482';

  @override
  String get orderPaid => 'PAID';

  @override
  String get orderTotalPaid => 'Total paid';

  @override
  String get orderPaymentMeta =>
      'Visa •••• 4242 · Includes \\\$4.80 tax\nReceipt sent to alex.morgan@email.com';

  @override
  String get orderClassConfirmed => 'Strength Circuit · Confirmed';

  @override
  String get orderClassMeta =>
      'Wed, 7 Oct · 7:00–7:45 AM\nCoach Maya · Brooklyn, Studio 01';

  @override
  String get orderViewEntryPass => 'View entry pass';

  @override
  String get orderPickupTitle => 'FORM Bottle · Club pickup';

  @override
  String get orderPickupMeta =>
      'Ready Wed, 7 Oct from 6:30 AM\nFORM Brooklyn · 68 Wythe Avenue\nShow your order number at the front desk.';

  @override
  String get orderViewBookingCta => 'View my booking & order';

  @override
  String get orderNeedHelp => 'Need a hand? Contact the club';
}
