// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'core_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CoreDataModel _$CoreDataModelFromJson(Map<String, dynamic> json) {
  return _CoreDataModel.fromJson(json);
}

/// @nodoc
mixin _$CoreDataModel {
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "data")
  List<Datum>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: "code")
  String? get code => throw _privateConstructorUsedError;

  /// Serializes this CoreDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoreDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoreDataModelCopyWith<CoreDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoreDataModelCopyWith<$Res> {
  factory $CoreDataModelCopyWith(
    CoreDataModel value,
    $Res Function(CoreDataModel) then,
  ) = _$CoreDataModelCopyWithImpl<$Res, CoreDataModel>;
  @useResult
  $Res call({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") List<Datum>? data,
    @JsonKey(name: "code") String? code,
  });
}

/// @nodoc
class _$CoreDataModelCopyWithImpl<$Res, $Val extends CoreDataModel>
    implements $CoreDataModelCopyWith<$Res> {
  _$CoreDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoreDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? code = freezed,
  }) {
    return _then(
      _value.copyWith(
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            data:
                freezed == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<Datum>?,
            code:
                freezed == code
                    ? _value.code
                    : code // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoreDataModelImplCopyWith<$Res>
    implements $CoreDataModelCopyWith<$Res> {
  factory _$$CoreDataModelImplCopyWith(
    _$CoreDataModelImpl value,
    $Res Function(_$CoreDataModelImpl) then,
  ) = __$$CoreDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "data") List<Datum>? data,
    @JsonKey(name: "code") String? code,
  });
}

