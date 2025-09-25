import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import '../models/zone_model.dart';

class ZoneListService {
  Future<List<ZoneModel>> getZoneList() async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiSecrets.baseUrl}/list-zone.php?token=${ApiSecrets.token}',
        ),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'true') {
          final List<dynamic> zoneList = jsonResponse['data'];
          return zoneList.map((zone) => ZoneModel.fromJson(zone)).toList();
        } else {
          throw Exception(
            'Failed to load zone list: ${jsonResponse['data']}',
          );
        }
      } else {
        throw Exception('Failed to load zone list: ${response.statusCode}');
      }
    } catch (e) {
     
      throw Exception(
        'Failed to load zone list. check your internet connection',
      );
    }
  }
}
