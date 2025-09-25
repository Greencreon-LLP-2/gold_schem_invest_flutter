class ZoneModel {
  final String id;
  final String name;
  final String description;
  final String isActive;
  final String allstoreOnOff;
  final String createdOn;
  final String updatedOn;

  ZoneModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.allstoreOnOff,
    required this.createdOn,
    required this.updatedOn,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      isActive: json['is_active'] ?? '',
      allstoreOnOff: json['allstore_onoff'] ?? '',
      createdOn: json['created_on'] ?? '',
      updatedOn: json['updated_on'] ?? '',
    );
  }
}
