import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../texts/text_widget.dart';

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    Key? key,
    required this.iconData,
    required this.themeColor,
    required this.socialName,
  }) : super(key: key);

  final IconData iconData;
  final Color themeColor;
  final String socialName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: themeColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: FaIcon(
                    iconData,
                    color: themeColor,
                    size: 26,
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: TextWidget(
                  text: socialName + " ile Giriş Yap",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                flex: 2,
              ),
            ],
          ),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            primary: themeColor,
          ),
        ),
      ),
    );
  }
}
