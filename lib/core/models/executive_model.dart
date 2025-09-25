class ExecutiveModel {
  final String userId;
  final String userLevel;
  final String username;
  final String email;
  final String mobileCode;
  final String mobile;
  final String name;
  final String whatsappNo;
  final String? userCard;
  final String? profileImage;
  final String? dob;
  final String? employeeId;
  final String storeId;
  final String latitude;
  final String longitude;
  final String code;
  final String status;
  final String mobileVerify;
  final String ban;
  final String executiveId;
  final String? createdBy;
  final String createdAt;
  final String updatedOn;

  ExecutiveModel({
    required this.userId,
    required this.userLevel,
    required this.username,
    required this.email,
    required this.mobileCode,
    required this.mobile,
    required this.name,
    required this.whatsappNo,
    this.userCard,
    this.profileImage,
    this.dob,
    this.employeeId,
    required this.storeId,
    required this.latitude,
    required this.longitude,
    required this.code,
    required this.status,
    required this.mobileVerify,
    required this.ban,
    required this.executiveId,
    this.createdBy,
    required this.createdAt,
    required this.updatedOn,
  });

  factory ExecutiveModel.fromJson(Map<String, dynamic> json) {
    return ExecutiveModel(
      userId: json['user_id'] ?? '',
      userLevel: json['user_level'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      mobileCode: json['mobile_code'] ?? '',
      mobile: json['mobile'] ?? '',
      name: json['name'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      userCard: json['user_card'],
      profileImage: json['profile_image'],
      dob: json['dob'],
      employeeId: json['employee_id'],
      storeId: json['store_id'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      code: json['code'] ?? '',
      status: json['status'] ?? '',
      mobileVerify: json['mobile_verify'] ?? '',
      ban: json['ban'] ?? '',
      executiveId: json['executive_id'] ?? '',
      createdBy: json['created_by'],
      createdAt: json['created_at'] ?? '',
      updatedOn: json['updated_on'] ?? '',
    );
  }
}
