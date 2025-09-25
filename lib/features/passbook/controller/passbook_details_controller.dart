import 'package:flutter/foundation.dart';
import 'package:rajakumari_scheme/features/passbook/models/passbook_details_model.dart';
import 'package:rajakumari_scheme/features/passbook/services/passbook_details_service.dart';

class PassbookDetailsController extends ChangeNotifier {
  final PassbookDetailsService _service = PassbookDetailsService();

  List<PassbookDetailsModel> _passbookDetails = [];
  bool _isLoading = false;
  String? _error;

  List<PassbookDetailsModel> get passbookDetails => _passbookDetails;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPassbookDetails(String passbookId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _passbookDetails = await _service.getPassbookDetails(passbookId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _passbookDetails = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Helper methods for UI
  double get totalInvestment {
    return _passbookDetails.fold(
      0,
      (sum, item) => sum + double.parse(item.amount),
    );
  }

  int get totalPayments {
    return _passbookDetails.where((item) => item.status == '1').length;
  }

  int get remainingPayments {
    return _passbookDetails.where((item) => item.status == '0').length;
  }

  String get passbookNumber {
    return _passbookDetails.isNotEmpty ? _passbookDetails.first.passbookNo : '';
  }

  String get startDate {
    return _passbookDetails.isNotEmpty
        ? _passbookDetails.first.paymentDate
        : '';
  }

  String get endDate {
    return _passbookDetails.isNotEmpty ? _passbookDetails.last.paymentDate : '';
  }
}
