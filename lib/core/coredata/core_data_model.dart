// core/constants/coredata/core_data_model.dart
// To parse this JSON data, do
//
//     final coreDataModel = coreDataModelFromJson(jsonString);

// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'core_data_model.freezed.dart';
part 'core_data_model.g.dart';

CoreDataModel coreDataModelFromJson(String str) =>
    CoreDataModel.fromJson(json.decode(str));

String coreDataModelToJson(CoreDataModel data) => json.encode(data.toJson());

@freezed
class CoreDataModel with _$CoreDataModel {
  const factory CoreDataModel({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") List<Datum>? data,
    @JsonKey(name: "code") String? code,
  }) = _CoreDataModel;

  factory CoreDataModel.fromJson(Map<String, dynamic> json) =>
      _$CoreDataModelFromJson(json);
}

@freezed
class Datum with _$Datum {
  const factory Datum({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "siteurl") String? siteurl,
    @JsonKey(name: "version") String? version,
    @JsonKey(name: "app_version") String? appVersion,
    @JsonKey(name: "site_title") String? siteTitle,
    @JsonKey(name: "site_description") String? siteDescription,
    @JsonKey(name: "meta_keyword") String? metaKeyword,
    @JsonKey(name: "meta_details") String? metaDetails,
    @JsonKey(name: "logo") String? logo,
    @JsonKey(name: "min_logo") String? minLogo,
    @JsonKey(name: "fav_icon") String? favIcon,
    @JsonKey(name: "web_logo") String? webLogo,
    @JsonKey(name: "app_logo") String? appLogo,
    @JsonKey(name: "address") String? address,
    @JsonKey(name: "site_email") String? siteEmail,
    @JsonKey(name: "whatsapp_no") String? whatsappNo,
    @JsonKey(name: "sendgrid_API") String? sendgridApi,
    @JsonKey(name: "google_API") String? googleApi,
    @JsonKey(name: "if_firebase") String? ifFirebase,
    @JsonKey(name: "firebase_config") String? firebaseConfig,
    @JsonKey(name: "firebase_API") String? firebaseApi,
    @JsonKey(name: "cod_status") String? codStatus,
    @JsonKey(name: "bank_transfer_status") String? bankTransferStatus,
    @JsonKey(name: "razorpay_status") String? razorpayStatus,
    @JsonKey(name: "razo_key_id") String? razoKeyId,
    @JsonKey(name: "razo_key_secret") String? razoKeySecret,
    @JsonKey(name: "ccavenue_status") String? ccavenueStatus,
    @JsonKey(name: "ccavenue_testmode") String? ccavenueTestmode,
    @JsonKey(name: "ccavenue_merchant_id") String? ccavenueMerchantId,
    @JsonKey(name: "ccavenue_access_code") String? ccavenueAccessCode,
    @JsonKey(name: "ccavenue_working_key") String? ccavenueWorkingKey,
    @JsonKey(name: "if_phonepe") String? ifPhonepe,
    @JsonKey(name: "phonepe_merchantId") String? phonepeMerchantId,
    @JsonKey(name: "phonepe_saltkey") String? phonepeSaltkey,
    @JsonKey(name: "phonepe_mode") String? phonepeMode,
    @JsonKey(name: "if_onesignal") String? ifOnesignal,
    @JsonKey(name: "onesignal_id") String? onesignalId,
    @JsonKey(name: "onesignal_key") String? onesignalKey,
    @JsonKey(name: "smtp_host") String? smtpHost,
    @JsonKey(name: "smtp_port") String? smtpPort,
    @JsonKey(name: "smtp_username") String? smtpUsername,
    @JsonKey(name: "smtp_password") String? smtpPassword,
    @JsonKey(name: "if_msg91") String? ifMsg91,
    @JsonKey(name: "msg91_apikey") String? msg91Apikey,
    @JsonKey(name: "if_textlocal") String? ifTextlocal,
    @JsonKey(name: "textlocal_apikey") String? textlocalApikey,
    @JsonKey(name: "sms_senderid") String? smsSenderid,
    @JsonKey(name: "sms_dltid") String? smsDltid,
    @JsonKey(name: "sms_msg") String? smsMsg,
    @JsonKey(name: "if_agora") String? ifAgora,
    @JsonKey(name: "agora_appid") String? agoraAppid,
    @JsonKey(name: "if_zigocloud") String? ifZigocloud,
    @JsonKey(name: "zigocloud_app_id") String? zigocloudAppId,
    @JsonKey(name: "zigocloud_app_signin") String? zigocloudAppSignin,
    @JsonKey(name: "maintenance_mode") String? maintenanceMode,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}
