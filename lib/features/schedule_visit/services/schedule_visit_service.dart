import 'dart:convert';
import 'dart:developer';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';

class ScheduleVisitService {
  Future<bool> scheduleVisit(
    String name,
    String mobileCode,
    String mobile,
    String storeId,
    String date,
    String userId,
  ) async {
    try {
      final url =
          "${ApiSecrets.baseUrl}/store-visit.php?token=${ApiSecrets.token}&name=$name&mobile_code=$mobileCode&mobile=$mobile&store_id=$storeId&date=$date&user_id=$userId";

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
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse['status'] == "true";
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
