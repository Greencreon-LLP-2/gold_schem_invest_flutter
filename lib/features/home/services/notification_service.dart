import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:rajakumari_scheme/features/home/models/notification_model.dart';

class NotificationService {
  Future<List<NotificationData>> fetchNotifications(String userId) async {
    final url =
        '${ApiSecrets.baseUrl}/notification.php?token=${ApiSecrets.token}&user_id=$userId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-app-version': AppConfig.appVersion},
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final res = NotificationResponse.fromJson(decoded);

        if (res.status && res.data.isNotEmpty) {
          return res.data;
        } else {
          return [];
        }
      } else {
        throw Exception("Failed to load notifications: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching notifications: $e");
    }
  }
}
