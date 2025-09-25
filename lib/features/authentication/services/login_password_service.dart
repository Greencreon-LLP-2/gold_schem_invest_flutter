import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:rajakumari_scheme/core/global_widgets/custom_alert_box.dart';
import 'package:rajakumari_scheme/core/services/shared_pref_service.dart';
import 'package:rajakumari_scheme/features/home/view/pages/main_scaffold.dart';

class LoginPasswordService {
  /// Login with password
  Future<bool> loginWithPassword({
    required String mobileCode,
    required String mobile,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final url =
          '${ApiSecrets.baseUrl}/login-password.php?token=${ApiSecrets.token}&mobile_code=$mobileCode&mobile=$mobile&password=$password';

      final response = await http.get(
        Uri.parse(url),
        headers: {'x-app-version': AppConfig.appVersion},
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == 'true') {
          final data = jsonResponse['data'];

          if (data is String) {
            if (context.mounted) {
              showGlassAlert(context, data, AlertStatus.warning);
            }
            return false;
          }

          if (data is Map && data.isNotEmpty) {
            final userData = data;

            try {
              final success = await SharedPrefService.saveUserData(
                Map<String, dynamic>.from(userData),
              );
              if (!success && context.mounted) {
                showGlassAlert(
                  context,
                  'Failed to save user data.',
                  AlertStatus.warning,
                );
              }
            } catch (e) {
              if (context.mounted) {
                showGlassAlert(
                  context,
                  'Error saving user data: $e',
                  AlertStatus.error,
                );
              }
              // Proceed even if saving user data fails
            }
            return true;
          }

          if (context.mounted) {
            showGlassAlert(
              context,
              'Unexpected response format.',
              AlertStatus.error,
            );
          }
          return false;
        } else {
          if (context.mounted) {
            final message = jsonResponse['data']?.toString() ?? 'Login failed.';
            showGlassAlert(context, message, AlertStatus.error);
          }
          return false;
        }
      } else if (response.statusCode == 426 && context.mounted) {
        final message =
            jsonResponse['data']?.toString() ??
            "Please update your app to the latest version. this version is outdated";
        if (context.mounted) {
          showGlassAlert(context, message, AlertStatus.error);
        }
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScaffold()),
          );
        });

        return false;
      } else {
        final message =
            jsonResponse['data']?.toString() ??
            'Login failed. Please try again.';
        if (context.mounted) {
          showGlassAlert(context, message, AlertStatus.error);
        }
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        showGlassAlert(
          context,
          'Login failed. Check your internet connection.',
          AlertStatus.error,
        );
      }
      return false;
    }
  }
}
