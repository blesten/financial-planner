import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancialOverview extends StatelessWidget {
  final double income;
  final double expense;
  final double saving;
  final double investment;

  const FinancialOverview({
    super.key,
    required this.income,
    required this.expense,
    required this.saving,
    required this.investment,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: Colors.red.shade500,
                    value: (expense / income) * 100,
                    title: "${((expense / income) * 100).toStringAsFixed(2)}%",
                    radius: 60.0,
                    titleStyle: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.purple.shade700,
                    value: (investment / income) * 100,
                    title:
                        "${((investment / income) * 100).toStringAsFixed(2)}%",
                    radius: 60.0,
                    titleStyle: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.blue.shade500,
                    value: (saving / income) * 100,
                    title: "${((saving / income) * 100).toStringAsFixed(2)}%",
                    radius: 60.0,
                    titleStyle: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              swapAnimationDuration: const Duration(milliseconds: 150),
              swapAnimationCurve: Curves.linear,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 85.h),
              if (expense != 0)
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(color: Colors.red.shade500),
                        ),
                        SizedBox(width: 10.w),
                        ReusableText(
                          text: "Expense",
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                  ],
                ),
              if (saving != 0)
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.h,
                          decoration:
                              BoxDecoration(color: Colors.blue.shade500),
                        ),
                        SizedBox(width: 10.w),
                        ReusableText(
                          text: "Saving",
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                  ],
                ),
              if (investment != 0)
                Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(color: Colors.purple.shade700),
                    ),
                    SizedBox(width: 10.w),
                    ReusableText(
                      text: "Investment",
                      fontSize: 13.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
