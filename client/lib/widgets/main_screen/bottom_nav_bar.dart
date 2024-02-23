import 'package:financial_planner/controllers/bottom_nav_controller.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final _bottomNavController = Get.put(BottomNavController());

  BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 27.h),
        child: Container(
          width: width * 0.8,
          height: 65.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(50.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _bottomNavController.currentIndex = 0;
                },
                child: Icon(
                  Icons.home,
                  color: _bottomNavController.currentIndex == 0
                      ? kPrimary
                      : kPrimary.withOpacity(0.2),
                  size: 30.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _bottomNavController.currentIndex = 1;
                },
                child: Icon(
                  Icons.credit_card,
                  color: _bottomNavController.currentIndex == 1
                      ? kPrimary
                      : kPrimary.withOpacity(0.2),
                  size: 30.sp,
                ),
              ),
              Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 7,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: kPrimary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _bottomNavController.currentIndex = 2;
                },
                child: Icon(
                  _bottomNavController.currentIndex == 2
                      ? CupertinoIcons.lightbulb_fill
                      : CupertinoIcons.lightbulb,
                  color: _bottomNavController.currentIndex == 2
                      ? kPrimary
                      : kPrimary.withOpacity(0.2),
                  size: 26.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _bottomNavController.currentIndex = 3;
                },
                child: Icon(
                  _bottomNavController.currentIndex == 3
                      ? CupertinoIcons.person_circle_fill
                      : CupertinoIcons.person_circle,
                  color: _bottomNavController.currentIndex == 3
                      ? kPrimary
                      : kPrimary.withOpacity(0.2),
                  size: 30.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
