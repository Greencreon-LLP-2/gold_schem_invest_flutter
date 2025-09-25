import '../models/zone_model.dart';
import '../services/zone_list_service.dart';

class ZoneListController {
  static final ZoneListController _instance = ZoneListController._internal();
  factory ZoneListController() => _instance;
  ZoneListController._internal();

  final ZoneListService _zoneListService = ZoneListService();
  List<ZoneModel> _zoneList = [];
  bool _isLoading = false;

  List<ZoneModel> get zoneList => _zoneList;
  bool get isLoading => _isLoading;

  Future<void> fetchZoneList() async {
    try {
      _isLoading = true;
      _zoneList = await _zoneListService.getZoneList();
    } finally {
      _isLoading = false;
    }
  }

  ZoneModel? getZoneById(String id) {
    try {
      return _zoneList.firstWhere((zone) => zone.id == id);
    } catch (e) {
      return null;
    }
  }
}