/// @nodoc
class __$$CoreDataModelImplCopyWithImpl<$Res>
    extends _$CoreDataModelCopyWithImpl<$Res, _$CoreDataModelImpl>
    implements _$$CoreDataModelImplCopyWith<$Res> {
  __$$CoreDataModelImplCopyWithImpl(
    _$CoreDataModelImpl _value,
    $Res Function(_$CoreDataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoreDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? code = freezed,
  }) {
    return _then(
      _$CoreDataModelImpl(
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        data:
            freezed == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<Datum>?,
        code:
            freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CoreDataModelImpl implements _CoreDataModel {
  const _$CoreDataModelImpl({
    @JsonKey(name: "status") this.status,
    @JsonKey(name: "data") final List<Datum>? data,
    @JsonKey(name: "code") this.code,
  }) : _data = data;

  factory _$CoreDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoreDataModelImplFromJson(json);

  @override
  @JsonKey(name: "status")
  final String? status;
  final List<Datum>? _data;
  @override
  @JsonKey(name: "data")
  List<Datum>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "code")
  final String? code;

  @override
  String toString() {
    return 'CoreDataModel(status: $status, data: $data, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoreDataModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_data),
    code,
  );

  /// Create a copy of CoreDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoreDataModelImplCopyWith<_$CoreDataModelImpl> get copyWith =>
      __$$CoreDataModelImplCopyWithImpl<_$CoreDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoreDataModelImplToJson(this);
  }
}

abstract class _CoreDataModel implements CoreDataModel {
  const factory _CoreDataModel({
    @JsonKey(name: "status") final String? status,
    @JsonKey(name: "data") final List<Datum>? data,
    @JsonKey(name: "code") final String? code,
  }) = _$CoreDataModelImpl;

  factory _CoreDataModel.fromJson(Map<String, dynamic> json) =
      _$CoreDataModelImpl.fromJson;

  @override
  @JsonKey(name: "status")
  String? get status;
  @override
  @JsonKey(name: "data")
  List<Datum>? get data;
  @override
  @JsonKey(name: "code")
  String? get code;

  /// Create a copy of CoreDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoreDataModelImplCopyWith<_$CoreDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Datum _$DatumFromJson(Map<String, dynamic> json) {
  return _Datum.fromJson(json);
}

/// @nodoc
mixin _$Datum {
  @JsonKey(name: "id")
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "siteurl")
  String? get siteurl => throw _privateConstructorUsedError;
  @JsonKey(name: "version")
  String? get version => throw _privateConstructorUsedError;
  @JsonKey(name: "app_version")
  String? get appVersion => throw _privateConstructorUsedError;
  @JsonKey(name: "site_title")
  String? get siteTitle => throw _privateConstructorUsedError;
  @JsonKey(name: "site_description")
  String? get siteDescription => throw _privateConstructorUsedError;
  @JsonKey(name: "meta_keyword")
  String? get metaKeyword => throw _privateConstructorUsedError;
  @JsonKey(name: "meta_details")
  String? get metaDetails => throw _privateConstructorUsedError;
  @JsonKey(name: "logo")
  String? get logo => throw _privateConstructorUsedError;
  @JsonKey(name: "min_logo")
  String? get minLogo => throw _privateConstructorUsedError;
  @JsonKey(name: "fav_icon")
  String? get favIcon => throw _privateConstructorUsedError;
  @JsonKey(name: "web_logo")
  String? get webLogo => throw _privateConstructorUsedError;
  @JsonKey(name: "app_logo")
  String? get appLogo => throw _privateConstructorUsedError;
  @JsonKey(name: "address")
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: "site_email")
  String? get siteEmail => throw _privateConstructorUsedError;
  @JsonKey(name: "whatsapp_no")
  String? get whatsappNo => throw _privateConstructorUsedError;
  @JsonKey(name: "sendgrid_API")
  String? get sendgridApi => throw _privateConstructorUsedError;
  @JsonKey(name: "google_API")
  String? get googleApi => throw _privateConstructorUsedError;
  @JsonKey(name: "if_firebase")
  String? get ifFirebase => throw _privateConstructorUsedError;
  @JsonKey(name: "firebase_config")
  String? get firebaseConfig => throw _privateConstructorUsedError;
  @JsonKey(name: "firebase_API")
  String? get firebaseApi => throw _privateConstructorUsedError;
  @JsonKey(name: "cod_status")
  String? get codStatus => throw _privateConstructorUsedError;
  @JsonKey(name: "bank_transfer_status")
  String? get bankTransferStatus => throw _privateConstructorUsedError;
  @JsonKey(name: "razorpay_status")
  String? get razorpayStatus => throw _privateConstructorUsedError;
  @JsonKey(name: "razo_key_id")
  String? get razoKeyId => throw _privateConstructorUsedError;
  @JsonKey(name: "razo_key_secret")
  String? get razoKeySecret => throw _privateConstructorUsedError;
  @JsonKey(name: "ccavenue_status")
  String? get ccavenueStatus => throw _privateConstructorUsedError;
  @JsonKey(name: "ccavenue_testmode")
  String? get ccavenueTestmode => throw _privateConstructorUsedError;
  @JsonKey(name: "ccavenue_merchant_id")
  String? get ccavenueMerchantId => throw _privateConstructorUsedError;
  @JsonKey(name: "ccavenue_access_code")
  String? get ccavenueAccessCode => throw _privateConstructorUsedError;
  @JsonKey(name: "ccavenue_working_key")
  String? get ccavenueWorkingKey => throw _privateConstructorUsedError;
  @JsonKey(name: "if_phonepe")
  String? get ifPhonepe => throw _privateConstructorUsedError;
  @JsonKey(name: "phonepe_merchantId")
  String? get phonepeMerchantId => throw _privateConstructorUsedError;
  @JsonKey(name: "phonepe_saltkey")
  String? get phonepeSaltkey => throw _privateConstructorUsedError;
  @JsonKey(name: "phonepe_mode")
  String? get phonepeMode => throw _privateConstructorUsedError;
  @JsonKey(name: "if_onesignal")
  String? get ifOnesignal => throw _privateConstructorUsedError;
  @JsonKey(name: "onesignal_id")
  String? get onesignalId => throw _privateConstructorUsedError;
  @JsonKey(name: "onesignal_key")
  String? get onesignalKey => throw _privateConstructorUsedError;
  @JsonKey(name: "smtp_host")
  String? get smtpHost => throw _privateConstructorUsedError;
  @JsonKey(name: "smtp_port")
  String? get smtpPort => throw _privateConstructorUsedError;
  @JsonKey(name: "smtp_username")
  String? get smtpUsername => throw _privateConstructorUsedError;
  @JsonKey(name: "smtp_password")
  String? get smtpPassword => throw _privateConstructorUsedError;
  @JsonKey(name: "if_msg91")
  String? get ifMsg91 => throw _privateConstructorUsedError;
  @JsonKey(name: "msg91_apikey")
  String? get msg91Apikey => throw _privateConstructorUsedError;
  @JsonKey(name: "if_textlocal")
  String? get ifTextlocal => throw _privateConstructorUsedError;
  @JsonKey(name: "textlocal_apikey")
  String? get textlocalApikey => throw _privateConstructorUsedError;
  @JsonKey(name: "sms_senderid")
  String? get smsSenderid => throw _privateConstructorUsedError;
  @JsonKey(name: "sms_dltid")
  String? get smsDltid => throw _privateConstructorUsedError;
  @JsonKey(name: "sms_msg")
  String? get smsMsg => throw _privateConstructorUsedError;
  @JsonKey(name: "if_agora")
  String? get ifAgora => throw _privateConstructorUsedError;
  @JsonKey(name: "agora_appid")
  String? get agoraAppid => throw _privateConstructorUsedError;
  @JsonKey(name: "if_zigocloud")
  String? get ifZigocloud => throw _privateConstructorUsedError;
  @JsonKey(name: "zigocloud_app_id")
  String? get zigocloudAppId => throw _privateConstructorUsedError;
  @JsonKey(name: "zigocloud_app_signin")
  String? get zigocloudAppSignin => throw _privateConstructorUsedError;
  @JsonKey(name: "maintenance_mode")
  String? get maintenanceMode => throw _privateConstructorUsedError;

  /// Serializes this Datum to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Datum
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DatumCopyWith<Datum> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatumCopyWith<$Res> {
  factory $DatumCopyWith(Datum value, $Res Function(Datum) then) =
      _$DatumCopyWithImpl<$Res, Datum>;
  @useResult
  $Res call({
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
  });
}

/// @nodoc
class _$DatumCopyWithImpl<$Res, $Val extends Datum>
    implements $DatumCopyWith<$Res> {
  _$DatumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Datum
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? siteurl = freezed,
    Object? version = freezed,
    Object? appVersion = freezed,
    Object? siteTitle = freezed,
    Object? siteDescription = freezed,
    Object? metaKeyword = freezed,
    Object? metaDetails = freezed,
    Object? logo = freezed,
    Object? minLogo = freezed,
    Object? favIcon = freezed,
    Object? webLogo = freezed,
    Object? appLogo = freezed,
    Object? address = freezed,
    Object? siteEmail = freezed,
    Object? whatsappNo = freezed,
    Object? sendgridApi = freezed,
    Object? googleApi = freezed,
    Object? ifFirebase = freezed,
    Object? firebaseConfig = freezed,
    Object? firebaseApi = freezed,
    Object? codStatus = freezed,
    Object? bankTransferStatus = freezed,
    Object? razorpayStatus = freezed,
    Object? razoKeyId = freezed,
    Object? razoKeySecret = freezed,
    Object? ccavenueStatus = freezed,
    Object? ccavenueTestmode = freezed,
    Object? ccavenueMerchantId = freezed,
    Object? ccavenueAccessCode = freezed,
    Object? ccavenueWorkingKey = freezed,
    Object? ifPhonepe = freezed,
    Object? phonepeMerchantId = freezed,
    Object? phonepeSaltkey = freezed,
    Object? phonepeMode = freezed,
    Object? ifOnesignal = freezed,
    Object? onesignalId = freezed,
    Object? onesignalKey = freezed,
    Object? smtpHost = freezed,
    Object? smtpPort = freezed,
    Object? smtpUsername = freezed,
    Object? smtpPassword = freezed,
    Object? ifMsg91 = freezed,
    Object? msg91Apikey = freezed,
    Object? ifTextlocal = freezed,
    Object? textlocalApikey = freezed,
    Object? smsSenderid = freezed,
    Object? smsDltid = freezed,
    Object? smsMsg = freezed,
    Object? ifAgora = freezed,
    Object? agoraAppid = freezed,
    Object? ifZigocloud = freezed,
    Object? zigocloudAppId = freezed,
    Object? zigocloudAppSignin = freezed,
    Object? maintenanceMode = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            siteurl:
                freezed == siteurl
                    ? _value.siteurl
                    : siteurl // ignore: cast_nullable_to_non_nullable
                        as String?,
            version:
                freezed == version
                    ? _value.version
                    : version // ignore: cast_nullable_to_non_nullable
                        as String?,
            appVersion:
                freezed == appVersion
                    ? _value.appVersion
                    : appVersion // ignore: cast_nullable_to_non_nullable
                        as String?,
            siteTitle:
                freezed == siteTitle
                    ? _value.siteTitle
                    : siteTitle // ignore: cast_nullable_to_non_nullable
                        as String?,
            siteDescription:
                freezed == siteDescription
                    ? _value.siteDescription
                    : siteDescription // ignore: cast_nullable_to_non_nullable
                        as String?,
            metaKeyword:
                freezed == metaKeyword
                    ? _value.metaKeyword
                    : metaKeyword // ignore: cast_nullable_to_non_nullable
                        as String?,
            metaDetails:
                freezed == metaDetails
                    ? _value.metaDetails
                    : metaDetails // ignore: cast_nullable_to_non_nullable
                        as String?,
            logo:
                freezed == logo
                    ? _value.logo
                    : logo // ignore: cast_nullable_to_non_nullable
                        as String?,
            minLogo:
                freezed == minLogo
                    ? _value.minLogo
                    : minLogo // ignore: cast_nullable_to_non_nullable
                        as String?,
            favIcon:
                freezed == favIcon
                    ? _value.favIcon
                    : favIcon // ignore: cast_nullable_to_non_nullable
                        as String?,
            webLogo:
                freezed == webLogo
                    ? _value.webLogo
                    : webLogo // ignore: cast_nullable_to_non_nullable
                        as String?,
            appLogo:
                freezed == appLogo
                    ? _value.appLogo
                    : appLogo // ignore: cast_nullable_to_non_nullable
                        as String?,
            address:
                freezed == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String?,
            siteEmail:
                freezed == siteEmail
                    ? _value.siteEmail
                    : siteEmail // ignore: cast_nullable_to_non_nullable
                        as String?,
            whatsappNo:
                freezed == whatsappNo
                    ? _value.whatsappNo
                    : whatsappNo // ignore: cast_nullable_to_non_nullable
                        as String?,
            sendgridApi:
                freezed == sendgridApi
                    ? _value.sendgridApi
                    : sendgridApi // ignore: cast_nullable_to_non_nullable
                        as String?,
            googleApi:
                freezed == googleApi
                    ? _value.googleApi
                    : googleApi // ignore: cast_nullable_to_non_nullable
                        as String?,
            ifFirebase:
                freezed == ifFirebase
                    ? _value.ifFirebase
                    : ifFirebase // ignore: cast_nullable_to_non_nullable
                        as String?,
            firebaseConfig:
                freezed == firebaseConfig
                    ? _value.firebaseConfig
                    : firebaseConfig // ignore: cast_nullable_to_non_nullable
                        as String?,
            firebaseApi:
                freezed == firebaseApi
                    ? _value.firebaseApi
                    : firebaseApi // ignore: cast_nullable_to_non_nullable
                        as String?,
            codStatus:
                freezed == codStatus
                    ? _value.codStatus
                    : codStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
            bankTransferStatus:
                freezed == bankTransferStatus
                    ? _value.bankTransferStatus
                    : bankTransferStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
            razorpayStatus:
                freezed == razorpayStatus
                    ? _value.razorpayStatus
                    : razorpayStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
            razoKeyId:
                freezed == razoKeyId
                    ? _value.razoKeyId
                    : razoKeyId // ignore: cast_nullable_to_non_nullable
                        as String?,
            razoKeySecret:
                freezed == razoKeySecret
                    ? _value.razoKeySecret
                    : razoKeySecret // ignore: cast_nullable_to_non_nullable
                        as String?,
            ccavenueStatus:
                freezed == ccavenueStatus
                    ? _value.ccavenueStatus
                    : ccavenueStatus // ignore: cast_nullable_to_non_nullable
                        as String?,
            ccavenueTestmode:
                freezed == ccavenueTestmode
                    ? _value.ccavenueTestmode
                    : ccavenueTestmode // ignore: cast_nullable_to_non_nullable
                        as String?,
            ccavenueMerchantId:
                freezed == ccavenueMerchantId
                    ? _value.ccavenueMerchantId
                    : ccavenueMerchantId // ignore: cast_nullable_to_non_nullable
                        as String?,
            ccavenueAccessCode:
                freezed == ccavenueAccessCode
                    ? _value.ccavenueAccessCode
                    : ccavenueAccessCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            ccavenueWorkingKey:
                freezed == ccavenueWorkingKey
                    ? _value.ccavenueWorkingKey
                    : ccavenueWorkingKey // ignore: cast_nullable_to_non_nullable
                        as String?,
            ifPhonepe:
                freezed == ifPhonepe
                    ? _value.ifPhonepe
                    : ifPhonepe // ignore: cast_nullable_to_non_nullable
                        as String?,
            phonepeMerchantId:
                freezed == phonepeMerchantId
                    ? _value.phonepeMerchantId
                    : phonepeMerchantId // ignore: cast_nullable_to_non_nullable
                        as String?,
            phonepeSaltkey:
                freezed == phonepeSaltkey
                    ? _value.phonepeSaltkey
                    : phonepeSaltkey // ignore: cast_nullable_to_non_nullable
                        as String?,
            phonepeMode:
                freezed == phonepeMode
                    ? _value.phonepeMode
                    : phonepeMode // ignore: cast_nullable_to_non_nullable
                        as String?,
            ifOnesignal:
                freezed == ifOnesignal
                    ? _value.ifOnesignal
                    : ifOnesignal // ignore: cast_nullable_to_non_nullable
                        as String?,
            onesignalId:
                freezed == onesignalId
                    ? _value.onesignalId
                    : onesignalId // ignore: cast_nullable_to_non_nullable
                        as String?,
            onesignalKey:
                freezed == onesignalKey
                    ? _value.onesignalKey
                    : onesignalKey // ignore: cast_nullable_to_non_nullable
                        as String?,
            smtpHost:
                freezed == smtpHost
                    ? _value.smtpHost
                    : smtpHost // ignore: cast_nullable_to_non_nullable
                        as String?,
            smtpPort:
                freezed == smtpPort
                    ? _value.smtpPort
                    : smtpPort // ignore: cast_nullable_to_non_nullable
                        as String?,
            smtpUsername:
                freezed == smtpUsername
                    ? _value.smtpUsername
                    : smtpUsername // ignore: cast_nullable_to_non_nullable
                        as String?,
            smtpPassword:
                freezed == smtpPassword
                    ? _value.smtpPassword
                    : smtpPassword // ignore: cast_nullable_to_non_nullable
                        as String?,
            ifMsg91:
                freezed == ifMsg91
                    ? _value.ifMsg91
                    : ifMsg91 // ignore: cast_nullable_to_non_nullable
                        as String?,
            msg91Apikey:
                freezed == msg91Apikey
                    ? _value.msg91Apikey
                    : msg91Apikey // ignore: cast_nullable_to_non_nullable
                        as String?,
            ifTextlocal:
                freezed == ifTextlocal
                    ? _value.ifTextlocal
                    : ifTextlocal // ignore: cast_nullable_to_non_nullable
                        as String?,
            textlocalApikey:
                freezed == textlocalApikey
                    ? _value.textlocalApikey
                    : textlocalApikey // ignore: cast_nullable_to_non_nullable
                        as String?,
            smsSenderid:
                freezed == smsSenderid
                    ? _value.smsSenderid
                    : smsSenderid // ignore: cast_nullable_to_non_nullable
                        as String?,
            smsDltid:
                freezed == smsDltid
                    ? _value.smsDltid
                    : smsDltid // ignore: cast_nullable_to_non_nullable
                        as String?,
            smsMsg:
                freezed == smsMsg
                    ? _value.smsMsg
                    : smsMsg // ignore: cast_nullable_to_non_nullable
                        as String?,
            ifAgora:
                freezed == ifAgora
                    ? _value.ifAgora
                    : ifAgora // ignore: cast_nullable_to_non_nullable
                        as String?,
            agoraAppid:
                freezed == agoraAppid
                    ? _value.agoraAppid
                    : agoraAppid // ignore: cast_nullable_to_non_nullable
                        as String?,
            ifZigocloud:
                freezed == ifZigocloud
                    ? _value.ifZigocloud
                    : ifZigocloud // ignore: cast_nullable_to_non_nullable
                        as String?,
            zigocloudAppId:
                freezed == zigocloudAppId
                    ? _value.zigocloudAppId
                    : zigocloudAppId // ignore: cast_nullable_to_non_nullable
                        as String?,
            zigocloudAppSignin:
                freezed == zigocloudAppSignin
                    ? _value.zigocloudAppSignin
                    : zigocloudAppSignin // ignore: cast_nullable_to_non_nullable
                        as String?,
            maintenanceMode:
                freezed == maintenanceMode
                    ? _value.maintenanceMode
                    : maintenanceMode // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DatumImplCopyWith<$Res> implements $DatumCopyWith<$Res> {
  factory _$$DatumImplCopyWith(
    _$DatumImpl value,
    $Res Function(_$DatumImpl) then,
  ) = __$$DatumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
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
  });
}

