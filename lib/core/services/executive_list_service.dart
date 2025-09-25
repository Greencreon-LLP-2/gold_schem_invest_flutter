import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import '../models/executive_model.dart';

class ExecutiveListService {
  Future<List<ExecutiveModel>> getExecutiveList() async {
    try {
      final url =
          '${ApiSecrets.baseUrl}/list-executive.php?token=${ApiSecrets.token}';
      dev.log('Fetching executives from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );
      dev.log('Response status code: ${response.statusCode}');
      dev.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'true') {
          final List<dynamic> executiveList = jsonResponse['data'];
          final executives =
              executiveList
                  .map((executive) => ExecutiveModel.fromJson(executive))
                  .toList();
          dev.log('Successfully parsed ${executives.length} executives');
          return executives;
        } else {
          throw Exception(
            'Failed to load executive list: ${jsonResponse['message']}',
          );
        }
      } else {
        throw Exception(
          'Failed to load executive list: ${response.statusCode}',
        );
      }
    } catch (e) {
      dev.log('Error in getExecutiveList: $e', error: e);
      throw Exception('Failed to load executive list: $e');
    }
  }
}
