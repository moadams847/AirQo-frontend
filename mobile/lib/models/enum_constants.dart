import 'package:app/themes/theme.dart';
import 'package:app/utils/utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enum_constants.g.dart';

enum Environment { dev, prod }

enum CloudAnalyticsEvent {
  browserAsAppGuest('browser_as_guest'),
  createUserProfile('created_profile'),
  shareAirQualityInformation('share_air_quality_information'),
  completeOneKYA('complete_kya_lesson'),
  allowNotification('allow_notification'),
  allowLocation('allow_location'),
  uploadProfilePicture('upload_profile_picture'),
  savesFiveFavorites('save_five_favorite_places'),
  maleUser('male_user'),
  femaleUser('female_user'),
  undefinedGender('undefined_gender'),
  iosUser('ios_user'),
  androidUser('android_user'),
  rateApp('rate_app'),
  mtnUser('mtn_user'),
  airtelUser('airtel_user'),
  otherNetwork('other_network'),
  deletedAccount('deleted_account'),
  notificationOpen('notification_open'),
  notificationReceive('notification_receive');

  const CloudAnalyticsEvent(this.snakeCaseValue);

  final String snakeCaseValue;

  String snakeCase() {
    return '${kReleaseMode ? 'prod_' : 'stage_'}$snakeCaseValue';
  }
}

enum InsightsStatus {
  loaded,
  error,
  refreshing,
  loading,
  noInternetConnection,
  noData;
}

enum AppPermission {
  notification,
  location,
  photosStorage,
}

enum BlocStatus {
  initial,
  editing,
  processing,
  updatingData,
  error,
  success,
  accountDeletionCheckSuccess,
}

enum FeedbackStep {
  channelStep,
  typeStep,
  formStep;
}

enum AuthenticationError {
  noInternetConnection(
    message: 'Check your internet connection',
    snackBarDuration: 5,
  ),
  invalidFirstName(
    message: 'First name is required.',
    snackBarDuration: 5,
  ),
  invalidLastName(
    message: 'Last name is required.',
    snackBarDuration: 5,
  ),
  accountInvalid(
    message: 'Invalid Account',
    snackBarDuration: 5,
  ),
  invalidAuthCode(
    message: 'Invalid code',
    snackBarDuration: 5,
  ),
  authSessionTimeout(
    message: 'Session time out. Sending another verification code',
    snackBarDuration: 5,
  ),
  none(
    message: '',
    snackBarDuration: 0,
  ),
  authFailure(
    message: 'Authentication failed. Try again later',
    snackBarDuration: 5,
  ),
  logInRequired(
    message: 'Log in required.',
    snackBarDuration: 5,
  ),
  logoutFailed(
    message: 'Failed to logout. Try again later',
    snackBarDuration: 5,
  ),
  phoneNumberTaken(
    message: 'Phone number taken',
    snackBarDuration: 5,
  ),
  invalidPhoneNumber(
    message: 'Invalid Phone number',
    snackBarDuration: 5,
  ),
  invalidEmailAddress(
    message: 'Invalid Email address',
    snackBarDuration: 5,
  ),
  accountTaken(
    message: 'Invalid email address',
    snackBarDuration: 5,
  ),
  emailTaken(
    message: 'Email Taken',
    snackBarDuration: 5,
  );

  const AuthenticationError({
    required this.message,
    required this.snackBarDuration,
  });

  final String message;
  final int snackBarDuration;

  @override
  String toString() => message;
}

enum NearbyAirQualityError {
  none(
    message: '',
  ),
  locationDenied(
    message: 'Enable location to get air quality near you',
  ),
  locationDisabled(
    message: 'Turn on location to get air quality near you',
  ),
  noNearbyAirQualityReadings(
    message:
        'We’re unable to get your location’s air quality. Explore locations below as we expand our network.',
  );

  const NearbyAirQualityError({required this.message});

  final String message;

  @override
  String toString() => message;
}

@HiveType(typeId: 110, adapterName: 'AppNotificationTypeAdapter')
enum AppNotificationType {
  @HiveField(0)
  appUpdate,
  @HiveField(1)
  reminder,
  @HiveField(2)
  welcomeMessage,
}

