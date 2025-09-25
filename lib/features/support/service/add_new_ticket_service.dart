// features/support/service/add_new_ticket_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';

class AddTicketService {
  Future<bool> addTicket({
    required String userId,
    required String mobile,
    required String subject,
    required String message,
  }) async {
    final String url =
        "${ApiSecrets.baseUrl}/add-ticket.php?token=${ApiSecrets.token}&user_id=$userId&mobile=$mobile&subject=$subject&msg=$message";

    try {
      log(url);
       final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Check the status and data field
        if (data['status'] == 'true' &&
            data['data'] == "Please provide valid data") {
          return false; // Invalid data
        }
        return true; // Valid data
      } else {
        throw Exception('Failed to add ticket: ${response.statusCode}');
      }
    } catch (e) {
      return false;
    }
  }
}
