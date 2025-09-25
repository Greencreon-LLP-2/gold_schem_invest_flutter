import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rajakumari_scheme/features/phonepe/models/local_payment.dart';

class PaymentCacheService {
  static const String _pendingPaymentsKey = 'pending_payments';
  static const String _completedPaymentsKey = 'completed_payments';
  static const String _boxName = 'Rajakumari';

  /// Initialize Hive box (call this once at app startup)
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  /// Store a pending payment
  static Future<void> storePendingPayment(LocalPayment payment) async {
    final box = Hive.box(_boxName);
    final existing = await _getPaymentsList(box, _pendingPaymentsKey);
    existing.add(payment.toJson());
    await _savePaymentsList(box, _pendingPaymentsKey, existing);
  }

  /// Move a payment from pending to completed
  static Future<void> markPaymentAsCompleted(String paymentId) async {
    final box = Hive.box(_boxName);

    // Get pending payments
    final pending = await _getPaymentsList(box, _pendingPaymentsKey);
    final completed = await _getPaymentsList(box, _completedPaymentsKey);

    // Find and move the payment
    final paymentIndex = pending.indexWhere((p) => p['paymentId'] == paymentId);
    if (paymentIndex != -1) {
      completed.add(pending[paymentIndex]);
      pending.removeAt(paymentIndex);

      // Save both lists
      await _savePaymentsList(box, _pendingPaymentsKey, pending);
      await _savePaymentsList(box, _completedPaymentsKey, completed);
    }
  }

  static Future<List<LocalPayment>> getPendingPayments() async {
    try {
      final box = Hive.box(_boxName);
      final String data = box.get(_pendingPaymentsKey, defaultValue: '[]');
      final List<dynamic> jsonList = json.decode(data);

      return jsonList
          .map((item) {
            try {
              return LocalPayment.fromJson(item as Map<String, dynamic>);
            } catch (e) {
            
              return null;
            }
          })
          .whereType<LocalPayment>()
          .toList();
    } catch (e) {
    
      return [];
    }
  }

  static Future<List<LocalPayment>> getCompletedPayments() async {
    try {
      final box = Hive.box(_boxName);
      final String data = box.get(_completedPaymentsKey, defaultValue: '[]');
      final List<dynamic> jsonList = json.decode(data);

      return jsonList
          .map((item) {
            try {
              return LocalPayment.fromJson(item as Map<String, dynamic>);
            } catch (e) {
           
              return null;
            }
          })
          .whereType<LocalPayment>()
          .toList();
    } catch (e) {
     
      return [];
    }
  }

  static Future<bool> removePayment(String paymentId) async {
    try {
      final box = Hive.box(_boxName);
      bool removed = false;

      // Remove from pending payments
      var pending = await _getPaymentsList(box, _pendingPaymentsKey);
      final newPending =
          pending.where((p) => p['paymentId'] != paymentId).toList();
      if (newPending.length != pending.length) {
        removed = true;
        await _savePaymentsList(box, _pendingPaymentsKey, newPending);
      }

      // Remove from completed payments
      var completed = await _getPaymentsList(box, _completedPaymentsKey);
      final newCompleted =
          completed.where((p) => p['paymentId'] != paymentId).toList();
      if (newCompleted.length != completed.length) {
        removed = true;
        await _savePaymentsList(box, _completedPaymentsKey, newCompleted);
      }

      return removed; // true if removed from either list
    } catch (e) {
    
      return false;
    }
  }

  // Helper methods
  static Future<List<Map<String, dynamic>>> _getPaymentsList(
    Box box,
    String key,
  ) async {
    final String data = box.get(key, defaultValue: '[]');
    try {
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.cast<Map<String, dynamic>>();
    } catch (e) {
      // If corrupted data, reset to empty list
      await box.put(key, '[]');
      return [];
    }
  }

  static Future<void> _savePaymentsList(
    Box box,
    String key,
    List<Map<String, dynamic>> payments,
  ) async {
    await box.put(key, json.encode(payments));
  }
}
