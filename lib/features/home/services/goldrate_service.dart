import 'dart:convert';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';

import '../models/gold_rate_model.dart';

class GoldRateService {
  Future<GoldRateResponse> getGoldRate() async {
    try {
      final url =
          '${ApiSecrets.baseUrl}/today-goldrate.php?token=${ApiSecrets.token}';

       final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return GoldRateResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load gold rate data: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching gold rate: $e');
    }
  }
}
