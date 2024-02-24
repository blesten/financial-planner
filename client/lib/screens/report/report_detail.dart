import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/imaginary_card.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:financial_planner/widgets/main_screen/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportDetail extends StatelessWidget {
  final CarouselController _carouselController = CarouselController();

  ReportDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: CustomAppBar(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(CupertinoIcons.back),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ReusableText(
                text: "February 2024 Report",
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15.h),
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: "Income",
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 25.h),
                              ReusableText(
                                text: "Investment",
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 25.h),
                              ReusableText(
                                text: "Saving",
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade500,
                                      ),
                                    ),
                                    Positioned(
                                      top: 7,
                                      left: 8,
                                      child: ReusableText(
                                        text: "IDR 50.000.000,00",
                                        fontSize: 11.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width: width,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:
                                            (25000000 / 50000000) * width / 2,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade500,
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 8,
                                        child: ReusableText(
                                          text: "IDR 25.000.000,00",
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width: width,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: (5000000 / 50000000) * width / 2,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade500,
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 8,
                                        child: ReusableText(
                                          text: "IDR 5.000.000,00",
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: "Amount left to spend",
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          ReusableText(
                            text: "IDR 15.000.000,00",
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: "Food",
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 25.h),
                              ReusableText(
                                text: "Snack",
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 25.h),
                              ReusableText(
                                text: "Self Reward",
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 25.h),
                              ReusableText(
                                text: "Monthly Needs",
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 25.h),
                              ReusableText(
                                text: "Transportation",
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: (3400000 / 15000000) * width / 2,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade300,
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 8,
                                        child: ReusableText(
                                          text: "IDR 3.400.000,00",
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width: width,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: (1200000 / 15000000) * width / 2,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade500,
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 8,
                                        child: ReusableText(
                                          text: "IDR 1.200.000,00",
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width: width,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: (3000000 / 15000000) * width / 2,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.purple.shade300,
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 8,
                                        child: ReusableText(
                                          text: "IDR 3.000.000,00",
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width: width,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: (500000 / 15000000) * width / 2,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade700,
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 8,
                                        child: ReusableText(
                                          text: "IDR 500.000,00",
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width: width,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: (3000000 / 15000000) * width / 2,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade600,
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 8,
                                        child: ReusableText(
                                          text: "IDR 3.000.000,00",
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: "Total spent",
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          ReusableText(
                            text: "IDR 15.000.000,00",
                            fontSize: 14.sp,
                            color: Colors.green.shade500,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
