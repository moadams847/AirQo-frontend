import 'dart:convert';
import 'dart:typed_data';

import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter<AppNotification>(AppNotificationAdapter())
      ..registerAdapter<Profile>(ProfileAdapter())
      ..registerAdapter<Kya>(KyaAdapter())
      ..registerAdapter<Analytics>(AnalyticsAdapter())
      ..registerAdapter<AppNotificationType>(AppNotificationTypeAdapter())
      ..registerAdapter<KyaLesson>(KyaLessonAdapter())
      ..registerAdapter<UserPreferences>(UserPreferencesTypeAdapter())
      ..registerAdapter<FavouritePlace>(FavouritePlaceAdapter())
      ..registerAdapter<SearchHistory>(SearchHistoryAdapter())
      ..registerAdapter<AirQualityReading>(AirQualityReadingAdapter());

    await Future.wait([
      Hive.openBox<AppNotification>(HiveBox.appNotifications),
      Hive.openBox<SearchHistory>(HiveBox.searchHistory),
      Hive.openBox<Kya>(HiveBox.kya),
      Hive.openBox<Analytics>(HiveBox.analytics),
      Hive.openBox<FavouritePlace>(HiveBox.favouritePlaces),
      Hive.openBox<AirQualityReading>(HiveBox.airQualityReadings),
      Hive.openBox<AirQualityReading>(HiveBox.nearByAirQualityReadings),
    ]);

    final encryptionKey = await getEncryptionKey();
    await Hive.openBox<Profile>(
      HiveBox.profile,
      encryptionCipher: encryptionKey == null
          ? null
          : HiveAesCipher(
              encryptionKey,
            ),
    );
  }

  static Future<Uint8List?>? getEncryptionKey() async {
    try {
      final secureStorage = SecureStorage();
      var encodedKey = await secureStorage.getValue(HiveBox.encryptionKey);
      if (encodedKey == null) {
        final secureKey = Hive.generateSecureKey();
        await secureStorage.setValue(
          key: HiveBox.encryptionKey,
          value: base64UrlEncode(secureKey),
        );
      }
      encodedKey = await secureStorage.getValue(HiveBox.encryptionKey);

      return base64Url.decode(encodedKey!);
    } catch (_, __) {
      return null;
    }
  }

  static Future<void> clearUserData() async {
    await Future.wait([
      Hive.box<AppNotification>(HiveBox.appNotifications).clear(),
      Hive.box<Kya>(HiveBox.kya).clear(),
      Hive.box<SearchHistory>(HiveBox.searchHistory).clear(),
      Hive.box<Analytics>(HiveBox.analytics).clear(),
      Hive.box<FavouritePlace>(HiveBox.favouritePlaces).clear(),
    ]);
  }

  static Future<void> updateAirQualityReading(
    AirQualityReading airQualityReading,
  ) async {
    await Hive.box<AirQualityReading>(HiveBox.airQualityReadings)
        .put(airQualityReading.placeId, airQualityReading);
  }

  static Future<void> updateKya(Kya kya) async {
    await Hive.box<Kya>(HiveBox.kya).put(kya.id, kya);
  }

  static Future<void> updateAirQualityReadings(
    List<AirQualityReading> airQualityReadings, {
    bool reload = false,
  }) async {
    final airQualityReadingsMap = <String, AirQualityReading>{};
    final currentReadings =
        Hive.box<AirQualityReading>(HiveBox.airQualityReadings).values.toList();
    for (final reading in airQualityReadings) {
      if (reading.shareLink.isEmpty) {
        AirQualityReading airQualityReading = currentReadings.firstWhere(
          (element) => element.placeId == reading.placeId,
          orElse: () {
            return reading;
          },
        );
        airQualityReadingsMap[reading.placeId] =
            reading.copyWith(shareLink: airQualityReading.shareLink);
      } else {
        airQualityReadingsMap[reading.placeId] = reading;
      }
    }

    if (reload) {
      await Hive.box<AirQualityReading>(HiveBox.airQualityReadings).clear();
    }
    await Hive.box<AirQualityReading>(HiveBox.airQualityReadings)
        .putAll(airQualityReadingsMap);
  }

  static List<AirQualityReading> getAirQualityReadings() {
    return Hive.box<AirQualityReading>(
      HiveBox.airQualityReadings,
    ).values.toList();
  }

  static Future<void> updateSearchHistory(
    AirQualityReading airQualityReading,
  ) async {
    List<SearchHistory> searchHistoryList =
        Hive.box<SearchHistory>(HiveBox.searchHistory).values.toList();
    searchHistoryList
        .add(SearchHistory.fromAirQualityReading(airQualityReading));
    searchHistoryList = searchHistoryList.sortByDateTime().take(10).toList();

    final searchHistoryMap = <String, SearchHistory>{};
    for (final searchHistory in searchHistoryList) {
      searchHistoryMap[searchHistory.placeId] = searchHistory;
    }

    await Hive.box<SearchHistory>(HiveBox.searchHistory).clear();
    await Hive.box<SearchHistory>(HiveBox.searchHistory)
        .putAll(searchHistoryMap);
  }

  static Future<void> updateNearbyAirQualityReadings(
    List<AirQualityReading> nearbyAirQualityReadings,
  ) async {
    final airQualityReadingsMap = <String, AirQualityReading>{};

    nearbyAirQualityReadings =
        nearbyAirQualityReadings.sortByDistanceToReferenceSite();

    for (final airQualityReading in nearbyAirQualityReadings) {
      airQualityReadingsMap[airQualityReading.placeId] = airQualityReading;
    }

    await Hive.box<AirQualityReading>(HiveBox.nearByAirQualityReadings).clear();
    await Hive.box<AirQualityReading>(HiveBox.nearByAirQualityReadings)
        .putAll(airQualityReadingsMap);
    await updateAnalytics(nearbyAirQualityReadings);
  }

  static Future<void> updateAnalytics(
    List<AirQualityReading> airQualityReadings,
  ) async {
    List<Analytics> analytics = airQualityReadings
        .map((e) => Analytics.fromAirQualityReading(e))
        .toList();

    analytics.addAll(Hive.box<Analytics>(HiveBox.analytics).values.toList());

    final analyticsMap = <String, Analytics>{};

    for (final element in analytics) {
      analyticsMap[element.id] = element;
    }

    await Hive.box<Analytics>(HiveBox.analytics).clear();
    await Hive.box<Analytics>(HiveBox.analytics).putAll(analyticsMap);
  }

  static Future<void> loadNotifications(
    List<AppNotification> notifications, {
    bool clear = false,
  }) async {
    if (notifications.isEmpty && !clear) {
      return;
    }
    await Hive.box<AppNotification>(HiveBox.appNotifications).clear();

    final notificationsMap = <String, AppNotification>{};

    for (final notification in notifications) {
      notificationsMap[notification.id] = notification;
    }
    await Hive.box<AppNotification>(HiveBox.appNotifications)
        .putAll(notificationsMap);
  }

  static Future<void> deleteFavouritePlaces() async {
    await Hive.box<FavouritePlace>(HiveBox.favouritePlaces).clear();
  }

  static List<FavouritePlace> getFavouritePlaces() {
    return Hive.box<FavouritePlace>(HiveBox.favouritePlaces).values.toList();
  }

  static Future<void> deleteAnalytics() async {
    await Hive.box<Analytics>(HiveBox.analytics).clear();
  }

  static List<Analytics> getAnalytics() {
    return Hive.box<Analytics>(HiveBox.analytics).values.toList();
  }

  static List<Kya> getKya() {
    return Hive.box<Kya>(HiveBox.kya).values.toList();
  }

  static List<AppNotification> getNotifications() {
    return Hive.box<AppNotification>(
      HiveBox.appNotifications,
    ).values.toList();
  }

  static Future<void> loadKya(List<Kya> kyaList) async {
    if (kyaList.isEmpty) {
      return;
    }

    final currentKya = Hive.box<Kya>(HiveBox.kya).values.toList();
    final kyaMap = <String, Kya>{};
    for (final x in kyaList) {
      if (x.shareLink.isEmpty) {
        Kya kya =
            currentKya.firstWhere((element) => element.id == x.id, orElse: () {
          return x;
        });
        kyaMap[x.id] = x.copyWith(shareLink: kya.shareLink);
      } else {
        kyaMap[x.id] = x;
      }
    }

    await Hive.box<Kya>(HiveBox.kya).clear();
    await Hive.box<Kya>(HiveBox.kya).putAll(kyaMap);

    kyaMap.forEach((_, value) {
      CacheService.cacheKyaImages(value);
    });
  }

  static Future<void> loadProfile(Profile profile) async {
    await Hive.box<Profile>(HiveBox.profile).put(HiveBox.profile, profile);
  }

  static Future<void> loadFavouritePlaces(
    List<FavouritePlace> favouritePlaces,
  ) async {
    if (favouritePlaces.isEmpty) {
      return;
    }
    await Hive.box<FavouritePlace>(HiveBox.favouritePlaces).clear();

    final favouritePlacesMap = <String, FavouritePlace>{};

    for (final favouritePlace in favouritePlaces) {
      favouritePlacesMap[favouritePlace.placeId] = favouritePlace;
    }

    await Hive.box<FavouritePlace>(HiveBox.favouritePlaces)
        .putAll(favouritePlacesMap)
        .then((value) => CloudStore.updateFavouritePlaces());
  }

  static Future<void> loadAnalytics(List<Analytics> analytics) async {
    if (analytics.isEmpty) {
      return;
    }
    await Hive.box<Analytics>(HiveBox.analytics).clear();

    final analyticsMap = <String, Analytics>{};

    for (final analytic in analytics) {
      analyticsMap[analytic.site] = analytic;
    }

    await Hive.box<Analytics>(HiveBox.analytics).putAll(analyticsMap);
  }
}

class HiveBox {
  static String get appNotifications => 'appNotifications';
  static String get searchHistory => 'searchHistory';
  static String get kya => 'kya-v1';
  static String get profile => 'profile';
  static String get encryptionKey => 'hiveEncryptionKey';
  static String get analytics => 'analytics';
  static String get airQualityReadings => 'airQualityReadings-v1';
  static String get nearByAirQualityReadings => 'nearByAirQualityReading-v1';
  static String get favouritePlaces => 'favouritePlaces';
}
