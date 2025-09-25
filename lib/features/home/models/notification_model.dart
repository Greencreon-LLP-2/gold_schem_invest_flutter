import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  final bool status;
  final List<NotificationData> data;
  final String code;

  NotificationResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        status: (json["status"]?.toString().toLowerCase() == "true"),
        data: json["data"] == null
            ? []
            : List<NotificationData>.from(
                json["data"].map((x) => NotificationData.fromJson(x))),
        code: json["code"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status.toString(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
      };
}

class NotificationData {
  final String id;
  final String targetUserid;
  final String createdBy;
  final String title;
  final String msg;
  final String image;
  final String ifProduct;
  final String link;
  final String data;
  final String status;
  final DateTime createdOn;
  final DateTime updatedOn;

  NotificationData({
    required this.id,
    required this.targetUserid,
    required this.createdBy,
    required this.title,
    required this.msg,
    required this.image,
    required this.ifProduct,
    required this.link,
    required this.data,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["id"]?.toString() ?? "",
        targetUserid: json["target_userid"]?.toString() ?? "",
        createdBy: json["created_by"]?.toString() ?? "",
        title: json["title"]?.toString() ?? "",
        msg: json["msg"]?.toString() ?? "",
        image: json["image"]?.toString() ?? "",
        ifProduct: json["if_product"]?.toString() ?? "",
        link: json["link"]?.toString() ?? "",
        data: json["data"]?.toString() ?? "",
        status: json["status"]?.toString() ?? "",
        createdOn: json["created_on"] != null && json["created_on"].toString().isNotEmpty
            ? DateTime.parse(json["created_on"].toString())
            : DateTime.fromMillisecondsSinceEpoch(0),
        updatedOn: json["updated_on"] != null && json["updated_on"].toString().isNotEmpty
            ? DateTime.parse(json["updated_on"].toString())
            : DateTime.fromMillisecondsSinceEpoch(0),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "target_userid": targetUserid,
        "created_by": createdBy,
        "title": title,
        "msg": msg,
        "image": image,
        "if_product": ifProduct,
        "link": link,
        "data": data,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
      };
}
