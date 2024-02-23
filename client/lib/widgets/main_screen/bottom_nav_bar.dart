import 'package:financial_planner/controllers/bottom_nav_controller.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _bottomNavController = Get.put(BottomNavController());

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
              GestureDetector(
                onTap: () {
                  _addTransaction();
                },
                child: Container(
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

  Future<dynamic> _addTransaction() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding:
            EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w, bottom: 15.h),
        height: height * 0.56,
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            SizedBox(height: 25.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: "Transaction Category",
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 17.h),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade700,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      // value: _selectedMonth,
                      items: const [
                        DropdownMenuItem(
                          value: "income",
                          child: Text('Income'),
                        ),
                        DropdownMenuItem(
                          value: "saving",
                          child: Text('Saving'),
                        ),
                        DropdownMenuItem(
                          value: "investment",
                          child: Text('Investment'),
                        ),
                        DropdownMenuItem(
                          value: "expense",
                          child: Text('Expense'),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Amount",
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 17.h),
                    SizedBox(
                      height: 50.h,
                      child: const TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          prefixText: "IDR  ",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                ReusableText(
                  text: "Expense Category",
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 17.h),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade700,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      // value: _selectedMonth,
                      items: const [
                        DropdownMenuItem(
                          value: "food",
                          child: Text('Food'),
                        ),
                        DropdownMenuItem(
                          value: "snack",
                          child: Text('Snack'),
                        ),
                        DropdownMenuItem(
                          value: "selfReward",
                          child: Text('Self Rewad'),
                        ),
                        DropdownMenuItem(
                          value: "monthlyNeeds",
                          child: Text('Monthly Needs'),
                        ),
                        DropdownMenuItem(
                          value: "transportation",
                          child: Text('Transportation'),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
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
                      text: 'Save Card',
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
