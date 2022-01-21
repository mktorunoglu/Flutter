import 'package:flutter/material.dart';

import '../texts/text_widget.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.fontWeight,
  }) : super(key: key);

  final Function() onPressed;
  final String text;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: TextWidget(
        text: text,
        color: Colors.black,
        fontWeight: fontWeight,
      ),
    );
  }
}
