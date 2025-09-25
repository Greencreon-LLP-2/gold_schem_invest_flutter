import 'package:flutter/material.dart';
import 'package:rajakumari_scheme/features/gold_scheme/services/invest_in_scheme_service.dart';

class InvestInSchemeController extends ChangeNotifier {
  final InvestInSchemeService _service = InvestInSchemeService();

  // State variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<bool> joinScheme({
    required String userId,
    required String schemeId,
    required String amount,
    required String paymentId,
    required String gateway,
    required String passbookName,
    required String passbookAddress,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _service.joinScheme(
        userId: userId,
        schemeId: schemeId,
        amount: amount,
        paymentId: paymentId,
        gateway: gateway,
        passbookName: passbookName,
        passbookAddress: passbookAddress,
      );

      // Check for exact success response format
      if (response['status'] == 'true' &&
          response['data'] == 'Payment Completed Successfully' &&
          response['code'] == '0') {
        return true;
      } else {
        _error = response['data'] ?? 'Failed to join scheme';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
