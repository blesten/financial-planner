import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_planner/controllers/card_controller.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/imaginary_card.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DebitCard extends StatefulWidget {
  const DebitCard({super.key});

  @override
  State<DebitCard> createState() => _DebitCardState();
}

class _DebitCardState extends State<DebitCard> {
  final CardController _cardController = Get.put(CardController());

  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _imaginaryCardNumberController =
      TextEditingController();
  final TextEditingController _cardTitleController = TextEditingController();
  String _cardTypeValue = "mastercard";
  bool _isContactless = false;
  int _cardColor = 0;

  final FocusNode _nameOnCardFocusNode = FocusNode();
  final FocusNode _imaginaryCardNumberFocusNode = FocusNode();
  final FocusNode _cardTitleFocusNode = FocusNode();

  String _cardTitleError = "";
  String _cardholderNameError = "";
  String _cardNumberError = "";

  bool _isSaving = false;

  late List<String> _months;
  late List<int> _years;
  late String _selectedMonth;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    _years = List.generate(11, (index) => DateTime.now().year - 5 + index);
    _selectedMonth = _months[DateTime.now().month - 1];
    _selectedYear = DateTime.now().year;
    _cardController.fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                child: _cardController.loading
                    ? Container(
                        width: 100.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.grey.shade200,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _upsertCard();
                        },
                        child: ReusableText(
                          text: "Add Card",
                          fontSize: 14.sp,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _cardController.loading
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 170.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                Container(
                                  width: 50.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              height: 180.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35.h),
                      SizedBox(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 170.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                Container(
                                  width: 50.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              height: 180.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : _cardController.cards.isEmpty
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
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _cardController.cards.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ReusableText(
                                          text: _cardController
                                              .cards[index].title,
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              size: 20.sp,
                                              color: Colors.blue.shade500,
                                            ),
                                            SizedBox(width: 10.w),
                                            Icon(
                                              Icons.delete,
                                              size: 20.sp,
                                              color: Colors.red.shade500,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  ImaginaryCard(
                                    cardType: _cardController.cards[index].type,
                                    cardColor:
                                        _cardController.cards[index].color,
                                    isContactless: _cardController
                                        .cards[index].contactless,
                                    cardNumber: _cardController.cards[index].no,
                                    cardholderName:
                                        _cardController.cards[index].name,
                                    cardExpDate:
                                        _cardController.cards[index].expDate,
                                  ),
                                ],
                              ),
                              SizedBox(height: 25.h),
                            ],
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }

