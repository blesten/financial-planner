import 'package:financial_planner/screens/login/login_phone.dart';
import 'package:financial_planner/screens/login/login_pin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _handphoneNo = "";

  Future<void> _loadHandphoneNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _handphoneNo = prefs.getString("budget_buddy_no") ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHandphoneNo();
  }

  @override
  Widget build(BuildContext context) {
    return _handphoneNo.isNotEmpty ? const LoginPin() : const LoginPhone();
  }
}
