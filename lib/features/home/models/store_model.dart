class StoreModel {
  final String id;
  final String countId;
  final String storeCode;
  final String storeName;
  final String slug;
  final String description;
  final String mobile;
  final String image;
  final String address;
  final String pincode;
  final String landmark;
  final String? latitude;
  final String? longitude;
  final String invoicePreletter;
  final String zone;
  final String status;
  final String createdAt;
  final String updatedOn;

  StoreModel({
    required this.id,
    required this.countId,
    required this.storeCode,
    required this.storeName,
    required this.slug,
    required this.description,
    required this.mobile,
    required this.image,
    required this.address,
    required this.pincode,
    required this.landmark,
    this.latitude,
    this.longitude,
    required this.invoicePreletter,
    required this.zone,
    required this.status,
    required this.createdAt,
    required this.updatedOn,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] ?? '',
      countId: json['count_id'] ?? '',
      storeCode: json['store_code'] ?? '',
      storeName: json['store_name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      mobile: json['mobile'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      pincode: json['pincode'] ?? '',
      landmark: json['landmark'] ?? '',
      latitude: json['latitude'],
      longitude: json['longitude'],
      invoicePreletter: json['invoice_preletter'] ?? '',
      zone: json['zone'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedOn: json['updated_on'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count_id': countId,
      'store_code': storeCode,
      'store_name': storeName,
      'slug': slug,
      'description': description,
      'mobile': mobile,
      'image': image,
      'address': address,
      'pincode': pincode,
      'landmark': landmark,
      'latitude': latitude,
      'longitude': longitude,
      'invoice_preletter': invoicePreletter,
      'zone': zone,
      'status': status,
      'created_at': createdAt,
      'updated_on': updatedOn,
    };
  }
}

class StoreResponse {
  final String status;
  final List<StoreModel> data;
  final String code;

  StoreResponse({required this.status, required this.data, required this.code});

  factory StoreResponse.fromJson(Map<String, dynamic> json) {
    return StoreResponse(
      status: json['status'] ?? '',
      data:
          json['data'] != null
              ? List<StoreModel>.from(
                json['data'].map((item) => StoreModel.fromJson(item)),
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
