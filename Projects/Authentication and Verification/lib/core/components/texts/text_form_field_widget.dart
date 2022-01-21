import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.labelText,
    this.textInputType,
    required this.controller,
    this.autofocus,
    this.hintText,
  }) : super(key: key);

  final String labelText;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final bool? autofocus;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      autofocus: autofocus ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
