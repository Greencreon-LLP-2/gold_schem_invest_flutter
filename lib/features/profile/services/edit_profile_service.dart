import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/global_widgets/custom_alert_box.dart';
import 'package:rajakumari_scheme/core/services/shared_pref_service.dart';

class EditProfileService {
  Future<bool> updateProfile({
    required BuildContext context,
    required String token,
    required String name,
    required String mobileCode,
    required String mobile,
    required String email,
    required String password,
    required String storeId,
    required String executiveId,
    required String address1,
    required String address2,
    required String district,
    required String pincode,
    required String state,
    required String landmark,
    required String zoneId,
    required String panNo,
    required String panImage,
    required String aadharNo,
    required String aadharImage,
    required String nomineeName,
    required String nomineeRelationship,
    required String nomineeAddress,
    required String userId,
  }) async {
    try {
      final url = Uri.parse(
        '${ApiSecrets.baseUrl}/profile-update.php?token=$token'
        '&name=$name&mobile_code=$mobileCode&mobile=$mobile'
        '&email=$email&password=$password&store_id=$storeId'
        '&executive_id=$executiveId&address_1=$address1&address_2=$address2'
        '&district=$district&pincode=$pincode&state=$state'
        '&landmark=$landmark&zone_id=$zoneId'
        '&pan_no=$panNo&pan_image=$panImage'
        '&aadhar_no=$aadharNo&aadhar_image=$aadharImage'
        '&nominee_name=$nomineeName&nominee_relationship=$nomineeRelationship'
        '&nominee_address=$nomineeAddress&user_id=$userId',
      );

      final response = await http.get(url);
    

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'true' && jsonResponse['data'] != null) {
          if (jsonResponse['data'] is List && jsonResponse['data'].isNotEmpty) {
            final userData = jsonResponse['data'][0];

            try {
              final success = await SharedPrefService.saveUserData(userData);
              if (success) {
     
                if (context.mounted) {
                  showGlassAlert(
                    context,
                    'Profile updated successfully',
                    AlertStatus.success,
                  );
                }
                return true;
              } else {
             
                if (context.mounted) {
                  showGlassAlert(
                    context,
                    'Failed to update profile data',
                    AlertStatus.error,
                  );
                }
                return false;
              }
            } catch (e) {
              print('Error updating user data: $e');
              if (context.mounted) {
                showGlassAlert(
                  context,
                  'Failed to update profile data',
                  AlertStatus.error,
                );
              }
              return false;
            }
          }
        }

        if (context.mounted) {
          showGlassAlert(
            context,
            jsonResponse['data']?.toString() ?? 'Profile update failed',
            AlertStatus.error,
          );
        }
        return false;
      } else {
        if (context.mounted) {
          showGlassAlert(
            context,
            'Profile update failed. Please try again.',
            AlertStatus.error,
          );
        }
        return false;
      }
    } catch (e) {
    
      if (context.mounted) {
        showGlassAlert(
          context,
          'Profile update failed. Check your internet connection.',
          AlertStatus.error,
        );
      }
      return false;
    }
  }
}
