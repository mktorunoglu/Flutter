import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.textOverflow,
    this.textAlign,
  }) : super(key: key);

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
      overflow: textOverflow,
      textAlign: textAlign,
    );
  }
}
