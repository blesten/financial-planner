import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:financial_planner/widgets/main_screen/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNotification extends StatelessWidget {
  const UserNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: const CustomAppBar(),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 18.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ReusableText(
                                text: "Notification Title Goes Here",
                                fontSize: 14.sp,
                                color: kPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(width: 10.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7.h, vertical: 5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: kPrimary,
                                ),
                                child: ReusableText(
                                  text: "New",
                                  fontSize: 11.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          ReusableText(
                            text:
                                "Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.",
                            fontSize: 12.sp,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500,
                            height: 1.7,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 18.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ReusableText(
                                text: "Notification Title Goes Here",
                                fontSize: 14.sp,
                                color: kPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(width: 10.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7.h, vertical: 5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: kPrimary,
                                ),
                                child: ReusableText(
                                  text: "New",
                                  fontSize: 11.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          ReusableText(
                            text:
                                "Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.",
                            fontSize: 12.sp,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500,
                            height: 1.7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
