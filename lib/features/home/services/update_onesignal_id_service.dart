import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';

class UpdateOneSignalIdService {
  Future<bool> updateOneSignalId({
    required String userId,
    required String playerId,
    required String externalIid,
  }) async {
    try {
      log('userId: $userId');
      log('playerId: $playerId');

      final response = await http.get(
        Uri.parse(
          '${ApiSecrets.baseUrl}/onesignal-playerid.php?token=${ApiSecrets.token}&user_id=$userId&playerid=$playerId&external_id=$externalIid',
        ),
         headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );
      log('response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['status'] == 'true';
      } else {
        throw Exception('Failed to update OneSignal ID');
      }
    } catch (e) {
      throw Exception('Error updating OneSignal ID please try again later');
    }
  }
}
