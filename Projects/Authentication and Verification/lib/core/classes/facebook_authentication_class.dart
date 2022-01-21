import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import '../controllers/account_controller.dart';
import '../controllers/state_controller.dart';
import '../enums/login_type.dart';
import '../enums/screen_body.dart';

class FacebookAuthenticationClass {
  static AccountController accountController = Get.put(AccountController());
  static StateController stateController = Get.put(StateController());

  static void login() async => await FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]).then(
        (value) => FacebookAuth.instance.getUserData().then(
          (map) {
            Map user = map;

            accountController.userName.value = user["name"];
            accountController.userEmail.value = user["email"];
            accountController.userId.value = user["id"];
            accountController.userPictureUrl.value =
                user["picture"]["data"]["url"];

            stateController.loginType.value = LoginType.facebook;
            stateController.screenBody.value = ScreenBody.user;
          },
        ),
      );

  static void logout() async =>
      await FacebookAuth.instance.logOut().then((value) {
        stateController.screenBody.value = ScreenBody.login;
        accountController.resetUserData();
      });
}
