import 'package:financial_planner/controllers/bottom_nav_controller.dart';
import 'package:financial_planner/screens/home/home.dart';
import 'package:financial_planner/screens/debit_card.dart';
import 'package:financial_planner/screens/profile/profile.dart';
import 'package:financial_planner/screens/report/report.dart';
import 'package:financial_planner/widgets/main_screen/bottom_nav_bar.dart';
import 'package:financial_planner/widgets/main_screen/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final _bottomNavController = Get.put(BottomNavController());

  final List<Widget> screen = [
    Home(),
    const DebitCard(),
    const Report(),
    Profile(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: CustomAppBar(),
          ),
          body: screen[_bottomNavController.currentIndex],
          bottomNavigationBar: const BottomNavBar(),
        ),
      ),
    );
  }
}
