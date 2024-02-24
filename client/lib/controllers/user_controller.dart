import 'package:financial_planner/models/user_model.dart';
import 'package:financial_planner/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  RxString _accessToken = "".obs;
  Rx<UserModel?> _user = Rx<UserModel?>(null);
  RxString _error = "".obs;

  void setUser({
    required String id,
    required String name,
    required String email,
    required String handphoneNo,
  }) {
    _user.value = UserModel(
      id: id,
      name: name,
      email: email,
      handphoneNo: handphoneNo,
    );
  }

  void clearUser() {
    _user.value = null;
  }

  void setAccessToken(String token) {
    _accessToken.value = token;
  }

  void clearAccessToken() {
    _accessToken.value = "";
  }

  Future<void> updateProfile(
      {required String name, required String email}) async {
    _error.value = "";

    try {
      final response = await http.patch(
        Uri.parse("$serverURL/api/v1/users/profile"),
        body: {"name": name, "email": email},
        headers: {"Authorization": _accessToken.value},
      );

      if (response.statusCode == 200) {
        _user.value = UserModel(
          id: _user.value!.id,
          name: name,
          email: email,
          handphoneNo: _user.value!.handphoneNo,
        );
      } else {
        _error.value = json.decode(response.body)['msg'];
      }
    } catch (err) {
      _error.value = err.toString();
    }
  }

  String get accessToken => _accessToken.value;

  UserModel? get user => _user.value;

  String get error => _error.value;
}
