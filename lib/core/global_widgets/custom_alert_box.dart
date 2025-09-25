import 'dart:ui';
import 'package:flutter/material.dart';

enum AlertStatus { success, error, warning }

void showGlassAlert(BuildContext context, String message, AlertStatus status) {
  Color getStatusColor() {
    switch (status) {
      case AlertStatus.success:
        return Colors.greenAccent.withOpacity(0.7);
      case AlertStatus.error:
        return Colors.redAccent.withOpacity(0.7);
      case AlertStatus.warning:
        return Colors.amber.withOpacity(0.7);
    }
  }

  IconData getStatusIcon() {
    switch (status) {
      case AlertStatus.success:
        return Icons.check_circle;
      case AlertStatus.error:
        return Icons.error;
      case AlertStatus.warning:
        return Icons.warning;
    }
  }

  String getStatusTitle() {
    switch (status) {
      case AlertStatus.success:
        return 'Success';
      case AlertStatus.error:
        return 'Error';
      case AlertStatus.warning:
        return 'Warning';
    }
  }

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: getStatusColor(),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(getStatusIcon(), size: 32, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getStatusTitle(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
