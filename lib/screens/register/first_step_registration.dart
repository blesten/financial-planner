import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstStepRegistration extends StatefulWidget {
  const FirstStepRegistration({super.key});

  @override
  State<FirstStepRegistration> createState() => _FirstStepRegistrationState();
}

class _FirstStepRegistrationState extends State<FirstStepRegistration> {
  final _phoneNumberController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                            text: 'Step 1/4',
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
                        "assets/images/registration_1.png",
                        width: width * 0.7,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 48.h),
                      ReusableText(
                        text: "Registration",
                        fontSize: 22.sp,
                        color: kPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 24.h),
                      ReusableText(
                        text:
                            "Enter your mobile number, we will send you OTP to verify later",
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        height: 1.5,
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        width: width * 0.9,
                        height: 52.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade700,
                            style: BorderStyle.solid,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 32.h,
                                  margin: EdgeInsets.only(left: 15.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 40.w,
                                        height: 14.h,
                                        decoration: const BoxDecoration(
                                            color: Colors.red),
                                      ),
                                      Container(
                                        width: 40.w,
                                        height: 14.h,
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                ReusableText(
                                  text: "+62",
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                            SizedBox(width: 7.w),
                            Expanded(
                              child: SizedBox(
                                height: 32.h,
                                child: TextField(
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  focusNode: _focusNode,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 42.h),
                      SizedBox(
                        width: width * 0.9,
                        height: 52.h,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: kPrimary,
                            side: BorderSide.none,
                          ),
                          onPressed: () {
                            print(_phoneNumberController.text);
                          },
                          child: ReusableText(
                            text: 'Continue',
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
