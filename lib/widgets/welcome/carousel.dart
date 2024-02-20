import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Carousel extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      "image": "assets/images/landing_1.png",
      "title": "Let's get started",
      "description":
          "Never a better time then now to start thinking about how you manage all your finances with ease"
    },
    {
      "image": "assets/images/landing_2.png",
      "title": "Track your Financial",
      "description":
          "Keep track of all your expenses and incomes in every card that you own to achieve your financial goals"
    },
    {
      "image": "assets/images/landing_3.png",
      "title": "Set your Goals",
      "description":
          "With us, set your life goals, and we’ll help you to manage your financial plan to achieve your spectacular goals"
    },
  ];

  final CarouselController _carouselController = CarouselController();

  Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1,
        height: 480,
      ),
      itemCount: items.length,
      itemBuilder: (context, index, pageViewIndex) {
        return Column(
          children: [
            Image.asset(
              items[index]["image"].toString(),
              height: 250,
            ),
            SizedBox(height: 40.h),
            ReusableText(
              text: items[index]["title"].toString(),
              fontSize: 24.sp,
              color: kPrimary,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 24.h),
            ReusableText(
              text: items[index]["description"].toString(),
              fontSize: 14.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              height: 1.5,
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(0);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.h),
                    child: Container(
                      width: 9.w,
                      height: 9.h,
                      color: index == 0 ? kPrimary : Colors.grey.shade500,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(1);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.h),
                    child: Container(
                      width: 9.w,
                      height: 9.h,
                      color: index == 1 ? kPrimary : Colors.grey.shade500,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(2);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.h),
                    child: Container(
                      width: 9.w,
                      height: 9.h,
                      color: index == 2 ? kPrimary : Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
