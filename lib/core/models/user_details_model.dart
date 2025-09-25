class UserDetailsResponse {
  final String status;
  final List<UserDetails> data;
  final String code;

  UserDetailsResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponse(
      status: json['status'] ?? '',
      data:
          (json['data'] as List?)
              ?.map((e) => UserDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      code: json['code'] ?? '',
    );
  }
}

class UserDetails {
  final String id;
  final String userId;
  final String label;
  final String mapAddress;
  final String latitude;
  final String longitude;
  final String defaultAddress;
  final String address1;
  final String address2;
  final String district;
  final String pincode;
  final String state;
  final String landmark;
  final String zoneId;
  final String panNo;
  final String panImage;
  final String aadharNo;
  final String aadharImage;
  final String nomineeName;
  final String nomineeRelationship;
  final String nomineeAddress;
  final String status;
  final String createdOn;
  final String updatedOn;

  UserDetails({
    required this.id,
    required this.userId,
    required this.label,
    required this.mapAddress,
    required this.latitude,
    required this.longitude,
    required this.defaultAddress,
    required this.address1,
    required this.address2,
    required this.district,
    required this.pincode,
    required this.state,
    required this.landmark,
    required this.zoneId,
    required this.panNo,
    required this.panImage,
    required this.aadharNo,
    required this.aadharImage,
    required this.nomineeName,
    required this.nomineeRelationship,
    required this.nomineeAddress,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      label: json['lable'] ?? '',
      mapAddress: json['map_address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      defaultAddress: json['default_adress'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      district: json['district'] ?? '',
      pincode: json['pincode'] ?? '',
      state: json['state'] ?? '',
      landmark: json['landmark'] ?? '',
      zoneId: json['zone_id'] ?? '',
      panNo: json['pan_no'] ?? '',
      panImage: json['pan_image'] ?? '',
      aadharNo: json['aadhar_no'] ?? '',
      aadharImage: json['aadhar_image'] ?? '',
      nomineeName: json['nominee_name'] ?? '',
      nomineeRelationship: json['nominee_relationship'] ?? '',
      nomineeAddress: json['nominee_address'] ?? '',
      status: json['status'] ?? '',
      createdOn: json['created_on'] ?? '',
      updatedOn: json['updated_on'] ?? '',
    );
  }
}
