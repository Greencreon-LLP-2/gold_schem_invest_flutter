class UserDetails {
  final String address1;
  final String address2;
  final String district;
  final String pincode;
  final String state;
  final String landmark;
  final String nomineeName;
  final String nomineeRelationship;
  final String nomineeAddress;

  UserDetails({
    required this.address1,
    required this.address2,
    required this.district,
    required this.pincode,
    required this.state,
    required this.landmark,
    required this.nomineeName,
    required this.nomineeRelationship,
    required this.nomineeAddress,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      address1: json['address_1']?.toString() ?? '',
      address2: json['address_2']?.toString() ?? '',
      district: json['district']?.toString() ?? '',
      pincode: json['pincode'] ?? '',
      state: json['state']?.toString() ?? '',
      landmark: json['landmark']?.toString() ?? '',
      nomineeName: json['nominee_name']?.toString() ?? '',
      nomineeRelationship: json['nominee_relationship']?.toString() ?? '',
      nomineeAddress: json['nominee_address']?.toString() ?? '',
    );
  }
}
