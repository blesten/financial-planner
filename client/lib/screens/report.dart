import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_planner/controllers/home_controller.dart';
import 'package:financial_planner/controllers/user_controller.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/utils/formatter.dart';
import 'package:financial_planner/widgets/general/imaginary_card.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final CarouselController _carouselController = CarouselController();
  final HomeController _homeController = Get.find<HomeController>();
  final UserController _userController = Get.find<UserController>();

  double _income = 0;
  double _expense = 0;
  double _saving = 0;
  double _investment = 0;
  double _food = 0;
  double _snack = 0;
  double _selfReward = 0;
  double _monthlyNeeds = 0;
  double _transportation = 0;

  Future<void> fetchSummary(String cardId) async {
    try {
      final response = await http.get(
        Uri.parse("$serverURL/api/v1/transactions/summarize/card/$cardId"),
        headers: {"Authorization": _userController.accessToken},
      );

      if (response.statusCode == 200) {
        setState(() {
          _income =
              double.parse(json.decode(response.body)['income'].toString());
          _expense =
              double.parse(json.decode(response.body)['expense'].toString());
          _saving =
              double.parse(json.decode(response.body)['saving'].toString());
          _investment =
              double.parse(json.decode(response.body)['investment'].toString());
          _food = double.parse(json.decode(response.body)['food'].toString());
          _snack = double.parse(json.decode(response.body)['snack'].toString());
          _selfReward =
              double.parse(json.decode(response.body)['selfReward'].toString());
          _monthlyNeeds = double.parse(
              json.decode(response.body)['monthlyNeeds'].toString());
          _transportation = double.parse(
              json.decode(response.body)['transportation'].toString());
        });
      }
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    if (_homeController.cards.isNotEmpty) {
      fetchSummary(_homeController.cards[0].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _homeController.cards.isEmpty
          ? Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/empty_card.png"),
                    SizedBox(height: 30.h),
                    ReusableText(
                      text: "Oops, it seems like you haven't create a card yet",
                      fontSize: 17.sp,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      height: 1.8.h,
                    ),
                  ],
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                  child: ReusableText(
                    text:
                        "${DateTime.now().month == 1 ? "January" : DateTime.now().month == 2 ? "February" : DateTime.now().month == 3 ? "March" : DateTime.now().month == 4 ? "April" : DateTime.now().month == 5 ? "May" : DateTime.now().month == 6 ? "June" : DateTime.now().month == 7 ? "July" : DateTime.now().month == 8 ? "August" : DateTime.now().month == 9 ? "September" : DateTime.now().month == 10 ? "October" : DateTime.now().month == 11 ? "November" : DateTime.now().month == 12 ? "December" : ""} ${DateTime.now().year} Report",
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
                    onPageChanged: (index, reason) {
                      fetchSummary(_homeController.cards[index].id);
                    },
                  ),
                  itemCount: _homeController.cards.length,
                  itemBuilder: (context, index, pageViewIndex) {
                    return Column(
                      children: [
                        ImaginaryCard(
                          cardType: _homeController.cards[index].type,
                          cardColor: _homeController.cards[index].color,
                          isContactless:
                              _homeController.cards[index].contactless,
                          cardNumber: _homeController.cards[index].no,
                          cardholderName: _homeController.cards[index].name,
                          cardExpDate: _homeController.cards[index].expDate,
                        ),
                        Visibility(
                          visible: _homeController.cards.length > 1,
                          child: SizedBox(height: 12.h),
                        ),
                        Visibility(
                          visible: _homeController.cards.length > 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ..._homeController.cards.map((item) {
                                return Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50.h),
                                      child: Container(
                                        width: 9.w,
                                        height: 9.h,
                                        color: index ==
                                                _homeController.cards
                                                    .indexOf(item)
                                            ? kPrimary
                                            : Colors.grey.shade500,
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                  ],
                                );
                              })
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                _income == 0 &&
                        _expense == 0 &&
                        _saving == 0 &&
                        _investment == 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical:
                                _homeController.cards.length > 1 ? 12.h : 0),
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h, bottom: 35.h),
                          width: width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade400,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: ReusableText(
                              text:
                                  "It seems like there's no any recent transactions yet on this card",
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              height: 1.5.h,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: _homeController.cards.length > 1
                                  ? 25.h
                                  : 10.h),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  text: formatToIDR(_income),
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
                                                      (_investment / _income) *
                                                          width /
                                                          2,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.orange.shade500,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  left: 8,
                                                  child: ReusableText(
                                                    text: formatToIDR(
                                                        _investment),
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
                                                  width: (_saving / _income) *
                                                      width /
                                                      2,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue.shade500,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  left: 8,
                                                  child: ReusableText(
                                                    text: formatToIDR(_saving),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                      text: "Amount left to spend",
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    ReusableText(
                                      text: formatToIDR(
                                          _income - _saving - _investment),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: (_food /
                                                          (_income -
                                                              _saving -
                                                              _investment)) *
                                                      width /
                                                      2,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.orange.shade300,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  left: 8,
                                                  child: ReusableText(
                                                    text: formatToIDR(_food),
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
                                                  width: (_snack /
                                                          (_income -
                                                              _saving -
                                                              _investment)) *
                                                      width /
                                                      2,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.shade500,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  left: 8,
                                                  child: ReusableText(
                                                    text: formatToIDR(_snack),
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
                                                  width: (_selfReward /
                                                          (_income -
                                                              _saving -
                                                              _investment)) *
                                                      width /
                                                      2,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.purple.shade300,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  left: 8,
                                                  child: ReusableText(
                                                    text: formatToIDR(
                                                        _selfReward),
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
                                                  width: (_monthlyNeeds /
                                                          (_income -
                                                              _saving -
                                                              _investment)) *
                                                      width /
                                                      2,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.orange.shade700,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  left: 8,
                                                  child: ReusableText(
                                                    text: formatToIDR(
                                                        _monthlyNeeds),
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
                                                  width: (_transportation /
                                                          (_income -
                                                              _saving -
                                                              _investment)) *
                                                      width /
                                                      2,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue.shade600,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  left: 8,
                                                  child: ReusableText(
                                                    text: formatToIDR(
                                                        _transportation),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                      text: "Total spent",
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    ReusableText(
                                      text: formatToIDR(_expense),
                                      fontSize: 14.sp,
                                      color: _expense <=
                                              (_income - _saving - _investment)
                                          ? Colors.green.shade500
                                          : Colors.red.shade500,
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
    );
  }
}
