import 'package:flutter/foundation.dart';
import 'package:rajakumari_scheme/features/passbook/services/invest_more_service.dart';

class InvestMoreController extends ChangeNotifier {
  final InvestMoreService _investMoreService;
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _investmentResponse;

  InvestMoreController(this._investMoreService);

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get investmentResponse => _investmentResponse;

  Future<bool> processInvestment({
    required String userId,
    required String schemeId,
    required String passbookId,
    required String investAmount,
    required String paymentId,
    required String gateway,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _investMoreService.makeInvestment(
        userId: userId,
        schemeId: schemeId,
        passbookId: passbookId,
        investAmount: investAmount,
        paymentId: paymentId,
        gateway: gateway,
      );

      _investmentResponse = response;
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
    _investmentResponse = null;
    notifyListeners();
  }
}
