import 'package:get/get.dart';

class RememberMeController extends GetxController {
  static RememberMeController instance = Get.find();
  RxBool isChecked = false.obs;

  void changeCheckStatus() {
    isChecked.value = !isChecked.value;
  }
}
