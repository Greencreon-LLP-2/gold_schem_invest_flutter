import 'package:flutter/foundation.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';

import '../services/schedule_visit_service.dart';

class ScheduleVisitController extends ChangeNotifier {
  final ScheduleVisitService _scheduleVisitService = ScheduleVisitService();
  final AuthStateService _authStateService = AuthStateService();

  bool _isLoading = false;
  String _errorMessage = '';
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  Future<void> scheduleVisit({
    required String name,
    required String mobileCode,
    required String mobile,
    required String storeId,
    required String date,
    String? userId,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = '';
      _isSuccess = false;
      notifyListeners();

      // Get userId from AuthStateService if user is logged in
      final String finalUserId =
          userId ??
          (_authStateService.isLoggedIn ? _authStateService.userId : '');

      final result = await _scheduleVisitService.scheduleVisit(
        name,
        mobileCode,
        mobile,
        storeId,
        date,
        finalUserId,
      );

      if (result) {
        _isSuccess = true;
      } else {
        _errorMessage = 'Failed to schedule visit. Please try again.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetState() {
    _isLoading = false;
    _errorMessage = '';
    _isSuccess = false;
    notifyListeners();
  }
}
