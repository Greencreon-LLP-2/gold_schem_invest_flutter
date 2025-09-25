import 'dart:convert';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/features/gold_scheme/models/scheme_model.dart';

class SchemeListService {
  /// Fetches scheme list data from the API
  ///
  /// Returns a [SchemeResponse] object containing the scheme list data
  /// Throws an exception if the API call fails
  Future<SchemeResponse> getSchemeList() async {
    try {
      final url =
          '${ApiSecrets.baseUrl}/list-scheme.php?token=${ApiSecrets.token}';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return SchemeResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load scheme list: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load scheme list: $e');
    }
  }

  /// Get the full image URL for a scheme image
  String getFullImageUrl(String imagePath) {
    if (imagePath.isEmpty) {
      return ''; // Return empty if no image
    }

    if (imagePath.startsWith('http')) {
      return imagePath;
    }

    final path = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;
    return '${ApiSecrets.imageBaseUrl}$path';
  }
}
