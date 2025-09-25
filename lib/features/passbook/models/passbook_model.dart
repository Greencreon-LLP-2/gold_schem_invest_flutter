class PassbookModel {
  final String id;
  final String countId;
  final String userId;
  final String passbookNo;
  final String schemeId;
  final String passbookName;
  final String passbookAddress;
  final String openDate;
  final String closeDate;
  final String openStoreId;
  final String closeStoreId;
  final String remainingDue;
  final String closeingAmount;
  final String? storeClosedate;
  final String totalAddonInvestmentAmt;
  final String forceClose;
  final String withdrawalType;
  final String status;
  final String createdBy;
  final String createdOn;
  final String updatedOn;

  PassbookModel({
    required this.id,
    required this.countId,
    required this.userId,
    required this.passbookNo,
    required this.schemeId,
    required this.passbookName,
    required this.passbookAddress,
    required this.openDate,
    required this.closeDate,
    required this.openStoreId,
    required this.closeStoreId,
    required this.remainingDue,
    required this.closeingAmount,
    this.storeClosedate,
    required this.totalAddonInvestmentAmt,
    required this.forceClose,
    required this.withdrawalType,
    required this.status,
    required this.createdBy,
    required this.createdOn,
    required this.updatedOn,
  });

  factory PassbookModel.fromJson(Map<String, dynamic> json) {
    return PassbookModel(
      id: json['id'] ?? '',
      countId: json['count_id'] ?? '',
      userId: json['user_id'] ?? '',
      passbookNo: json['passbook_no'] ?? '',
      schemeId: json['scheme_id'] ?? '',
      passbookName: json['passbook_name'] ?? '',
      passbookAddress: json['passbook_address'] ?? '',
      openDate: json['open_date'] ?? '',
      closeDate: json['close_date'] ?? '',
      openStoreId: json['open_store_id'] ?? '',
      closeStoreId: json['close_store_id'] ?? '',
      remainingDue: json['remaining_due'] ?? '',
      closeingAmount: json['closeing_amount'] ?? '',
      storeClosedate: json['store_closedate'],
      totalAddonInvestmentAmt: json['total_addon_investment_amt'] ?? '',
      forceClose: json['force_close'] ?? '',
      withdrawalType: json['withdrawal_type'] ?? '',
      status: json['status'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdOn: json['created_on'] ?? '',
      updatedOn: json['updated_on'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count_id': countId,
      'user_id': userId,
      'passbook_no': passbookNo,
      'scheme_id': schemeId,
      'passbook_name': passbookName,
      'passbook_address': passbookAddress,
      'open_date': openDate,
      'close_date': closeDate,
      'open_store_id': openStoreId,
      'close_store_id': closeStoreId,
      'remaining_due': remainingDue,
      'closeing_amount': closeingAmount,
      'store_closedate': storeClosedate,
      'total_addon_investment_amt': totalAddonInvestmentAmt,
      'force_close': forceClose,
      'withdrawal_type': withdrawalType,
      'status': status,
      'created_by': createdBy,
      'created_on': createdOn,
      'updated_on': updatedOn,
    };
  }
}
