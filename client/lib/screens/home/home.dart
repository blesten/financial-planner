import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_planner/controllers/home_controller.dart';
import 'package:financial_planner/screens/home/all_transaction.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/imaginary_card.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:financial_planner/widgets/home/financial_overview.dart';
import 'package:financial_planner/widgets/home/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = Get.put(HomeController());

  final CarouselController _carouselController = CarouselController();

  String _currentCard = "";

  Future<void> initializeData() async {
    await _homeController.fetchCards();
    if (_homeController.cards.isNotEmpty) {
      _homeController.currentCarousel = _homeController.cards[0].id;
      _currentCard = _homeController.cards[0].id;
      await _homeController
          .fetchRecentTransactions(_homeController.cards[0].id);
      await _homeController
          .fetchTransactionOverview(_homeController.cards[0].id);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _homeController.cardLoading
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                )
              : _homeController.cards.isEmpty
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/empty_card.png"),
                            SizedBox(height: 30.h),
                            ReusableText(
                              text:
                                  "Oops, it seems like you haven't create a card yet",
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
                  : Expanded(
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 1,
                                height: 220,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentCard =
                                        _homeController.cards[index].id;
                                  });
                                  _homeController.currentCarousel =
                                      _homeController.cards[index].id;
                                  _homeController.fetchTransactionOverview(
                                      _homeController.cards[index].id);
                                  _homeController.fetchRecentTransactions(
                                      _homeController.cards[index].id);
                                }),
                            itemCount: _homeController.cards.length,
                            itemBuilder: (context, index, pageViewIndex) {
                              return Column(
                                children: [
                                  ImaginaryCard(
                                    cardType: _homeController.cards[index].type,
                                    cardColor:
                                        _homeController.cards[index].color,
                                    isContactless: _homeController
                                        .cards[index].contactless,
                                    cardNumber: _homeController.cards[index].no,
                                    cardholderName:
                                        _homeController.cards[index].name,
                                    cardExpDate:
                                        _homeController.cards[index].expDate,
                                  ),
                                  SizedBox(height: 12.h),
                                  if (_homeController.cards.length > 1)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0;
                                            i < _homeController.cards.length;
                                            i++)
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.h),
                                                child: Container(
                                                  width: 9.w,
                                                  height: 9.h,
                                                  color: i == index
                                                      ? kPrimary
                                                      : Colors.grey.shade500,
                                                ),
                                              ),
                                              SizedBox(width: 12.w),
                                            ],
                                          ),
                                      ],
                                    ),
                                ],
                              );
                            },
                          ),
                          if (_homeController.cards.length > 1)
                            SizedBox(height: 24.h),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 7.h),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _homeController.overviewLoading
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 150.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                              ),
                                              SizedBox(height: 25.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: 160.w,
                                                    height: 160.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80.r),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 30.w,
                                                            height: 30.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r),
                                                            ),
                                                          ),
                                                          SizedBox(width: 12.w),
                                                          Container(
                                                            width: 80.w,
                                                            height: 30.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 30.w,
                                                            height: 30.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r),
                                                            ),
                                                          ),
                                                          SizedBox(width: 12.w),
                                                          Container(
                                                            width: 80.w,
                                                            height: 30.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 30.w,
                                                            height: 30.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r),
                                                            ),
                                                          ),
                                                          SizedBox(width: 12.w),
                                                          Container(
                                                            width: 80.w,
                                                            height: 30.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.r),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 30.h),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                text: "Financial Overview",
                                                fontSize: 15.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              _homeController.recentTransactions
                                                          .isEmpty ||
                                                      (_homeController
                                                                  .saving ==
                                                              0 &&
                                                          _homeController
                                                                  .investment ==
                                                              0 &&
                                                          _homeController
                                                                  .expense ==
                                                              0)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          top: 20.h,
                                                          bottom: 35.h),
                                                      width: width,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 20.w,
                                                        vertical: 12.h,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .orange.shade400,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                      ),
                                                      child: Center(
                                                        child: ReusableText(
                                                          text:
                                                              "It seems like there's no any recent transactions yet on this card",
                                                          fontSize: 14.sp,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.5.h,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    )
                                                  : FinancialOverview(
                                                      income: _homeController
                                                          .income,
                                                      expense: _homeController
                                                          .expense,
                                                      saving: _homeController
                                                          .saving,
                                                      investment:
                                                          _homeController
                                                              .investment,
                                                    ),
                                            ],
                                          ),
                                    SizedBox(height: 6.h),
                                    _homeController.recentTransactionsLoading
                                        ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 150.w,
                                                    height: 30.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 75.w,
                                                    height: 30.h,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 35.h),
                                              Container(
                                                width: width,
                                                height: 80.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                              ),
                                              SizedBox(height: 25.h),
                                              Container(
                                                width: width,
                                                height: 80.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                              ),
                                            ],
                                          )
                                        : _homeController
                                                .recentTransactions.isEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                    text: "Recent Transactions",
                                                    fontSize: 15.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  SizedBox(height: 25.h),
                                                  Container(
                                                    width: width,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20.w,
                                                      vertical: 12.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .orange.shade400,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                    ),
                                                    child: Center(
                                                      child: ReusableText(
                                                        text:
                                                            "It seems like there's no any recent transactions yet on this card",
                                                        fontSize: 14.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.5.h,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ReusableText(
                                                        text:
                                                            "Recent Transactions",
                                                        fontSize: 15.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                            () =>
                                                                AllTransaction(
                                                              cardId:
                                                                  _currentCard,
                                                            ),
                                                            transition:
                                                                Transition
                                                                    .rightToLeft,
                                                            duration:
                                                                const Duration(
                                                              milliseconds: 200,
                                                            ),
                                                          );
                                                        },
                                                        child: ReusableText(
                                                          text: "View all",
                                                          fontSize: 14.sp,
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 25.h),
                                                  ..._homeController
                                                      .recentTransactions
                                                      .map(
                                                    (item) {
                                                      return Column(
                                                        children: [
                                                          TransactionCard(
                                                            price: item.amount
                                                                .toString(),
                                                            date:
                                                                item.createdAt,
                                                            transactionType: item
                                                                .transactionCategory,
                                                            expenseCategory: item
                                                                .expenseCategory,
                                                          ),
                                                          SizedBox(
                                                              height: 25.h),
                                                        ],
                                                      );
                                                    },
                                                  ).toList(),
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
        ],
      ),
    );
  }
}
