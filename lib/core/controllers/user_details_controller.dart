import 'package:rajakumari_scheme/core/services/user_details_pref_service.dart';
import 'package:rajakumari_scheme/core/services/user_details_service.dart';

import '../models/user_details.dart';

class UserDetailsController {
  static final UserDetailsController _instance =
      UserDetailsController._internal();
  factory UserDetailsController() => _instance;
  UserDetailsController._internal();

  final UserDetailsService _userDetailsService = UserDetailsService();
  UserDetails? _userDetails;
  bool _isLoading = false;

  UserDetails? get userDetails => _userDetails;
  bool get isLoading => _isLoading;

  Future<void> fetchUserDetails(String userId) async {
    try {
      _isLoading = true;

      // Try to get cached data first
      final cachedDetails = UserDetailsPrefService.getUserDetails();
      if (cachedDetails != null) {
        _userDetails = cachedDetails;
      }

      // Fetch fresh data from API
      _userDetails = await _userDetailsService.getUserDetails(userId);

      // Cache the fresh data
      if (_userDetails != null) {
        await UserDetailsPrefService.saveUserDetails(_userDetails!);
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> updateUserDetails({
    String? address1,
    String? address2,
    String? district,
    String? pincode,
    String? state,
    String? landmark,
    String? nomineeName,
    String? nomineeRelationship,
    String? nomineeAddress,
  }) async {
    try {
      _isLoading = true;

      final success = await UserDetailsPrefService.updateUserDetails(
        address1: address1,
        address2: address2,
        district: district,
        pincode: pincode,
        state: state,
        landmark: landmark,
        nomineeName: nomineeName,
        nomineeRelationship: nomineeRelationship,
        nomineeAddress: nomineeAddress,
      );

      if (success) {
        _userDetails = UserDetailsPrefService.getUserDetails();
      }
    } finally {
      _isLoading = false;
    }
  }

  void clearUserDetails() {
    _userDetails = null;
    UserDetailsPrefService.clearUserDetails();
  }

  bool hasUserDetails() {
    return UserDetailsPrefService.hasUserDetails();
  }
}
