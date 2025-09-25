class GoldRateListModel {
  final String id;
  final String k24_1gm;
  final String k24_8gm;
  final String k22_1gm;
  final String k22_8gm;
  final String createdOn;
  final String updatedOn;

  GoldRateListModel({
    required this.id,
    required this.k24_1gm,
    required this.k24_8gm,
    required this.k22_1gm,
    required this.k22_8gm,
    required this.createdOn,
    required this.updatedOn,
  });

  factory GoldRateListModel.fromJson(Map<String, dynamic> json) {
    return GoldRateListModel(
      id: json['id'] ?? '',
      k24_1gm: json['24k1gm'] ?? '',
      k24_8gm: json['24k8gm'] ?? '',
      k22_1gm: json['22k1gm'] ?? '',
      k22_8gm: json['22k8gm'] ?? '',
      createdOn: json['created_on'] ?? '',
      updatedOn: json['updated_on'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      '24k1gm': k24_1gm,
      '24k8gm': k24_8gm,
      '22k1gm': k22_1gm,
      '22k8gm': k22_8gm,
      'created_on': createdOn,
      'updated_on': updatedOn,
    };
  }
}

class GoldRateListResponse {
  final String status;
  final List<GoldRateListModel> data;
  final String code;

  GoldRateListResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory GoldRateListResponse.fromJson(Map<String, dynamic> json) {
    return GoldRateListResponse(
      status: json['status'] ?? '',
      data:
          json['data'] != null
              ? List<GoldRateListModel>.from(
                json['data'].map((item) => GoldRateListModel.fromJson(item)),
              )
              : [],
      code: json['code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
      'code': code,
    };
  }
}
