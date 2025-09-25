import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:rajakumari_scheme/core/config/app_config.dart';
class ProfileDeleteService {
  final String baseUrl;
  final String token;

  ProfileDeleteService({required this.baseUrl, required this.token});

  Future<bool> deleteProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/delete-request.php?token=$token&user_id=$userId"),
         headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['status'] == 'true';
      }

      return false;
    } catch (e) {
    
      return false;
    }
  }
}
