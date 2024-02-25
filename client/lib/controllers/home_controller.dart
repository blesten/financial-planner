import 'package:financial_planner/controllers/user_controller.dart';
import 'package:financial_planner/models/card_model.dart';
import 'package:financial_planner/models/transaction_model.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  final UserController _userController = Get.find<UserController>();

  final RxList<CardModel> _cards = <CardModel>[].obs;
  final RxString _cardError = "".obs;
  final RxBool _cardLoading = false.obs;

  final RxList<TransactionModel> _recentTransactions = <TransactionModel>[].obs;
  final RxBool _recentTransactionsLoading = false.obs;
  final RxString _recentTransactionsError = "".obs;

  final RxDouble _income = 0.0.obs;
  final RxDouble _expense = 0.0.obs;
  final RxDouble _saving = 0.0.obs;
  final RxDouble _investment = 0.0.obs;
  final RxString _overviewError = "".obs;
  final RxBool _overviewLoading = false.obs;

  Future<void> fetchCards() async {
    try {
      _cardLoading.value = true;

      final response = await http.get(
        Uri.parse("$serverURL/api/v1/cards"),
        headers: {"Authorization": _userController.accessToken},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['cards'];
        _cards.value = data.map((json) => CardModel.fromJson(json)).toList();
      } else {
        _cardError.value = json.decode(response.body)['msg'];
        throw Exception("Failed to fetch cards");
      }
    } catch (err) {
      _cardError.value = err.toString();
      throw Exception("Failed to fetch cards");
    } finally {
      _cardLoading.value = false;
    }
  }

  Future<void> fetchTransactionOverview(String cardId) async {
    try {
      _overviewLoading.value = true;

      final response = await http.get(
        Uri.parse("$serverURL/api/v1/transactions/summarize/card/$cardId"),
        headers: {"Authorization": _userController.accessToken},
      );

      if (response.statusCode == 200) {
        _income.value =
            double.parse(json.decode(response.body)['income'].toString());
        _investment.value =
            double.parse(json.decode(response.body)['investment'].toString());
        _expense.value =
            double.parse(json.decode(response.body)['expense'].toString());
        _saving.value =
            double.parse(json.decode(response.body)['saving'].toString());
      } else {
        _overviewError.value = json.decode(response.body)['msg'];
      }
    } catch (err) {
      _overviewError.value = err.toString();
    } finally {
      _overviewLoading.value = false;
    }
  }

  Future<void> fetchRecentTransactions(String cardId) async {
    try {
      _recentTransactionsLoading.value = true;

      final response = await http.get(
        Uri.parse("$serverURL/api/v1/transactions/recent/card/$cardId"),
        headers: {"Authorization": _userController.accessToken},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['transactions'];
        _recentTransactions.value =
            data.map((json) => TransactionModel.fromJson(json)).toList();
      }
    } catch (err) {
      _recentTransactionsError.value = err.toString();
    } finally {
      _recentTransactionsLoading.value = false;
    }
  }

  Future<void> addTransaction({
    required String cardId,
    required String transactionCategory,
    required String amount,
    required String expenseCategory,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$serverURL/api/v1/transactions"),
        body: {
          "cardId": cardId,
          "transactionCategory": transactionCategory,
          "amount": amount,
          "expenseCategory": expenseCategory,
        },
        headers: {"Authorization": _userController.accessToken},
      );

      if (response.statusCode == 201) {
        final transaction = json.decode(response.body)['transaction'];

        _recentTransactions.insert(
          0,
          TransactionModel(
            transactionCategory: transaction['transactionCategory'],
            amount: double.parse(transaction['amount'].toString()),
            expenseCategory: transaction['expenseCategory'],
            createdAt: transaction['createdAt'],
          ),
        );

        if (_recentTransactions.length > 5) {
          _recentTransactions.removeRange(5, _recentTransactions.length);
        }

        if (transactionCategory == "income") {
          _income.value += double.parse(transaction['amount'].toString());
        } else if (transactionCategory == "saving") {
          _saving.value += double.parse(transaction['amount'].toString());
        } else if (transactionCategory == "investment") {
          _investment.value += double.parse(transaction['amount'].toString());
        } else {
          _expense.value += double.parse(transaction['amount'].toString());
        }
      } else {
        _recentTransactionsError.value = json.decode(response.body)['msg'];
      }
    } catch (err) {
      _recentTransactionsError.value = err.toString();
    }
  }

  List<CardModel> get cards => _cards;

  List<TransactionModel> get recentTransactions => _recentTransactions;

  bool get cardLoading => _cardLoading.value;

  bool get recentTransactionsLoading => _recentTransactionsLoading.value;

  bool get overviewLoading => _overviewLoading.value;

  String get recentTransactionsError => _recentTransactionsError.value;

  double get income => _income.value;

  double get expense => _expense.value;

  double get saving => _saving.value;

  double get investment => _investment.value;
}
