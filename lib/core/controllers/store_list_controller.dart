import 'package:flutter/foundation.dart';

import '../models/store_model.dart';
import '../services/store_list_service.dart';

class StoreListController extends ChangeNotifier {
  static final StoreListController _instance = StoreListController._internal();
  factory StoreListController() => _instance;
  StoreListController._internal();

  final StoreListService _storeListService = StoreListService();
  List<StoreModel> _storeList = [];
  bool _isLoading = false;
  String? _error;

  List<StoreModel> get storeList => _storeList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchStoreList() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _storeList = await _storeListService.getStoreList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  StoreModel? getStoreById(String id) {
    try {
      return _storeList.firstWhere((store) => store.id == id);
    } catch (e) {
      return null;
    }
  }

  StoreModel? getStoreByCode(String storeCode) {
    try {
      return _storeList.firstWhere((store) => store.storeCode == storeCode);
    } catch (e) {
      return null;
    }
  }
}
