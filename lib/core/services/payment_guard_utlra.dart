import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';

class PaymentGuardUtlraService {
  /// Before payment submission
  Future<bool> submitPaymentBeforeData({
    required String userId,
    required String transactionId,
    required String merchantTransactionId,
    required double amount,
    required int ifJoin,
    required int schemeId,
    required int ifMonthly,
    required String userSubscriptionPaymentsId,
    required String passbookId,
    required int ifInvestment,
    required String userSubscriptionId,
  }) async {
    try {
      final url =
          '${ApiSecrets.baseUrl}/online-payment.php'
          '?token=${ApiSecrets.token}'
          '&user_id=$userId'
          '&transaction_id=$transactionId'
          '&merchant_transaction_id=$merchantTransactionId'
          '&amount=$amount'
          '&if_join=$ifJoin'
          '&scheme_id=$schemeId'
          '&if_monthly=$ifMonthly'
          '&user_subscription_payments_id=$userSubscriptionPaymentsId'
          '&passbook_id=$passbookId'
          '&if_investment=$ifInvestment'
          '&user_subscription_id=$userSubscriptionId';

      final response = await http.get(
        Uri.parse(url),
        headers: {'x-app-version': AppConfig.appVersion},
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return jsonResponse['status'] != 'false';
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// After payment update
  Future<bool> submitPaymentAfterData({
    required int userId,
    required String onlinePaymentId,
    required String merchantTransactionId,
  }) async {
    try {
      final url =
          '${ApiSecrets.baseUrl}/online_payment_update.php'
          '?token=${ApiSecrets.token}'
          '&user_id=$userId'
          '&online_payment_id=$onlinePaymentId'
          '&merchant_transaction_id=$merchantTransactionId';

      final response = await http.get(
        Uri.parse(url),
        headers: {'x-app-version': AppConfig.appVersion},
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        return jsonResponse['status'] != 'false';
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
