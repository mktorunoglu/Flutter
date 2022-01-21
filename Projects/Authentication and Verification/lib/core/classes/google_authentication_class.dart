import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/account_controller.dart';
import '../controllers/state_controller.dart';
import '../enums/login_type.dart';
import '../enums/screen_body.dart';

class GoogleAuthenticationClass {
  static AccountController accountController = Get.put(AccountController());
  static StateController stateController = Get.put(StateController());

  static void login() async =>
      await GoogleSignIn().signIn().then((googleSignInAccount) {
        GoogleSignInAccount account = googleSignInAccount!;

        accountController.userName.value = account.displayName!;
        accountController.userEmail.value = account.email;
        accountController.userId.value = account.id;
        accountController.userPictureUrl.value = account.photoUrl!;

        stateController.loginType.value = LoginType.google;
        stateController.screenBody.value = ScreenBody.user;
      });

  static void logout() async => await GoogleSignIn().signOut().then((value) {
        stateController.screenBody.value = ScreenBody.login;
        accountController.resetUserData();
      });
}
