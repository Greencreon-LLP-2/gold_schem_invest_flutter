import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  static String? _packageName;
  static String? _version;
  static String? _buildNumber;

  static Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _packageName = packageInfo.packageName;
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
  }

  static String get packageName => _packageName ?? '';
  static String get version => _version ?? '';
  static String get buildNumber => _buildNumber ?? '';
}
