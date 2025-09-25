// features/support/service/chat_messages_service.dart
import 'dart:convert';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';

import '../models/ticket_comment_model.dart';

class ChatMessagesService {
  Future<TicketCommentsResponse> fetchTicketComments(String ticketId) async {
    final String url =
        '${ApiSecrets.baseUrl}/ticket-comments.php?token=${ApiSecrets.token}&ticket_id=$ticketId';

    try {
       final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        return TicketCommentsResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Error fetching comments: $e');
    }
  }
}
