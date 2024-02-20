import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FourthStepRegistration extends StatelessWidget {
  const FourthStepRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 15.h,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(CupertinoIcons.back),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableText(
                          text: 'Step 4/4',
                          fontSize: 16.sp,
                          color: kPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/registration_4.png",
                    width: width * 0.7,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 48.h),
                  ReusableText(
                    text: "Congratulations",
                    fontSize: 22.sp,
                    color: kPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 24.h),
                  ReusableText(
                    text: "Now you are registered. Get ready with",
                    fontSize: 14.sp,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  ReusableText(
                    text: "Budget Buddy",
                    fontSize: 14.sp,
                    color: kPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 48.h),
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
                        text: 'Start Now',
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}