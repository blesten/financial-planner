import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/utils/formatter.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionCard extends StatelessWidget {
  final String price;
  final String date;
  final String transactionType;
  final String? expenseCategory;

  const TransactionCard({
    super.key,
    required this.price,
    required this.date,
    required this.transactionType,
    this.expenseCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/icons/${expenseCategory == "food" ? "food" : expenseCategory == "snack" ? "snack" : expenseCategory == "transportation" ? "transportation" : expenseCategory == "selfReward" ? "self_reward" : expenseCategory == "monthlyNeeds" ? "monthly_needs" : "${transactionType.substring(0, 1).toLowerCase()}${transactionType.substring(1)}"}.png",
                width: 40.w,
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: formatToIDR(double.parse(price)),
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8.h),
                  ReusableText(
                    text: formatDate(date),
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
              color: transactionType == "income"
                  ? const Color(0xFF31D337)
                  : transactionType == 'investment' ||
                          transactionType == 'saving'
                      ? const Color(0xFF4D8AFF)
                      : Colors.red.shade500,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: ReusableText(
              text:
                  "${transactionType.substring(0, 1).toUpperCase()}${transactionType.substring(1)}",
              fontSize: 10.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
