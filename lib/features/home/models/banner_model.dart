class BannerResponse {
  final String status;
  final List<BannerItem> data;
  final String code;

  BannerResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return BannerResponse(
      status: json['status'] ?? '',
      data:
          json['data'] != null
              ? List<BannerItem>.from(
                json['data'].map((item) => BannerItem.fromJson(item)),
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

class BannerItem {
  final String id;
  final String title;
  final String image;
  final String ifProduct;
  final String link;
  final String position;
  final String publish;
  final String createdOn;
  final String updatedOn;

  BannerItem({
    required this.id,
    required this.title,
    required this.image,
    required this.ifProduct,
    required this.link,
    required this.position,
    required this.publish,
    required this.createdOn,
    required this.updatedOn,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      ifProduct: json['if_product'] ?? '',
      link: json['link'] ?? '',
      position: json['position'] ?? '',
      publish: json['publish'] ?? '',
      createdOn: json['created_on'] ?? '',
      updatedOn: json['updated_on'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'if_product': ifProduct,
      'link': link,
      'position': position,
      'publish': publish,
      'created_on': createdOn,
      'updated_on': updatedOn,
    };
  }
}
