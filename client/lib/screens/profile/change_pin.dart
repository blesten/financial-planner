import 'package:financial_planner/controllers/user_controller.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:financial_planner/widgets/main_screen/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  final UserController _userController = Get.find<UserController>();

  final TextEditingController _currentPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _newPinConfirmationController =
      TextEditingController();

  String _currentPinError = "";
  String _newPinError = "";
  String _newPinConfirmationError = "";

  bool _isSaving = false;

  bool _showCurrentPin = false;
  bool _showNewPin = false;
  bool _showNewPinConfirmation = false;

  Future<void> changePin() async {
    setState(() {
      _currentPinError = "";
      _newPinError = "";
      _newPinConfirmationError = "";
      _isSaving = true;
    });

    if (_currentPinController.text.isEmpty) {
      _currentPinError = "Current PIN should be filled";
    }

    if (_newPinController.text.isEmpty) {
      _newPinError = "New PIN should be filled";
    }

    if (_newPinConfirmationController.text.isEmpty) {
      _newPinConfirmationError = "New PIN Confirmation should be filled";
    }

    if (_currentPinError.isNotEmpty ||
        _newPinError.isNotEmpty ||
        _newPinConfirmationError.isNotEmpty) {
      setState(() {
        _isSaving = false;
      });
      return;
    }

    if (_newPinController.text != _newPinConfirmationController.text) {
      _newPinConfirmationError =
          "New PIN Confirmation should be matched with New PIN";
      setState(() {
        _isSaving = false;
      });
      return;
    }

    try {
      final response = await http.patch(
        Uri.parse("$serverURL/api/v1/users/pin"),
        body: {
          "currentPIN": _currentPinController.text,
          "newPIN": _newPinController.text,
        },
        headers: {
          "Authorization": _userController.accessToken,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _currentPinController.text = "";
          _newPinController.text = "";
          _newPinConfirmationController.text = "";
          _showCurrentPin = false;
          _showNewPin = false;
          _showNewPinConfirmation = false;
        });

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("PIN has been changed successfully"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(json.decode(response.body)['msg']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (err) {
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: const CustomAppBar(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(CupertinoIcons.back),
              ),
              SizedBox(height: 25.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: "Current PIN",
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: width,
                    height: 55.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade500,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextField(
                              obscureText: _showCurrentPin ? false : true,
                              maxLength: 4,
                              controller: _currentPinController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showCurrentPin = !_showCurrentPin;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Icon(
                              _showCurrentPin
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              size: 20.w,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _currentPinError.isNotEmpty,
                    child: SizedBox(height: 9.h),
                  ),
                  Visibility(
                    visible: _currentPinError.isNotEmpty,
                    child: ReusableText(
                      text: _currentPinError,
                      fontSize: 11.sp,
                      color: Colors.red.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: "New PIN",
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: width,
                    height: 55.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade500,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextField(
                              obscureText: _showNewPin ? false : true,
                              maxLength: 4,
                              controller: _newPinController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showNewPin = !_showNewPin;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Icon(
                              _showNewPin
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              size: 20.w,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _newPinError.isNotEmpty,
                    child: SizedBox(height: 9.h),
                  ),
                  Visibility(
                    visible: _newPinError.isNotEmpty,
                    child: ReusableText(
                      text: _newPinError,
                      fontSize: 11.sp,
                      color: Colors.red.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: "New PIN Confirmation",
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: width,
                    height: 55.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade500,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextField(
                              obscureText:
                                  _showNewPinConfirmation ? false : true,
                              maxLength: 4,
                              controller: _newPinConfirmationController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showNewPinConfirmation =
                                  !_showNewPinConfirmation;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Icon(
                              _showNewPinConfirmation
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye,
                              size: 20.w,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _newPinConfirmationError.isNotEmpty,
                    child: SizedBox(height: 9.h),
                  ),
                  Visibility(
                    visible: _newPinConfirmationError.isNotEmpty,
                    child: ReusableText(
                      text: _newPinConfirmationError,
                      fontSize: 11.sp,
                      color: Colors.red.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: width * 0.9,
                height: 52.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        _isSaving ? kPrimary.withOpacity(0.2) : kPrimary,
                    side: BorderSide.none,
                  ),
                  onPressed: _isSaving
                      ? null
                      : () async {
                          await changePin();
                        },
                  child: _isSaving
                      ? const CircularProgressIndicator()
                      : ReusableText(
                          text: 'Update PIN',
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
