import 'package:flutter/material.dart';

import '../texts/text_widget.dart';

class FloatingActionButtonExtended extends StatelessWidget {
  const FloatingActionButtonExtended({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final Color? buttonColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: buttonColor ?? Colors.grey.shade400,
      splashColor: (textColor ?? Colors.black).withOpacity(0.1),
      onPressed: onPressed,
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextWidget(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
