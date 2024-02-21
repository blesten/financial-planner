import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxInt _currentStep = 0.obs;
  RxString _phoneNumber = "".obs;
  List<RxInt> _otp = List.generate(4, (index) => 0.obs);
  List<RxInt> _pin = List.generate(4, (index) => 0.obs);

  int get currentStep => _currentStep.value;
  String get phoneNumber => _phoneNumber.value;
  int get otp =>
      int.parse(_otp.map((rxInt) => rxInt.value.toString()).join(''));
  int get pin =>
      int.parse(_pin.map((rxInt) => rxInt.value.toString()).join(''));

  set currentStep(int value) {
    _currentStep.value = value;
  }

  set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  set otp(int value) {
    for (int i = 0; i < _otp.length; i++) {
      _otp[i].value = int.parse(value.toString().substring(i, i + 1));
    }
  }

  set pin(int value) {
    for (int i = 0; i < _pin.length; i++) {
      _pin[i].value = value;
    }
  }
}
