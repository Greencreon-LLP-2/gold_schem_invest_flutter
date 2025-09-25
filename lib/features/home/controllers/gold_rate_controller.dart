import 'package:rajakumari_scheme/features/home/models/gold_rate_model.dart';
import 'package:rajakumari_scheme/features/home/services/goldrate_service.dart';

class GoldRateController {
  final GoldRateService _goldRateService = GoldRateService();

  Future<GoldRateResponse> getGoldRate() async {
    return await _goldRateService.getGoldRate();
  }
}