/// @nodoc
class __$$DatumImplCopyWithImpl<$Res>
    extends _$DatumCopyWithImpl<$Res, _$DatumImpl>
    implements _$$DatumImplCopyWith<$Res> {
  __$$DatumImplCopyWithImpl(
    _$DatumImpl _value,
    $Res Function(_$DatumImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Datum
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? siteurl = freezed,
    Object? version = freezed,
    Object? appVersion = freezed,
    Object? siteTitle = freezed,
    Object? siteDescription = freezed,
    Object? metaKeyword = freezed,
    Object? metaDetails = freezed,
    Object? logo = freezed,
    Object? minLogo = freezed,
    Object? favIcon = freezed,
    Object? webLogo = freezed,
    Object? appLogo = freezed,
    Object? address = freezed,
    Object? siteEmail = freezed,
    Object? whatsappNo = freezed,
    Object? sendgridApi = freezed,
    Object? googleApi = freezed,
    Object? ifFirebase = freezed,
    Object? firebaseConfig = freezed,
    Object? firebaseApi = freezed,
    Object? codStatus = freezed,
    Object? bankTransferStatus = freezed,
    Object? razorpayStatus = freezed,
    Object? razoKeyId = freezed,
    Object? razoKeySecret = freezed,
    Object? ccavenueStatus = freezed,
    Object? ccavenueTestmode = freezed,
    Object? ccavenueMerchantId = freezed,
    Object? ccavenueAccessCode = freezed,
    Object? ccavenueWorkingKey = freezed,
    Object? ifPhonepe = freezed,
    Object? phonepeMerchantId = freezed,
    Object? phonepeSaltkey = freezed,
    Object? phonepeMode = freezed,
    Object? ifOnesignal = freezed,
    Object? onesignalId = freezed,
    Object? onesignalKey = freezed,
    Object? smtpHost = freezed,
    Object? smtpPort = freezed,
    Object? smtpUsername = freezed,
    Object? smtpPassword = freezed,
    Object? ifMsg91 = freezed,
    Object? msg91Apikey = freezed,
    Object? ifTextlocal = freezed,
    Object? textlocalApikey = freezed,
    Object? smsSenderid = freezed,
    Object? smsDltid = freezed,
    Object? smsMsg = freezed,
    Object? ifAgora = freezed,
    Object? agoraAppid = freezed,
    Object? ifZigocloud = freezed,
    Object? zigocloudAppId = freezed,
    Object? zigocloudAppSignin = freezed,
    Object? maintenanceMode = freezed,
  }) {
    return _then(
      _$DatumImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        siteurl:
            freezed == siteurl
                ? _value.siteurl
                : siteurl // ignore: cast_nullable_to_non_nullable
                    as String?,
        version:
            freezed == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                    as String?,
        appVersion:
            freezed == appVersion
                ? _value.appVersion
                : appVersion // ignore: cast_nullable_to_non_nullable
                    as String?,
        siteTitle:
            freezed == siteTitle
                ? _value.siteTitle
                : siteTitle // ignore: cast_nullable_to_non_nullable
                    as String?,
        siteDescription:
            freezed == siteDescription
                ? _value.siteDescription
                : siteDescription // ignore: cast_nullable_to_non_nullable
                    as String?,
        metaKeyword:
            freezed == metaKeyword
                ? _value.metaKeyword
                : metaKeyword // ignore: cast_nullable_to_non_nullable
                    as String?,
        metaDetails:
            freezed == metaDetails
                ? _value.metaDetails
                : metaDetails // ignore: cast_nullable_to_non_nullable
                    as String?,
        logo:
            freezed == logo
                ? _value.logo
                : logo // ignore: cast_nullable_to_non_nullable
                    as String?,
        minLogo:
            freezed == minLogo
                ? _value.minLogo
                : minLogo // ignore: cast_nullable_to_non_nullable
                    as String?,
        favIcon:
            freezed == favIcon
                ? _value.favIcon
                : favIcon // ignore: cast_nullable_to_non_nullable
                    as String?,
        webLogo:
            freezed == webLogo
                ? _value.webLogo
                : webLogo // ignore: cast_nullable_to_non_nullable
                    as String?,
        appLogo:
            freezed == appLogo
                ? _value.appLogo
                : appLogo // ignore: cast_nullable_to_non_nullable
                    as String?,
        address:
            freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String?,
        siteEmail:
            freezed == siteEmail
                ? _value.siteEmail
                : siteEmail // ignore: cast_nullable_to_non_nullable
                    as String?,
        whatsappNo:
            freezed == whatsappNo
                ? _value.whatsappNo
                : whatsappNo // ignore: cast_nullable_to_non_nullable
                    as String?,
        sendgridApi:
            freezed == sendgridApi
                ? _value.sendgridApi
                : sendgridApi // ignore: cast_nullable_to_non_nullable
                    as String?,
        googleApi:
            freezed == googleApi
                ? _value.googleApi
                : googleApi // ignore: cast_nullable_to_non_nullable
                    as String?,
        ifFirebase:
            freezed == ifFirebase
                ? _value.ifFirebase
                : ifFirebase // ignore: cast_nullable_to_non_nullable
                    as String?,
        firebaseConfig:
            freezed == firebaseConfig
                ? _value.firebaseConfig
                : firebaseConfig // ignore: cast_nullable_to_non_nullable
                    as String?,
        firebaseApi:
            freezed == firebaseApi
                ? _value.firebaseApi
                : firebaseApi // ignore: cast_nullable_to_non_nullable
                    as String?,
        codStatus:
            freezed == codStatus
                ? _value.codStatus
                : codStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
        bankTransferStatus:
            freezed == bankTransferStatus
                ? _value.bankTransferStatus
                : bankTransferStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
        razorpayStatus:
            freezed == razorpayStatus
                ? _value.razorpayStatus
                : razorpayStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
        razoKeyId:
            freezed == razoKeyId
                ? _value.razoKeyId
                : razoKeyId // ignore: cast_nullable_to_non_nullable
                    as String?,
        razoKeySecret:
            freezed == razoKeySecret
                ? _value.razoKeySecret
                : razoKeySecret // ignore: cast_nullable_to_non_nullable
                    as String?,
        ccavenueStatus:
            freezed == ccavenueStatus
                ? _value.ccavenueStatus
                : ccavenueStatus // ignore: cast_nullable_to_non_nullable
                    as String?,
        ccavenueTestmode:
            freezed == ccavenueTestmode
                ? _value.ccavenueTestmode
                : ccavenueTestmode // ignore: cast_nullable_to_non_nullable
                    as String?,
        ccavenueMerchantId:
            freezed == ccavenueMerchantId
                ? _value.ccavenueMerchantId
                : ccavenueMerchantId // ignore: cast_nullable_to_non_nullable
                    as String?,
        ccavenueAccessCode:
            freezed == ccavenueAccessCode
                ? _value.ccavenueAccessCode
                : ccavenueAccessCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        ccavenueWorkingKey:
            freezed == ccavenueWorkingKey
                ? _value.ccavenueWorkingKey
                : ccavenueWorkingKey // ignore: cast_nullable_to_non_nullable
                    as String?,
        ifPhonepe:
            freezed == ifPhonepe
                ? _value.ifPhonepe
                : ifPhonepe // ignore: cast_nullable_to_non_nullable
                    as String?,
        phonepeMerchantId:
            freezed == phonepeMerchantId
                ? _value.phonepeMerchantId
                : phonepeMerchantId // ignore: cast_nullable_to_non_nullable
                    as String?,
        phonepeSaltkey:
            freezed == phonepeSaltkey
                ? _value.phonepeSaltkey
                : phonepeSaltkey // ignore: cast_nullable_to_non_nullable
                    as String?,
        phonepeMode:
            freezed == phonepeMode
                ? _value.phonepeMode
                : phonepeMode // ignore: cast_nullable_to_non_nullable
                    as String?,
        ifOnesignal:
            freezed == ifOnesignal
                ? _value.ifOnesignal
                : ifOnesignal // ignore: cast_nullable_to_non_nullable
                    as String?,
        onesignalId:
            freezed == onesignalId
                ? _value.onesignalId
                : onesignalId // ignore: cast_nullable_to_non_nullable
                    as String?,
        onesignalKey:
            freezed == onesignalKey
                ? _value.onesignalKey
                : onesignalKey // ignore: cast_nullable_to_non_nullable
                    as String?,
        smtpHost:
            freezed == smtpHost
                ? _value.smtpHost
                : smtpHost // ignore: cast_nullable_to_non_nullable
                    as String?,
        smtpPort:
            freezed == smtpPort
                ? _value.smtpPort
                : smtpPort // ignore: cast_nullable_to_non_nullable
                    as String?,
        smtpUsername:
            freezed == smtpUsername
                ? _value.smtpUsername
                : smtpUsername // ignore: cast_nullable_to_non_nullable
                    as String?,
        smtpPassword:
            freezed == smtpPassword
                ? _value.smtpPassword
                : smtpPassword // ignore: cast_nullable_to_non_nullable
                    as String?,
        ifMsg91:
            freezed == ifMsg91
                ? _value.ifMsg91
                : ifMsg91 // ignore: cast_nullable_to_non_nullable
                    as String?,
        msg91Apikey:
            freezed == msg91Apikey
                ? _value.msg91Apikey
                : msg91Apikey // ignore: cast_nullable_to_non_nullable
                    as String?,
        ifTextlocal:
            freezed == ifTextlocal
                ? _value.ifTextlocal
                : ifTextlocal // ignore: cast_nullable_to_non_nullable
                    as String?,
        textlocalApikey:
            freezed == textlocalApikey
                ? _value.textlocalApikey
                : textlocalApikey // ignore: cast_nullable_to_non_nullable
                    as String?,
        smsSenderid:
            freezed == smsSenderid
                ? _value.smsSenderid
                : smsSenderid // ignore: cast_nullable_to_non_nullable
                    as String?,
        smsDltid:
            freezed == smsDltid
                ? _value.smsDltid
                : smsDltid // ignore: cast_nullable_to_non_nullable
                    as String?,
        smsMsg:
            freezed == smsMsg
                ? _value.smsMsg
                : smsMsg // ignore: cast_nullable_to_non_nullable
                    as String?,
        ifAgora:
            freezed == ifAgora
                ? _value.ifAgora
                : ifAgora // ignore: cast_nullable_to_non_nullable
                    as String?,
        agoraAppid:
            freezed == agoraAppid
                ? _value.agoraAppid
                : agoraAppid // ignore: cast_nullable_to_non_nullable
                    as String?,
        ifZigocloud:
            freezed == ifZigocloud
                ? _value.ifZigocloud
                : ifZigocloud // ignore: cast_nullable_to_non_nullable
                    as String?,
        zigocloudAppId:
            freezed == zigocloudAppId
                ? _value.zigocloudAppId
                : zigocloudAppId // ignore: cast_nullable_to_non_nullable
                    as String?,
        zigocloudAppSignin:
            freezed == zigocloudAppSignin
                ? _value.zigocloudAppSignin
                : zigocloudAppSignin // ignore: cast_nullable_to_non_nullable
                    as String?,
        maintenanceMode:
            freezed == maintenanceMode
                ? _value.maintenanceMode
                : maintenanceMode // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DatumImpl implements _Datum {
  const _$DatumImpl({
    @JsonKey(name: "id") this.id,
    @JsonKey(name: "siteurl") this.siteurl,
    @JsonKey(name: "version") this.version,
    @JsonKey(name: "app_version") this.appVersion,
    @JsonKey(name: "site_title") this.siteTitle,
    @JsonKey(name: "site_description") this.siteDescription,
    @JsonKey(name: "meta_keyword") this.metaKeyword,
    @JsonKey(name: "meta_details") this.metaDetails,
    @JsonKey(name: "logo") this.logo,
    @JsonKey(name: "min_logo") this.minLogo,
    @JsonKey(name: "fav_icon") this.favIcon,
    @JsonKey(name: "web_logo") this.webLogo,
    @JsonKey(name: "app_logo") this.appLogo,
    @JsonKey(name: "address") this.address,
    @JsonKey(name: "site_email") this.siteEmail,
    @JsonKey(name: "whatsapp_no") this.whatsappNo,
    @JsonKey(name: "sendgrid_API") this.sendgridApi,
    @JsonKey(name: "google_API") this.googleApi,
    @JsonKey(name: "if_firebase") this.ifFirebase,
    @JsonKey(name: "firebase_config") this.firebaseConfig,
    @JsonKey(name: "firebase_API") this.firebaseApi,
    @JsonKey(name: "cod_status") this.codStatus,
    @JsonKey(name: "bank_transfer_status") this.bankTransferStatus,
    @JsonKey(name: "razorpay_status") this.razorpayStatus,
    @JsonKey(name: "razo_key_id") this.razoKeyId,
    @JsonKey(name: "razo_key_secret") this.razoKeySecret,
    @JsonKey(name: "ccavenue_status") this.ccavenueStatus,
    @JsonKey(name: "ccavenue_testmode") this.ccavenueTestmode,
    @JsonKey(name: "ccavenue_merchant_id") this.ccavenueMerchantId,
    @JsonKey(name: "ccavenue_access_code") this.ccavenueAccessCode,
    @JsonKey(name: "ccavenue_working_key") this.ccavenueWorkingKey,
    @JsonKey(name: "if_phonepe") this.ifPhonepe,
    @JsonKey(name: "phonepe_merchantId") this.phonepeMerchantId,
    @JsonKey(name: "phonepe_saltkey") this.phonepeSaltkey,
    @JsonKey(name: "phonepe_mode") this.phonepeMode,
    @JsonKey(name: "if_onesignal") this.ifOnesignal,
    @JsonKey(name: "onesignal_id") this.onesignalId,
    @JsonKey(name: "onesignal_key") this.onesignalKey,
    @JsonKey(name: "smtp_host") this.smtpHost,
    @JsonKey(name: "smtp_port") this.smtpPort,
    @JsonKey(name: "smtp_username") this.smtpUsername,
    @JsonKey(name: "smtp_password") this.smtpPassword,
    @JsonKey(name: "if_msg91") this.ifMsg91,
    @JsonKey(name: "msg91_apikey") this.msg91Apikey,
    @JsonKey(name: "if_textlocal") this.ifTextlocal,
    @JsonKey(name: "textlocal_apikey") this.textlocalApikey,
    @JsonKey(name: "sms_senderid") this.smsSenderid,
    @JsonKey(name: "sms_dltid") this.smsDltid,
    @JsonKey(name: "sms_msg") this.smsMsg,
    @JsonKey(name: "if_agora") this.ifAgora,
    @JsonKey(name: "agora_appid") this.agoraAppid,
    @JsonKey(name: "if_zigocloud") this.ifZigocloud,
    @JsonKey(name: "zigocloud_app_id") this.zigocloudAppId,
    @JsonKey(name: "zigocloud_app_signin") this.zigocloudAppSignin,
    @JsonKey(name: "maintenance_mode") this.maintenanceMode,
  });

  factory _$DatumImpl.fromJson(Map<String, dynamic> json) =>
      _$$DatumImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final String? id;
  @override
  @JsonKey(name: "siteurl")
  final String? siteurl;
  @override
  @JsonKey(name: "version")
  final String? version;
  @override
  @JsonKey(name: "app_version")
  final String? appVersion;
  @override
  @JsonKey(name: "site_title")
  final String? siteTitle;
  @override
  @JsonKey(name: "site_description")
  final String? siteDescription;
  @override
  @JsonKey(name: "meta_keyword")
  final String? metaKeyword;
  @override
  @JsonKey(name: "meta_details")
  final String? metaDetails;
  @override
  @JsonKey(name: "logo")
  final String? logo;
  @override
  @JsonKey(name: "min_logo")
  final String? minLogo;
  @override
  @JsonKey(name: "fav_icon")
  final String? favIcon;
  @override
  @JsonKey(name: "web_logo")
  final String? webLogo;
  @override
  @JsonKey(name: "app_logo")
  final String? appLogo;
  @override
  @JsonKey(name: "address")
  final String? address;
  @override
  @JsonKey(name: "site_email")
  final String? siteEmail;
  @override
  @JsonKey(name: "whatsapp_no")
  final String? whatsappNo;
  @override
  @JsonKey(name: "sendgrid_API")
  final String? sendgridApi;
  @override
  @JsonKey(name: "google_API")
  final String? googleApi;
  @override
  @JsonKey(name: "if_firebase")
  final String? ifFirebase;
  @override
  @JsonKey(name: "firebase_config")
  final String? firebaseConfig;
  @override
  @JsonKey(name: "firebase_API")
  final String? firebaseApi;
  @override
  @JsonKey(name: "cod_status")
  final String? codStatus;
  @override
  @JsonKey(name: "bank_transfer_status")
  final String? bankTransferStatus;
  @override
  @JsonKey(name: "razorpay_status")
  final String? razorpayStatus;
  @override
  @JsonKey(name: "razo_key_id")
  final String? razoKeyId;
  @override
  @JsonKey(name: "razo_key_secret")
  final String? razoKeySecret;
  @override
  @JsonKey(name: "ccavenue_status")
  final String? ccavenueStatus;
  @override
  @JsonKey(name: "ccavenue_testmode")
  final String? ccavenueTestmode;
  @override
  @JsonKey(name: "ccavenue_merchant_id")
  final String? ccavenueMerchantId;
  @override
  @JsonKey(name: "ccavenue_access_code")
  final String? ccavenueAccessCode;
  @override
  @JsonKey(name: "ccavenue_working_key")
  final String? ccavenueWorkingKey;
  @override
  @JsonKey(name: "if_phonepe")
  final String? ifPhonepe;
  @override
  @JsonKey(name: "phonepe_merchantId")
  final String? phonepeMerchantId;
  @override
  @JsonKey(name: "phonepe_saltkey")
  final String? phonepeSaltkey;
  @override
  @JsonKey(name: "phonepe_mode")
  final String? phonepeMode;
  @override
  @JsonKey(name: "if_onesignal")
  final String? ifOnesignal;
  @override
  @JsonKey(name: "onesignal_id")
  final String? onesignalId;
  @override
  @JsonKey(name: "onesignal_key")
  final String? onesignalKey;
  @override
  @JsonKey(name: "smtp_host")
  final String? smtpHost;
  @override
  @JsonKey(name: "smtp_port")
  final String? smtpPort;
  @override
  @JsonKey(name: "smtp_username")
  final String? smtpUsername;
  @override
  @JsonKey(name: "smtp_password")
  final String? smtpPassword;
  @override
  @JsonKey(name: "if_msg91")
  final String? ifMsg91;
  @override
  @JsonKey(name: "msg91_apikey")
  final String? msg91Apikey;
  @override
  @JsonKey(name: "if_textlocal")
  final String? ifTextlocal;
  @override
  @JsonKey(name: "textlocal_apikey")
  final String? textlocalApikey;
  @override
  @JsonKey(name: "sms_senderid")
  final String? smsSenderid;
  @override
  @JsonKey(name: "sms_dltid")
  final String? smsDltid;
  @override
  @JsonKey(name: "sms_msg")
  final String? smsMsg;
  @override
  @JsonKey(name: "if_agora")
  final String? ifAgora;
  @override
  @JsonKey(name: "agora_appid")
  final String? agoraAppid;
  @override
  @JsonKey(name: "if_zigocloud")
  final String? ifZigocloud;
  @override
  @JsonKey(name: "zigocloud_app_id")
  final String? zigocloudAppId;
  @override
  @JsonKey(name: "zigocloud_app_signin")
  final String? zigocloudAppSignin;
  @override
  @JsonKey(name: "maintenance_mode")
  final String? maintenanceMode;

  @override
  String toString() {
    return 'Datum(id: $id, siteurl: $siteurl, version: $version, appVersion: $appVersion, siteTitle: $siteTitle, siteDescription: $siteDescription, metaKeyword: $metaKeyword, metaDetails: $metaDetails, logo: $logo, minLogo: $minLogo, favIcon: $favIcon, webLogo: $webLogo, appLogo: $appLogo, address: $address, siteEmail: $siteEmail, whatsappNo: $whatsappNo, sendgridApi: $sendgridApi, googleApi: $googleApi, ifFirebase: $ifFirebase, firebaseConfig: $firebaseConfig, firebaseApi: $firebaseApi, codStatus: $codStatus, bankTransferStatus: $bankTransferStatus, razorpayStatus: $razorpayStatus, razoKeyId: $razoKeyId, razoKeySecret: $razoKeySecret, ccavenueStatus: $ccavenueStatus, ccavenueTestmode: $ccavenueTestmode, ccavenueMerchantId: $ccavenueMerchantId, ccavenueAccessCode: $ccavenueAccessCode, ccavenueWorkingKey: $ccavenueWorkingKey, ifPhonepe: $ifPhonepe, phonepeMerchantId: $phonepeMerchantId, phonepeSaltkey: $phonepeSaltkey, phonepeMode: $phonepeMode, ifOnesignal: $ifOnesignal, onesignalId: $onesignalId, onesignalKey: $onesignalKey, smtpHost: $smtpHost, smtpPort: $smtpPort, smtpUsername: $smtpUsername, smtpPassword: $smtpPassword, ifMsg91: $ifMsg91, msg91Apikey: $msg91Apikey, ifTextlocal: $ifTextlocal, textlocalApikey: $textlocalApikey, smsSenderid: $smsSenderid, smsDltid: $smsDltid, smsMsg: $smsMsg, ifAgora: $ifAgora, agoraAppid: $agoraAppid, ifZigocloud: $ifZigocloud, zigocloudAppId: $zigocloudAppId, zigocloudAppSignin: $zigocloudAppSignin, maintenanceMode: $maintenanceMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatumImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.siteurl, siteurl) || other.siteurl == siteurl) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.siteTitle, siteTitle) ||
                other.siteTitle == siteTitle) &&
            (identical(other.siteDescription, siteDescription) ||
                other.siteDescription == siteDescription) &&
            (identical(other.metaKeyword, metaKeyword) ||
                other.metaKeyword == metaKeyword) &&
            (identical(other.metaDetails, metaDetails) ||
                other.metaDetails == metaDetails) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.minLogo, minLogo) || other.minLogo == minLogo) &&
            (identical(other.favIcon, favIcon) || other.favIcon == favIcon) &&
            (identical(other.webLogo, webLogo) || other.webLogo == webLogo) &&
            (identical(other.appLogo, appLogo) || other.appLogo == appLogo) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.siteEmail, siteEmail) ||
                other.siteEmail == siteEmail) &&
            (identical(other.whatsappNo, whatsappNo) ||
                other.whatsappNo == whatsappNo) &&
            (identical(other.sendgridApi, sendgridApi) ||
                other.sendgridApi == sendgridApi) &&
            (identical(other.googleApi, googleApi) ||
                other.googleApi == googleApi) &&
            (identical(other.ifFirebase, ifFirebase) ||
                other.ifFirebase == ifFirebase) &&
            (identical(other.firebaseConfig, firebaseConfig) ||
                other.firebaseConfig == firebaseConfig) &&
            (identical(other.firebaseApi, firebaseApi) ||
                other.firebaseApi == firebaseApi) &&
            (identical(other.codStatus, codStatus) ||
                other.codStatus == codStatus) &&
            (identical(other.bankTransferStatus, bankTransferStatus) ||
                other.bankTransferStatus == bankTransferStatus) &&
            (identical(other.razorpayStatus, razorpayStatus) ||
                other.razorpayStatus == razorpayStatus) &&
            (identical(other.razoKeyId, razoKeyId) ||
                other.razoKeyId == razoKeyId) &&
            (identical(other.razoKeySecret, razoKeySecret) ||
                other.razoKeySecret == razoKeySecret) &&
            (identical(other.ccavenueStatus, ccavenueStatus) ||
                other.ccavenueStatus == ccavenueStatus) &&
            (identical(other.ccavenueTestmode, ccavenueTestmode) ||
                other.ccavenueTestmode == ccavenueTestmode) &&
            (identical(other.ccavenueMerchantId, ccavenueMerchantId) ||
                other.ccavenueMerchantId == ccavenueMerchantId) &&
            (identical(other.ccavenueAccessCode, ccavenueAccessCode) ||
                other.ccavenueAccessCode == ccavenueAccessCode) &&
            (identical(other.ccavenueWorkingKey, ccavenueWorkingKey) ||
                other.ccavenueWorkingKey == ccavenueWorkingKey) &&
            (identical(other.ifPhonepe, ifPhonepe) ||
                other.ifPhonepe == ifPhonepe) &&
            (identical(other.phonepeMerchantId, phonepeMerchantId) ||
                other.phonepeMerchantId == phonepeMerchantId) &&
            (identical(other.phonepeSaltkey, phonepeSaltkey) ||
                other.phonepeSaltkey == phonepeSaltkey) &&
            (identical(other.phonepeMode, phonepeMode) ||
                other.phonepeMode == phonepeMode) &&
            (identical(other.ifOnesignal, ifOnesignal) ||
                other.ifOnesignal == ifOnesignal) &&
            (identical(other.onesignalId, onesignalId) ||
                other.onesignalId == onesignalId) &&
            (identical(other.onesignalKey, onesignalKey) ||
                other.onesignalKey == onesignalKey) &&
            (identical(other.smtpHost, smtpHost) ||
                other.smtpHost == smtpHost) &&
            (identical(other.smtpPort, smtpPort) ||
                other.smtpPort == smtpPort) &&
            (identical(other.smtpUsername, smtpUsername) ||
                other.smtpUsername == smtpUsername) &&
            (identical(other.smtpPassword, smtpPassword) ||
                other.smtpPassword == smtpPassword) &&
            (identical(other.ifMsg91, ifMsg91) || other.ifMsg91 == ifMsg91) &&
            (identical(other.msg91Apikey, msg91Apikey) ||
                other.msg91Apikey == msg91Apikey) &&
            (identical(other.ifTextlocal, ifTextlocal) ||
                other.ifTextlocal == ifTextlocal) &&
            (identical(other.textlocalApikey, textlocalApikey) ||
                other.textlocalApikey == textlocalApikey) &&
            (identical(other.smsSenderid, smsSenderid) ||
                other.smsSenderid == smsSenderid) &&
            (identical(other.smsDltid, smsDltid) ||
                other.smsDltid == smsDltid) &&
            (identical(other.smsMsg, smsMsg) || other.smsMsg == smsMsg) &&
            (identical(other.ifAgora, ifAgora) || other.ifAgora == ifAgora) &&
            (identical(other.agoraAppid, agoraAppid) ||
                other.agoraAppid == agoraAppid) &&
            (identical(other.ifZigocloud, ifZigocloud) ||
                other.ifZigocloud == ifZigocloud) &&
            (identical(other.zigocloudAppId, zigocloudAppId) ||
                other.zigocloudAppId == zigocloudAppId) &&
            (identical(other.zigocloudAppSignin, zigocloudAppSignin) ||
                other.zigocloudAppSignin == zigocloudAppSignin) &&
            (identical(other.maintenanceMode, maintenanceMode) ||
                other.maintenanceMode == maintenanceMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    siteurl,
    version,
    appVersion,
    siteTitle,
    siteDescription,
    metaKeyword,
    metaDetails,
    logo,
    minLogo,
    favIcon,
    webLogo,
    appLogo,
    address,
    siteEmail,
    whatsappNo,
    sendgridApi,
    googleApi,
    ifFirebase,
    firebaseConfig,
    firebaseApi,
    codStatus,
    bankTransferStatus,
    razorpayStatus,
    razoKeyId,
    razoKeySecret,
    ccavenueStatus,
    ccavenueTestmode,
    ccavenueMerchantId,
    ccavenueAccessCode,
    ccavenueWorkingKey,
    ifPhonepe,
    phonepeMerchantId,
    phonepeSaltkey,
    phonepeMode,
    ifOnesignal,
    onesignalId,
    onesignalKey,
    smtpHost,
    smtpPort,
    smtpUsername,
    smtpPassword,
    ifMsg91,
    msg91Apikey,
    ifTextlocal,
    textlocalApikey,
    smsSenderid,
    smsDltid,
    smsMsg,
    ifAgora,
    agoraAppid,
    ifZigocloud,
    zigocloudAppId,
    zigocloudAppSignin,
    maintenanceMode,
  ]);

  /// Create a copy of Datum
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatumImplCopyWith<_$DatumImpl> get copyWith =>
      __$$DatumImplCopyWithImpl<_$DatumImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DatumImplToJson(this);
  }
}

