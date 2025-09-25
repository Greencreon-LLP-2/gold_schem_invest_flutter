import 'dart:convert';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/features/home/models/banner_model.dart';

class BannerService {
  /// Fetches banner data from the API
  ///
  /// Returns a [BannerResponse] object containing the banner data
  /// Throws an exception if the API call fails
  Future<BannerResponse> getBanners() async {
    try {
      final url = '${ApiSecrets.baseUrl}/banner.php?token=${ApiSecrets.token}';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return BannerResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load banners: $e');
    }
  }
}
