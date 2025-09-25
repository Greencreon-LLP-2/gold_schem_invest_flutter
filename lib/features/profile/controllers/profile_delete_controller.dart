import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';
import 'package:rajakumari_scheme/features/profile/services/profile_delete_service.dart';

class ProfileDeleteController {
  final ProfileDeleteService _deleteService = ProfileDeleteService(
    baseUrl: ApiSecrets.baseUrl2,
    token: ApiSecrets.token,
  );

  Future<void> deleteProfile(BuildContext context,String userId) async {
    try {
      final bool isDeleted = await _deleteService.deleteProfile(userId);

      if (!context.mounted) return;

      if (isDeleted) {
        // Show success message
        Fluttertoast.showToast(
          msg: 'Profile deletion request sent successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
        );
        // Logout after successful deletion
        await AuthStateService().logout();
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send profile deletion request'),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      Fluttertoast.showToast(
        msg: 'Failed to send profile deletion request',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
      );
    }
  }
}
