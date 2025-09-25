import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/features/support/service/support_ticket_list.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
class TicketService {
  Future<List<TicketModel>> fetchOpenTickets(String userId) async {
    final String url =
        "${ApiSecrets.baseUrl}/support-ticket-list.php?token=${ApiSecrets.token}&user_id=$userId";

    try {
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
        if (data['status'] == 'true') {
          List<TicketModel> tickets = [];
          for (var item in data['data']) {
            if (item is Map<String, dynamic>) {
              tickets.add(TicketModel.fromJson(item));
            }
          }
          log(tickets.toString());
          return tickets;
        }
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      print('Error fetching tickets: $e');
    }
    return [];
  }
}
