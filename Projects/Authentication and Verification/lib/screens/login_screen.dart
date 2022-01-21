import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/controllers/state_controller.dart';
import '../core/enums/screen_body.dart';
import 'login_body.dart';
import 'user_body.dart';
import 'verification_body.dart';
import 'verification_code_body.dart';
import 'verification_success_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateController stateController = Get.put(StateController());

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Obx(
            () {
              switch (stateController.screenBody.value) {
                case ScreenBody.login:
                  return const LoginBody();
                case ScreenBody.user:
                  return const UserBody();
                case ScreenBody.verification:
                  return const VerificationBody();
                case ScreenBody.verificationCode:
                  return const VerificationCodeBody();
                case ScreenBody.verificationSuccess:
                  return const VerificationSuccessBody();
                default:
                  return const LoginBody();
              }
            },
          ),
        ),
      ),
    );
  }
}
