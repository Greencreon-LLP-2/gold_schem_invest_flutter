import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';

class TicketReplayService {
  Future<bool> sendTicketReply(
    String userid,
    String msg,
    String ticketId,
    String? image,
  ) async {
    try {
      String url =
          '${ApiSecrets.baseUrl}/ticket-reply.php?token=${ApiSecrets.token}&user_id=$userid&ticket_id=$ticketId&comment=$msg&image=$image';

      log(url);

      final response = await http.post(Uri.parse(url));

      log(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'true' &&
            responseData['data'] == 'Replay sended') {
        
          return true;
        }
      } else {
        // Handle error
      
        return false;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
