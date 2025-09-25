// features/support/models/ticket_comment_model.dart
class TicketComment {
  final String id;
  final String ticketId;
  final String userId;
  final String comment;
  final String? image;
  final String status;
  final DateTime createdOn;
  final DateTime updatedOn;

  TicketComment({
    required this.id,
    required this.ticketId,
    required this.userId,
    required this.comment,
    this.image,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory TicketComment.fromJson(Map<String, dynamic> json) {
    return TicketComment(
      id: json['id'],
      ticketId: json['ticket_id'],
      userId: json['user_id'],
      comment: json['comment'],
      image: json['image'],
      status: json['status'],
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
    );
  }
}

class TicketCommentsResponse {
  final bool status;
  final List<TicketComment> data;
  final String code;

  TicketCommentsResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory TicketCommentsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<TicketComment> commentsList =
        list.map((i) => TicketComment.fromJson(i)).toList();

    return TicketCommentsResponse(
      status: json['status'] == 'true',
      data: commentsList,
      code: json['code'],
    );
  }
}
