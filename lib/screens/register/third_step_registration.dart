import 'package:financial_planner/controllers/register_controller.dart';
import 'package:financial_planner/screens/register/fourth_step_registration.dart';
import 'package:financial_planner/screens/register/second_step_registration.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThirdStepRegistration extends StatefulWidget {
  const ThirdStepRegistration({super.key});

  @override
  State<ThirdStepRegistration> createState() => _ThirdStepRegistrationState();
}

class _ThirdStepRegistrationState extends State<ThirdStepRegistration> {
  final _registerStepController = Get.find<RegisterController>();
  final _firstDigitController = TextEditingController();
  final _secondDigitController = TextEditingController();
  final _thirdDigitController = TextEditingController();
  final _fourthDigitController = TextEditingController();

  final _firstDigitFocusNode = FocusNode();
  final _secondDigitFocusNode = FocusNode();
  final _thirdDigitFocusNode = FocusNode();
  final _fourthDigitFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _firstDigitController.addListener(_onTextChanged);
    _secondDigitController.addListener(_onTextChanged);
    _thirdDigitController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _firstDigitController.dispose();
    _secondDigitController.dispose();
    _thirdDigitController.dispose();
    _fourthDigitController.dispose();
    _firstDigitFocusNode.dispose();
    _secondDigitFocusNode.dispose();
    _thirdDigitFocusNode.dispose();
    _fourthDigitFocusNode.dispose();
  }

  void _onTextChanged() {
    if (_firstDigitController.text.length == 1) {
      FocusScope.of(context).requestFocus(_secondDigitFocusNode);
    }

    if (_secondDigitController.text.length == 1) {
      FocusScope.of(context).requestFocus(_thirdDigitFocusNode);
    }

    if (_thirdDigitController.text.length == 1) {
      FocusScope.of(context).requestFocus(_fourthDigitFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: GestureDetector(
          onTap: () {
            _firstDigitFocusNode.unfocus();
            _secondDigitFocusNode.unfocus();
            _thirdDigitFocusNode.unfocus();
            _fourthDigitFocusNode.unfocus();
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
                            () => const SecondStepRegistration(),
                            transition: Transition.leftToRight,
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                          );
                          _registerStepController.currentStep -= 1;
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
                        "assets/images/registration_3.png",
                        width: width * 0.7,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 48.h),
                      ReusableText(
                        text: "Application PIN",
                        fontSize: 22.sp,
                        color: kPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 24.h),
                      ReusableText(
                        text:
                            "Set up your application PIN to make it more secure",
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 28.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.15,
                            child: TextField(
                              controller: _firstDigitController,
                              focusNode: _firstDigitFocusNode,
                              maxLength: 1,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade600,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimary,
                                    width: 2,
                                  ),
                                ),
                                counterText: "",
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          SizedBox(
                            width: width * 0.15,
                            child: TextField(
                              controller: _secondDigitController,
                              focusNode: _secondDigitFocusNode,
                              maxLength: 1,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade600,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimary,
                                    width: 2,
                                  ),
                                ),
                                counterText: "",
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          SizedBox(
                            width: width * 0.15,
                            child: TextField(
                              controller: _thirdDigitController,
                              focusNode: _thirdDigitFocusNode,
                              maxLength: 1,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade600,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimary,
                                    width: 2,
                                  ),
                                ),
                                counterText: "",
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          SizedBox(
                            width: width * 0.15,
                            child: TextField(
                              controller: _fourthDigitController,
                              focusNode: _fourthDigitFocusNode,
                              maxLength: 1,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade600,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimary,
                                    width: 2,
                                  ),
                                ),
                                counterText: "",
                              ),
                            ),
                          ),
                        ],
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
                          onPressed: () {
                            _registerStepController.pin = int.parse([
                              _firstDigitController.text,
                              _secondDigitController.text,
                              _thirdDigitController.text,
                              _fourthDigitController.text
                            ].join(''));

                            Get.to(
                              () => const FourthStepRegistration(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                            );

                            _registerStepController.currentStep = 3;
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
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
