import 'package:financial_planner/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  RxString _accessToken = "".obs;
  Rx<UserModel?> _user = Rx<UserModel?>(null);

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

  String get accessToken => _accessToken.value;

  UserModel? get user => _user.value;
}
