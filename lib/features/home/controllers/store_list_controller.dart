import 'package:flutter/material.dart';
import 'package:rajakumari_scheme/features/home/models/store_model.dart';
import 'package:rajakumari_scheme/features/home/services/store_list_service.dart';

class StoreListController {
  final StoreListService _storeListService = StoreListService();

  /// Fetches store list data from the service
  Future<StoreResponse> getStoreList(BuildContext context) async {
    return await _storeListService.getStoreList(context);
  }

  /// Get the full image URL for a store image
  String getFullImageUrl(String imagePath) {
    return _storeListService.getFullImageUrl(imagePath);
  }
}
