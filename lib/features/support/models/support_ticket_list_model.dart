// features/support/service/support_ticket_list.dart
class Ticket {
  final String id;
  final String uniqId;
  final String userId;
  final String mobile;
  final String subject;
  final String msg;
  final String status;
  final String? remark;
  final String notifiAdmin;
  final String createdOn;
  final String updatedOn;

  Ticket({
    required this.id,
    required this.uniqId,
    required this.userId,
    required this.mobile,
    required this.subject,
    required this.msg,
    required this.status,
    this.remark,
    required this.notifiAdmin,
    required this.createdOn,
    required this.updatedOn,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      uniqId: json['uniq_id'],
      userId: json['user_id'],
      mobile: json['mobile'],
      subject: json['subject'],
      msg: json['msg'],
      status: json['status'],
      remark: json['remark'],
      notifiAdmin: json['notifi_admin'],
      createdOn: json['created_on'],
      updatedOn: json['updated_on'],
    );
  }
}
