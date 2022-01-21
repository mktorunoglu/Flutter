import 'package:get/get.dart';
import 'package:twitter_login/twitter_login.dart';

import '../constants/string_constants.dart';
import '../controllers/account_controller.dart';
import '../controllers/state_controller.dart';
import '../enums/login_type.dart';
import '../enums/screen_body.dart';

class TwitterAuthenticationClass {
  static AccountController accountController = Get.put(AccountController());
  static StateController stateController = Get.put(StateController());

  static void login() async => await TwitterLogin(
              apiKey: StringConstants.twitterApiKey,
              apiSecretKey: StringConstants.twitterApiSecretKey,
              redirectURI: StringConstants.twitterRedirectURI)
          .login()
          .then((authResult) {
        final user = authResult.user!;

        accountController.userName.value = user.name;
        accountController.userEmail.value =
            user.email == "" ? user.screenName : user.email;
        accountController.userId.value = user.id.toString();
        accountController.userPictureUrl.value = user.thumbnailImage;

        stateController.loginType.value = LoginType.twitter;
        stateController.screenBody.value = ScreenBody.user;
      });

  static void logout() async {
    stateController.screenBody.value = ScreenBody.login;
    accountController.resetUserData();
  }
}
