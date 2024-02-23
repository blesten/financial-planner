import 'package:financial_planner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ImaginaryCard extends StatelessWidget {
  final String cardType;
  final String cardColor;
  final bool isContactless;
  final String cardNumber;
  final String cardholderName;
  final String cardExpDate;

  const ImaginaryCard({
    super.key,
    required this.cardType,
    required this.cardColor,
    required this.isContactless,
    required this.cardNumber,
    required this.cardholderName,
    required this.cardExpDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.h),
      width: width,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        image: DecorationImage(
          image: AssetImage("assets/card_templates/$cardColor.png"),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/icons/${cardType == 'mastercard' ? 'mastercard' : 'visa'}.png",
                width: 45.w,
                fit: BoxFit.contain,
              ),
              Text(
                'DEBIT CARD',
                style: GoogleFonts.firaCode(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/icons/chip.png"),
                  if (isContactless)
                    Image.asset("assets/icons/contactless.png"),
                ],
              ),
              SizedBox(height: 15.h),
              Text(
                cardNumber,
                style: GoogleFonts.firaCode(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cardholderName,
                    style: GoogleFonts.firaCode(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    cardExpDate,
                    style: GoogleFonts.firaCode(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
