import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../core/components/buttons/gradient_button.dart';
import '../core/components/buttons/social_sign_in_button.dart';
import '../core/components/buttons/text_button_widget.dart';
import '../core/components/checkboxes/checkbox_widget.dart';
import '../core/components/containers/gradient_container.dart';
import '../core/components/containers/header_container.dart';
import '../core/components/containers/rounded_container.dart';
import '../core/components/texts/text_form_field_widget.dart';
import '../core/components/texts/text_widget.dart';
import '../core/constants/color_constants.dart';
import 'forgotten_password_screen.dart';
import 'mail_box_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        headerWidget: const HeaderContainer(
          iconData: Icons.account_circle,
          text: "Giriş Yap",
          addBackButton: false,
        ),
        child: RoundedContainer(
          scrollBar: false,
          child: Column(
            children: [
              const TextFormFieldWidget(
                labelText: "E-Posta Adresi",
                iconData: Icons.email,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 25),
              const TextFormFieldWidget(
                labelText: "Parola",
                iconData: Icons.lock,
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButtonWidget(
                      onPressed: () {
                        Get.to(() => const ForgottenPasswordScreen());
                      },
                      text: "Şifremi Unuttum",
                    ),
                  ],
                ),
              ),
              GradientButton(
                text: "Giriş Yap",
                onPressed: () {
                  Get.to(() => const MailBoxScreen());
                },
              ),
              const SizedBox(height: 10),
              const CheckboxWidget(text: "Beni Hatırla"),
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 2)),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextWidget(
                      text: "Ya Da",
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 2)),
                ],
              ),
              SocialSignInButton(
                iconData: FontAwesomeIcons.googlePlus,
                themeColor: ColorConstants.googleRedColor,
                socialName: "Google",
              ),
              SocialSignInButton(
                iconData: FontAwesomeIcons.facebook,
                themeColor: ColorConstants.facebookColor,
                socialName: "Facebook",
              ),
              const SocialSignInButton(
                iconData: FontAwesomeIcons.apple,
                themeColor: Colors.black,
                socialName: "Apple ID",
              ),
              const Divider(thickness: 2, height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Hesabın Yok Mu?"),
                  TextButtonWidget(
                    onPressed: () {
                      Get.to(() => const RegisterScreen());
                    },
                    text: "Kaydol.",
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
