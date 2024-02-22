import 'package:financial_planner/screens/home.dart';
import 'package:financial_planner/screens/login/login_phone.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPin extends StatefulWidget {
  const LoginPin({super.key});

  @override
  State<LoginPin> createState() => _LoginPinState();
}

class _LoginPinState extends State<LoginPin> {
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
  String _handphoneNo = "";

  Future<void> login(String handphoneNo, String pin) async {
    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      var url = '$serverURL/api/v1/users/login';
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

  Future<void> _setIsRegisteredStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("budget_buddy_is_registered_status", true);
  }

  Future<void> _loadHandphoneNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _handphoneNo = prefs.getString("budget_buddy_no") ?? "";
    });
  }

  @override
  void initState() {
    super.initState();

    _loadHandphoneNo();
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
    return SafeArea(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/login_pin.png",
                  width: width * 0.7,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 48.h),
                ReusableText(
                  text: "Enter your PIN",
                  fontSize: 22.sp,
                  color: kPrimary,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 24.h),
                ReusableText(
                  text:
                      "Enter your 4 digit application PIN in order to sign in to Budget Buddy",
                  fontSize: 14.sp,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  height: 1.5,
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
                      backgroundColor:
                          _isLoading ? kPrimary.withOpacity(0.2) : kPrimary,
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
                                _error = "Please provide PIN";
                              });
                              return;
                            }

                            String pin = [
                              _firstDigitController.text,
                              _secondDigitController.text,
                              _thirdDigitController.text,
                              _fourthDigitController.text
                            ].join('');

                            await login(_handphoneNo, pin);

                            if (_error.isEmpty) {
                              _setIsRegisteredStatus();

                              Get.to(
                                () => const Home(),
                                transition: Transition.fadeIn,
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                              );
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
                    text: "Sign in with another number",
                    fontSize: 14.sp,
                    color: kPrimary,
                    fontWeight: FontWeight.w600,
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
