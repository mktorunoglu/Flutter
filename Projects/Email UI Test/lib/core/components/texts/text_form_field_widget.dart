import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.labelText,
    required this.iconData,
    this.obscureText,
    this.textInputType,
  }) : super(key: key);

  final String labelText;
  final IconData iconData;
  final bool? obscureText;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: Icon(iconData),
        contentPadding: const EdgeInsets.only(left: 20),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: ColorConstants.primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
