import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/classes/email_authentication_class.dart';
import '../core/classes/phone_authentication_class.dart';
import '../core/components/buttons/floating_action_button_extended.dart';
import '../core/components/texts/text_widget.dart';
import '../core/controllers/state_controller.dart';
import '../core/enums/verification_type.dart';

class VerificationSuccessBody extends StatelessWidget {
  const VerificationSuccessBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateController stateController = Get.put(StateController());

    String verificationType = "";
    Function() exitButtonFunction = () {};

    switch (stateController.verificationType.value) {
      case VerificationType.phone:
        verificationType = "Telefon Numarası";
        exitButtonFunction = () => PhoneAuthenticationClass.logout();
        break;
      case VerificationType.email:
        verificationType = "E-Posta Adresi";
        exitButtonFunction = () => EmailAuthenticationClass.logout();
        break;
      default:
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 100),
          const SizedBox(height: 30),
          TextWidget(
            text: verificationType + " Doğrulandı",
            fontSize: 30,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            color: Colors.green,
            height: 1.5,
          ),
          const SizedBox(height: 50),
          FloatingActionButtonExtended(
            text: "Kapat",
            onPressed: exitButtonFunction,
          ),
        ],
      ),
    );
  }
}
