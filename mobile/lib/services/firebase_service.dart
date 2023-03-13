import 'dart:io';

import 'package:app/blocs/blocs.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CloudAnalytics {
  static Future<bool> logEvent(CloudAnalyticsEvent analyticsEvent) async {
    await FirebaseAnalytics.instance.logEvent(
      name: analyticsEvent.snakeCase(),
    );

    return true;
  }

  static Future<void> logAppRating() async {
    await CloudAnalytics.logEvent(
      Event.rateApp,
    );
  }

  static Future<void> logSignUpEvents() async {
    try {
      await Future.wait([
        logEvent(Event.createUserProfile),
        logNetworkProvider(),
        logPlatformType(),
        logGender(),
      ]);
    } catch (exception, stackTrace) {
      debugPrint('$exception\n$stackTrace');
    }
  }

  static Future<void> logSignInEvents() async {
    try {
      await Future.wait([
        logPlatformType(),
      ]);
    } catch (exception, stackTrace) {
      debugPrint('$exception\n$stackTrace');
    }
  }

  static Future<void> logAirQualitySharing() async {
    final profile = Hive.box<Profile>(HiveBox.profile).getAt(0);
    if (profile != null) {
      profile.preferences.aqShares = profile.preferences.aqShares + 1;
      if (profile.preferences.aqShares >= 5) {
        await CloudAnalytics.logEvent(
          Event.shareAirQualityInformation,
        );
      }
    }
  }

  static Future<void> logNetworkProvider() async {
    final profile = Hive.box<Profile>(HiveBox.profile).getAt(0);
    if (profile != null) {
      final carrier = await AirqoApiClient().getCarrier(profile.phoneNumber);
      if (carrier.toLowerCase().contains('airtel')) {
        await logEvent(CloudAnalyticsEvent.airtelUser);
      } else if (carrier.toLowerCase().contains('mtn')) {
        await logEvent(CloudAnalyticsEvent.mtnUser);
      } else {
        await logEvent(
          CloudAnalyticsEvent.otherNetwork,
        );
      }
    }
  }

  static Future<void> logPlatformType() async {
    if (Platform.isAndroid) {
      await logEvent(
        CloudAnalyticsEvent.androidUser,
      );
    } else if (Platform.isIOS) {
      await logEvent(
        CloudAnalyticsEvent.iosUser,
      );
    } else {
      debugPrint('Unknown Platform');
    }
  }

  static Future<void> logGender() async {
    final profile = Hive.box<Profile>(HiveBox.profile).getAt(0);
    if (profile != null) {
      if (profile.gender() == Gender.male) {
        await logEvent(
          CloudAnalyticsEvent.maleUser,
        );
      } else if (profile.gender() == Gender.female) {
        await logEvent(
          CloudAnalyticsEvent.femaleUser,
        );
      } else {
        await logEvent(
          CloudAnalyticsEvent.undefinedGender,
        );
      }
    }
  }
}

class CloudStore {
  static Future<void> updateKyaProgress(Kya kya) async {
    final userId = CustomAuth.getUserId();
    KyaProgress progress = KyaProgress.fromKya(kya);

    try {
      await FirebaseFirestore.instance
          .collection(Config.usersKyaCollection)
          .doc(userId)
          .collection(userId)
          .doc(progress.id)
          .set(progress.toJson());
    } catch (exception, stackTrace) {
      await logException(
        exception,
        stackTrace,
      );
    }
  }

  static Future<List<Kya>> getKya() async {
    List<Kya> kya = <Kya>[];
    final kyaCollection =
        await FirebaseFirestore.instance.collection(Config.kyaCollection).get();

    for (final doc in kyaCollection.docs) {
      try {
        final kyaData = doc.data();
        if (kyaData.isEmpty) {
          continue;
        }
        kya.add(Kya.fromJson(kyaData));
      } catch (exception, stackTrace) {
        logException(exception, stackTrace);
      }
    }

    final userId = CustomAuth.getUserId();
    if (userId.isEmpty) {
      return kya;
    }

    List<KyaProgress> userProgress = <KyaProgress>[];
    final kyaProgressCollection = await FirebaseFirestore.instance
        .collection(Config.usersKyaCollection)
        .doc(userId)
        .collection(userId)
        .get();

    for (final doc in kyaProgressCollection.docs) {
      try {
        userProgress.add(KyaProgress.fromJson(doc.data()));
      } catch (exception, stackTrace) {
        debugPrint('$exception\n$stackTrace');
      }
    }

    kya = kya.map((element) {
      KyaProgress kyaProgress =
          userProgress.firstWhere((x) => x.id == element.id, orElse: () {
        return KyaProgress(id: element.id, progress: 0);
      });

      return element.copyWith(progress: kyaProgress.progress);
    }).toList();

    return kya;
  }

