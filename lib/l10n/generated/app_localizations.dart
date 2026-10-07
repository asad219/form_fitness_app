import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
/// import 'generated/app_localizations.dart';
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
    Locale('ar'),
    Locale('en'),
  ];

  /// This language's name written in itself. Shown in the language switcher.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @noOptions.
  ///
  /// In en, this message translates to:
  /// **'No options available'**
  String get noOptions;

  /// No description provided for @noResultsFor.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String noResultsFor(String query);

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnknown;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'The server couldn\'t complete your request. Please try again.'**
  String get errorServer;

  /// No description provided for @errorNoConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get errorNoConnection;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Please try again.'**
  String get errorTimeout;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session expired. Please sign in again.'**
  String get errorSessionExpired;

  /// No description provided for @notFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get notFoundTitle;

  /// No description provided for @notFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The page you\'re looking for doesn\'t exist.'**
  String get notFoundMessage;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @acceptToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please accept to continue'**
  String get acceptToContinue;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @validationFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validationFieldRequired;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'{field} is required'**
  String validationRequired(String field);

  /// No description provided for @validationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validationEmailRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validationPasswordRequired;

  /// No description provided for @validationPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {min} characters'**
  String validationPasswordTooShort(int min);

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signOutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get signOutConfirmTitle;

  /// No description provided for @signOutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to use the app.'**
  String get signOutConfirmMessage;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name} 👋'**
  String homeGreeting(String name);

  /// No description provided for @homeGreetingGuest.
  ///
  /// In en, this message translates to:
  /// **'Hello 👋'**
  String get homeGreetingGuest;

  /// No description provided for @pushTitle.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get pushTitle;

  /// No description provided for @pushConfigured.
  ///
  /// In en, this message translates to:
  /// **'Configured'**
  String get pushConfigured;

  /// No description provided for @pushNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get pushNotConfigured;

  /// No description provided for @pushConfiguredMessage.
  ///
  /// In en, this message translates to:
  /// **'Firebase is configured.'**
  String get pushConfiguredMessage;

  /// No description provided for @pushNotConfiguredMessage.
  ///
  /// In en, this message translates to:
  /// **'Firebase is not set up. See \"Firebase setup\" in the README.'**
  String get pushNotConfiguredMessage;

  /// No description provided for @pushCopyToken.
  ///
  /// In en, this message translates to:
  /// **'Copy FCM token'**
  String get pushCopyToken;

  /// No description provided for @pushTokenCopied.
  ///
  /// In en, this message translates to:
  /// **'FCM token copied'**
  String get pushTokenCopied;

  /// No description provided for @pushEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get pushEnable;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @onboardingClubTag.
  ///
  /// In en, this message translates to:
  /// **'BROOKLYN TRAINING CLUB'**
  String get onboardingClubTag;

  /// No description provided for @onboardingCardTitle1.
  ///
  /// In en, this message translates to:
  /// **'YOUR GOALS. YOUR PACE.'**
  String get onboardingCardTitle1;

  /// No description provided for @onboardingChipMemberships.
  ///
  /// In en, this message translates to:
  /// **'Memberships'**
  String get onboardingChipMemberships;

  /// No description provided for @onboardingChipClasses.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get onboardingChipClasses;

  /// No description provided for @onboardingChipPersonalTraining.
  ///
  /// In en, this message translates to:
  /// **'Personal training'**
  String get onboardingChipPersonalTraining;

  /// No description provided for @onboardingLabel1.
  ///
  /// In en, this message translates to:
  /// **'FIND YOUR STRONG'**
  String get onboardingLabel1;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'YOUR NEXT LEVEL.\nSTARTS HERE.'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Discover gym memberships, energising classes and personal training built around your goals.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingLabel2.
  ///
  /// In en, this message translates to:
  /// **'GEAR FOR THE GRIND'**
  String get onboardingLabel2;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'GOOD SESSIONS.\nGREAT ESSENTIALS.'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Shop apparel, equipment and recovery gear. Everything you need, with free club pickup.'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingEverydayLineup.
  ///
  /// In en, this message translates to:
  /// **'THE EVERYDAY LINEUP'**
  String get onboardingEverydayLineup;

  /// No description provided for @onboardingProductBottle.
  ///
  /// In en, this message translates to:
  /// **'FORM Bottle'**
  String get onboardingProductBottle;

  /// No description provided for @onboardingProductTee.
  ///
  /// In en, this message translates to:
  /// **'Training Tee'**
  String get onboardingProductTee;

  /// No description provided for @onboardingProductResistance.
  ///
  /// In en, this message translates to:
  /// **'Resistance Set'**
  String get onboardingProductResistance;

  /// No description provided for @onboardingProductRoller.
  ///
  /// In en, this message translates to:
  /// **'Recovery Roller'**
  String get onboardingProductRoller;

  /// No description provided for @onboardingLabel3.
  ///
  /// In en, this message translates to:
  /// **'ONE CLUB. ALL YOUR EVERYDAY.'**
  String get onboardingLabel3;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'BOOK. SHOP.\nSHOW UP.'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Book your next session and buy your essentials in one place. Less admin. More time for you.'**
  String get onboardingSubtitle3;

  /// No description provided for @onboardingNextMove.
  ///
  /// In en, this message translates to:
  /// **'YOUR NEXT MOVE'**
  String get onboardingNextMove;

  /// No description provided for @onboardingBookAClass.
  ///
  /// In en, this message translates to:
  /// **'BOOK A CLASS'**
  String get onboardingBookAClass;

  /// No description provided for @onboardingClassName.
  ///
  /// In en, this message translates to:
  /// **'Strength Circuit'**
  String get onboardingClassName;

  /// No description provided for @onboardingClassMeta.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow · 7:00 AM · 45 min'**
  String get onboardingClassMeta;

  /// No description provided for @onboardingClassPrice.
  ///
  /// In en, this message translates to:
  /// **'\\\$28 / class'**
  String get onboardingClassPrice;

  /// No description provided for @onboardingPickupTag.
  ///
  /// In en, this message translates to:
  /// **'PICK UP AT THE CLUB'**
  String get onboardingPickupTag;

  /// No description provided for @onboardingBottleMeta.
  ///
  /// In en, this message translates to:
  /// **'750 ml · Charcoal'**
  String get onboardingBottleMeta;

  /// No description provided for @onboardingBottlePrice.
  ///
  /// In en, this message translates to:
  /// **'\\\$32'**
  String get onboardingBottlePrice;

  /// No description provided for @onboardingCartNote.
  ///
  /// In en, this message translates to:
  /// **'One cart. One easy checkout.'**
  String get onboardingCartNote;

  /// No description provided for @loginHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR TRAINING. YOUR ESSENTIALS.'**
  String get loginHeroTitle;

  /// No description provided for @loginTagLine.
  ///
  /// In en, this message translates to:
  /// **'BACK TO YOUR EVERYDAY'**
  String get loginTagLine;

  /// No description provided for @loginHeadline.
  ///
  /// In en, this message translates to:
  /// **'WELCOME BACK.'**
  String get loginHeadline;

  /// No description provided for @loginBody.
  ///
  /// In en, this message translates to:
  /// **'Log in to book your next session, manage your membership and shop your essentials.'**
  String get loginBody;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @newToForm.
  ///
  /// In en, this message translates to:
  /// **'New to FORM?'**
  String get newToForm;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'OR CONTINUE WITH'**
  String get orContinueWith;

  /// No description provided for @exploreAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Explore FORM as a guest'**
  String get exploreAsGuest;

  /// No description provided for @registerStepCreate.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerStepCreate;

  /// No description provided for @registerStepVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify email'**
  String get registerStepVerify;

  /// No description provided for @registerTagLine.
  ///
  /// In en, this message translates to:
  /// **'ONE CLUB. ALL YOUR EVERYDAY.'**
  String get registerTagLine;

  /// No description provided for @registerHeadline.
  ///
  /// In en, this message translates to:
  /// **'YOUR NEXT LEVEL.\nSTARTS HERE.'**
  String get registerHeadline;

  /// No description provided for @registerBody.
  ///
  /// In en, this message translates to:
  /// **'Create your account for training, classes and essentials. All in one place.'**
  String get registerBody;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters, including a number.'**
  String get passwordHint;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to FORM\'s Terms of Service and Privacy Policy.'**
  String get agreeToTerms;

  /// No description provided for @registerNextNote.
  ///
  /// In en, this message translates to:
  /// **'Next, we\'ll email you a code to verify your account.'**
  String get registerNextNote;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already part of FORM?'**
  String get alreadyHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @forgotPasswordHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'A QUICK RESET.\nBACK TO YOUR ROUTINE.'**
  String get forgotPasswordHeroTitle;

  /// No description provided for @forgotPasswordTagLine.
  ///
  /// In en, this message translates to:
  /// **'LET\'S GET YOU BACK IN'**
  String get forgotPasswordTagLine;

  /// No description provided for @forgotPasswordHeadline.
  ///
  /// In en, this message translates to:
  /// **'FORGOT YOUR\nPASSWORD?'**
  String get forgotPasswordHeadline;

  /// No description provided for @forgotPasswordBody.
  ///
  /// In en, this message translates to:
  /// **'No sweat. Enter the email address linked to your FORM account and we\'ll send you a password reset link.'**
  String get forgotPasswordBody;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// No description provided for @resetLinkNote.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for this email, you\'ll receive a link. Check your inbox and spam folder. The link expires in 30 minutes.'**
  String get resetLinkNote;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get rememberPassword;

  /// No description provided for @cantAccessEmail.
  ///
  /// In en, this message translates to:
  /// **'Can\'t access your email? Contact the club'**
  String get cantAccessEmail;

  /// No description provided for @trainHardLiveWell.
  ///
  /// In en, this message translates to:
  /// **'TRAIN HARD. LIVE WELL.'**
  String get trainHardLiveWell;

  /// No description provided for @verifyTagLine.
  ///
  /// In en, this message translates to:
  /// **'ONE LAST REP, {name}'**
  String verifyTagLine(String name);

  /// No description provided for @verifyHeadline.
  ///
  /// In en, this message translates to:
  /// **'VERIFY YOUR\nACCOUNT.'**
  String get verifyHeadline;

  /// No description provided for @verifyBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code we emailed you to finish creating your FORM account.'**
  String get verifyBody;

  /// No description provided for @verifyCodeSentTo.
  ///
  /// In en, this message translates to:
  /// **'Code sent to'**
  String get verifyCodeSentTo;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get changeEmail;

  /// No description provided for @verificationCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCodeLabel;

  /// No description provided for @codeValidFor.
  ///
  /// In en, this message translates to:
  /// **'Your code is valid for 10 minutes.'**
  String get codeValidFor;

  /// No description provided for @verifyAndCreate.
  ///
  /// In en, this message translates to:
  /// **'Verify & create account'**
  String get verifyAndCreate;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive a code?'**
  String get didntReceiveCode;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds}'**
  String resendCodeIn(String seconds);

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @checkSpamNote.
  ///
  /// In en, this message translates to:
  /// **'Check your spam folder, or change your email above if it isn\'t correct.'**
  String get checkSpamNote;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTrain.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get navTrain;

  /// No description provided for @navShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get navShop;

  /// No description provided for @navCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get navCart;

  /// No description provided for @navYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get navYou;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'GOOD MORNING, {name}'**
  String homeGreetingMorning(String name);

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'BUILD YOUR EVERYDAY.'**
  String get homeHeadline;

  /// No description provided for @homeHeroTag.
  ///
  /// In en, this message translates to:
  /// **'TRAIN HARD. LIVE WELL.'**
  String get homeHeroTag;

  /// No description provided for @homeHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'MORE THAN A GYM.\nYOUR NEXT LEVEL.'**
  String get homeHeroTitle;

  /// No description provided for @homeHeroCta.
  ///
  /// In en, this message translates to:
  /// **'Find your training rhythm'**
  String get homeHeroCta;

  /// No description provided for @homeCategoryMemberships.
  ///
  /// In en, this message translates to:
  /// **'Memberships'**
  String get homeCategoryMemberships;

  /// No description provided for @homeCategoryCoaching.
  ///
  /// In en, this message translates to:
  /// **'Coaching'**
  String get homeCategoryCoaching;

  /// No description provided for @homeCategoryGear.
  ///
  /// In en, this message translates to:
  /// **'Gear'**
  String get homeCategoryGear;

  /// No description provided for @homeNextMove.
  ///
  /// In en, this message translates to:
  /// **'YOUR NEXT MOVE'**
  String get homeNextMove;

  /// No description provided for @homeExploreAll.
  ///
  /// In en, this message translates to:
  /// **'Explore all'**
  String get homeExploreAll;

  /// No description provided for @homeClubNote.
  ///
  /// In en, this message translates to:
  /// **'One club. Your training + your essentials.'**
  String get homeClubNote;

  /// No description provided for @trainTitle.
  ///
  /// In en, this message translates to:
  /// **'Train at FORM'**
  String get trainTitle;

  /// No description provided for @trainHeadline.
  ///
  /// In en, this message translates to:
  /// **'FIND YOUR STRONG.'**
  String get trainHeadline;

  /// No description provided for @trainSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Expert coaching. Better energy. A plan that fits you.'**
  String get trainSubtitle;

  /// No description provided for @trainFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get trainFilterAll;

  /// No description provided for @trainFilterClasses.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get trainFilterClasses;

  /// No description provided for @trainFilterCoaching.
  ///
  /// In en, this message translates to:
  /// **'Coaching'**
  String get trainFilterCoaching;

  /// No description provided for @trainFilterMemberships.
  ///
  /// In en, this message translates to:
  /// **'Memberships'**
  String get trainFilterMemberships;

  /// No description provided for @trainClubMeta.
  ///
  /// In en, this message translates to:
  /// **'{club} club · {count} ways to train'**
  String trainClubMeta(String club, int count);

  /// No description provided for @trainTagGroupClass.
  ///
  /// In en, this message translates to:
  /// **'GROUP CLASS'**
  String get trainTagGroupClass;

  /// No description provided for @trainTagCoaching.
  ///
  /// In en, this message translates to:
  /// **'1:1 COACHING'**
  String get trainTagCoaching;

  /// No description provided for @trainTagMembership.
  ///
  /// In en, this message translates to:
  /// **'MEMBERSHIP'**
  String get trainTagMembership;

  /// No description provided for @trainClassName.
  ///
  /// In en, this message translates to:
  /// **'Strength Circuit'**
  String get trainClassName;

  /// No description provided for @trainClassMeta.
  ///
  /// In en, this message translates to:
  /// **'45 min · Strength + conditioning'**
  String get trainClassMeta;

  /// No description provided for @trainClassCoach.
  ///
  /// In en, this message translates to:
  /// **'All levels · Coach Maya'**
  String get trainClassCoach;

  /// No description provided for @trainClassPrice.
  ///
  /// In en, this message translates to:
  /// **'\\\$28 / class'**
  String get trainClassPrice;

  /// No description provided for @trainClassNext.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow, 7:00 AM · 6 spots left'**
  String get trainClassNext;

  /// No description provided for @trainPtName.
  ///
  /// In en, this message translates to:
  /// **'Personal Training'**
  String get trainPtName;

  /// No description provided for @trainPtMeta.
  ///
  /// In en, this message translates to:
  /// **'60 min · Your goals, your plan'**
  String get trainPtMeta;

  /// No description provided for @trainPtCoach.
  ///
  /// In en, this message translates to:
  /// **'With a certified FORM coach'**
  String get trainPtCoach;

  /// No description provided for @trainPtPrice.
  ///
  /// In en, this message translates to:
  /// **'\\\$85 / session'**
  String get trainPtPrice;

  /// No description provided for @trainPtNext.
  ///
  /// In en, this message translates to:
  /// **'Next opening: Thu, 8 Oct · 10:00 AM'**
  String get trainPtNext;

  /// No description provided for @trainMembershipName.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Access'**
  String get trainMembershipName;

  /// No description provided for @trainMembershipMeta.
  ///
  /// In en, this message translates to:
  /// **'Open gym + unlimited classes'**
  String get trainMembershipMeta;

  /// No description provided for @trainMembershipPlan.
  ///
  /// In en, this message translates to:
  /// **'Monthly · No annual commitment'**
  String get trainMembershipPlan;

  /// No description provided for @trainMembershipPrice.
  ///
  /// In en, this message translates to:
  /// **'\\\$149 / month'**
  String get trainMembershipPrice;

  /// No description provided for @trainMembershipNext.
  ///
  /// In en, this message translates to:
  /// **'Start any day · Open 5 AM–11 PM'**
  String get trainMembershipNext;

  /// No description provided for @classDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Class details'**
  String get classDetailsTitle;

  /// No description provided for @classRating.
  ///
  /// In en, this message translates to:
  /// **'4.9 (128)'**
  String get classRating;

  /// No description provided for @classDescription.
  ///
  /// In en, this message translates to:
  /// **'Build strength with a full-body mix of weights and conditioning. Show up. We\'ll bring the energy.'**
  String get classDescription;

  /// No description provided for @classDuration.
  ///
  /// In en, this message translates to:
  /// **'45 minutes'**
  String get classDuration;

  /// No description provided for @classLevel.
  ///
  /// In en, this message translates to:
  /// **'All levels'**
  String get classLevel;

  /// No description provided for @classCoach.
  ///
  /// In en, this message translates to:
  /// **'Coach Maya'**
  String get classCoach;

  /// No description provided for @classPickSession.
  ///
  /// In en, this message translates to:
  /// **'PICK YOUR SESSION'**
  String get classPickSession;

  /// No description provided for @classSpotsLeft.
  ///
  /// In en, this message translates to:
  /// **'{spots} spots left · {club} club, Studio 01'**
  String classSpotsLeft(int spots, String club);

  /// No description provided for @classTicketLabel.
  ///
  /// In en, this message translates to:
  /// **'Single class · 1 person'**
  String get classTicketLabel;

  /// No description provided for @classTicketNote.
  ///
  /// In en, this message translates to:
  /// **'Unlimited members: included'**
  String get classTicketNote;

  /// No description provided for @classReserveCta.
  ///
  /// In en, this message translates to:
  /// **'Reserve & add to cart · {price}'**
  String classReserveCta(String price);

  /// No description provided for @classCancelNote.
  ///
  /// In en, this message translates to:
  /// **'Pay at checkout. Cancel free up to 12 hours before class.'**
  String get classCancelNote;

  /// No description provided for @reservationTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation'**
  String get reservationTitle;

  /// No description provided for @reservationHeadline.
  ///
  /// In en, this message translates to:
  /// **'YOUR SPOT.\nHELD FOR YOU.'**
  String get reservationHeadline;

  /// No description provided for @reservationBody.
  ///
  /// In en, this message translates to:
  /// **'{className} is in your cart. Complete checkout to confirm your booking.'**
  String reservationBody(String className);

  /// No description provided for @reservationTagPending.
  ///
  /// In en, this message translates to:
  /// **'RESERVATION · PAYMENT PENDING'**
  String get reservationTagPending;

  /// No description provided for @reservationWhen.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get reservationWhen;

  /// No description provided for @reservationWhere.
  ///
  /// In en, this message translates to:
  /// **'Where'**
  String get reservationWhere;

  /// No description provided for @reservationWith.
  ///
  /// In en, this message translates to:
  /// **'With'**
  String get reservationWith;

  /// No description provided for @reservationSingleClass.
  ///
  /// In en, this message translates to:
  /// **'Single class'**
  String get reservationSingleClass;

  /// No description provided for @reservationNote.
  ///
  /// In en, this message translates to:
  /// **'Arrive 10 minutes early. Bring water and training shoes.\nYour entry pass appears after payment.'**
  String get reservationNote;

  /// No description provided for @reservationUpsellTitle.
  ///
  /// In en, this message translates to:
  /// **'BRING YOUR A-GAME.'**
  String get reservationUpsellTitle;

  /// No description provided for @reservationUpsellMeta.
  ///
  /// In en, this message translates to:
  /// **'Cold water. Every rep. · \\\$32'**
  String get reservationUpsellMeta;

  /// No description provided for @reservationUpsellCta.
  ///
  /// In en, this message translates to:
  /// **'Shop essentials'**
  String get reservationUpsellCta;

  /// No description provided for @reservationGoToCart.
  ///
  /// In en, this message translates to:
  /// **'Go to cart · {count} item'**
  String reservationGoToCart(int count);

  /// No description provided for @reservationKeepExploring.
  ///
  /// In en, this message translates to:
  /// **'Keep exploring'**
  String get reservationKeepExploring;

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'FORM essentials'**
  String get shopTitle;

  /// No description provided for @shopHeadline.
  ///
  /// In en, this message translates to:
  /// **'GEAR FOR THE GRIND.'**
  String get shopHeadline;

  /// No description provided for @shopSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Made for your session. And everything after.'**
  String get shopSubtitle;

  /// No description provided for @shopSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search gear, apparel & recovery'**
  String get shopSearchHint;

  /// No description provided for @shopFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All gear'**
  String get shopFilterAll;

  /// No description provided for @shopFilterApparel.
  ///
  /// In en, this message translates to:
  /// **'Apparel'**
  String get shopFilterApparel;

  /// No description provided for @shopFilterEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get shopFilterEquipment;

  /// No description provided for @shopFilterRecovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get shopFilterRecovery;

  /// No description provided for @shopMeta.
  ///
  /// In en, this message translates to:
  /// **'{count} essentials · In stock'**
  String shopMeta(int count);

  /// No description provided for @shopTagBestseller.
  ///
  /// In en, this message translates to:
  /// **'BESTSELLER'**
  String get shopTagBestseller;

  /// No description provided for @shopTagNew.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get shopTagNew;

  /// No description provided for @shopTagTraining.
  ///
  /// In en, this message translates to:
  /// **'TRAINING'**
  String get shopTagTraining;

  /// No description provided for @shopTagRecovery.
  ///
  /// In en, this message translates to:
  /// **'RECOVERY'**
  String get shopTagRecovery;

  /// No description provided for @shopBottleMeta.
  ///
  /// In en, this message translates to:
  /// **'750 ml · Charcoal'**
  String get shopBottleMeta;

  /// No description provided for @shopTeeMeta.
  ///
  /// In en, this message translates to:
  /// **'Unisex · Sizes XS–XXL'**
  String get shopTeeMeta;

  /// No description provided for @shopResistanceMeta.
  ///
  /// In en, this message translates to:
  /// **'3 bands · Light to heavy'**
  String get shopResistanceMeta;

  /// No description provided for @shopRollerMeta.
  ///
  /// In en, this message translates to:
  /// **'Firm support · 33 cm'**
  String get shopRollerMeta;

  /// No description provided for @shopPickupNote.
  ///
  /// In en, this message translates to:
  /// **'Free club pickup. Grab your gear before you train.'**
  String get shopPickupNote;

  /// No description provided for @productDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Product details'**
  String get productDetailsTitle;

  /// No description provided for @productTagEssentials.
  ///
  /// In en, this message translates to:
  /// **'FORM ESSENTIALS'**
  String get productTagEssentials;

  /// No description provided for @productBottleName.
  ///
  /// In en, this message translates to:
  /// **'FORM BOTTLE'**
  String get productBottleName;

  /// No description provided for @productBottleDescription.
  ///
  /// In en, this message translates to:
  /// **'Your daily hydration, upgraded. Double-wall steel keeps drinks cold for 24 hours. Built to go again.'**
  String get productBottleDescription;

  /// No description provided for @productColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color: Charcoal · 750 ml'**
  String get productColorLabel;

  /// No description provided for @productInStock.
  ///
  /// In en, this message translates to:
  /// **'In stock · Ready for club pickup'**
  String get productInStock;

  /// No description provided for @productFulfillmentNote.
  ///
  /// In en, this message translates to:
  /// **'Pick up free at Brooklyn or ship for \\\$5. Choose fulfillment in your cart.'**
  String get productFulfillmentNote;

  /// No description provided for @productAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart · {price}'**
  String productAddToCart(String price);

  /// No description provided for @productFeatures.
  ///
  /// In en, this message translates to:
  /// **'Leakproof · BPA-free · Easy-grip finish · 30-day returns'**
  String get productFeatures;

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Your cart'**
  String get cartTitle;

  /// No description provided for @cartHeadline.
  ///
  /// In en, this message translates to:
  /// **'ONE CART. ALL IN.'**
  String get cartHeadline;

  /// No description provided for @cartMeta.
  ///
  /// In en, this message translates to:
  /// **'{count} items · Your session + your essentials'**
  String cartMeta(int count);

  /// No description provided for @cartTagService.
  ///
  /// In en, this message translates to:
  /// **'SERVICE · 1 PERSON'**
  String get cartTagService;

  /// No description provided for @cartTagProduct.
  ///
  /// In en, this message translates to:
  /// **'PHYSICAL PRODUCT'**
  String get cartTagProduct;

  /// No description provided for @cartEntryPassNote.
  ///
  /// In en, this message translates to:
  /// **'Entry pass delivered in app after payment.'**
  String get cartEntryPassNote;

  /// No description provided for @cartRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get cartRemove;

  /// No description provided for @cartClubPickup.
  ///
  /// In en, this message translates to:
  /// **'Club pickup · FREE'**
  String get cartClubPickup;

  /// No description provided for @cartShipToMe.
  ///
  /// In en, this message translates to:
  /// **'Ship to me · \\\$5'**
  String get cartShipToMe;

  /// No description provided for @cartPickupNote.
  ///
  /// In en, this message translates to:
  /// **'Ready tomorrow at Brooklyn front desk.'**
  String get cartPickupNote;

  /// No description provided for @cartPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Have a promo code?'**
  String get cartPromoCode;

  /// No description provided for @cartSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get cartSubtotal;

  /// No description provided for @cartPickupFree.
  ///
  /// In en, this message translates to:
  /// **'Club pickup'**
  String get cartPickupFree;

  /// No description provided for @cartFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get cartFree;

  /// No description provided for @cartEstimatedTax.
  ///
  /// In en, this message translates to:
  /// **'Estimated tax'**
  String get cartEstimatedTax;

  /// No description provided for @cartTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cartTotal;

  /// No description provided for @cartPayWith.
  ///
  /// In en, this message translates to:
  /// **'Pay with Visa •••• 4242'**
  String get cartPayWith;

  /// No description provided for @cartBillingSaved.
  ///
  /// In en, this message translates to:
  /// **'{name} · Billing details saved'**
  String cartBillingSaved(String name);

  /// No description provided for @cartChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get cartChange;

  /// No description provided for @cartPayCta.
  ///
  /// In en, this message translates to:
  /// **'Pay & confirm · {total}'**
  String cartPayCta(String total);

  /// No description provided for @cartTerms.
  ///
  /// In en, this message translates to:
  /// **'Secure checkout. By placing your order, you agree to FORM\'s booking terms and 30-day product return policy.'**
  String get cartTerms;

  /// No description provided for @orderCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout complete'**
  String get orderCompleteTitle;

  /// No description provided for @orderStepCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get orderStepCart;

  /// No description provided for @orderStepPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get orderStepPayment;

  /// No description provided for @orderStepConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get orderStepConfirmed;

  /// No description provided for @orderHeadline.
  ///
  /// In en, this message translates to:
  /// **'YOU\'RE ALL SET,\n{name}.'**
  String orderHeadline(String name);

  /// No description provided for @orderBody.
  ///
  /// In en, this message translates to:
  /// **'Your class is booked. Your gear is on its way to the club.\nLet\'s get to work.'**
  String get orderBody;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'ORDER #FRM-10482'**
  String get orderNumber;

  /// No description provided for @orderPaid.
  ///
  /// In en, this message translates to:
  /// **'PAID'**
  String get orderPaid;

  /// No description provided for @orderTotalPaid.
  ///
  /// In en, this message translates to:
  /// **'Total paid'**
  String get orderTotalPaid;

  /// No description provided for @orderPaymentMeta.
  ///
  /// In en, this message translates to:
  /// **'Visa •••• 4242 · Includes \\\$4.80 tax\nReceipt sent to alex.morgan@email.com'**
  String get orderPaymentMeta;

  /// No description provided for @orderClassConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Strength Circuit · Confirmed'**
  String get orderClassConfirmed;

  /// No description provided for @orderClassMeta.
  ///
  /// In en, this message translates to:
  /// **'Wed, 7 Oct · 7:00–7:45 AM\nCoach Maya · Brooklyn, Studio 01'**
  String get orderClassMeta;

  /// No description provided for @orderViewEntryPass.
  ///
  /// In en, this message translates to:
  /// **'View entry pass'**
  String get orderViewEntryPass;

  /// No description provided for @orderPickupTitle.
  ///
  /// In en, this message translates to:
  /// **'FORM Bottle · Club pickup'**
  String get orderPickupTitle;

  /// No description provided for @orderPickupMeta.
  ///
  /// In en, this message translates to:
  /// **'Ready Wed, 7 Oct from 6:30 AM\nFORM Brooklyn · 68 Wythe Avenue\nShow your order number at the front desk.'**
  String get orderPickupMeta;

  /// No description provided for @orderViewBookingCta.
  ///
  /// In en, this message translates to:
  /// **'View my booking & order'**
  String get orderViewBookingCta;

  /// No description provided for @orderNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'Need a hand? Contact the club'**
  String get orderNeedHelp;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
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
