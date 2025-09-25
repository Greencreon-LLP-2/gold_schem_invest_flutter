import 'package:flutter/material.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';
import 'package:rajakumari_scheme/core/services/shared_pref_service.dart';
import 'package:rajakumari_scheme/features/authentication/services/login_otp_service.dart';

class LoginOtpController extends ChangeNotifier {
  final LoginOtpService _loginOtpService = LoginOtpService();
  final AuthStateService _authStateService = AuthStateService();

  // State variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error message
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  /// Set mobile country code
  void setMobileCode(String code) {
    notifyListeners();
  }

  /// Send OTP to the entered mobile number
  ///
  /// Returns true if OTP sent successfully, false otherwise
  Future<String> sendOtp(
    String mobile,
    String mobileCode,
    String otp,
    BuildContext context,
  ) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      final result = await _loginOtpService.sendOtp(
        context: context,
        mobileCode: mobileCode,
        mobile: mobile,
        otp: otp,
      );

      if (result == 'failed') {
        _errorMessage = 'Failed to send OTP';
      } else if (result == 'outdatedapp') {
        _errorMessage = 'Application outdated!';
      }

      return result;
    } catch (e) {
      _errorMessage = 'Error sending OTP: $e';
      return 'failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Check if user exists and save user data
  ///
  /// Returns true if user exists, false otherwise
  Future<bool> checkUserExist(
    String mobileCode,
    String mobile,
    BuildContext context,
  ) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final result = await _loginOtpService.checkUserExsist(
        context: context,
        mobileCode: mobileCode,
        mobile: mobile,
      );

      if (!result) {
        _errorMessage = 'User not found. Please register first.';
      }

      return result;
    } catch (e) {
      _errorMessage = 'Error verifying user: $e';
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
