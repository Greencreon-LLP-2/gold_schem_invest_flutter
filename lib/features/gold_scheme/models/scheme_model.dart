class SchemeModel {
  final String id;
  final String countId;
  final String schemeCode;
  final String name;
  final String slug;
  final String image;
  final String noMonths;
  final String instalmentAmt;
  final String totalInstalmentAmt;
  final String bonusAmt;
  final String totalAmt;
  final String description;
  final String status;
  final String createdBy;
  final String createdOn;
  final String updatedOn;

  SchemeModel({
    required this.id,
    required this.countId,
    required this.schemeCode,
    required this.name,
    required this.slug,
    required this.image,
    required this.noMonths,
    required this.instalmentAmt,
    required this.totalInstalmentAmt,
    required this.bonusAmt,
    required this.totalAmt,
    required this.description,
    required this.status,
    required this.createdBy,
    required this.createdOn,
    required this.updatedOn,
  });

  factory SchemeModel.fromJson(Map<String, dynamic> json) {
    return SchemeModel(
      id: json['id'] ?? '',
      countId: json['count_id'] ?? '',
      schemeCode: json['scheme_code'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      noMonths: json['no_months'] ?? '',
      instalmentAmt: json['instalment_amt'] ?? '',
      totalInstalmentAmt: json['total_instalment_amt'] ?? '',
      bonusAmt: json['bonus_amt'] ?? '',
      totalAmt: json['total_amt'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdOn: json['created_on'] ?? '',
      updatedOn: json['updated_on'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count_id': countId,
      'scheme_code': schemeCode,
      'name': name,
      'slug': slug,
      'image': image,
      'no_months': noMonths,
      'instalment_amt': instalmentAmt,
      'total_instalment_amt': totalInstalmentAmt,
      'bonus_amt': bonusAmt,
      'total_amt': totalAmt,
      'description': description,
      'status': status,
      'created_by': createdBy,
      'created_on': createdOn,
      'updated_on': updatedOn,
    };
  }
}

class SchemeResponse {
  final String status;
  final List<SchemeModel> data;
  final String code;

  SchemeResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory SchemeResponse.fromJson(Map<String, dynamic> json) {
    return SchemeResponse(
      status: json['status'] ?? '',
      data:
          json['data'] != null
              ? List<SchemeModel>.from(
                json['data'].map((item) => SchemeModel.fromJson(item)),
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