  Future<dynamic> _upsertCard() {
    const colors = ["red", "blue", "orange", "purple", "green"];
    const monthsMap = {
      "January": "01",
      "February": "02",
      "March": "03",
      "April": "04",
      "May": "05",
      "June": "06",
      "July": "07",
      "August": "08",
      "September": "09",
      "October": "10",
      "November": "11",
      "December": "12",
    };

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => GestureDetector(
        onTap: () {
          _cardTitleFocusNode.unfocus();
          _nameOnCardFocusNode.unfocus();
          _imaginaryCardNumberFocusNode.unfocus();
        },
        child: StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: EdgeInsets.only(top: 10.h),
            height: height * 0.85,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 100.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CarouselSlider(
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      viewportFraction: 1,
                      height: 220,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _cardColor = index;
                        });
                      },
                      initialPage: _cardColor,
                    ),
                    items: colors.map((i) {
                      return Column(
                        children: [
                          ImaginaryCard(
                            cardType: _cardTypeValue,
                            cardColor: colors[colors.indexOf(i)],
                            isContactless: _isContactless,
                            cardNumber: _imaginaryCardNumberController.text,
                            cardholderName: _nameOnCardController.text,
                            cardExpDate:
                                "${monthsMap[_selectedMonth]}/$_selectedYear",
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
                                  color: colors.indexOf(i) == 0
                                      ? kPrimary
                                      : Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.h),
                                child: Container(
                                  width: 9.w,
                                  height: 9.h,
                                  color: colors.indexOf(i) == 1
                                      ? kPrimary
                                      : Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.h),
                                child: Container(
                                  width: 9.w,
                                  height: 9.h,
                                  color: colors.indexOf(i) == 2
                                      ? kPrimary
                                      : Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.h),
                                child: Container(
                                  width: 9.w,
                                  height: 9.h,
                                  color: colors.indexOf(i) == 3
                                      ? kPrimary
                                      : Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.h),
                                child: Container(
                                  width: 9.w,
                                  height: 9.h,
                                  color: colors.indexOf(i) == 4
                                      ? kPrimary
                                      : Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(
                              text: "Contactless",
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isContactless = !_isContactless;
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 45.w,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.r),
                                      border: Border.all(
                                        color: Colors.grey.shade500,
                                        style: BorderStyle.solid,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5.h,
                                    left: _isContactless ? 25.w : 5.w,
                                    child: Container(
                                      width: 15.w,
                                      height: 15.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                        color: _isContactless
                                            ? kPrimary
                                            : Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: "Card Title",
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 17.h),
                            SizedBox(
                              height: 50.h,
                              child: TextField(
                                controller: _cardTitleController,
                                focusNode: _cardTitleFocusNode,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _cardTitleError.isNotEmpty,
                              child: SizedBox(height: 10.h),
                            ),
                            Visibility(
                              visible: _cardTitleError.isNotEmpty,
                              child: ReusableText(
                                text: _cardTitleError,
                                fontSize: 11.sp,
                                color: Colors.red.shade500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: "Name on Card",
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 17.h),
                            SizedBox(
                              height: 50.h,
                              child: TextField(
                                controller: _nameOnCardController,
                                focusNode: _nameOnCardFocusNode,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _cardholderNameError.isNotEmpty,
                              child: SizedBox(height: 10.h),
                            ),
                            Visibility(
                              visible: _cardholderNameError.isNotEmpty,
                              child: ReusableText(
                                text: _cardholderNameError,
                                fontSize: 11.sp,
                                color: Colors.red.shade500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: "Imaginary Card Number",
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 17.h),
                            SizedBox(
                              height: 50.h,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 16,
                                controller: _imaginaryCardNumberController,
                                focusNode: _imaginaryCardNumberFocusNode,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  counterText: "",
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _cardNumberError.isNotEmpty,
                              child: SizedBox(height: 10.h),
                            ),
                            Visibility(
                              visible: _cardNumberError.isNotEmpty,
                              child: ReusableText(
                                text: _cardNumberError,
                                fontSize: 11.sp,
                                color: Colors.red.shade500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: "Exp Date",
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 17.h),
                            Row(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
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
                                      value: _selectedMonth,
                                      items: _months
                                          .map((String value) =>
                                              DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value)))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedMonth = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 25.w),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
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
                                      value: _selectedYear,
                                      items: _years
                                          .map((int value) => DropdownMenuItem(
                                              value: value,
                                              child: Text(value.toString())))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedYear = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: "Card Type",
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 17.h),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _cardTypeValue = "mastercard";
                                    });
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    width: 100.w,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _cardTypeValue == "mastercard"
                                            ? kPrimary
                                            : Colors.black,
                                        width: _cardTypeValue == "mastercard"
                                            ? 2.w
                                            : 1.w,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Image.asset(
                                        "assets/icons/mastercard.png"),
                                  ),
                                ),
                                SizedBox(width: 25.w),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _cardTypeValue = "visa";
                                    });
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    width: 100.w,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _cardTypeValue == "visa"
                                            ? kPrimary
                                            : Colors.black,
                                        width: _cardTypeValue == "visa"
                                            ? 2.w
                                            : 1.w,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Image.asset("assets/icons/visa.png"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                                    _cardTitleError = "";
                                    _cardholderNameError = "";
                                    _cardNumberError = "";

                                    if (_cardTitleController.text.isEmpty) {
                                      setState(() {
                                        _cardTitleError =
                                            "Card title should be filled.";
                                      });
                                    }

                                    if (_nameOnCardController.text.isEmpty) {
                                      setState(() {
                                        _cardholderNameError =
                                            "Cardholder name should be filled.";
                                      });
                                    }

                                    if (_imaginaryCardNumberController
                                        .text.isEmpty) {
                                      setState(() {
                                        _cardNumberError =
                                            "Imaginary card number should be filled";
                                      });
                                    }

                                    if (_cardTitleError.isNotEmpty ||
                                        _cardholderNameError.isNotEmpty ||
                                        _cardNumberError.isNotEmpty) {
                                      return;
                                    }

                                    setState(() {
                                      _isSaving = true;
                                    });

                                    await _cardController.addCard(
                                      title: _cardTitleController.text,
                                      name: _nameOnCardController.text,
                                      no: _imaginaryCardNumberController.text,
                                      type: _cardTypeValue,
                                      contactless: _isContactless,
                                      expDate:
                                          "${monthsMap[_selectedMonth]}/$_selectedYear",
                                      color: colors[_cardColor],
                                    );

                                    setState(() {
                                      _isSaving = false;
                                    });

                                    if (_cardController.error.isNotEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content:
                                                Text(_cardController.error),
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
                                      Navigator.of(context).pop();

                                      _cardTitleController.text = "";
                                      _nameOnCardController.text = "";
                                      _imaginaryCardNumberController.text = "";
                                      _isContactless = false;
                                      _cardTypeValue = "mastercard";
                                      _cardColor = 0;
                                    }
                                  },
                            child: _isSaving
                                ? const CircularProgressIndicator()
                                : ReusableText(
                                    text: "Save Card",
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                          ),
                        ),
                        SizedBox(height: 25.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
