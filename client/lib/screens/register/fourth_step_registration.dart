import 'package:financial_planner/controllers/register_controller.dart';
import 'package:financial_planner/screens/login/login.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FourthStepRegistration extends StatelessWidget {
  final _registerStepController = Get.find<RegisterController>();

  FourthStepRegistration({super.key});

  Future<void> _completeRegistration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        "budget_buddy_no", _registerStepController.phoneNumber);
    await prefs.setBool("budget_buddy_is_registered_status", true);
  }

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
                      onPressed: () async {
                        _completeRegistration();
                        Get.to(
                          () => const Login(),
                          transition: Transition.fadeIn,
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                        );
                      },
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
