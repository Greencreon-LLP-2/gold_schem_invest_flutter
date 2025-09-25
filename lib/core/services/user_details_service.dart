import 'dart:convert';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/models/user_details.dart';
import 'package:rajakumari_scheme/core/services/shared_pref_service.dart';

class UserDetailsService {
  UserDetailsService();

  Future<UserDetails> getUserDetails(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiSecrets.baseUrl}/user-details.php?token=${ApiSecrets.token}&user_id=$userId',
        ),
        headers: {'x-app-version': AppConfig.appVersion},
      );
      
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['status'] == 'true') {
          final userDetails = UserDetails.fromJson(jsonResponse['data'][0][0]);
          SharedPrefService.saveUserData(jsonResponse['data'][0][0]);
          return userDetails;
        } else {
          throw Exception(jsonResponse['data']);
        }
      } else {
        throw Exception(jsonResponse['data']);
      }
    } catch (e,stack) {
      // SharedPrefService.clearUserData();
      print(stack);
      throw Exception(
        'Error fetching user details . check your internet connection',
      );
    }
  }
}
