import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/state_controller.dart';
import '../enums/screen_body.dart';
import 'snackbar_class.dart';

class EmailAuthenticationClass {
  static StateController stateController = Get.put(StateController());

  static EmailAuth emailAuth = EmailAuth(sessionName: "Test Session");
  static String email = "";

  static void login(BuildContext context, String _email) async {
    bool result = await emailAuth.sendOtp(recipientMail: _email);

    if (result) {
      email = _email;
      stateController.screenBody.value = ScreenBody.verificationCode;

      SnackbarClass.showSnackbar(
          context,
          Icons.check,
          "Doğrulama Kodu Gönderildi. Lütfen E-Posta Adresinize Gönderilen Kodu Giriniz.",
          Colors.green,
          5);
    } else {
      SnackbarClass.showSnackbar(context, Icons.error,
          "Doğrulama Kodu Gönderilemedi", Colors.redAccent, 3);
    }
  }

  static void verify(BuildContext context, String otp) {
    bool result = emailAuth.validateOtp(recipientMail: email, userOtp: otp);

    if (result) {
      stateController.screenBody.value = ScreenBody.verificationSuccess;
    } else {
      SnackbarClass.showSnackbar(
          context, Icons.error, "Doğrulama Hatası", Colors.redAccent, 3);
    }
  }

  static void logout() async =>
      stateController.screenBody.value = ScreenBody.login;
}
