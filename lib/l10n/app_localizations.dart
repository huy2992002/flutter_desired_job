import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @desired.
  ///
  /// In en, this message translates to:
  /// **'desired'**
  String get desired;

  /// No description provided for @titleJob.
  ///
  /// In en, this message translates to:
  /// **'job.'**
  String get titleJob;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @continueAsAGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as a guest'**
  String get continueAsAGuest;

  /// No description provided for @titleLogin.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Indeed to see you, Again!'**
  String get titleLogin;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @orLoginWith.
  ///
  /// In en, this message translates to:
  /// **'Or login with'**
  String get orLoginWith;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// No description provided for @titleRegister.
  ///
  /// In en, this message translates to:
  /// **'Hello! Register to get started'**
  String get titleRegister;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @orRegisterWith.
  ///
  /// In en, this message translates to:
  /// **'Or register with'**
  String get orRegisterWith;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login now'**
  String get loginNow;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @fieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldIsRequired;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validEmail;

  /// No description provided for @validPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 digits long'**
  String get validPassword;

  /// No description provided for @validPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get validPhone;

  /// No description provided for @validConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is not match'**
  String get validConfirmPassword;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @emailAlready.
  ///
  /// In en, this message translates to:
  /// **'Email already exists'**
  String get emailAlready;

  /// No description provided for @createAccSuccess.
  ///
  /// In en, this message translates to:
  /// **'Create account success'**
  String get createAccSuccess;

  /// No description provided for @goToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to Login'**
  String get goToLogin;

  /// No description provided for @emailOrPassIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect'**
  String get emailOrPassIncorrect;

  /// No description provided for @descriptionForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Dont worry! It occurs. Please enter the email address linked with your account.'**
  String get descriptionForgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter a new password'**
  String get enterNewPassword;

  /// No description provided for @enterThePassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the password'**
  String get enterThePassword;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember Password? '**
  String get rememberPassword;

  /// No description provided for @emailNotExits.
  ///
  /// In en, this message translates to:
  /// **'Email does not exist'**
  String get emailNotExits;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get changePasswordSuccess;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @makeChangesToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Make changes to your account'**
  String get makeChangesToYourAccount;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @manageYourSavedAccount.
  ///
  /// In en, this message translates to:
  /// **'Manage your saved account'**
  String get manageYourSavedAccount;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @manageYourDeviceSecurity.
  ///
  /// In en, this message translates to:
  /// **'Manage your device security'**
  String get manageYourDeviceSecurity;

  /// No description provided for @myCV.
  ///
  /// In en, this message translates to:
  /// **'My CV'**
  String get myCV;

  /// No description provided for @furtherSecureYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Further secure your account for safety'**
  String get furtherSecureYourAccount;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @doYouWantLogout.
  ///
  /// In en, this message translates to:
  /// **'Do you want to logout the app?'**
  String get doYouWantLogout;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert !!!'**
  String get alert;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @youWantToLookJob.
  ///
  /// In en, this message translates to:
  /// **'You want to look for a job?'**
  String get youWantToLookJob;

  /// No description provided for @searchSources.
  ///
  /// In en, this message translates to:
  /// **'Search sources'**
  String get searchSources;

  /// No description provided for @popularJob.
  ///
  /// In en, this message translates to:
  /// **'Popular Job'**
  String get popularJob;

  /// No description provided for @allPopularJob.
  ///
  /// In en, this message translates to:
  /// **'All Popular Job'**
  String get allPopularJob;

  /// No description provided for @allRecentJob.
  ///
  /// In en, this message translates to:
  /// **'All recent Job'**
  String get allRecentJob;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'view all'**
  String get viewAll;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @recentJobList.
  ///
  /// In en, this message translates to:
  /// **'Recent Job List'**
  String get recentJobList;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @searchJobs.
  ///
  /// In en, this message translates to:
  /// **'Search Jobs'**
  String get searchJobs;

  /// No description provided for @errorInternet.
  ///
  /// In en, this message translates to:
  /// **'Error Internet'**
  String get errorInternet;

  /// No description provided for @jobDetails.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get jobDetails;

  /// No description provided for @jobDescription.
  ///
  /// In en, this message translates to:
  /// **'Job Description'**
  String get jobDescription;

  /// No description provided for @skillsAndRequirements.
  ///
  /// In en, this message translates to:
  /// **'Skills & Requirements'**
  String get skillsAndRequirements;

  /// No description provided for @yourRole.
  ///
  /// In en, this message translates to:
  /// **'Your Role'**
  String get yourRole;

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get applyNow;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'Innovative by Student Nguyen Ngoc Huy - 20CNTT2'**
  String get copyright;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'The University of Danang, University of Education'**
  String get university;

  /// No description provided for @aboutAppInfo.
  ///
  /// In en, this message translates to:
  /// **'desired'**
  String get aboutAppInfo;

  /// No description provided for @helpAndSupportInfo.
  ///
  /// In en, this message translates to:
  /// **'For any assistance needed, please feel free to contact us through the following channels'**
  String get helpAndSupportInfo;

  /// No description provided for @mailInfo.
  ///
  /// In en, this message translates to:
  /// **'huy2992018@gmail.com'**
  String get mailInfo;

  /// No description provided for @phoneInfo.
  ///
  /// In en, this message translates to:
  /// **'0393361504'**
  String get phoneInfo;

  /// No description provided for @favoritesList.
  ///
  /// In en, this message translates to:
  /// **'Favorites List'**
  String get favoritesList;

  /// No description provided for @favoritesListEmpty.
  ///
  /// In en, this message translates to:
  /// **'Favorites job list is Empty'**
  String get favoritesListEmpty;

  /// No description provided for @popularListEmpty.
  ///
  /// In en, this message translates to:
  /// **'Popular job list is Empty'**
  String get popularListEmpty;

  /// No description provided for @recentListEmpty.
  ///
  /// In en, this message translates to:
  /// **'Recent job list is Empty'**
  String get recentListEmpty;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @updateProfileSuccess.
  ///
  /// In en, this message translates to:
  /// **'Update profile success'**
  String get updateProfileSuccess;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @currentPassIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get currentPassIncorrect;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @desOtpVerification.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code we just sent on your email address.'**
  String get desOtpVerification;

  /// No description provided for @nameApp.
  ///
  /// In en, this message translates to:
  /// **'Desired Job App'**
  String get nameApp;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @resendSuccess.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP successfully'**
  String get resendSuccess;

  /// No description provided for @otpIncorrect.
  ///
  /// In en, this message translates to:
  /// **'OTP code is incorrect'**
  String get otpIncorrect;

  /// No description provided for @pleaseDontEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter complete information'**
  String get pleaseDontEmpty;

  /// No description provided for @registerForBusiness.
  ///
  /// In en, this message translates to:
  /// **'Sign up for a business account'**
  String get registerForBusiness;

  /// No description provided for @nameBusiness.
  ///
  /// In en, this message translates to:
  /// **'Name business'**
  String get nameBusiness;

  /// No description provided for @emailBusiness.
  ///
  /// In en, this message translates to:
  /// **'Email business'**
  String get emailBusiness;

  /// No description provided for @phoneBusiness.
  ///
  /// In en, this message translates to:
  /// **'Phone Business'**
  String get phoneBusiness;

  /// No description provided for @hintPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get hintPassword;

  /// No description provided for @hintConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get hintConfirmPassword;

  /// No description provided for @pleaseChooseAvatar.
  ///
  /// In en, this message translates to:
  /// **'Please choose an avatar for the business'**
  String get pleaseChooseAvatar;

  /// No description provided for @createPost.
  ///
  /// In en, this message translates to:
  /// **'Create post'**
  String get createPost;

  /// No description provided for @editPost.
  ///
  /// In en, this message translates to:
  /// **'Edit post'**
  String get editPost;

  /// No description provided for @plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plan;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDate;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get dueDate;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @levels.
  ///
  /// In en, this message translates to:
  /// **'Levels'**
  String get levels;

  /// No description provided for @types.
  ///
  /// In en, this message translates to:
  /// **'Types'**
  String get types;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @requirement.
  ///
  /// In en, this message translates to:
  /// **'Requirement'**
  String get requirement;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @createJobSuccess.
  ///
  /// In en, this message translates to:
  /// **'Create job successfully'**
  String get createJobSuccess;

  /// No description provided for @editJobSuccess.
  ///
  /// In en, this message translates to:
  /// **'Edit job successfully'**
  String get editJobSuccess;

  /// No description provided for @hiddenPost.
  ///
  /// In en, this message translates to:
  /// **'Hidden post'**
  String get hiddenPost;

  /// No description provided for @showPost.
  ///
  /// In en, this message translates to:
  /// **'Show post'**
  String get showPost;

  /// No description provided for @doYouWantShowPost.
  ///
  /// In en, this message translates to:
  /// **'Do you want show post?'**
  String get doYouWantShowPost;

  /// No description provided for @doYouWantHiddenPost.
  ///
  /// In en, this message translates to:
  /// **'Do you want hidden post?'**
  String get doYouWantHiddenPost;

  /// No description provided for @doYouWantRemovePost.
  ///
  /// In en, this message translates to:
  /// **'Do you want remove post?'**
  String get doYouWantRemovePost;

  /// No description provided for @doYouWantApprovedPost.
  ///
  /// In en, this message translates to:
  /// **'Do you want approved post?'**
  String get doYouWantApprovedPost;

  /// No description provided for @removeJobSuccess.
  ///
  /// In en, this message translates to:
  /// **'Remove post successfully'**
  String get removeJobSuccess;

  /// No description provided for @allBusinessJob.
  ///
  /// In en, this message translates to:
  /// **'All Business Jobs'**
  String get allBusinessJob;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @censoring.
  ///
  /// In en, this message translates to:
  /// **'Censoring'**
  String get censoring;

  /// No description provided for @almostOpen.
  ///
  /// In en, this message translates to:
  /// **'Almost open'**
  String get almostOpen;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @hidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hidden;

  /// No description provided for @posted.
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get posted;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @registrations.
  ///
  /// In en, this message translates to:
  /// **'Registrations'**
  String get registrations;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @haveNotPostJob.
  ///
  /// In en, this message translates to:
  /// **'Have not posted any jobs yet'**
  String get haveNotPostJob;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @choiceYourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get choiceYourLanguage;

  /// No description provided for @desChangeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language to use'**
  String get desChangeLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @vietNamese.
  ///
  /// In en, this message translates to:
  /// **'VietNamese'**
  String get vietNamese;

  /// No description provided for @changeLanguageSuccess.
  ///
  /// In en, this message translates to:
  /// **'Changed language successfully'**
  String get changeLanguageSuccess;

  /// No description provided for @job.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get job;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @adminJob.
  ///
  /// In en, this message translates to:
  /// **'Job management'**
  String get adminJob;

  /// No description provided for @adminUser.
  ///
  /// In en, this message translates to:
  /// **'User management'**
  String get adminUser;

  /// No description provided for @adminBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business management'**
  String get adminBusiness;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @doYouWantRemoveUser.
  ///
  /// In en, this message translates to:
  /// **'Do you want remove user?'**
  String get doYouWantRemoveUser;

  /// No description provided for @doYouWantRemoveBusiness.
  ///
  /// In en, this message translates to:
  /// **'Do you want remove business?'**
  String get doYouWantRemoveBusiness;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @addUser.
  ///
  /// In en, this message translates to:
  /// **'Add user'**
  String get addUser;

  /// No description provided for @addBusiness.
  ///
  /// In en, this message translates to:
  /// **'Add business'**
  String get addBusiness;

  /// No description provided for @introduceYourself.
  ///
  /// In en, this message translates to:
  /// **'Introduce yourself'**
  String get introduceYourself;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @strengths.
  ///
  /// In en, this message translates to:
  /// **'Strengths'**
  String get strengths;

  /// No description provided for @applySuccess.
  ///
  /// In en, this message translates to:
  /// **'Apply successfully'**
  String get applySuccess;

  /// No description provided for @listCandidate.
  ///
  /// In en, this message translates to:
  /// **'List candidate'**
  String get listCandidate;

  /// No description provided for @candidate.
  ///
  /// In en, this message translates to:
  /// **'Candidate'**
  String get candidate;

  /// No description provided for @myOtp.
  ///
  /// In en, this message translates to:
  /// **'Your authentication code is {otp}'**
  String myOtp(String otp);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
