import 'package:flutter/material.dart';

import '../core/components/buttons/gradient_button.dart';
import '../core/components/containers/gradient_container.dart';
import '../core/components/containers/header_container.dart';
import '../core/components/containers/rounded_container.dart';
import '../core/components/texts/text_form_field_widget.dart';
import '../core/components/texts/text_widget.dart';

class ForgottenPasswordScreen extends StatelessWidget {
  const ForgottenPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        headerWidget: const HeaderContainer(
          iconData: Icons.lock,
          text: "Şifremi Unuttum",
          addBackButton: true,
        ),
        child: RoundedContainer(
          scrollBar: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                text: "Şifrenizi Sıfırlamak İçin",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              const TextWidget(
                text: "E-Posta Adresinizi Giriniz.",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 2,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: TextFormFieldWidget(
                  labelText: "E-Posta Adresi",
                  iconData: Icons.email,
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              GradientButton(
                text: "E-Posta Gönder",
                onPressed: () {},
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
