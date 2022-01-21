import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/state_controller.dart';
import '../enums/screen_body.dart';
import 'snackbar_class.dart';

class PhoneAuthenticationClass {
  static StateController stateController = Get.put(StateController());
  static String verificationId = "";

  static void login(BuildContext context, String phoneNumber) async =>
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {},
        verificationFailed: (exception) {
          SnackbarClass.showSnackbar(
              context, Icons.error, exception.message!, Colors.redAccent, 5);
        },
        codeSent: (_verificationId, resendingToken) {
          verificationId = _verificationId;
          stateController.screenBody.value = ScreenBody.verificationCode;

          SnackbarClass.showSnackbar(
              context,
              Icons.check,
              "Doğrulama Kodu Gönderildi. Lütfen Telefon Numaranıza SMS Olarak Gönderilen Kodu Giriniz.",
              Colors.green,
              5);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );

  static void verify(BuildContext context, String smsCode) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

      if (userCredential.user != null) {
        stateController.screenBody.value = ScreenBody.verificationSuccess;
      }
    } on FirebaseAuthException catch (e) {
      SnackbarClass.showSnackbar(
          context, Icons.error, e.message!, Colors.redAccent, 5);
    }
  }

  static void logout() async => await FirebaseAuth.instance
      .signOut()
      .then((value) => stateController.screenBody.value = ScreenBody.login);
}