enum AirQuality {
  good(
    string: 'Good',
    searchNearbyLocationsText: 'Good Quality Air around you',
    searchOtherLocationsText: 'Locations with Good Quality Air',
    value: 6,
    minimumValue: 0,
    maximumValue: 12.09,
  ),
  moderate(
    string: 'Moderate',
    searchNearbyLocationsText: 'Moderate Quality Air around you',
    searchOtherLocationsText: 'Locations with Moderate Quality Air',
    value: 23.8,
    minimumValue: 12.1,
    maximumValue: 35.49,
  ),
  ufsgs(
    string: 'Unhealthy For Sensitive Groups',
    searchNearbyLocationsText:
        'Nearby locations with air quality Unhealthy For Sensitive Groups',
    searchOtherLocationsText:
        'Locations with air quality Unhealthy For Sensitive Groups',
    value: 101,
    minimumValue: 35.5,
    maximumValue: 55.49,
  ),
  unhealthy(
    string: 'Unhealthy',
    searchNearbyLocationsText: 'Unhealthy Quality Air around you',
    searchOtherLocationsText: 'Locations with Unhealthy Quality Air',
    value: 103,
    minimumValue: 55.5,
    maximumValue: 150.49,
  ),
  veryUnhealthy(
    string: 'Very Unhealthy',
    searchNearbyLocationsText: 'Very Unhealthy Quality Air around you',
    searchOtherLocationsText: 'Locations with Very Unhealthy Quality Air',
    value: 200.5,
    minimumValue: 150.5,
    maximumValue: 250.49,
  ),
  hazardous(
    string: 'Hazardous',
    searchNearbyLocationsText: 'Hazardous Quality Air around you',
    searchOtherLocationsText: 'Locations with Hazardous Quality Air',
    value: 300,
    minimumValue: 250.5,
    maximumValue: 500,
  );

  const AirQuality({
    required this.string,
    required this.searchNearbyLocationsText,
    required this.searchOtherLocationsText,
    required this.value,
    required this.minimumValue,
    required this.maximumValue,
  });

  final String string;
  final String searchOtherLocationsText;
  final String searchNearbyLocationsText;
  final double value;
  final double minimumValue;
  final double maximumValue;

  Color color() {
    switch (this) {
      case AirQuality.good:
        return CustomColors.aqiGreen;
      case AirQuality.moderate:
        return CustomColors.aqiYellow;
      case AirQuality.ufsgs:
        return CustomColors.aqiOrange;
      case AirQuality.unhealthy:
        return CustomColors.aqiRed;
      case AirQuality.veryUnhealthy:
        return CustomColors.aqiPurple;
      case AirQuality.hazardous:
        return CustomColors.aqiMaroon;
    }
  }

  @override
  String toString() => string;
}

enum FeedbackType {
  inquiry('Inquiry'),
  suggestion('Suggestion'),
  appBugs('App Bugs'),
  reportAirPollution('Report Air Pollution'),
  none('');

  const FeedbackType(this.string);

  final String string;

  @override
  String toString() => string;
}

enum FeedbackChannel {
  whatsApp('Whatsapp'),
  email('Email'),
  none('');

  const FeedbackChannel(this.string);

  final String string;

  @override
  String toString() => string;
}

enum AuthMethod {
  phone(
    updateMessage:
        'You will not be able to sign in with your previous phone number after changing it',
    codeVerificationText: 'Enter the 6 digits code sent to',
    editEntryText: 'Change your number',
    invalidInputErrorMessage: 'Looks like you missed a digit.',
    invalidInputMessage: 'Oops, Something’s wrong with your phone number',
  ),
  email(
    updateMessage:
        'You will not be able to sign in with your previous email address after changing it',
    codeVerificationText: 'Enter the 6 digits code sent to',
    editEntryText: 'Change your email',
    invalidInputErrorMessage: 'Looks like you missed a letter',
    invalidInputMessage: 'Oops, Something’s wrong with your email',
  ),
  none(
    updateMessage: 'You do not have an account. Consider creating one',
    codeVerificationText: '',
    editEntryText: '',
    invalidInputErrorMessage: '',
    invalidInputMessage: '',
  );

  const AuthMethod({
    required this.updateMessage,
    required this.codeVerificationText,
    required this.editEntryText,
    required this.invalidInputErrorMessage,
    required this.invalidInputMessage,
  });

  final String updateMessage;
  final String codeVerificationText;
  final String editEntryText;
  final String invalidInputErrorMessage;
  final String invalidInputMessage;

  String optionsText(AuthProcedure procedure) {
    switch (this) {
      case AuthMethod.phone:
        return procedure == AuthProcedure.login
            ? 'Login with your mobile number or email'
            : 'Sign up with your mobile number or email';
      case AuthMethod.email:
        return procedure == AuthProcedure.login
            ? 'Login with your email or mobile number'
            : 'Sign up with your email or mobile number';
      default:
        return '';
    }
  }

