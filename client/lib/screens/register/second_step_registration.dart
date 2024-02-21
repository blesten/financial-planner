import 'dart:async';
import 'package:financial_planner/controllers/register_controller.dart';
import 'package:financial_planner/screens/register/first_step_registration.dart';
import 'package:financial_planner/screens/register/third_step_registration.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SecondStepRegistration extends StatefulWidget {
  const SecondStepRegistration({super.key});

  @override
  State<SecondStepRegistration> createState() => _SecondStepRegistrationState();
}

class _SecondStepRegistrationState extends State<SecondStepRegistration> {
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

  late Timer _timer;
  int _countdown = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_countdown == 0) {
          timer.cancel();
        } else {
          _countdown--;
        }
      });
    });
  }

  Future<void> sendOtp(String handphoneNo) async {
    setState(() {
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
  }

  Future<void> verifyOtp(String handphoneNo, int code) async {
    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      var url =
          '$serverURL/api/v1/users/verifyOtp?handphoneNo=$handphoneNo&code=$code';

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
    startTimer();

    _firstDigitController.addListener(_onTextChanged);
    _secondDigitController.addListener(_onTextChanged);
    _thirdDigitController.addListener(_onTextChanged);

    if (_registerStepController.otp != 0) {
      _firstDigitController.text = _registerStepController.otp.toString()[0];
      _secondDigitController.text = _registerStepController.otp.toString()[1];
      _thirdDigitController.text = _registerStepController.otp.toString()[2];
      _fourthDigitController.text = _registerStepController.otp.toString()[3];
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
                            () => const FirstStepRegistration(),
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
                        "assets/images/registration_2.png",
                        width: width * 0.7,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 48.h),
                      ReusableText(
                        text: "Verification",
                        fontSize: 22.sp,
                        color: kPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 24.h),
                      ReusableText(
                        text: "Enter 4 digit number that sent to",
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 9.h),
                      ReusableText(
                        text:
                            "+62 ${_registerStepController.phoneNumber.substring(0, 3)} ${_registerStepController.phoneNumber.substring(3, 7)} ${_registerStepController.phoneNumber.substring(7)}",
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
                                      _error =
                                          "Please provide OTP (One Time Password)";
                                    });
                                    return;
                                  }

                                  _registerStepController.otp = int.parse([
                                    _firstDigitController.text,
                                    _secondDigitController.text,
                                    _thirdDigitController.text,
                                    _fourthDigitController.text
                                  ].join(''));

                                  await verifyOtp(
                                      _registerStepController.phoneNumber,
                                      _registerStepController.otp);

                                  if (_error.isEmpty) {
                                    Get.to(
                                      () => const ThirdStepRegistration(),
                                      transition: Transition.rightToLeft,
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                    );

                                    _registerStepController.currentStep = 2;
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
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        // when _countdown is 0, then onTap is not null, but when it was clicked, it should reset to 30 again
                        onTap: _countdown != 0
                            ? null
                            : () async {
                                await sendOtp(
                                    _registerStepController.phoneNumber);
                                setState(() {
                                  _countdown = 30;
                                  startTimer();
                                });
                              },
                        child: ReusableText(
                          text: _countdown != 0
                              ? "Resend code in 0:$_countdown"
                              : "Resend code",
                          fontSize: 14.sp,
                          color: kPrimary,
                          fontWeight: FontWeight.w600,
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
