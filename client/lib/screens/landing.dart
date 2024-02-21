import 'dart:async';
import 'package:financial_planner/screens/login/login.dart';
import 'package:financial_planner/screens/welcome.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool _registeredStatus = false;

  Future<void> _loadRegisteredStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _registeredStatus =
          prefs.getBool("budget_buddy_is_registered_status") ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRegisteredStatus();
    Timer(const Duration(seconds: 1), () async {
      Get.to(
        () => _registeredStatus ? const Login() : const Welcome(),
        transition: Transition.fadeIn,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: Container(
          width: 200.w,
          height: 200.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
