import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  set currentIndex(int value) {
    _currentIndex.value = value;
  }
}
