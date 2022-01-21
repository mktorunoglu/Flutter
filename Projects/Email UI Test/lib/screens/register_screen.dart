import 'package:flutter/material.dart';

import '../core/components/buttons/gradient_button.dart';
import '../core/components/containers/gradient_container.dart';
import '../core/components/containers/header_container.dart';
import '../core/components/containers/rounded_container.dart';
import '../core/components/texts/text_widget.dart';
import '../core/components/texts/text_form_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        headerWidget: const HeaderContainer(
          iconData: Icons.person,
          text: "Kayıt Ol",
          addBackButton: true,
        ),
        child: RoundedContainer(
          scrollBar: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                text: "Lütfen Bilgilerinizi Giriniz.",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 30),
              const TextFormFieldWidget(
                labelText: "Ad Soyad",
                iconData: Icons.person,
              ),
              const SizedBox(height: 15),
              const TextFormFieldWidget(
                labelText: "Cep Telefonu",
                iconData: Icons.phone,
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              const TextFormFieldWidget(
                labelText: "E-Posta Adresi",
                iconData: Icons.email,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              const TextFormFieldWidget(
                labelText: "Parola",
                iconData: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              const TextFormFieldWidget(
                labelText: "Parola (Tekrar)",
                iconData: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              GradientButton(
                text: "Kayıt Ol",
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
