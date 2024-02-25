import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_planner/controllers/bottom_nav_controller.dart';
import 'package:financial_planner/controllers/home_controller.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/imaginary_card.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _bottomNavController = Get.put(BottomNavController());
  final _homeController = Get.find<HomeController>();

  final TextEditingController _amountController = TextEditingController();

  final FocusNode _amountFocusNode = FocusNode();

  String _selectedTransactionCategory = "income";
  String _selectedExpenseCategory = "food";

  String _selectedCard = "";

  String _amountError = "";

  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 27.h),
        child: Container(
          width: width * 0.8,
          height: 65.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(50.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _bottomNavController.currentIndex = 0;
                },
                child: Icon(
                  Icons.home,
                  color: _bottomNavController.currentIndex == 0
                      ? kPrimary
                      : kPrimary.withOpacity(0.2),
                  size: 30.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _bottomNavController.currentIndex = 1;
                },
                child: Icon(
                  Icons.credit_card,
                  color: _bottomNavController.currentIndex == 1
                      ? kPrimary
                      : kPrimary.withOpacity(0.2),
                  size: 30.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_homeController.cards.isNotEmpty) {
                    setState(() {
                      _selectedCard = _homeController.cards[0].id;
                    });
                    _addTransaction();
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Restricted"),
                          content: const Text(
                              "You don't have any card to add transaction."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    color: kPrimary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _bottomNavController.currentIndex = 2;
                },
                child: Icon(
                  _bottomNavController.currentIndex == 2
                      ? CupertinoIcons.lightbulb_fill
                      : CupertinoIcons.lightbulb,
                  color: _bottomNavController.currentIndex == 2
                      ? kPrimary
                      : kPrimary.withOpacity(0.2),
                  size: 26.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _bottomNavController.currentIndex = 3;
                },
                child: Icon(
                  _bottomNavController.currentIndex == 3
                      ? CupertinoIcons.person_circle_fill
                      : CupertinoIcons.person_circle,
                  color: _bottomNavController.currentIndex == 3
                      ? kPrimary
                      : kPrimary.withOpacity(0.2),
                  size: 30.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _addTransaction() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => GestureDetector(
        onTap: () {
          _amountFocusNode.unfocus();
        },
        child: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Container(
                        width: 100.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        height: 220,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _selectedCard = _homeController.cards[index].id;
                          });
                        },
                      ),
                      items: _homeController.cards.map((item) {
                        return Column(
                          children: [
                            ImaginaryCard(
                              cardType: item.type,
                              cardColor: item.color,
                              isContactless: item.contactless,
                              cardNumber: item.no,
                              cardholderName: item.name,
                              cardExpDate: item.expDate,
                            ),
                            if (_homeController.cards.length > 1)
                              SizedBox(height: 12.w),
                            if (_homeController.cards.length > 1)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i < _homeController.cards.length;
                                      i++)
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.h),
                                          child: Container(
                                            width: 9.w,
                                            height: 9.h,
                                            color: _homeController.cards
                                                        .indexOf(item) ==
                                                    i
                                                ? kPrimary
                                                : Colors.grey.shade500,
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                      ],
                                    ),
                                ],
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: _homeController.cards.length > 1 ? 25.h : 0,
                          left: 20.w,
                          right: 20.w,
                          bottom: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: "Transaction Category",
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 17.h),
                          Container(
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade700,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: _selectedTransactionCategory,
                                items: const [
                                  DropdownMenuItem(
                                    value: "income",
                                    child: Text('Income'),
                                  ),
                                  DropdownMenuItem(
                                    value: "saving",
                                    child: Text('Saving'),
                                  ),
                                  DropdownMenuItem(
                                    value: "investment",
                                    child: Text('Investment'),
                                  ),
                                  DropdownMenuItem(
                                    value: "expense",
                                    child: Text('Expense'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedTransactionCategory = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: "Amount",
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 17.h),
                              SizedBox(
                                height: 50.h,
                                child: TextField(
                                  controller: _amountController,
                                  focusNode: _amountFocusNode,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    prefixText: "IDR  ",
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _amountError.isNotEmpty,
                                child: SizedBox(height: 10.h),
                              ),
                              Visibility(
                                visible: _amountError.isNotEmpty,
                                child: ReusableText(
                                  text: _amountError,
                                  fontSize: 14.sp,
                                  color: Colors.red.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.h),
                          if (_selectedTransactionCategory == "expense")
                            ReusableText(
                              text: "Expense Category",
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          if (_selectedTransactionCategory == "expense")
                            SizedBox(height: 17.h),
                          if (_selectedTransactionCategory == "expense")
                            Container(
                              width: width,
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade700,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: _selectedExpenseCategory,
                                  items: const [
                                    DropdownMenuItem(
                                      value: "food",
                                      child: Text('Food'),
                                    ),
                                    DropdownMenuItem(
                                      value: "snack",
                                      child: Text('Snack'),
                                    ),
                                    DropdownMenuItem(
                                      value: "selfReward",
                                      child: Text('Self Reward'),
                                    ),
                                    DropdownMenuItem(
                                      value: "monthlyNeeds",
                                      child: Text('Monthly Needs'),
                                    ),
                                    DropdownMenuItem(
                                      value: "transportation",
                                      child: Text('Transportation'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedExpenseCategory = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          if (_selectedTransactionCategory == "expense")
                            SizedBox(height: 30.h),
                          SizedBox(
                            width: width * 0.9,
                            height: 52.h,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: _isSaving
                                    ? kPrimary.withOpacity(0.2)
                                    : kPrimary,
                                side: BorderSide.none,
                              ),
                              onPressed: _isSaving
                                  ? null
                                  : () async {
                                      setState(() {
                                        _isSaving = true;
                                        _amountError = "";
                                      });

                                      if (_amountController.text.isEmpty) {
                                        setState(() {
                                          _amountError =
                                              "Please provide valid amount";
                                          _isSaving = false;
                                        });
                                        return;
                                      }

                                      await _homeController.addTransaction(
                                        cardId: _selectedCard,
                                        transactionCategory:
                                            _selectedTransactionCategory,
                                        amount: _amountController.text,
                                        expenseCategory:
                                            _selectedTransactionCategory ==
                                                    "expense"
                                                ? _selectedExpenseCategory
                                                : "",
                                      );

                                      if (_homeController
                                          .recentTransactionsError.isNotEmpty) {
                                        setState(() {
                                          _isSaving = false;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text(_homeController
                                                  .recentTransactionsError),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        setState(() {
                                          _isSaving = false;
                                        });
                                        if (_homeController.cards.length > 1) {
                                          _homeController
                                              .fetchTransactionOverview(
                                                  _homeController
                                                      .currentCarousel);
                                          _homeController
                                              .fetchRecentTransactions(
                                                  _homeController
                                                      .currentCarousel);
                                        }
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Success"),
                                              content: Text(
                                                  "Transaction has been added successfully"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                              child: _isSaving
                                  ? const CircularProgressIndicator()
                                  : ReusableText(
                                      text: 'Save Card',
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ).then((value) {
      setState(() {
        _selectedTransactionCategory = "income";
        _selectedExpenseCategory = "food";
        _amountController.clear();
      });
    });
  }
}
