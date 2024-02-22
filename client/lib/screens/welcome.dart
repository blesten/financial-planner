import 'package:financial_planner/screens/login/login_phone.dart';
import 'package:financial_planner/screens/register/register.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:financial_planner/widgets/welcome/carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Carousel(),
              SizedBox(height: 20.h),
              SizedBox(
                width: width * 0.9,
                height: 52.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: kPrimary,
                    side: BorderSide.none,
                  ),
                  onPressed: () {
                    Get.to(
                      () => Register(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  child: ReusableText(
                    text: 'Create Account',
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const LoginPhone(),
                    transition: Transition.fadeIn,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                  );
                },
                child: ReusableText(
                  text: "Login to Account",
                  fontSize: 14.sp,
                  color: kPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
