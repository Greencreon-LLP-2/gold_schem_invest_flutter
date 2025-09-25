import 'dart:convert';
import 'dart:developer';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';

class InvestInSchemeService {
  Future<Map<String, dynamic>> joinScheme({
    required String userId,
    required String schemeId,
    required String amount,
    required String paymentId,
    required String gateway,
    required String passbookName,
    required String passbookAddress,
  }) async {
    try {
      final url =
          "${ApiSecrets.baseUrl}/join-scheme.php?token=${ApiSecrets.token}&user_id=$userId&scheme_id=$schemeId&amount=$amount&payment_id=$paymentId&gateway=$gateway&passbook_name=$passbookName&passbook_address=$passbookAddress";

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
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to join scheme: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Error joining scheme: $e');
    }
  }
}
