// core/constants/coredata/core_data_service.dart
import 'package:dio/dio.dart';
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:rajakumari_scheme/core/coredata/core_data_model.dart';

class RsCoreDataService {
  final Dio _dio;
  final String baseUrl;
  final String token;

  // Singleton pattern
  static final RsCoreDataService _instance = RsCoreDataService._internal();

  factory RsCoreDataService() {
    return _instance;
  }

  RsCoreDataService._internal()
    : _dio = Dio(),
      baseUrl = ApiSecrets.baseUrl,
      token = ApiSecrets.token;

  Future<CoreDataModel> getCoreData() async {
    try {
      final response = await _dio.get(
        '$baseUrl/coredata.php',
        queryParameters: {'token': token},
        options: Options(headers: {'x-app-version': AppConfig.appVersion}),
      );
      final data = response.data;

      if (response.statusCode == 200) {
        if (data['status'] == false) {
          throw data['data']; // Custom API error message
        }

        return CoreDataModel.fromJson(data);
      } else {
        throw Exception(data['data']);
      }
    } catch (e) {
      throw Exception('Error fetching core data: $e');
    }
  }

  // Static method for convenience
  static Future<CoreDataModel> fetchCoreData() async {
    return await RsCoreDataService().getCoreData();
  }

  // Optional: Method to clear any cached data
  void clearCache() {
    // Add cache clearing logic if needed
  }

  Future<void> updateAgoraAppId() async {
    try {
      final response = await _dio.get(
        '$baseUrl/coredata.php',
        options: Options(headers: {'x-app-version': AppConfig.appVersion}),
        queryParameters: {'token': token},
      );

      if (response.statusCode == 200) {
        CoreDataModel.fromJson(response.data);
      }
    } catch (e) {}
  }

  static Future<void> initializeAgoraAppId() async {
    await RsCoreDataService().updateAgoraAppId();
  }
}
