import 'package:get/get.dart';

class AccountController extends GetxController {
  RxString userName = "".obs;
  RxString userEmail = "".obs;
  RxString userId = "".obs;
  RxString userPictureUrl = "".obs;

  void resetUserData() {
    userName.value = "";
    userEmail.value = "";
    userId.value = "";
    userPictureUrl.value = "";
  }
}
