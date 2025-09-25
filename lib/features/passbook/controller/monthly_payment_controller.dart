import 'package:flutter/foundation.dart';
import 'package:rajakumari_scheme/features/passbook/services/monthly_payment_service.dart';

class MonthlyPaymentController extends ChangeNotifier {
  final MonthlyPaymentService _monthlyPaymentService;
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _paymentResponse;

  MonthlyPaymentController(this._monthlyPaymentService);

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get paymentResponse => _paymentResponse;

  Future<bool> processMonthlyPayment({
    required String userId,
    required String monthlyPaymentId,
    required String uniqId,
    required String amount,
    required String paymentId,
    required String gateway,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _monthlyPaymentService.makeMonthlyPayment(
        userId: userId,
        monthlyPaymentId: monthlyPaymentId,
        uniqId: uniqId,
        amount: amount,
        paymentId: paymentId,
        gateway: gateway,
      );

      _paymentResponse = response;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _error = null;
    _paymentResponse = null;
    notifyListeners();
  }
}
