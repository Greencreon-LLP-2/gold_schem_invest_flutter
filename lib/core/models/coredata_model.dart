class CoreDataResponse {
  final String status;
  final List<CoreData> data;
  final String code;
 final int httpStatusCode;
  CoreDataResponse({
      required this.httpStatusCode,
    required this.status,
    required this.data,
    required this.code,
  });

  factory CoreDataResponse.fromJson(Map<String, dynamic> json) {
    return CoreDataResponse(
       httpStatusCode: json['httpStatusCode'] ?? 200,
      status: json['status'] ?? '',
      data:
          json['data'] != null
              ? List<CoreData>.from(
                json['data'].map((item) => CoreData.fromJson(item)),
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

class CoreData {
  final String id;
  final String siteurl;
  final String version;
  final String siteTitle;
  final String licenseValidity;
  final String licenseKey;
  final String footerCopyright;
  final String siteDescription;
  final String metaKeyword;
  final String metaDetails;
  final String logo;
  final String minLogo;
  final String favIcon;
  final String webLogo;
  final String appLogo;
  final String address;
  final String siteEmail;
  final String whatsappNo;
  final String timezone;
  final String sendgridAPI;
  final String ifGoogleanalytics;
  final String googleAnalyticsId;
  final String codStatus;
  final String bankTransferStatus;
  final String bankDetails;
  final String razorpayStatus;
  final String razoKeyId;
  final String razoKeySecret;
  final String ifPhonepe;
  final String phonepeMerchantId;
  final String phonepeSaltkey;
  final String phonepeMode;
  final String ifGooglemap;
  final String googlemapAPI;
  final String ifFirebase;
  final String firebaseConfig;
  final String firebaseAPI;
  final String ifOnesignal;
  final String onesignalId;
  final String onesignalKey;
  final String smtpHost;
  final String smtpPort;
  final String smtpUsername;
  final String smtpPassword;
  final String ifTestotp;
  final String ifMsg91;
  final String msg91Apikey;
  final String ifTextlocal;
  final String textlocalApikey;
  final String ifGreensms;
  final String greensmsAccessToken;
  final String greensmsAccessTokenKey;
  final String smsSenderid;
  final String smsEntityId;
  final String smsDltid;
  final String smsMsg;
  final String purchaseDate;
  final String validityEnd;
  final String inMaintenance;
  CoreData({
    required this.id,
    required this.siteurl,
    required this.version,
    required this.siteTitle,
    required this.licenseValidity,
    required this.licenseKey,
    required this.footerCopyright,
    required this.siteDescription,
    required this.metaKeyword,
    required this.metaDetails,
    required this.logo,
    required this.minLogo,
    required this.favIcon,
    required this.webLogo,
    required this.appLogo,
    required this.address,
    required this.siteEmail,
    required this.whatsappNo,
    required this.timezone,
    required this.sendgridAPI,
    required this.ifGoogleanalytics,
    required this.googleAnalyticsId,
    required this.codStatus,
    required this.bankTransferStatus,
    required this.bankDetails,
    required this.razorpayStatus,
    required this.razoKeyId,
    required this.razoKeySecret,
    required this.ifPhonepe,
    required this.phonepeMerchantId,
    required this.phonepeSaltkey,
    required this.phonepeMode,
    required this.ifGooglemap,
    required this.googlemapAPI,
    required this.ifFirebase,
    required this.firebaseConfig,
    required this.firebaseAPI,
    required this.ifOnesignal,
    required this.onesignalId,
    required this.onesignalKey,
    required this.smtpHost,
    required this.smtpPort,
    required this.smtpUsername,
    required this.smtpPassword,
    required this.ifTestotp,
    required this.ifMsg91,
    required this.msg91Apikey,
    required this.ifTextlocal,
    required this.textlocalApikey,
    required this.ifGreensms,
    required this.greensmsAccessToken,
    required this.greensmsAccessTokenKey,
    required this.smsSenderid,
    required this.smsEntityId,
    required this.smsDltid,
    required this.smsMsg,
    required this.purchaseDate,
    required this.validityEnd,
    required this.inMaintenance,
  });

  factory CoreData.fromJson(Map<String, dynamic> json) {
    return CoreData(
      id: json['id'] ?? '',
      siteurl: json['siteurl'] ?? '',
      version: json['version'] ?? '',
      siteTitle: json['site_title'] ?? '',
      licenseValidity: json['license_validity'] ?? '',
      licenseKey: json['license_key'] ?? '',
      footerCopyright: json['footer_copyright'] ?? '',
      siteDescription: json['site_description'] ?? '',
      metaKeyword: json['meta_keyword'] ?? '',
      metaDetails: json['meta_details'] ?? '',
      logo: json['logo'] ?? '',
      minLogo: json['min_logo'] ?? '',
      favIcon: json['fav_icon'] ?? '',
      webLogo: json['web_logo'] ?? '',
      appLogo: json['app_logo'] ?? '',
      address: json['address'] ?? '',
      siteEmail: json['site_email'] ?? '',
      whatsappNo: json['whatsapp_no'] ?? '',
      timezone: json['timezone'] ?? '',
      sendgridAPI: json['sendgrid_API'] ?? '',
      ifGoogleanalytics: json['if_googleanalytics'] ?? '',
      googleAnalyticsId: json['google_analytics_id'] ?? '',
      codStatus: json['cod_status'] ?? '',
      bankTransferStatus: json['bank_transfer_status'] ?? '',
      bankDetails: json['bank_details'] ?? '',
      razorpayStatus: json['razorpay_status'] ?? '',
      razoKeyId: json['razo_key_id'] ?? '',
      razoKeySecret: json['razo_key_secret'] ?? '',
      ifPhonepe: json['if_phonepe'] ?? '',
      phonepeMerchantId: json['phonepe_merchantId'] ?? '',
      phonepeSaltkey: json['phonepe_saltkey'] ?? '',
      phonepeMode: json['phonepe_mode'] ?? '',
      ifGooglemap: json['if_googlemap'] ?? '',
      googlemapAPI: json['googlemap_API'] ?? '',
      ifFirebase: json['if_firebase'] ?? '',
      firebaseConfig: json['firebase_config'] ?? '',
      firebaseAPI: json['firebase_API'] ?? '',
      ifOnesignal: json['if_onesignal'] ?? '',
      onesignalId: json['onesignal_id'] ?? '',
      onesignalKey: json['onesignal_key'] ?? '',
      smtpHost: json['smtp_host'] ?? '',
      smtpPort: json['smtp_port'] ?? '',
      smtpUsername: json['smtp_username'] ?? '',
      smtpPassword: json['smtp_password'] ?? '',
      ifTestotp: json['if_testotp'] ?? '',
      ifMsg91: json['if_msg91'] ?? '',
      msg91Apikey: json['msg91_apikey'] ?? '',
      ifTextlocal: json['if_textlocal'] ?? '',
      textlocalApikey: json['textlocal_apikey'] ?? '',
      ifGreensms: json['if_greensms'] ?? '',
      greensmsAccessToken: json['greensms_accessToken'] ?? '',
      greensmsAccessTokenKey: json['greensms_accessTokenKey'] ?? '',
      smsSenderid: json['sms_senderid'] ?? '',
      smsEntityId: json['sms_entityId'] ?? '',
      smsDltid: json['sms_dltid'] ?? '',
      smsMsg: json['sms_msg'] ?? '',
      purchaseDate: json['purchase_date'] ?? '',
      validityEnd: json['validity_end'] ?? '',
      inMaintenance: json['maintenance_mode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'siteurl': siteurl,
      'version': version,
      'site_title': siteTitle,
      'license_validity': licenseValidity,
      'license_key': licenseKey,
      'footer_copyright': footerCopyright,
      'site_description': siteDescription,
      'meta_keyword': metaKeyword,
      'meta_details': metaDetails,
      'logo': logo,
      'min_logo': minLogo,
      'fav_icon': favIcon,
      'web_logo': webLogo,
      'app_logo': appLogo,
      'address': address,
      'site_email': siteEmail,
      'whatsapp_no': whatsappNo,
      'timezone': timezone,
      'sendgrid_API': sendgridAPI,
      'if_googleanalytics': ifGoogleanalytics,
      'google_analytics_id': googleAnalyticsId,
      'cod_status': codStatus,
      'bank_transfer_status': bankTransferStatus,
      'bank_details': bankDetails,
      'razorpay_status': razorpayStatus,
      'razo_key_id': razoKeyId,
      'razo_key_secret': razoKeySecret,
      'if_phonepe': ifPhonepe,
      'phonepe_merchantId': phonepeMerchantId,
      'phonepe_saltkey': phonepeSaltkey,
      'phonepe_mode': phonepeMode,
      'if_googlemap': ifGooglemap,
      'googlemap_API': googlemapAPI,
      'if_firebase': ifFirebase,
      'firebase_config': firebaseConfig,
      'firebase_API': firebaseAPI,
      'if_onesignal': ifOnesignal,
      'onesignal_id': onesignalId,
      'onesignal_key': onesignalKey,
      'smtp_host': smtpHost,
      'smtp_port': smtpPort,
      'smtp_username': smtpUsername,
      'smtp_password': smtpPassword,
      'if_testotp': ifTestotp,
      'if_msg91': ifMsg91,
      'msg91_apikey': msg91Apikey,
      'if_textlocal': ifTextlocal,
      'textlocal_apikey': textlocalApikey,
      'if_greensms': ifGreensms,
      'greensms_accessToken': greensmsAccessToken,
      'greensms_accessTokenKey': greensmsAccessTokenKey,
      'sms_senderid': smsSenderid,
      'sms_entityId': smsEntityId,
      'sms_dltid': smsDltid,
      'sms_msg': smsMsg,
      'purchase_date': purchaseDate,
      'validity_end': validityEnd,
      'maintenance_mode': inMaintenance,
    };
  }
}
