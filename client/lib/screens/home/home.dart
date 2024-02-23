import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_planner/screens/home/all_transaction.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/imaginary_card.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:financial_planner/widgets/home/financial_overview.dart';
import 'package:financial_planner/widgets/home/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final CarouselController _carouselController = CarouselController();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: 1,
            height: 220,
          ),
          itemCount: 2,
          itemBuilder: (context, index, pageViewIndex) {
            return Column(
              children: [
                const ImaginaryCard(
                  cardType: "mastercard",
                  cardColor: "blue",
                  isContactless: true,
                  cardNumber: "1234 5678 0123 4567",
                  cardholderName: "GIANNA LOUIS",
                  cardExpDate: "09/28",
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.h),
                      child: Container(
                        width: 9.w,
                        height: 9.h,
                        color: kPrimary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.h),
                      child: Container(
                        width: 9.w,
                        height: 9.h,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: "Financial Overview",
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  const FinancialOverview(),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text: "Recent Transactions",
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => const AllTransaction(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                          );
                        },
                        child: ReusableText(
                          text: "View all",
                          fontSize: 14.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  const TransactionCard(
                    price: "IDR 15.000,00",
                    date: "23 February 2024",
                    transactionType: "Expense",
                  ),
                  SizedBox(height: 25.h),
                  const TransactionCard(
                    price: "IDR 15.000,00",
                    date: "23 February 2024",
                    transactionType: "Expense",
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