abstract class _Datum implements Datum {
  const factory _Datum({
    @JsonKey(name: "id") final String? id,
    @JsonKey(name: "siteurl") final String? siteurl,
    @JsonKey(name: "version") final String? version,
    @JsonKey(name: "app_version") final String? appVersion,
    @JsonKey(name: "site_title") final String? siteTitle,
    @JsonKey(name: "site_description") final String? siteDescription,
    @JsonKey(name: "meta_keyword") final String? metaKeyword,
    @JsonKey(name: "meta_details") final String? metaDetails,
    @JsonKey(name: "logo") final String? logo,
    @JsonKey(name: "min_logo") final String? minLogo,
    @JsonKey(name: "fav_icon") final String? favIcon,
    @JsonKey(name: "web_logo") final String? webLogo,
    @JsonKey(name: "app_logo") final String? appLogo,
    @JsonKey(name: "address") final String? address,
    @JsonKey(name: "site_email") final String? siteEmail,
    @JsonKey(name: "whatsapp_no") final String? whatsappNo,
    @JsonKey(name: "sendgrid_API") final String? sendgridApi,
    @JsonKey(name: "google_API") final String? googleApi,
    @JsonKey(name: "if_firebase") final String? ifFirebase,
    @JsonKey(name: "firebase_config") final String? firebaseConfig,
    @JsonKey(name: "firebase_API") final String? firebaseApi,
    @JsonKey(name: "cod_status") final String? codStatus,
    @JsonKey(name: "bank_transfer_status") final String? bankTransferStatus,
    @JsonKey(name: "razorpay_status") final String? razorpayStatus,
    @JsonKey(name: "razo_key_id") final String? razoKeyId,
    @JsonKey(name: "razo_key_secret") final String? razoKeySecret,
    @JsonKey(name: "ccavenue_status") final String? ccavenueStatus,
    @JsonKey(name: "ccavenue_testmode") final String? ccavenueTestmode,
    @JsonKey(name: "ccavenue_merchant_id") final String? ccavenueMerchantId,
    @JsonKey(name: "ccavenue_access_code") final String? ccavenueAccessCode,
    @JsonKey(name: "ccavenue_working_key") final String? ccavenueWorkingKey,
    @JsonKey(name: "if_phonepe") final String? ifPhonepe,
    @JsonKey(name: "phonepe_merchantId") final String? phonepeMerchantId,
    @JsonKey(name: "phonepe_saltkey") final String? phonepeSaltkey,
    @JsonKey(name: "phonepe_mode") final String? phonepeMode,
    @JsonKey(name: "if_onesignal") final String? ifOnesignal,
    @JsonKey(name: "onesignal_id") final String? onesignalId,
    @JsonKey(name: "onesignal_key") final String? onesignalKey,
    @JsonKey(name: "smtp_host") final String? smtpHost,
    @JsonKey(name: "smtp_port") final String? smtpPort,
    @JsonKey(name: "smtp_username") final String? smtpUsername,
    @JsonKey(name: "smtp_password") final String? smtpPassword,
    @JsonKey(name: "if_msg91") final String? ifMsg91,
    @JsonKey(name: "msg91_apikey") final String? msg91Apikey,
    @JsonKey(name: "if_textlocal") final String? ifTextlocal,
    @JsonKey(name: "textlocal_apikey") final String? textlocalApikey,
    @JsonKey(name: "sms_senderid") final String? smsSenderid,
    @JsonKey(name: "sms_dltid") final String? smsDltid,
    @JsonKey(name: "sms_msg") final String? smsMsg,
    @JsonKey(name: "if_agora") final String? ifAgora,
    @JsonKey(name: "agora_appid") final String? agoraAppid,
    @JsonKey(name: "if_zigocloud") final String? ifZigocloud,
    @JsonKey(name: "zigocloud_app_id") final String? zigocloudAppId,
    @JsonKey(name: "zigocloud_app_signin") final String? zigocloudAppSignin,
    @JsonKey(name: "maintenance_mode") final String? maintenanceMode,
  }) = _$DatumImpl;

