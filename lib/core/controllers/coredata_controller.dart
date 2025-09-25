import 'package:rajakumari_scheme/core/models/coredata_model.dart';
import 'package:rajakumari_scheme/core/services/coredata_service.dart';

class CoreDataController {
  final CoreDataService _coreDataService = CoreDataService();

  Future<CoreDataResponse> getCoreData() async {
    return await _coreDataService.getCoreData();
  }

  String getFullLogoUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;

    final path = imagePath.startsWith('/')
        ? imagePath.substring(1)
        : imagePath;
    return 'https://rajakumarischeme.com/admin/$path';
  }
}
