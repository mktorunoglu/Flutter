import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.text,
    this.textColor,
    this.buttonColor,
    this.fontSize,
    this.disableButton,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final double? fontSize;
  final bool? disableButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disableButton == true ? null : () {},
      style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
