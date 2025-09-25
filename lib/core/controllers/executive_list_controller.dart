import '../models/executive_model.dart';
import '../services/executive_list_service.dart';

class ExecutiveListController {
  static final ExecutiveListController _instance =
      ExecutiveListController._internal();
  factory ExecutiveListController() => _instance;
  ExecutiveListController._internal();

  final ExecutiveListService _executiveListService = ExecutiveListService();
  List<ExecutiveModel> _executiveList = [];
  bool _isLoading = false;

  List<ExecutiveModel> get executiveList => _executiveList;
  bool get isLoading => _isLoading;

  Future<void> fetchExecutiveList() async {
    try {
      _isLoading = true;
      _executiveList = await _executiveListService.getExecutiveList();
    } finally {
      _isLoading = false;
    }
  }

  ExecutiveModel? getExecutiveById(String id) {
    try {
      return _executiveList.firstWhere((executive) => executive.userId == id);
    } catch (e) {
      return null;
    }
  }

  // List<ExecutiveModel> getExecutivesByStoreId(String storeId) {
  //   return _executiveList
  //       .where((executive) => executive.storeId == storeId)
  //       .toList();
  // }
}
