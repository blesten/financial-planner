import 'package:financial_planner/widgets/home/transaction_card.dart';
import 'package:financial_planner/widgets/main_screen/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllTransaction extends StatelessWidget {
  const AllTransaction({super.key});

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
                      const TransactionCard(
                        price: "IDR 15.000,00",
                        date: "23 February 2024",
                        transactionType: "Expense",
                      ),
                      SizedBox(height: 20.h),
                      const TransactionCard(
                        price: "IDR 15.000,00",
                        date: "23 February 2024",
                        transactionType: "Expense",
                      ),
                      SizedBox(height: 20.h),
                      const TransactionCard(
                        price: "IDR 15.000,00",
                        date: "23 February 2024",
                        transactionType: "Expense",
                      ),
                      SizedBox(height: 20.h),
                      const TransactionCard(
                        price: "IDR 15.000,00",
                        date: "23 February 2024",
                        transactionType: "Expense",
                      ),
                      SizedBox(height: 20.h),
                      const TransactionCard(
                        price: "IDR 15.000,00",
                        date: "23 February 2024",
                        transactionType: "Expense",
                      ),
                      SizedBox(height: 20.h),
                      const TransactionCard(
                        price: "IDR 15.000,00",
                        date: "23 February 2024",
                        transactionType: "Expense",
                      ),
                      SizedBox(height: 20.h),
                      const TransactionCard(
                        price: "IDR 15.000,00",
                        date: "23 February 2024",
                        transactionType: "Expense",
                      ),
                      SizedBox(height: 20.h),
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
