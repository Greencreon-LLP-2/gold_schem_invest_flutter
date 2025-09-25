import 'dart:convert';
import 'dart:developer';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';

class InvestMoreService {
  InvestMoreService();

  Future<Map<String, dynamic>> makeInvestment({
    required String userId,
    required String schemeId,
    required String passbookId,
    required String investAmount,
    required String paymentId,
    required String gateway,
  }) async {
    try {
      if (userId.isEmpty ||
          schemeId.isEmpty ||
          passbookId.isEmpty ||
          investAmount.isEmpty ||
          paymentId.isEmpty ||
          gateway.isEmpty) {
        throw Exception('All investment parameters are required');
      }

      final url =
          "${ApiSecrets.baseUrl}/passbook-investment.php?token=${ApiSecrets.token}&user_id=$userId&scheme_id=$schemeId&passbook_id=$passbookId&invest_amount=$investAmount&payment_id=$paymentId&gateway=$gateway";
       final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );
      log('Investment API URL: $url');
      log('Investment API Response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'true') {
          return {
            'success': true,
            'message':
                jsonResponse['data'] ??
                'Investment Payment Completed Successfully',
            'data': jsonResponse['data'],
          };
        } else {
          throw Exception(jsonResponse['data'] ?? 'Investment payment failed');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on FormatException {
      throw Exception('Invalid response format from server');
    } on http.ClientException {
      throw Exception('Network error: Please check your internet connection');
    } catch (e) {
      log('Investment payment error: $e');
      throw Exception('Failed to process investment payment: ${e.toString()}');
    }
  }
}
