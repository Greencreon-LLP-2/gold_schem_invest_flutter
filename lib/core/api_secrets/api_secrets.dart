class ApiSecrets {
  // static const String baseUrl = 'http://localhost/admin/api/v2';
  static const String baseUrl = 'https://goldscheme.greencreon.com/admin/api/v2';
  static const String baseUrl2 = 'https://goldscheme.greencreon.com';
  static const String token = '5cb2c9b569416b5db1604e0e12478ded';
  static const String imageBaseUrl = 'https://goldscheme.greencreon.com/admin/';

  static String _onesignalAppId = '';

  static void setOnesignalAppId(String appId) {
    _onesignalAppId = appId;
  }

  static String get onesignalAppId => _onesignalAppId;
}
