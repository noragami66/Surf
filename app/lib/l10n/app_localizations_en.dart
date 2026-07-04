// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Glina';

  @override
  String get appTagline => 'Pottery workshop';

  @override
  String get slotsTab => 'Slots';

  @override
  String get myBookingsTab => 'My bookings';

  @override
  String get slotsSectionTitle => 'Schedule';

  @override
  String get slotsEmptyTitle => 'No workshops available yet';

  @override
  String get slotsEmptySubtitle =>
      'Check back later — the schedule updates regularly';

  @override
  String get slotsErrorTitle => 'Could not load';

  @override
  String get slotsErrorSubtitle => 'Check your connection and try again';

  @override
  String slotsSeatsAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seats left',
      one: '$count seat left',
    );
    return '$_temp0';
  }

  @override
  String get myBookingsSubtitle => 'Your bookings and history';

  @override
  String get myBookingsEmptyTitle => 'No bookings yet';

  @override
  String get myBookingsEmptySubtitle =>
      'Pick a workshop from the schedule to book a spot';

  @override
  String get myBookingsGoToSchedule => 'Go to schedule';

  @override
  String homeGreeting(String name) {
    return 'Hello, $name';
  }

  @override
  String get homeGreetingSubtitle => 'Glad to see you again';

  @override
  String get loading => 'Loading…';

  @override
  String get authPhoneTitle => 'Welcome to Glina';

  @override
  String get authPhoneSubtitle =>
      'Enter your phone number to sign in or create an account';

  @override
  String get authPhoneLabel => 'Phone number';

  @override
  String get authPhoneHint => '+7 000 000 00 00';

  @override
  String get authContinue => 'Continue';

  @override
  String get authOtpTitle => 'Confirm your number';

  @override
  String authOtpSubtitle(String phone) {
    return 'We sent a 4-digit code to $phone';
  }

  @override
  String get authOtpHintMock => 'Mock code: 0000';

  @override
  String get authVerify => 'Verify';

  @override
  String get authChangeNumber => 'Change number';

  @override
  String get authResendCode => 'Resend code';

  @override
  String get authNameTitle => 'How should we call you?';

  @override
  String get authNameSubtitle =>
      'Add your name to finish setting up your account';

  @override
  String get authNameLabel => 'Your name';

  @override
  String get authNameHint => 'Anna';

  @override
  String get authFinish => 'Finish';

  @override
  String get authErrorInvalidPhone => 'Enter a valid phone number';

  @override
  String get authErrorInvalidCode => 'The code is incorrect. Try again';

  @override
  String get authErrorRateLimited => 'Too many attempts. Please wait a moment';

  @override
  String get authErrorEmptyName => 'Please enter your name';

  @override
  String get authErrorNetwork => 'Network error. Please try again';

  @override
  String get authErrorGeneric => 'Something went wrong. Please try again';

  @override
  String get logout => 'Log out';

  @override
  String get slotDetailNotFoundTitle => 'Workshop not found';

  @override
  String get slotDetailNotFoundSubtitle =>
      'It may have been removed from the schedule';

  @override
  String get slotDetailDateTime => 'Date and time';

  @override
  String get slotDetailDuration => 'Duration';

  @override
  String slotDetailDurationMin(int minutes) {
    return '$minutes min';
  }

  @override
  String get slotDetailAddress => 'Address';

  @override
  String get slotDetailSeats => 'Available seats';

  @override
  String get slotDetailRental => 'Rental kits';

  @override
  String slotDetailRentalAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kits',
      one: '$count kit',
    );
    return '$_temp0';
  }

  @override
  String get slotDetailPrice => 'Price per seat';

  @override
  String get slotDetailRentalPrice => 'Rental per kit';

  @override
  String get slotDetailBookCta => 'Book a spot';

  @override
  String get slotDetailBookUnavailable =>
      'Booking is unavailable for this workshop';

  @override
  String get bookingTitle => 'Book a spot';

  @override
  String get bookingSeatsLabel => 'Number of seats';

  @override
  String get bookingRentalLabel => 'Rental kits';

  @override
  String get bookingRentalHint =>
      'Rental includes apron and tools. Your own equipment is free.';

  @override
  String get bookingTotalLabel => 'Total';

  @override
  String get bookingSubmit => 'Confirm booking';

  @override
  String get bookingErrorSlotFull =>
      'Not enough seats or rental kits. Adjust your selection.';

  @override
  String get bookingErrorDoubleBooking =>
      'You already have a booking for this workshop';

  @override
  String get bookingErrorSlotCancelled =>
      'This workshop was cancelled by the studio';

  @override
  String get bookingErrorSlotStarted => 'This workshop has already started';

  @override
  String get bookingErrorInvalidSeats => 'Choose between 1 and 3 seats';

  @override
  String get bookingErrorInvalidRental =>
      'Rental count cannot exceed the number of seats';
}
