import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/classes/email_authentication_class.dart';
import '../core/classes/phone_authentication_class.dart';
import '../core/components/buttons/floating_action_button_extended.dart';
import '../core/components/texts/text_form_field_widget.dart';
import '../core/controllers/state_controller.dart';
import '../core/enums/screen_body.dart';
import '../core/enums/verification_type.dart';

class VerificationBody extends StatelessWidget {
  const VerificationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateController stateController = Get.put(StateController());
    TextEditingController tecVerification = TextEditingController();

    String labelText = "";
    String hintText = "";
    Function() actionButtonFunction = () {};
    TextInputType textInputType = TextInputType.phone;

    switch (stateController.verificationType.value) {
      case VerificationType.phone:
        tecVerification.text = "+90";
        labelText = "Telefon Numarası";
        hintText = "+90XXXXXXXXXX";
        actionButtonFunction =
            () => PhoneAuthenticationClass.login(context, tecVerification.text);
        break;
      case VerificationType.email:
        labelText = "E-Posta Adresi";
        actionButtonFunction =
            () => EmailAuthenticationClass.login(context, tecVerification.text);
        textInputType = TextInputType.emailAddress;
        break;
      default:
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            controller: tecVerification,
            labelText: labelText,
            textInputType: textInputType,
            autofocus: true,
            hintText: hintText,
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
                text: "Kod Gönder",
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
