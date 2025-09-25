import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  static String appVersion = '';
  static String buildNumber = '';
  static Future<void> initAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    appVersion = info.version.toString(); // e.g., "2.0.1"
    buildNumber = info.buildNumber.toString(); // e.g., "2"
  }

  static const String applicationId = 'com.greencreon.rajakumarischeme';
}
