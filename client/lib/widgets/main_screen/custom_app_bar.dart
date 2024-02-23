import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(
                    50.r,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                    text: "Good Morning",
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(height: 6.h),
                  ReusableText(
                    text: "Gianna Louis",
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              )
            ],
          ),
          Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.notifications_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
