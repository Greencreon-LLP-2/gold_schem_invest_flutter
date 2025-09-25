import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:rajakumari_scheme/core/models/coredata_model.dart';
import 'package:rajakumari_scheme/core/models/user_details.dart';
import 'package:rajakumari_scheme/core/services/coredata_service.dart';
import 'package:rajakumari_scheme/core/services/shared_pref_service.dart';
import 'package:rajakumari_scheme/core/services/user_details_service.dart';

// A singleton service to manage authentication state across the app
class AuthStateService extends ChangeNotifier {
  Timer? _refreshTimer;

  // Singleton instance
  static final AuthStateService _instance = AuthStateService._internal();

  // Factory constructor
  factory AuthStateService() => _instance;

  // Private constructor
  AuthStateService._internal() {
    // Initialize state from SharedPreferences
    _initializeAuthState();
    _refreshTimer = Timer.periodic(Duration(minutes: 1), (_) {
      refreshAuthState();
    });
  }
  void disposeService() {
    _refreshTimer?.cancel();
  }

  // Initialize auth state from SharedPreferences
  Future<void> _initializeAuthState() async {
    try {
      _isLoggedIn = SharedPrefService.getUserLoggedStatus();
      _userName = SharedPrefService.getUserName();
      _userProfileImage = SharedPrefService.getUserProfileImage();
      _userId = SharedPrefService.getUserId();
    } catch (e) {
      // Set safe defaults
      _isLoggedIn = false;
      _userName = '';
      _userProfileImage = '';
      _userId = '';
    }
  }

  // Authentication state
  bool _isLoggedIn = false;
  String _userName = '';
  String _userProfileImage = '';
  String _userId = '';
  String _error = '';

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userProfileImage => _userProfileImage;
  String get userId => _userId;
  String get erorr => _error;
  final userDetailsService = UserDetailsService();
  final coreDataService = CoreDataService();
  UserDetails? _userData;
  CoreDataResponse? _coreData;

  // Refresh the auth state from SharedPreferences
  Future<void> refreshAuthState() async {
    _isLoggedIn = SharedPrefService.getUserLoggedStatus();
    _userName = SharedPrefService.getUserName();
    _userProfileImage = SharedPrefService.getUserProfileImage();
    _userId = SharedPrefService.getUserId();

    try {
      if (_isLoggedIn && _userId.isNotEmpty) {
        _userData = await userDetailsService.getUserDetails(_userId);
        _coreData = await coreDataService.getCoreData();

        // Re-fetch again just to sync any updates
        _isLoggedIn = SharedPrefService.getUserLoggedStatus();
        _userName = SharedPrefService.getUserName();
        _userProfileImage = SharedPrefService.getUserProfileImage();
        _userId = SharedPrefService.getUserId();
      } else {
        await logout();
      }
    } catch (e) {
      _isLoggedIn = false;
      _userName = '';
      _userProfileImage = '';
      _userId = '';
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }

 
  // Check login status and update if needed
  Future<void> checkAuthState() async {
    await refreshAuthState();
  }

  // Login the user (this would typically be called after successful login)
  Future<void> setLoggedIn() async {
    await SharedPrefService.setUserLoggedStatus(true);
  }

  // Logout the user
  Future<bool> logout() async {
    try {
      final userId = _userId;

      final url =
          '${ApiSecrets.baseUrl}/logout.php?token=${ApiSecrets.token}&user_id=$userId';

      await http.get(
        Uri.parse(url),
        headers: {'x-app-version': AppConfig.appVersion},
      );

      await SharedPrefService.clearUserData();
      _isLoggedIn = false;
      _userName = '';
      _userProfileImage = '';
      _userId = '';

      return false;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }
}
