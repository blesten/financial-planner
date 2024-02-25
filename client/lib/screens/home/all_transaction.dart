import 'package:financial_planner/controllers/user_controller.dart';
import 'package:financial_planner/models/transaction_model.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/home/transaction_card.dart';
import 'package:financial_planner/widgets/main_screen/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllTransaction extends StatefulWidget {
  String cardId = "";

  AllTransaction({super.key, required this.cardId});

  @override
  State<AllTransaction> createState() => _AllTransactionState();
}

class _AllTransactionState extends State<AllTransaction> {
  final UserController _userController = Get.find<UserController>();

  List<TransactionModel> _transactions = [];

  Future<void> fetchAllTransactions() async {
    try {
      final response = await http.get(
        Uri.parse("$serverURL/api/v1/transactions/card/${widget.cardId}"),
        headers: {"Authorization": _userController.accessToken},
      );

      setState(() {
        final List<dynamic> data = json.decode(response.body)['transactions'];
        _transactions =
            data.map((json) => TransactionModel.fromJson(json)).toList();
      });
    } catch (err) {
      throw Exception(err);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: const CustomAppBar(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  CupertinoIcons.back,
                ),
              ),
              SizedBox(height: 25.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ..._transactions.map((item) {
                        return Column(
                          children: [
                            TransactionCard(
                              price: item.amount.toString(),
                              date: item.createdAt,
                              transactionType: item.transactionCategory,
                              expenseCategory: item.expenseCategory,
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
