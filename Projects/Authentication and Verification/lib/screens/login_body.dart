import 'package:flutter/material.dart';
import '../core/enums/verification_type.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../core/classes/facebook_authentication_class.dart';
import '../core/classes/google_authentication_class.dart';
import '../core/classes/twitter_Authentication_class.dart';
import '../core/components/buttons/sign_in_button.dart';
import '../core/constants/color_constants.dart';
import '../core/controllers/state_controller.dart';
import '../core/enums/screen_body.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateController stateController = Get.put(StateController());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SignInButton(
          iconData: Icons.phone_iphone,
          themeColor: Colors.black,
          socialName: "Telefon Numarası",
          onPressed: () {
            stateController.verificationType.value = VerificationType.phone;
            stateController.screenBody.value = ScreenBody.verification;
          },
        ),
        SignInButton(
          iconData: Icons.email,
          themeColor: Colors.blueGrey,
          socialName: "E-Posta Adresi",
          onPressed: () {
            stateController.verificationType.value = VerificationType.email;
            stateController.screenBody.value = ScreenBody.verification;
          },
        ),
        SignInButton(
          iconData: FontAwesomeIcons.googlePlus,
          themeColor: ColorConstants.googleRedColor,
          socialName: "Google",
          onPressed: () => GoogleAuthenticationClass.login(),
        ),
        SignInButton(
          iconData: FontAwesomeIcons.facebook,
          themeColor: ColorConstants.facebookColor,
          socialName: "Facebook",
          onPressed: () => FacebookAuthenticationClass.login(),
        ),
        SignInButton(
          iconData: FontAwesomeIcons.twitter,
          themeColor: ColorConstants.twitterColor,
          socialName: "Twitter",
          onPressed: () => TwitterAuthenticationClass.login(),
        ),
      ],
    );
  }
}