  static Future<bool> deleteAccount() async {
    try {
      final id = CustomAuth.getUser()?.uid;
      await Future.wait([
        FirebaseFirestore.instance
            .collection(Config.usersCollection)
            .doc(id)
            .delete(),
        FirebaseFirestore.instance
            .collection(Config.usersKyaCollection)
            .doc(id)
            .delete(),
        FirebaseFirestore.instance
            .collection(Config.usersNotificationCollection)
            .doc(id)
            .delete(),
        FirebaseFirestore.instance
            .collection(Config.favPlacesCollection)
            .doc(id)
            .delete(),
        FirebaseFirestore.instance
            .collection(Config.usersAnalyticsCollection)
            .doc(id)
            .delete(),
      ]);
    } catch (exception, stackTrace) {
      await logException(
        exception,
        stackTrace,
      );
    }

    return true;
  }

  static Future<List<AppNotification>> getNotifications() async {
    final notifications = <AppNotification>[];

    final profile = await HiveService.getProfile();
    if (profile.userId.isEmpty || profile.user == null) {
      return notifications;
    }

    final notificationsCollection = await FirebaseFirestore.instance
        .collection(Config.usersNotificationCollection)
        .doc(profile.userId)
        .collection(profile.userId)
        .get();

    for (final doc in notificationsCollection.docs) {
      try {
        notifications.add(AppNotification.fromJson(doc.data()));
      } catch (exception, stackTrace) {
        await logException(
          exception,
          stackTrace,
        );
      }
    }

    return notifications;
  }

  static Future<List<Analytics>> getCloudAnalytics() async {
    String uid = CustomAuth.getUserId();
    List<Analytics> analytics = <Analytics>[];

    try {
      final analyticsCollection = await FirebaseFirestore.instance
          .collection(Config.usersKyaCollection)
          .doc(uid)
          .collection(uid)
          .get();

      for (final doc in analyticsCollection.docs) {
        try {
          analytics.add(Analytics.fromJson(doc.data()));
        } catch (exception, stackTrace) {
          await logException(
            exception,
            stackTrace,
          );
        }
      }
    } catch (exception, stackTrace) {
      await logException(
        exception,
        stackTrace,
      );
    }

    return analytics;
  }

  static Future<Profile> getProfile() async {
    Profile? profile;

    try {
      final profileJson = await FirebaseFirestore.instance
          .collection(Config.usersCollection)
          .doc(CustomAuth.getUserId())
          .get();

      final profileData = profileJson.data();
      if (profileData != null) {
        profile = Profile.fromJson(profileData);
      }
    } catch (exception, stackTrace) {
      await logException(
        exception,
        stackTrace,
      );
    }

    if (profile == null) {
      profile = await HiveService.getProfile();
      await updateProfile();
    }

    return await profile.setUserCredentials();
  }

  static Future<List<FavouritePlace>> getFavouritePlaces() async {
    final favouritePlaces = <FavouritePlace>[];

    try {
      final userId = CustomAuth.getUserId();

      final jsonObject = await FirebaseFirestore.instance
          .collection(Config.favPlacesCollection)
          .doc(userId)
          .collection(userId)
          .get();

      for (final doc in jsonObject.docs) {
        try {
          favouritePlaces.add(FavouritePlace.fromFirestore(doc));
        } catch (exception, stackTrace) {
          await logException(exception, stackTrace);
        }
      }
    } catch (exception, stackTrace) {
      await logException(
        exception,
        stackTrace,
      );
    }

    return favouritePlaces;
  }