  String optionsButtonText(AuthProcedure procedure) {
    switch (this) {
      case AuthMethod.phone:
        return procedure == AuthProcedure.login
            ? 'Login with an email instead'
            : 'Sign up with an email instead';
      case AuthMethod.email:
        return procedure == AuthProcedure.login
            ? 'Login with a mobile number instead'
            : 'Sign up with a mobile number instead';
      default:
        throw UnimplementedError(
          '$name does’nt have options button text implementation',
        );
    }
  }
}

enum AuthProcedure {
  login(
    confirmationTitle: '',
    confirmationBody: '',
    confirmationOkayText: '',
    confirmationCancelText: '',
  ),
  signup(
    confirmationTitle: '',
    confirmationBody: '',
    confirmationOkayText: '',
    confirmationCancelText: '',
  ),
  anonymousLogin(
    confirmationTitle: '',
    confirmationBody: '',
    confirmationOkayText: '',
    confirmationCancelText: '',
  ),
  deleteAccount(
    confirmationTitle: 'Heads up!!!.. you are about to delete your account!',
    confirmationBody: 'You will lose all your saved places',
    confirmationOkayText: 'Proceed',
    confirmationCancelText: 'Cancel',
  ),
  none(
    confirmationTitle: '',
    confirmationBody: '',
    confirmationOkayText: '',
    confirmationCancelText: '',
  ),
  logout(
    confirmationTitle: 'Heads up!!!.. you are about to logout!',
    confirmationBody:
        'You will miss out on notifications and won’t be able to save favourite places',
    confirmationOkayText: 'Proceed',
    confirmationCancelText: 'Cancel',
  );

  const AuthProcedure({
    required this.confirmationTitle,
    required this.confirmationBody,
    required this.confirmationOkayText,
    required this.confirmationCancelText,
  });

  final String confirmationTitle;
  final String confirmationBody;
  final String confirmationOkayText;
  final String confirmationCancelText;
}

@JsonEnum(valueField: 'string')
enum Frequency {
  daily('daily'),
  hourly('hourly');

  const Frequency(this.string);

  final String string;

  @override
  String toString() => string;

  List<charts.TickSpec<String>> staticTicks() {
    switch (this) {
      case Frequency.daily:
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
            .map(
              (day) => charts.TickSpec(
                day,
                label: day,
                style: charts.TextStyleSpec(
                  color: charts.ColorUtil.fromDartColor(CustomColors.greyColor),
                ),
              ),
            )
            .toList();

      case Frequency.hourly:
        final labels = <int>[0, 6, 12, 18];
        final hours = List<int>.generate(24, (index) => index + 1)
          ..removeWhere(labels.contains);

        final List<charts.TickSpec<String>> hourlyTicks = labels
            .map(
              (hour) => charts.TickSpec(
                hour.toStringLength(),
                label: hour.toStringLength(),
                style: charts.TextStyleSpec(
                  color: charts.ColorUtil.fromDartColor(CustomColors.greyColor),
                ),
              ),
            )
            .toList();

        hourlyTicks.addAll(hours
            .map(
              (hour) => charts.TickSpec(
                hour.toStringLength(),
                label: hour.toStringLength(),
                style: charts.TextStyleSpec(
                  color: charts.ColorUtil.fromDartColor(Colors.transparent),
                ),
              ),
            )
            .toList());

        return hourlyTicks;
    }
  }
}

enum Gender {
  male,
  female,
  undefined,
}

enum ConfirmationAction {
  cancel,
  ok,
}

enum OnBoardingPage {
  signup('signup'),
  profile('profile'),
  notification('notification'),
  location('location'),
  complete('complete'),
  home('home'),
  welcome('welcome');

  const OnBoardingPage(this.string);

  final String string;

  @override
  String toString() => string;
}

enum Pollutant {
  pm2_5(svg: 'assets/icon/PM2.5.svg'),
  pm10(svg: 'assets/icon/PM10.svg');

  const Pollutant({required this.svg});

  final String svg;

