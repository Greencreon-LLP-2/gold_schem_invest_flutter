import 'package:flutter/material.dart';
import 'package:rajakumari_scheme/core/services/auth_state_service.dart';

import '../models/passbook_model.dart';
import '../services/passbook_list_service.dart';

class PassbookListController extends ChangeNotifier {
  final PassbookListService _service;
  final AuthStateService _authStateService;

  List<PassbookModel> _passbooks = [];
  bool _isLoading = false;
  String? _error;
  bool _isRefreshing = false;

  PassbookListController(this._service, this._authStateService);

  List<PassbookModel> get passbooks => _passbooks;
  bool get isLoading => _isLoading;
  bool get isRefreshing => _isRefreshing;
  String? get error => _error;

  Future<void> fetchPassbookList() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userId = _authStateService.userId;
      if (userId.isEmpty) {
        throw Exception('User not logged in');
      }

      _passbooks = await _service.getPassbookList(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshPassbookList() async {
    try {
      _isRefreshing = true;
      _error = null;
      notifyListeners();

      final userId = _authStateService.userId;
      if (userId.isEmpty) {
        throw Exception('User not logged in');
      }

      _passbooks = await _service.getPassbookList(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isRefreshing = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
