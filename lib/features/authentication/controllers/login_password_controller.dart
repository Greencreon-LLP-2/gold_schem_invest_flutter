import 'package:flutter/material.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';
import 'package:rajakumari_scheme/core/services/shared_pref_service.dart';
import 'package:rajakumari_scheme/features/authentication/services/login_password_service.dart';

class LoginPasswordController extends ChangeNotifier {
  final LoginPasswordService _loginPasswordService = LoginPasswordService();
  final AuthStateService _authStateService = AuthStateService();

  // State variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error message
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  /// Login with password
  ///
  /// Returns true if login was successful, false otherwise
  Future<bool> loginWithPassword({
    required String mobileCode,
    required String mobile,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final result = await _loginPasswordService.loginWithPassword(
        context: context,
        mobileCode: mobileCode,
        mobile: mobile,
        password: password,
      );

      if (result) {
        // Refresh auth state after successful login
        await _authStateService.setLoggedIn();
      } else {
        _errorMessage = 'Login failed. Please check your credentials.';
      }

      return result;
    } catch (e) {
      _errorMessage = 'Error during login: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return _authStateService.isLoggedIn;
  }

  /// Get user data
  Map<String, dynamic>? getUserData() {
    return SharedPrefService.getUserData();
  }

  /// Get user name
  String getUserName() {
    return _authStateService.userName;
  }

  /// Get user profile image
  String getUserProfileImage() {
    return _authStateService.userProfileImage;
  }
}
