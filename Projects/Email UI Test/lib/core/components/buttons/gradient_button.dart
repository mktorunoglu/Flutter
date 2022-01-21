import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../texts/text_widget.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorConstants.gradientBeginColor,
            ColorConstants.gradientEndColor,
          ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: 50,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: TextWidget(
          text: text,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
