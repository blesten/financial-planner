import 'package:financial_planner/controllers/register_controller.dart';
import 'package:financial_planner/screens/register/first_step_registration.dart';
import 'package:financial_planner/screens/register/fourth_step_registration.dart';
import 'package:financial_planner/screens/register/second_step_registration.dart';
import 'package:financial_planner/screens/register/third_step_registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  final registerStepController = Get.put(RegisterController());

  final List<Widget> registrationStep = [
    const FirstStepRegistration(),
    const SecondStepRegistration(),
    const ThirdStepRegistration(),
    FourthStepRegistration(),
  ];

  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => registrationStep[registerStepController.currentStep]);
  }
}