  static Future<bool> updateFavouritePlaces() async {
    Profile profile = await HiveService.getProfile();

    final batch = FirebaseFirestore.instance.batch();

    batch.delete(FirebaseFirestore.instance
        .collection(Config.favPlacesCollection)
        .doc(profile.userId));

    final favouritePlaces = HiveService.getFavouritePlaces();
    for (final favouritePlace in favouritePlaces) {
      final document = FirebaseFirestore.instance
          .collection(Config.favPlacesCollection)
          .doc(profile.userId)
          .collection(profile.userId)
          .doc(favouritePlace.placeId);
      batch.set(document, favouritePlace.toJson());
    }

    await batch.commit();

    return true;
  }

  static Future<bool> updateProfile() async {
    Profile profile = await HiveService.getProfile();
    final user = profile.user;
    if (user == null) {
      return false;
    }

    await Future.wait([
      user.updateDisplayName(profile.firstName),
      user.updatePhotoURL(profile.photoUrl),
      FirebaseFirestore.instance
          .collection(Config.usersCollection)
          .doc(profile.userId)
          .set(profile.toJson()),
    ]);

    return true;
  }

  static Future<bool> updateKya() async {
    Profile profile = await HiveService.getProfile();
    final batch = FirebaseFirestore.instance.batch();
    batch.delete(FirebaseFirestore.instance
        .collection(Config.usersKyaCollection)
        .doc(profile.userId));

    List<KyaProgress> userProgress =
        HiveService.getKya().map((e) => KyaProgress.fromKya(e)).toList();

    for (final progress in userProgress) {
      final document = FirebaseFirestore.instance
          .collection(Config.usersKyaCollection)
          .doc(profile.userId)
          .collection(profile.userId)
          .doc(progress.id);
      batch.set(document, progress.toJson());
    }

    await batch.commit();

    return true;
  }

  static Future<bool> updateCloudAnalytics() async {
    final batch = FirebaseFirestore.instance.batch();
    Profile profile = await HiveService.getProfile();
    final analytics = HiveService.getAnalytics();

    for (final x in analytics) {
      final document = FirebaseFirestore.instance
          .collection(Config.usersAnalyticsCollection)
          .doc(profile.userId)
          .collection(profile.userId)
          .doc(x.site);
      batch.set(document, x.toJson());
    }

    await batch.commit();

    return true;
  }

  static Future<void> updateCloudNotification(
    AppNotification notification,
    Profile profile,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        try {
          await FirebaseFirestore.instance
              .collection(Config.usersNotificationCollection)
              .doc(profile.userId)
              .collection(profile.userId)
              .doc(notification.id)
              .update(
                notification.toJson(),
              );
        } catch (exception) {
          await FirebaseFirestore.instance
              .collection(Config.usersNotificationCollection)
              .doc(profile.userId)
              .collection(profile.userId)
              .doc(notification.id)
              .set(
                notification.toJson(),
              );
        }
      } catch (exception, stackTrace) {
        await logException(
          exception,
          stackTrace,
        );
      }
    }
  }

  static Future<void> updateKyaProgress(Kya kya) async {
    final userId = CustomAuth.getUserId();
    KyaProgress progress = KyaProgress.fromKya(kya);

    try {
      await FirebaseFirestore.instance
          .collection(Config.usersKyaCollection)
          .doc(userId)
          .collection(userId)
          .doc(progress.id)
          .set(progress.toJson());
    } catch (exception, stackTrace) {
      await logException(
        exception,
        stackTrace,
      );
    }
  }

  static Future<String> uploadProfilePicture(String filePath) async {
    try {
      final userId = CustomAuth.getUserId();
      final file = File(filePath);

      final docRef = '${Config.usersProfilePictureStorage}/'
          '$userId/avatar${file.getExtension()}';

      final task = await firebase_storage.FirebaseStorage.instance
          .ref(docRef)
          .putFile(file);

      String photoUrl = await task.storage.ref(docRef).getDownloadURL();
      if (photoUrl.isEmpty) {
        return '';
      }

      Profile profile = await HiveService.getProfile();
      profile = profile.copyWith(photoUrl: photoUrl);
      HiveService.updateProfile(profile);

      await Future.wait([
        CloudAnalytics.logEvent(
          Event.uploadProfilePicture,
        ),
        updateProfile(),
      ]);

      return photoUrl;
    } on Exception catch (exception, stackTrace) {
      await logException(
        exception,
        stackTrace,
      );
    }

    return '';
  }
}

