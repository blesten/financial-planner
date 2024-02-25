class TransactionModel {
  String transactionCategory;
  double amount;
  String expenseCategory;
  String createdAt;

  TransactionModel({
    required this.transactionCategory,
    required this.amount,
    required this.expenseCategory,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionCategory: json['transactionCategory'],
      amount: double.parse(json['amount'].toString()),
      expenseCategory: json['expenseCategory'],
      createdAt: json['createdAt'],
    );
  }
}
