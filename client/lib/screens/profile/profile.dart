import 'package:financial_planner/controllers/bottom_nav_controller.dart';
import 'package:financial_planner/controllers/user_controller.dart';
import 'package:financial_planner/screens/login/login_phone.dart';
import 'package:financial_planner/screens/profile/change_pin.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:financial_planner/widgets/general/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserController _userController = Get.put(UserController());
  final BottomNavController _bottomNavController =
      Get.find<BottomNavController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  bool _isSaving = false;

  Future<void> _removeHandphoneNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("budget_buddy_no");
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = _userController.user!.name;
    _emailController.text = _userController.user!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          _nameFocusNode.unfocus();
          _emailFocusNode.unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: "Name",
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 17.h),
                      SizedBox(
                        height: 50.h,
                        child: TextField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: "Email",
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 17.h),
                      SizedBox(
                        height: 50.h,
                        child: TextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: "Handphone No",
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 17.h),
                      Container(
                        width: width * 0.9,
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: Colors.grey.shade600,
                            style: BorderStyle.solid,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 32.h,
                                  margin: EdgeInsets.only(left: 15.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 40.w,
                                        height: 14.h,
                                        decoration: const BoxDecoration(
                                            color: Colors.red),
                                      ),
                                      Container(
                                        width: 40.w,
                                        height: 14.h,
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                ReusableText(
                                  text: "+62",
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                            SizedBox(width: 7.w),
                            SizedBox(
                              height: 32.h,
                              child: Center(
                                child: ReusableText(
                                  text: _userController.user!.handphoneNo
                                      .substring(3),
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  SizedBox(
                    width: width * 0.9,
                    height: 52.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            _isSaving ? kPrimary.withOpacity(0.2) : kPrimary,
                        side: BorderSide.none,
                      ),
                      onPressed: _isSaving
                          ? null
                          : () async {
                              setState(() {
                                _isSaving = true;
                              });

                              await _userController.updateProfile(
                                name: _nameController.text,
                                email: _emailController.text,
                              );

                              setState(() {
                                _isSaving = false;
                              });

                              if (_userController.error.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(_userController.error),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("OK"))
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Success"),
                                      content: Text(
                                          "Profile has been updated successfully."),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("OK"))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                      child: _isSaving
                          ? const CircularProgressIndicator()
                          : ReusableText(
                              text: 'Save Changes',
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: width * 0.9,
                    height: 52.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: kPrimary,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      onPressed: () {
                        Get.to(
                          () => const ChangePin(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(
                            milliseconds: 150,
                          ),
                        );
                      },
                      child: ReusableText(
                        text: 'Change PIN',
                        color: kPrimary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: width * 0.9,
                    height: 52.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red.shade500,
                        side: BorderSide.none,
                      ),
                      onPressed: () {
                        _userController.clearUser();
                        _userController.clearAccessToken();
                        _bottomNavController.currentIndex = 0;
                        _removeHandphoneNo();

                        Get.to(
                          const LoginPhone(),
                          transition: Transition.fadeIn,
                          duration: const Duration(
                            milliseconds: 150,
                          ),
                        );
                      },
                      child: ReusableText(
                        text: 'Sign Out',
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
