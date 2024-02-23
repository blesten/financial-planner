import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/imaginary_card.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DebitCard extends StatefulWidget {
  const DebitCard({super.key});

  @override
  State<DebitCard> createState() => _DebitCardState();
}

class _DebitCardState extends State<DebitCard> {
  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _imaginaryCardNumberController =
      TextEditingController();
  final TextEditingController _cardTitleController = TextEditingController();
  String _cardTypeValue = "";

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
              child: GestureDetector(
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: "Primary Card",
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          Icon(Icons.edit, size: 20.sp),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    const ImaginaryCard(
                      cardType: "visa",
                      cardColor: "red",
                      isContactless: true,
                      cardNumber: "1234 5678 9012 3456",
                      cardholderName: "GIANNA LOUIS",
                      cardExpDate: "09/28",
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: "Primary Card",
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          Icon(Icons.edit, size: 20.sp),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    const ImaginaryCard(
                      cardType: "mastercard",
                      cardColor: "blue",
                      isContactless: false,
                      cardNumber: "1234 5678 9012 3456",
                      cardholderName: "GIANNA LOUIS",
                      cardExpDate: "02/29",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _upsertCard() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
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
              CarouselSlider.builder(
                itemCount: 2,
                itemBuilder: (context, index, pageViewIndex) {
                  return Column(
                    children: [
                      const ImaginaryCard(
                        cardType: "",
                        cardColor: "red",
                        isContactless: false,
                        cardNumber: "",
                        cardholderName: "",
                        cardExpDate: "",
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
                options: CarouselOptions(
                  enableInfiniteScroll: true,
                  viewportFraction: 1,
                  height: 220,
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
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
                        Stack(
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
                              left: 5.w,
                              child: Container(
                                width: 15.w,
                                height: 15.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: Colors.grey.shade500,
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
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
                            controller: _imaginaryCardNumberController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
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
                                  value: _selectedMonth,
                                  items: _months
                                      .map((String value) => DropdownMenuItem(
                                          value: value, child: Text(value)))
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
                                padding: EdgeInsets.symmetric(vertical: 8.h),
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
                                child:
                                    Image.asset("assets/icons/mastercard.png"),
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
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                width: 100.w,
                                height: 70.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _cardTypeValue == "visa"
                                        ? kPrimary
                                        : Colors.black,
                                    width: _cardTypeValue == "visa" ? 2.w : 1.w,
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
                          backgroundColor: kPrimary,
                          side: BorderSide.none,
                        ),
                        onPressed: () {},
                        child: ReusableText(
                          text: 'Save Card',
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
      ),
    );
  }
}
