import 'package:financial_planner/screens/report/report_detail.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                text: "Monthly Report",
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade700,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: 2024,
                    items: [
                      DropdownMenuItem(
                        value: 2024,
                        child: Text(
                          2024.toString(),
                        ),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 35.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: "March",
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ReportDetail(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(
                                milliseconds: 150,
                              ),
                            );
                          },
                          child: ReusableText(
                            text: "Show",
                            fontSize: 13.sp,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: "February",
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: ReusableText(
                            text: "Show",
                            fontSize: 13.sp,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w600,
                          ),
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
    );
  }
}
