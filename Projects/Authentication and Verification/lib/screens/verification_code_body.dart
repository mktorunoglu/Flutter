import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/classes/email_authentication_class.dart';
import '../core/classes/phone_authentication_class.dart';
import '../core/components/buttons/floating_action_button_extended.dart';
import '../core/components/texts/text_form_field_widget.dart';
import '../core/controllers/state_controller.dart';
import '../core/enums/screen_body.dart';
import '../core/enums/verification_type.dart';

class VerificationCodeBody extends StatelessWidget {
  const VerificationCodeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateController stateController = Get.put(StateController());
    TextEditingController tecVerificationId = TextEditingController();

    Function() actionButtonFunction = () {};

    switch (stateController.verificationType.value) {
      case VerificationType.phone:
        actionButtonFunction = () =>
            PhoneAuthenticationClass.verify(context, tecVerificationId.text);
        break;
      case VerificationType.email:
        actionButtonFunction = () =>
            EmailAuthenticationClass.verify(context, tecVerificationId.text);
        break;
      default:
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            controller: tecVerificationId,
            labelText: "Doğrulama Kodu",
            textInputType: TextInputType.number,
            autofocus: true,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButtonExtended(
                text: "İptal",
                onPressed: () =>
                    stateController.screenBody.value = ScreenBody.login,
              ),
              FloatingActionButtonExtended(
                text: "Doğrula",
                onPressed: actionButtonFunction,
                buttonColor: Colors.black,
                textColor: Colors.grey.shade400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
