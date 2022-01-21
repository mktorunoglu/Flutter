import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/classes/facebook_authentication_class.dart';
import '../core/classes/google_authentication_class.dart';
import '../core/classes/twitter_authentication_class.dart';
import '../core/components/buttons/floating_action_button_extended.dart';
import '../core/components/texts/text_widget.dart';
import '../core/controllers/account_controller.dart';
import '../core/controllers/state_controller.dart';
import '../core/enums/login_type.dart';

class UserBody extends StatelessWidget {
  const UserBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountController accountController = Get.put(AccountController());
    StateController stateController = Get.put(StateController());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          child: accountController.userPictureUrl.value == ""
              ? TextWidget(
                  text: accountController.userName.value.substring(0, 1),
                  fontSize: 50,
                  color: Colors.white,
                )
              : Container(),
          backgroundImage:
              Image.network(accountController.userPictureUrl.value).image,
          radius: 50,
        ),
        const SizedBox(height: 30),
        TextWidget(
          text: accountController.userName.value,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 30),
        TextWidget(
          text: accountController.userEmail.value,
          fontSize: 18,
        ),
        const SizedBox(height: 30),
        TextWidget(
          text: "id : " + accountController.userId.value,
          fontSize: 14,
        ),
        const SizedBox(height: 100),
        FloatingActionButtonExtended(
          text: "Çıkış Yap",
          onPressed: () {
            switch (stateController.loginType.value) {
              case LoginType.google:
                GoogleAuthenticationClass.logout();
                break;
              case LoginType.facebook:
                FacebookAuthenticationClass.logout();
                break;
              case LoginType.twitter:
                TwitterAuthenticationClass.logout();
                break;
              default:
            }
          },
        ),
      ],
    );
  }
}
