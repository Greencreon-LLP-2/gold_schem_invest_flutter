import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rajakumari_scheme/core/global_widgets/custom_alert_box.dart';
import 'package:rajakumari_scheme/features/info/services/info_service.dart';

class PolicyPage extends StatefulWidget {
  final String title;

  const PolicyPage({super.key, required this.title});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  final InfoService _infoService = InfoService();
  String _content = '';
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPolicyContent();
  }

  Future<void> _loadPolicyContent() async {
    try {
      final pageId = await _infoService.findPageIdByTitle(widget.title);

      if (pageId == null) {
        setState(() {
          _isLoading = false;
          _error = 'Page not found for title: ${widget.title}';
        });
        if (mounted) {
          showGlassAlert(context, _error!, AlertStatus.error);
        }
        return;
      }

      final content = await _infoService.getPolicyPageDetails(pageId);
      setState(() {
        _content = formatHtmlWithHeadings(content);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Error loading content';
      });
      if (mounted) {
        showGlassAlert(context, 'Error loading content: $e', AlertStatus.error);
      }
    }
  }

  String formatHtmlWithHeadings(String rawHtml) {
    final knownHeadings = [
      'Introduction',
      'Collection',
      'Usage',
      'Sharing',
      'Security Precautions',
      'Data Deletion and Retention',
      'Your Rights',
      'Consent',
      'Changes to this Privacy Policy',
      'Contact us:',
      'Terms and Conditions',
      'Return Policy',
      'Shipping Policy',
    ];

    for (final heading in knownHeadings) {
      rawHtml = rawHtml.replaceAll('<p>$heading</p>', '<h2>$heading</h2>');
    }

    return rawHtml;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.amber.shade600,
        foregroundColor: Colors.white,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text(_error!))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Html(
                  data: _content,
                  style: {
                    'body': Style(
                      fontSize: FontSize(16),
                      lineHeight: LineHeight(1.8),
                      color: Colors.black87,
                    ),
                    'h2': Style(
                      fontSize: FontSize.xLarge,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      margin: Margins.only(bottom: 16, top: 24),
                    ),
                    'p': Style(
                      fontSize: FontSize.medium,
                      margin: Margins.only(bottom: 16),
                      color: Colors.grey.shade900,
                    ),
                  },
                ),
              ),
    );
  }
}
