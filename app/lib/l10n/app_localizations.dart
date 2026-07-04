import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('en'),
    Locale('ru'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Glina'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Pottery workshop'**
  String get appTagline;

  /// No description provided for @slotsTab.
  ///
  /// In en, this message translates to:
  /// **'Slots'**
  String get slotsTab;

  /// No description provided for @myBookingsTab.
  ///
  /// In en, this message translates to:
  /// **'My bookings'**
  String get myBookingsTab;

  /// No description provided for @slotsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get slotsSectionTitle;

  /// Empty state when no slots in schedule
  ///
  /// In en, this message translates to:
  /// **'No workshops available yet'**
  String get slotsEmptyTitle;

  /// No description provided for @slotsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check back later — the schedule updates regularly'**
  String get slotsEmptySubtitle;

  /// No description provided for @slotsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not load'**
  String get slotsErrorTitle;

  /// No description provided for @slotsErrorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again'**
  String get slotsErrorSubtitle;

  /// No description provided for @slotsSeatsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} seat left} other{{count} seats left}}'**
  String slotsSeatsAvailable(int count);

  /// No description provided for @myBookingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your bookings and history'**
  String get myBookingsSubtitle;

  /// No description provided for @myBookingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No bookings yet'**
  String get myBookingsEmptyTitle;

  /// No description provided for @myBookingsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a workshop from the schedule to book a spot'**
  String get myBookingsEmptySubtitle;

  /// No description provided for @myBookingsGoToSchedule.
  ///
  /// In en, this message translates to:
  /// **'Go to schedule'**
  String get myBookingsGoToSchedule;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String homeGreeting(String name);

  /// No description provided for @homeGreetingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Glad to see you again'**
  String get homeGreetingSubtitle;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// Login screen heading
  ///
  /// In en, this message translates to:
  /// **'Welcome to Glina'**
  String get authPhoneTitle;

  /// No description provided for @authPhoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to sign in or create an account'**
  String get authPhoneSubtitle;

  /// No description provided for @authPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get authPhoneLabel;

  /// No description provided for @authPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'+7 000 000 00 00'**
  String get authPhoneHint;

  /// No description provided for @authContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get authContinue;

  /// No description provided for @authOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your number'**
  String get authOtpTitle;

  /// No description provided for @authOtpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We sent a 4-digit code to {phone}'**
  String authOtpSubtitle(String phone);

  /// No description provided for @authOtpHintMock.
  ///
  /// In en, this message translates to:
  /// **'Mock code: 0000'**
  String get authOtpHintMock;

  /// No description provided for @authVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get authVerify;

  /// No description provided for @authChangeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get authChangeNumber;

  /// No description provided for @authResendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get authResendCode;

  /// No description provided for @authNameTitle.
  ///
  /// In en, this message translates to:
  /// **'How should we call you?'**
  String get authNameTitle;

  /// No description provided for @authNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your name to finish setting up your account'**
  String get authNameSubtitle;

  /// No description provided for @authNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get authNameLabel;

  /// No description provided for @authNameHint.
  ///
  /// In en, this message translates to:
  /// **'Anna'**
  String get authNameHint;

  /// No description provided for @authFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get authFinish;

  /// No description provided for @authErrorInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get authErrorInvalidPhone;

  /// No description provided for @authErrorInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'The code is incorrect. Try again'**
  String get authErrorInvalidCode;

  /// No description provided for @authErrorRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait a moment'**
  String get authErrorRateLimited;

  /// No description provided for @authErrorEmptyName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get authErrorEmptyName;

  /// No description provided for @authErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please try again'**
  String get authErrorNetwork;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again'**
  String get authErrorGeneric;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @slotDetailNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Workshop not found'**
  String get slotDetailNotFoundTitle;

  /// No description provided for @slotDetailNotFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'It may have been removed from the schedule'**
  String get slotDetailNotFoundSubtitle;

  /// No description provided for @slotDetailDateTime.
  ///
  /// In en, this message translates to:
  /// **'Date and time'**
  String get slotDetailDateTime;

  /// No description provided for @slotDetailDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get slotDetailDuration;

  /// No description provided for @slotDetailDurationMin.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String slotDetailDurationMin(int minutes);

  /// No description provided for @slotDetailAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get slotDetailAddress;

  /// No description provided for @slotDetailSeats.
  ///
  /// In en, this message translates to:
  /// **'Available seats'**
  String get slotDetailSeats;

  /// No description provided for @slotDetailRental.
  ///
  /// In en, this message translates to:
  /// **'Rental kits'**
  String get slotDetailRental;

  /// No description provided for @slotDetailRentalAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} kit} other{{count} kits}}'**
  String slotDetailRentalAvailable(int count);

  /// No description provided for @slotDetailPrice.
  ///
  /// In en, this message translates to:
  /// **'Price per seat'**
  String get slotDetailPrice;

  /// No description provided for @slotDetailRentalPrice.
  ///
  /// In en, this message translates to:
  /// **'Rental per kit'**
  String get slotDetailRentalPrice;

  /// No description provided for @slotDetailBookCta.
  ///
  /// In en, this message translates to:
  /// **'Book a spot'**
  String get slotDetailBookCta;

  /// No description provided for @slotDetailBookUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Booking is unavailable for this workshop'**
  String get slotDetailBookUnavailable;

  /// No description provided for @bookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Book a spot'**
  String get bookingTitle;

  /// No description provided for @bookingSeatsLabel.
  ///
  /// In en, this message translates to:
  /// **'Number of seats'**
  String get bookingSeatsLabel;

  /// No description provided for @bookingRentalLabel.
  ///
  /// In en, this message translates to:
  /// **'Rental kits'**
  String get bookingRentalLabel;

  /// No description provided for @bookingRentalHint.
  ///
  /// In en, this message translates to:
  /// **'Rental includes apron and tools. Your own equipment is free.'**
  String get bookingRentalHint;

  /// No description provided for @bookingTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get bookingTotalLabel;

  /// No description provided for @bookingSubmit.
  ///
  /// In en, this message translates to:
  /// **'Confirm booking'**
  String get bookingSubmit;

  /// No description provided for @bookingErrorSlotFull.
  ///
  /// In en, this message translates to:
  /// **'Not enough seats or rental kits. Adjust your selection.'**
  String get bookingErrorSlotFull;

  /// No description provided for @bookingErrorDoubleBooking.
  ///
  /// In en, this message translates to:
  /// **'You already have a booking for this workshop'**
  String get bookingErrorDoubleBooking;

  /// No description provided for @bookingErrorSlotCancelled.
  ///
  /// In en, this message translates to:
  /// **'This workshop was cancelled by the studio'**
  String get bookingErrorSlotCancelled;

  /// No description provided for @bookingErrorSlotStarted.
  ///
  /// In en, this message translates to:
  /// **'This workshop has already started'**
  String get bookingErrorSlotStarted;

  /// No description provided for @bookingErrorInvalidSeats.
  ///
  /// In en, this message translates to:
  /// **'Choose between 1 and 3 seats'**
  String get bookingErrorInvalidSeats;

  /// No description provided for @bookingErrorInvalidRental.
  ///
  /// In en, this message translates to:
  /// **'Rental count cannot exceed the number of seats'**
  String get bookingErrorInvalidRental;

  /// No description provided for @myBookingsSeatsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} seat} other{{count} seats}}'**
  String myBookingsSeatsCount(int count);

  /// No description provided for @myBookingsRentalCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} rental kit} other{{count} rental kits}}'**
  String myBookingsRentalCount(int count);

  /// No description provided for @myBookingsStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get myBookingsStatusActive;

  /// No description provided for @myBookingsStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get myBookingsStatusCancelled;

  /// No description provided for @myBookingsStatusLateCancel.
  ///
  /// In en, this message translates to:
  /// **'Late cancel'**
  String get myBookingsStatusLateCancel;

  /// No description provided for @myBookingsStatusWorkshopCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by studio'**
  String get myBookingsStatusWorkshopCancelled;

  /// No description provided for @bookingDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking details'**
  String get bookingDetailTitle;

  /// No description provided for @bookingDetailNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking not found'**
  String get bookingDetailNotFoundTitle;

  /// No description provided for @bookingDetailNotFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'It may have been removed'**
  String get bookingDetailNotFoundSubtitle;

  /// No description provided for @bookingDetailCancelCta.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get bookingDetailCancelCta;

  /// No description provided for @bookingDetailCancelDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this booking?'**
  String get bookingDetailCancelDialogTitle;

  /// No description provided for @bookingDetailCancelDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Early cancellation frees your seats. Late cancellation keeps them reserved.'**
  String get bookingDetailCancelDialogBody;

  /// No description provided for @bookingDetailCancelDialogDismiss.
  ///
  /// In en, this message translates to:
  /// **'Keep booking'**
  String get bookingDetailCancelDialogDismiss;

  /// No description provided for @bookingDetailCancelDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get bookingDetailCancelDialogConfirm;

  /// No description provided for @bookingDetailCancelledAt.
  ///
  /// In en, this message translates to:
  /// **'Cancelled on {date}'**
  String bookingDetailCancelledAt(String date);

  /// No description provided for @bookingDetailWorkshopReason.
  ///
  /// In en, this message translates to:
  /// **'Studio reason: {reason}'**
  String bookingDetailWorkshopReason(String reason);

  /// No description provided for @bookingDetailErrorAlreadyCancelled.
  ///
  /// In en, this message translates to:
  /// **'This booking is already cancelled'**
  String get bookingDetailErrorAlreadyCancelled;

  /// No description provided for @bookingDetailErrorSlotStarted.
  ///
  /// In en, this message translates to:
  /// **'The workshop has started — cancellation unavailable'**
  String get bookingDetailErrorSlotStarted;
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
