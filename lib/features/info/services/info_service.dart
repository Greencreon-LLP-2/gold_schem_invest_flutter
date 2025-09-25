import 'dart:convert';
import 'package:rajakumari_scheme/core/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:rajakumari_scheme/core/api_secrets/api_secrets.dart';
import 'package:rajakumari_scheme/features/info/models/policy_page_model.dart';

class InfoService {
  final String baseUrl = ApiSecrets.baseUrl;
  final String token = ApiSecrets.token;
  List<PolicyPage>? _cachedPolicyPages;

  // Fetch all policy pages
  Future<List<PolicyPage>> getPolicyPages() async {
    if (_cachedPolicyPages != null) {
      return _cachedPolicyPages!;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pages.php?token=$token'),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'true') {
          final List<dynamic> pages = data['data'];
          _cachedPolicyPages =
              pages.map((page) => PolicyPage.fromJson(page)).toList();
          return _cachedPolicyPages!;
        }
      }
      throw Exception('Failed to load policy pages');
    } catch (e) {
      throw Exception('Error fetching policy pages: $e');
    }
  }

  // Find page ID by title
  Future<String?> findPageIdByTitle(String title) async {
    final pages = await getPolicyPages();

    try {
      final page = pages.firstWhere(
        (page) => page.title.toLowerCase().contains(title.toLowerCase()),
      );
      return page.pageId;
    } catch (_) {
      return null; // No match found, return null instead of throwing
    }
  }

  // Fetch specific policy page details
  Future<String> getPolicyPageDetails(String pageId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/page-details.php?token=$token&page_id=$pageId'),
        headers: {
          'x-app-version':
              AppConfig.appVersion
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to load policy page details');
    } catch (e) {
      throw Exception('Error fetching policy page details: $e');
    }
  }
}
