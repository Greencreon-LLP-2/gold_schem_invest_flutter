import 'dart:convert';
import 'dart:developer';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';

import '../models/passbook_model.dart';

class PassbookListService {
  PassbookListService();

  Future<List<PassbookModel>> getPassbookList(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID is required');
      }

      final response = await http.get(
        Uri.parse(
          '${ApiSecrets.baseUrl}/list-passbook.php?token=${ApiSecrets.token}&user_id=$userId',
        ),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      log('Passbook API Response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'true') {
          final data = jsonResponse['data'];

          // Handle case where data is a string message
          if (data is String) {
            if (data.contains("didn't join any scheme") ||
                data.contains("You didnt join any scheme till now")) {
              return [];
            }
            throw Exception(data);
          }

          // Handle case where data is a list
          if (data is List) {
            if (data.isEmpty) {
              return [];
            }
            return data.map((json) => PassbookModel.fromJson(json)).toList();
          }

          throw Exception('Invalid data format received from server');
        } else {
          final errorMessage =
              jsonResponse['message'] ?? 'Failed to load passbook list';
          throw Exception(errorMessage);
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on FormatException {
      throw Exception('Invalid response format from server');
    } on http.ClientException {
      throw Exception('Network error: Please check your internet connection');
    } catch (e) {
      log('Passbook list error: $e');
      // Check if the error message contains the specific text
      if (e.toString().contains("You didnt join any scheme till now")) {
        return [];
      }
      throw Exception('Failed to load passbook list: Please try again later');
    }
  }
}
