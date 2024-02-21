import 'package:financial_planner/controllers/register_controller.dart';
import 'package:financial_planner/screens/register/second_step_registration.dart';
import 'package:financial_planner/screens/welcome.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FirstStepRegistration extends StatefulWidget {
  const FirstStepRegistration({super.key});

  @override
  State<FirstStepRegistration> createState() => _FirstStepRegistrationState();
}

class _FirstStepRegistrationState extends State<FirstStepRegistration> {
  final _registerStepController = Get.find<RegisterController>();
  final _phoneNumberController = TextEditingController();
  final _focusNode = FocusNode();

  String _error = "";
  bool _isLoading = false;

  Future<void> sendOtp(String handphoneNo) async {
    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      var url = '$serverURL/api/v1/users/checkHandphoneNo/$handphoneNo';

      var response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        setState(() {
          _error = json.decode(response.body)['msg'];
        });
      }
    } catch (err) {
      setState(() {
        _error = err.toString();
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (_registerStepController.phoneNumber.isNotEmpty) {
      _phoneNumberController.text = _registerStepController.phoneNumber;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
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
                        onTap: () {
                          Get.to(
                            () => const Welcome(),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        child: const Icon(CupertinoIcons.back),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReusableText(
                              text:
                                  'Step ${_registerStepController.currentStep + 1}/4',
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.9,
                              height: 52.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade700,
                                  style: BorderStyle.solid,
                                  width: 1.w,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
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
                            Visibility(
                              visible: _error.isNotEmpty,
                              child: SizedBox(height: 12.h),
                            ),
                            Visibility(
                              visible: _error.isNotEmpty,
                              child: ReusableText(
                                text: _error,
                                fontSize: 11.sp,
                                color: Colors.red.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 42.h),
                        SizedBox(
                          width: width * 0.9,
                          height: 52.h,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: _isLoading
                                  ? kPrimary.withOpacity(0.2)
                                  : kPrimary,
                              side: BorderSide.none,
                            ),
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    if (_phoneNumberController.text.length <
                                        10) {
                                      setState(() {
                                        _error =
                                            "Please provide valid phone number";
                                      });
                                      return;
                                    }

                                    _registerStepController.phoneNumber =
                                        _phoneNumberController.text;

                                    await sendOtp(
                                        _registerStepController.phoneNumber);

                                    if (_error.isEmpty) {
                                      Get.to(
                                        () => const SecondStepRegistration(),
                                        transition: Transition.rightToLeft,
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                      );
                                      _registerStepController.currentStep = 1;
                                    }
                                  },
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : ReusableText(
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
      ),
    );
  }
}
