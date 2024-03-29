import 'dart:convert';
import 'package:financial_planner/screens/login/login_pin.dart';
import 'package:financial_planner/screens/register/first_step_registration.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final _phoneNumberController = TextEditingController();
  final _focusNode = FocusNode();

  String _error = "";
  bool _isLoading = false;

  Future<void> checkLoginPhone(String handphoneNo) async {
    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      var url = '$serverURL/api/v1/users/checkLoginPhone/$handphoneNo';

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

  Future<void> saveHandponeNo(String handphoneNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("budget_buddy_no", handphoneNo);
  }

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/login_phone.png",
                  width: width * 0.7,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 48.h),
                ReusableText(
                  text: "Sign In",
                  fontSize: 22.sp,
                  color: kPrimary,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 24.h),
                ReusableText(
                  text:
                      "Enter your handphone number in order to sign in to Budget Buddy",
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
                      backgroundColor:
                          _isLoading ? kPrimary.withOpacity(0.2) : kPrimary,
                      side: BorderSide.none,
                    ),
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_phoneNumberController.text.length < 10) {
                              setState(() {
                                _error = "Please provide valid phone number";
                              });

                              return;
                            }

                            await checkLoginPhone(_phoneNumberController.text);

                            if (_error.isEmpty) {
                              await saveHandponeNo(_phoneNumberController.text);

                              Get.to(
                                () => const LoginPin(),
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
                      () => const FirstStepRegistration(),
                      transition: Transition.fadeIn,
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                    );
                  },
                  child: ReusableText(
                    text: "Create an account for free",
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
