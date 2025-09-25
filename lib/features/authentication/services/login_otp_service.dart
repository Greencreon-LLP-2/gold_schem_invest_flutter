import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/services/shared_pref_service.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:rajakumari_scheme/core/global_widgets/custom_alert_box.dart';

class LoginOtpService {
  /// Sends OTP to the specified mobile number
  ///
  /// Returns true if OTP was sent successfully, false otherwise
  Future<String> sendOtp({
    required String mobileCode,
    required String mobile,
    required String otp,
    required BuildContext context,
  }) async {
    try {
      final url =
          '${ApiSecrets.baseUrl}/otp-send.php?token=${ApiSecrets.token}&mobile_code=$mobileCode&mobile=$mobile&otp=$otp';

      final response = await http.get(
        Uri.parse(url),
        headers: {'x-app-version': AppConfig.appVersion},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        final status = jsonResponse['status'];
        final code = jsonResponse['code'];

        if (status == 'true' && code == '0') {
          return 'otp_sent';
        } else if (status == 'false' && code == '3') {
          await SharedPrefService.saveUserData(
            Map<String, dynamic>.from(jsonResponse['user_data']),
          );
          return 'user_exists';
        } else {
          if (context.mounted) {
            showGlassAlert(
              context,
              'Failed to send OTP. Try again.',
              AlertStatus.warning,
            );
          }
          return 'failed';
        }
      } else if (response.statusCode == 426) {
        if (context.mounted) {
          showGlassAlert(
            context,
            "Please update your app to the latest version. this version is outdated",
            AlertStatus.error,
          );
        }
        return 'outdatedapp';
      } else {
        if (context.mounted) {
          showGlassAlert(
            context,
            'Server error while sending OTP.',
            AlertStatus.error,
          );
        }
        return 'failed';
      }
    } catch (e) {
      if (context.mounted) {
        showGlassAlert(
          context,
          'Failed to send OTP. Check your internet connection.',
          AlertStatus.error,
        );
      }
      return 'failed';
    }
  }

  /// Checks if the user exists and saves user data locally if valid
  Future<bool> checkUserExsist({
    required String mobileCode,
    required String mobile,
    required BuildContext context,
  }) async {
    try {
      final url =
          '${ApiSecrets.baseUrl}/login.php?token=${ApiSecrets.token}&mobile_code=$mobileCode&mobile=$mobile';

      final response = await http.get(
        Uri.parse(url),
        headers: {'x-app-version': AppConfig.appVersion},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'true' &&
            jsonResponse['data'] != "No user found") {
          final data = jsonResponse['data'];

          if (data is List && data.isNotEmpty) {
            final userData = data[0];

            try {
              final saved = await SharedPrefService.saveUserData(userData);
              if (!saved && context.mounted) {
                showGlassAlert(
                  context,
                  'Failed to save user data',
                  AlertStatus.warning,
                );
              }
            } catch (e) {
              if (context.mounted) {
                showGlassAlert(
                  context,
                  'Failed to save user data: $e',
                  AlertStatus.error,
                );
              }
            }
          }
          return true;
        }
      }

      return false;
    } catch (e) {
      if (context.mounted) {
        showGlassAlert(
          context,
          'Verification failed. Check your internet connection.',
          AlertStatus.error,
        );
      }
      return false;
    }
  }
}
