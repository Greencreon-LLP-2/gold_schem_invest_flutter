class PassbookDetailsModel {
  final String id;
  final String uniqId;
  final String userSubscriptionId;
  final String schemeId;
  final String passbookNo;
  final String userId;
  final String storeId;
  final String paymentDate;
  final String noPayment;
  final String remainingPayment;
  final String addOnInvestment;
  final String amount;
  final String payedOn;
  final String paymentMode;
  final String status;
  final String collectedBy;
  final String createdOn;
  final String updatedOn;

  PassbookDetailsModel({
    required this.id,
    required this.uniqId,
    required this.userSubscriptionId,
    required this.schemeId,
    required this.passbookNo,
    required this.userId,
    required this.storeId,
    required this.paymentDate,
    required this.noPayment,
    required this.remainingPayment,
    required this.addOnInvestment,
    required this.amount,
    required this.payedOn,
    required this.paymentMode,
    required this.status,
    required this.collectedBy,
    required this.createdOn,
    required this.updatedOn,
  });

  factory PassbookDetailsModel.fromJson(Map<String, dynamic> json) {
    return PassbookDetailsModel(
      id: json['id'] ?? '',
      uniqId: json['uniq_id'] ?? '',
      userSubscriptionId: json['user_subscription_id'] ?? '',
      schemeId: json['scheme_id'] ?? '',
      passbookNo: json['passbook_no'] ?? '',
      userId: json['user_id'] ?? '',
      storeId: json['store_id'] ?? '',
      paymentDate: json['payment_date'] ?? '',
      noPayment: json['no_payment'] ?? '',
      remainingPayment: json['remaining_payment'] ?? '',
      addOnInvestment: json['add_on_investment'] ?? '',
      amount: json['amount'] ?? '',
      payedOn: json['payed_on'] ?? '',
      paymentMode: json['payment_mode'] ?? '',
      status: json['status'] ?? '',
      collectedBy: json['collected_by'] ?? '',
      createdOn: json['created_on'] ?? '',
      updatedOn: json['updated_on'] ?? '',
    );
  }
}
