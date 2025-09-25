import 'package:rajakumari_scheme/features/gold_scheme/models/scheme_model.dart';
import 'package:rajakumari_scheme/features/gold_scheme/services/scheme_list_service.dart';

class SchemeListController {
  final SchemeListService _schemeListService = SchemeListService();

  /// Fetches scheme list data from the service
  Future<SchemeResponse> getSchemeList() async {
    return await _schemeListService.getSchemeList();
  }

  /// Get the full image URL for a scheme image
  String getFullImageUrl(String imagePath) {
    return _schemeListService.getFullImageUrl(imagePath);
  }
}
