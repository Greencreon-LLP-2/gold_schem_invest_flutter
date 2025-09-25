import 'dart:convert';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/features/home/models/gold_rate_list_model.dart';

class GoldRateListService {
  /// Fetches gold rate list data from the API
  ///
  /// Returns a [GoldRateListResponse] object containing the gold rate list data
  /// Throws an exception if the API call fails
  Future<GoldRateListResponse> getGoldRateList() async {
    try {
      final url =
          '${ApiSecrets.baseUrl}/list-goldrate.php?token=${ApiSecrets.token}';

       final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return GoldRateListResponse.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to load gold rate list: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load gold rate list: $e');
    }
  }
}