class CloudMessaging {
  static Future<String?> getDeviceToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}

class CustomAuth {
  static Future<bool> guestSignIn() async {
    UserCredential userCredential;
    User? user = getUser();
    if (user != null && user.isAnonymous) {
      return true;
    }

    userCredential = await FirebaseAuth.instance.signInAnonymously();

    return userCredential.user != null;
  }

  static Future<bool> signIn(AuthCredential authCredential) async {
    UserCredential userCredential;
    User? user = getUser();
    bool isSignedOut = true;

    if (user != null) {
      isSignedOut = await signOut();
    }
    if (isSignedOut) {
      userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);

      return userCredential.user != null;
    }

    return false;
  }

  static Future<bool> deleteAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();

      return true;
    }

    return false;
  }

  static Future<bool> signOut() async {
    try {
      final profile = await CloudStore.updateProfile();
      final analytics = await CloudStore.updateCloudAnalytics();
      final favouritePlaces = await CloudStore.updateFavouritePlaces();
      final kya = await CloudStore.updateKya();

      if (!kya || !analytics || !profile || !favouritePlaces) return false;

      await FirebaseAuth.instance.signOut();
    } catch (exception, stackTrace) {
      await logException(
        exception,
        stackTrace,
      );

      return false;
    }

    return true;
  }

  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static String getUserId() {
    User? user = getUser();

    return user == null ? '' : user.uid;
  }

  static bool isLoggedIn() {
    return getUser() != null;
  }

  static Future<bool> reAuthenticate(AuthCredential authCredential) async {
    final userCredential = await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(authCredential);

    return userCredential.user != null;
  }

  static AuthenticationError getFirebaseExceptionMessage(
    FirebaseAuthException exception,
  ) {
    String code = exception.code;
    switch (code) {
      case 'invalid-email':
        return AuthenticationError.invalidEmailAddress;
      case 'email-already-in-use':
        return AuthenticationError.emailTaken;
      case 'credential-already-in-use':
      case 'account-exists-with-different-credential':
        return AuthenticationError.accountTaken;
      case 'invalid-verification-code':
        return AuthenticationError.invalidAuthCode;
      case 'invalid-phone-number':
        return AuthenticationError.invalidPhoneNumber;
      case 'session-expired':
      case 'expired-action-code':
        return AuthenticationError.authSessionTimeout;
      case 'user-disabled':
      case 'user-mismatch':
      case 'user-not-found':
        return AuthenticationError.accountInvalid;
      case 'requires-recent-login':
        return AuthenticationError.logInRequired;
      case 'invalid-verification-id':
      case 'invalid-credential':
      case 'missing-client-identifier':
      default:
        return AuthenticationError.authFailure;
    }
  }

  static Future<void> initiatePhoneNumberVerification(
    String phoneNumber, {
    required BuildContext buildContext,
    int? resendingToken,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        debugPrint("verification complete");
        buildContext
            .read<PhoneAuthBloc>()
            .add(PhoneAutoVerificationCompleted(credential));
      },
      verificationFailed: (FirebaseAuthException exception) {
        debugPrint("verification Failed");
        buildContext
            .read<PhoneAuthBloc>()
            .add(PhoneVerificationException(exception));
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint("code Sent");
        buildContext.read<PhoneAuthBloc>().add(PhoneVerificationCodeSent(
              verificationId,
              resendingToken: resendToken,
            ));
      },
      forceResendingToken: resendingToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint("code Auto Retrieval Timeout");
        buildContext
            .read<PhoneAuthBloc>()
            .add(PhoneAutoVerificationTimeout(verificationId));
      },
      timeout: const Duration(seconds: 5),
    );
  }

  static Future<void> initiateEmailVerification(
    String emailAddress, {
    required BuildContext buildContext,
  }) async {
    await AirqoApiClient()
        .requestEmailVerificationCode(emailAddress)
        .then((emailAuthModel) {
      if (emailAuthModel == null) {
        buildContext.read<EmailAuthBloc>().add(const EmailValidationFailed());
      } else {
        buildContext.read<EmailAuthBloc>().add(EmailVerificationCodeSent(
              verificationLink: emailAuthModel.loginLink,
              token: emailAuthModel.token,
            ));
      }
    });
  }
}
