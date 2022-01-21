import 'package:flutter/material.dart';

import '../texts/text_widget.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.iconData,
    required this.themeColor,
    required this.socialName,
    required this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final Color themeColor;
  final String socialName;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(color: themeColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Icon(
                    iconData,
                    color: themeColor,
                    size: 28,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextWidget(
                  text: socialName + " ile Giriş Yap",
                  color: themeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              primary: themeColor,
              backgroundColor: themeColor.withOpacity(0.1)),
        ),
      ),
    );
  }
}
