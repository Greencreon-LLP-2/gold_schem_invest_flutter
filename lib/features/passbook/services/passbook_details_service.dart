import 'dart:convert';
import 'dart:developer';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/features/passbook/models/passbook_details_model.dart';

class PassbookDetailsService {
  Future<List<PassbookDetailsModel>> getPassbookDetails(
    String passbookId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiSecrets.baseUrl}/passbook-details.php?token=${ApiSecrets.token}&passbook_id=$passbookId',
        ),
        headers: {'x-app-version': AppConfig.appVersion},
      );
    
      log('Passbook Details API Response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'true') {
          if (jsonResponse['data'] is List) {
            final List<dynamic> data = jsonResponse['data'];
            return data
                .map((item) => PassbookDetailsModel.fromJson(item))
                .toList();
          } else if (jsonResponse['data'] is String) {
            // Handle case where data is a string message
            if (jsonResponse['data'].toString().contains(
              "didn't join any scheme",
            )) {
              return [];
            }
            throw Exception(jsonResponse['data']);
          }
        }
        throw Exception('Failed to load passbook details');
      } else {
        throw Exception('Failed to load passbook details');
      }
    } catch (e) {
      throw Exception('Failed to load passbook details: $e');
    }
  }
}
