import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:financial_planner/widgets/main_screen/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePin extends StatelessWidget {
  const ChangePin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            child: const TextField(
                              obscureText: true,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Icon(
                              CupertinoIcons.eye,
                              size: 20.w,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
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
                            child: const TextField(
                              obscureText: true,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Icon(
                              CupertinoIcons.eye,
                              size: 20.w,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
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
                            child: const TextField(
                              obscureText: true,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Icon(
                              CupertinoIcons.eye,
                              size: 20.w,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
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
                    backgroundColor: kPrimary,
                    side: BorderSide.none,
                  ),
                  onPressed: () {},
                  child: ReusableText(
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
