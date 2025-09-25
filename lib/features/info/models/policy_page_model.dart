class PolicyPage {
  final String pageId;
  final String title;
  final String options;
  final String publishStatus;
  final String showAppMenu;

  PolicyPage({
    required this.pageId,
    required this.title,
    required this.options,
    required this.publishStatus,
    required this.showAppMenu,
  });

  factory PolicyPage.fromJson(Map<String, dynamic> json) {
    return PolicyPage(
      pageId: json['page_id'] ?? '',
      title: json['title'] ?? '',
      options: json['options'] ?? '',
      publishStatus: json['publish_status'] ?? '',
      showAppMenu: json['showapp_menu'] ?? '',
    );
  }
}
