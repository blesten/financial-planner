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
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  String _error = "";
  bool _isLoading = false;

  Future<void> register(String handphoneNo, String pin) async {
    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      var url = '$serverURL/api/v1/users/register';

      var response = await http.post(
        Uri.parse(url),
        body: {
          "handphoneNo": handphoneNo,
          "pin": pin,
        },
      );

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
    _firstDigitController.addListener(_onTextChanged);
    _secondDigitController.addListener(_onTextChanged);
    _thirdDigitController.addListener(_onTextChanged);

    if (_registerStepController.pin != 0) {
      _firstDigitController.text = _registerStepController.pin.toString()[0];
      _secondDigitController.text = _registerStepController.pin.toString()[1];
      _thirdDigitController.text = _registerStepController.pin.toString()[2];
      _fourthDigitController.text = _registerStepController.pin.toString()[3];
    }
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
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width * 0.15,
                                child: TextField(
                                  controller: _firstDigitController,
                                  focusNode: _firstDigitFocusNode,
                                  obscureText: true,
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
                                  obscureText: true,
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
                                  obscureText: true,
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
                                  obscureText: true,
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
                      SizedBox(height: 48.h),
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
                                  if (_firstDigitController.text.isEmpty ||
                                      _secondDigitController.text.isEmpty ||
                                      _thirdDigitController.text.isEmpty ||
                                      _fourthDigitController.text.isEmpty) {
                                    setState(() {
                                      _error = "Please provide application PIN";
                                    });
                                    return;
                                  }

                                  _registerStepController.pin = int.parse([
                                    _firstDigitController.text,
                                    _secondDigitController.text,
                                    _thirdDigitController.text,
                                    _fourthDigitController.text
                                  ].join(''));

                                  await register(
                                      _registerStepController.phoneNumber,
                                      _registerStepController.pin
                                          .toString()
                                          .substring(0, 4));

                                  if (_error.isEmpty) {
                                    Get.to(
                                      () => FourthStepRegistration(),
                                      transition: Transition.rightToLeft,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                    );

                                    _registerStepController.currentStep = 3;
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