  AirQuality airQuality(double value) {
    switch (this) {
      case Pollutant.pm2_5:
        if (value <= 12.09) {
          return AirQuality.good;
        } else if (value.isWithin(12.1, 35.49)) {
          return AirQuality.moderate;
        } else if (value.isWithin(35.5, 55.49)) {
          return AirQuality.ufsgs;
        } else if (value.isWithin(55.5, 150.49)) {
          return AirQuality.unhealthy;
        } else if (value.isWithin(150.5, 250.49)) {
          return AirQuality.veryUnhealthy;
        } else if (value >= 250.5) {
          return AirQuality.hazardous;
        } else {
          return AirQuality.good;
        }
      case Pollutant.pm10:
        if (value <= 50.99) {
          return AirQuality.good;
        } else if (value.isWithin(51, 100.99)) {
          return AirQuality.moderate;
        } else if (value.isWithin(101, 250.99)) {
          return AirQuality.ufsgs;
        } else if (value.isWithin(251, 350.99)) {
          return AirQuality.unhealthy;
        } else if (value.isWithin(351, 430.99)) {
          return AirQuality.veryUnhealthy;
        } else if (value >= 431) {
          return AirQuality.hazardous;
        } else {
          return AirQuality.good;
        }
    }
  }

  String infoDialogText(double value) {
    switch (airQuality(value)) {
      case AirQuality.good:
        return 'Air quality is safe for everyone!';
      case AirQuality.moderate:
        return 'Unusually sensitive people should consider reducing '
            'prolonged or intense outdoor activities.';
      case AirQuality.ufsgs:
        return 'The elderly and children should limit intense outdoor '
            'activities. Sensitive people should reduce prolonged or '
            'intense outdoor activities.';
      case AirQuality.unhealthy:
        return 'People with respiratory or heart disease,'
            ' the elderly and children should avoid '
            'intense outdoor activities.'
            'Everyone else should limit intense outdoor activities.';
      case AirQuality.veryUnhealthy:
        return 'People with respiratory or heart disease, '
            'the elderly and children should avoid any outdoor activity.'
            'Everyone else should limit intense outdoor activities.';
      case AirQuality.hazardous:
        return 'Everyone should avoid any intense outdoor activities. '
            'People with respiratory or heart disease,'
            ' the elderly and children should remain indoors.';
    }
  }

  Color color(double value) {
    switch (airQuality(value)) {
      case AirQuality.good:
        return CustomColors.aqiGreen;
      case AirQuality.moderate:
        return CustomColors.aqiYellow;
      case AirQuality.ufsgs:
        return CustomColors.aqiOrange;
      case AirQuality.unhealthy:
        return CustomColors.aqiRed;
      case AirQuality.veryUnhealthy:
        return CustomColors.aqiPurple;
      case AirQuality.hazardous:
        return CustomColors.aqiMaroon;
    }
  }

  String stringValue(double value) {
    return airQuality(value).toString();
  }

  charts.Color chartColor(double value) {
    switch (airQuality(value)) {
      case AirQuality.good:
        return charts.ColorUtil.fromDartColor(CustomColors.aqiGreen);
      case AirQuality.moderate:
        return charts.ColorUtil.fromDartColor(CustomColors.aqiYellow);
      case AirQuality.ufsgs:
        return charts.ColorUtil.fromDartColor(CustomColors.aqiOrange);
      case AirQuality.unhealthy:
        return charts.ColorUtil.fromDartColor(CustomColors.aqiRed);
      case AirQuality.veryUnhealthy:
        return charts.ColorUtil.fromDartColor(CustomColors.aqiPurple);
      case AirQuality.hazardous:
        return charts.ColorUtil.fromDartColor(CustomColors.aqiMaroon);
    }
  }

  Color textColor({required double value, bool graph = false}) {
    switch (airQuality(value)) {
      case AirQuality.good:
        return CustomColors.aqiGreenTextColor;
      case AirQuality.moderate:
        return CustomColors.aqiYellowTextColor;
      case AirQuality.ufsgs:
        return CustomColors.aqiOrangeTextColor;
      case AirQuality.unhealthy:
        return CustomColors.aqiRedTextColor;
      case AirQuality.veryUnhealthy:
        return CustomColors.aqiPurpleTextColor;
      case AirQuality.hazardous:
        if (graph) {
          return CustomColors.aqiMaroon;
        }
        return CustomColors.aqiMaroonTextColor;
    }
  }
}

enum TitleOptions {
  ms(value: 'Ms', displayValue: 'Ms.', abbr: 'Ms.'),
  mr(value: 'Mr', displayValue: 'Mr.', abbr: 'Mr.'),
  undefined(
    value: 'Rather Not Say',
    displayValue: 'Rather Not Say',
    abbr: 'Ra.',
  );

  const TitleOptions({
    required this.value,
    required this.displayValue,
    required this.abbr,
  });

  final String value;
  final String displayValue;
  final String abbr;
}

enum ToolTipType {
  favouritePlaces,
  info,
  forYou,
  forecast,
}

enum ShowcaseOptions {
  up,
  skip,
  none,
}
