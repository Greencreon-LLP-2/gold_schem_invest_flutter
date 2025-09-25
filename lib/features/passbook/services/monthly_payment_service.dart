import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';


class MonthlyPaymentService {
  MonthlyPaymentService();

  Future<Map<String, dynamic>> makeMonthlyPayment({
    required String userId,
    required String monthlyPaymentId,
    required String uniqId,
    required String amount,
    required String paymentId,
    required String gateway,
  }) async {
    // Validate inputs
    if ([userId, monthlyPaymentId, uniqId, amount, paymentId, gateway]
        .any((element) => element.isEmpty)) {
      throw Exception('All payment parameters are required');
    }

    final url =
        "${ApiSecrets.baseUrl}/monthly-payment.php?token=${ApiSecrets.token}"
        "&user_id=$userId"
        "&monthliy_payment_id=$monthlyPaymentId"
        "&uniq_id=$uniqId"
        "&amount=$amount"
        "&payment_id=$paymentId"
        "&gateway=$gateway";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-app-version': AppConfig.appVersion,
        },
      );

      log('Monthly Payment API URL: $url');
      log('Monthly Payment API Response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'true') {
          return {
            'success': true,
            'message': jsonResponse['message'] ?? 'Payment successful',
            'data': jsonResponse['data'],
          };
        } else {
          throw Exception(jsonResponse['message'] ?? 'Payment failed');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on FormatException {
      throw Exception('Invalid response format from server');
    } on http.ClientException {
      throw Exception('Network error: Please check your internet connection');
    } catch (e) {
      log('Monthly payment error: $e');
      throw Exception('Failed to process payment: ${e.toString()}');
    }
  }
}
