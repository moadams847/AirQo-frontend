import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

class TestModel extends Equatable {
  const TestModel({
    required this.testDateTime,
    required this.testInt,
  });

  final int testInt;
  final DateTime testDateTime;

  @override
  List<Object?> get props => [testDateTime.day];
}

void main() {
  group('AppStoreVersion', () {
    test('store version should be greater than user version', () {
      const String userAppVersion = '1.0.0';

      AppStoreVersion appStoreVersion = AppStoreVersion.fromJson({
        'version': '1.0.1',
        'url': 'https://airqo.net',
      });
      expect(appStoreVersion.compareVersion(userAppVersion), 1);

      appStoreVersion = AppStoreVersion.fromJson({
        'version': '1.1.0',
        'url': 'https://airqo.net',
      });
      expect(appStoreVersion.compareVersion(userAppVersion), 1);

      appStoreVersion = AppStoreVersion.fromJson({
        'version': '2.0.0',
        'url': 'https://airqo.net',
      });
      expect(appStoreVersion.compareVersion(userAppVersion), 1);
    });

    test('store version should be lesser than user version', () {
      final AppStoreVersion appStoreVersion = AppStoreVersion.fromJson({
        'version': '1.0.0',
        'url': 'https://airqo.net',
      });

      String userAppVersion = '1.0.1';
      expect(appStoreVersion.compareVersion(userAppVersion), -1);

      userAppVersion = '1.1.0';
      expect(appStoreVersion.compareVersion(userAppVersion), -1);

      userAppVersion = '2.0.0';
      expect(appStoreVersion.compareVersion(userAppVersion), -1);
    });

    test('store version should be equal to user version', () {
      final AppStoreVersion appStoreVersion = AppStoreVersion.fromJson({
        'version': '1.0.0',
        'url': 'https://airqo.net',
      });

      const String userAppVersion = '1.0.0';
      expect(appStoreVersion.compareVersion(userAppVersion), 0);
    });
  });
}