  factory _Datum.fromJson(Map<String, dynamic> json) = _$DatumImpl.fromJson;

  @override
  @JsonKey(name: "id")
  String? get id;
  @override
  @JsonKey(name: "siteurl")
  String? get siteurl;
  @override
  @JsonKey(name: "version")
  String? get version;
  @override
  @JsonKey(name: "app_version")
  String? get appVersion;
  @override
  @JsonKey(name: "site_title")
  String? get siteTitle;
  @override
  @JsonKey(name: "site_description")
  String? get siteDescription;
  @override
  @JsonKey(name: "meta_keyword")
  String? get metaKeyword;
  @override
  @JsonKey(name: "meta_details")
  String? get metaDetails;
  @override
  @JsonKey(name: "logo")
  String? get logo;
  @override
  @JsonKey(name: "min_logo")
  String? get minLogo;
  @override
  @JsonKey(name: "fav_icon")
  String? get favIcon;
  @override
  @JsonKey(name: "web_logo")
  String? get webLogo;
  @override
  @JsonKey(name: "app_logo")
  String? get appLogo;
  @override
  @JsonKey(name: "address")
  String? get address;
  @override
  @JsonKey(name: "site_email")
  String? get siteEmail;
  @override
  @JsonKey(name: "whatsapp_no")
  String? get whatsappNo;
  @override
  @JsonKey(name: "sendgrid_API")
  String? get sendgridApi;
  @override
  @JsonKey(name: "google_API")
  String? get googleApi;
  @override
  @JsonKey(name: "if_firebase")
  String? get ifFirebase;
  @override
  @JsonKey(name: "firebase_config")
  String? get firebaseConfig;
  @override
  @JsonKey(name: "firebase_API")
  String? get firebaseApi;
  @override
  @JsonKey(name: "cod_status")
  String? get codStatus;
  @override
  @JsonKey(name: "bank_transfer_status")
  String? get bankTransferStatus;
  @override
  @JsonKey(name: "razorpay_status")
  String? get razorpayStatus;
  @override
  @JsonKey(name: "razo_key_id")
  String? get razoKeyId;
  @override
  @JsonKey(name: "razo_key_secret")
  String? get razoKeySecret;
  @override
  @JsonKey(name: "ccavenue_status")
  String? get ccavenueStatus;
  @override
  @JsonKey(name: "ccavenue_testmode")
  String? get ccavenueTestmode;
  @override
  @JsonKey(name: "ccavenue_merchant_id")
  String? get ccavenueMerchantId;
  @override
  @JsonKey(name: "ccavenue_access_code")
  String? get ccavenueAccessCode;
  @override
  @JsonKey(name: "ccavenue_working_key")
  String? get ccavenueWorkingKey;
  @override
  @JsonKey(name: "if_phonepe")
  String? get ifPhonepe;
  @override
  @JsonKey(name: "phonepe_merchantId")
  String? get phonepeMerchantId;
  @override
  @JsonKey(name: "phonepe_saltkey")
  String? get phonepeSaltkey;
  @override
  @JsonKey(name: "phonepe_mode")
  String? get phonepeMode;
  @override
  @JsonKey(name: "if_onesignal")
  String? get ifOnesignal;
  @override
  @JsonKey(name: "onesignal_id")
  String? get onesignalId;
  @override
  @JsonKey(name: "onesignal_key")
  String? get onesignalKey;
  @override
  @JsonKey(name: "smtp_host")
  String? get smtpHost;
  @override
  @JsonKey(name: "smtp_port")
  String? get smtpPort;
  @override
  @JsonKey(name: "smtp_username")
  String? get smtpUsername;
  @override
  @JsonKey(name: "smtp_password")
  String? get smtpPassword;
  @override
  @JsonKey(name: "if_msg91")
  String? get ifMsg91;
  @override
  @JsonKey(name: "msg91_apikey")
  String? get msg91Apikey;
  @override
  @JsonKey(name: "if_textlocal")
  String? get ifTextlocal;
  @override
  @JsonKey(name: "textlocal_apikey")
  String? get textlocalApikey;
  @override
  @JsonKey(name: "sms_senderid")
  String? get smsSenderid;
  @override
  @JsonKey(name: "sms_dltid")
  String? get smsDltid;
  @override
  @JsonKey(name: "sms_msg")
  String? get smsMsg;
  @override
  @JsonKey(name: "if_agora")
  String? get ifAgora;
  @override
  @JsonKey(name: "agora_appid")
  String? get agoraAppid;
  @override
  @JsonKey(name: "if_zigocloud")
  String? get ifZigocloud;
  @override
  @JsonKey(name: "zigocloud_app_id")
  String? get zigocloudAppId;
  @override
  @JsonKey(name: "zigocloud_app_signin")
  String? get zigocloudAppSignin;
  @override
  @JsonKey(name: "maintenance_mode")
  String? get maintenanceMode;

  /// Create a copy of Datum
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatumImplCopyWith<_$DatumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
