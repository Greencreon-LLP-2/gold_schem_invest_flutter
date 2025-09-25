import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import '../models/store_model.dart';

class StoreListService {
  Future<List<StoreModel>> getStoreList() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiSecrets.baseUrl}/list-store.php?token=${ApiSecrets.token}',
        ),
         headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'true') {
          final List<dynamic> storeList = jsonResponse['data'];
          return storeList.map((store) => StoreModel.fromJson(store)).toList();
        } else {
          throw Exception(
            'Failed to load store list: ${jsonResponse['message']}',
          );
        }
      } else {
        throw Exception('Failed to load store list: ${response.statusCode}');
      }
    } catch (e) {
   
      throw Exception(
        'Failed to load store list. check your internet connection',
      );
    }
  }
}
