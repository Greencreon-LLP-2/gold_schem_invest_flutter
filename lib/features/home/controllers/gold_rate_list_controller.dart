import 'package:rajakumari_scheme/features/home/models/gold_rate_list_model.dart';
import 'package:rajakumari_scheme/features/home/services/gold_rate_list_service.dart';

class GoldRateListController {
  final GoldRateListService _goldRateListService = GoldRateListService();

  /// Fetches gold rate list data from the service
  Future<GoldRateListResponse> getGoldRateList() async {
    return await _goldRateListService.getGoldRateList();
  }
}
