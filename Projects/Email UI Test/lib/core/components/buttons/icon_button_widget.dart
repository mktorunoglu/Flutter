import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    Key? key,
    required this.iconData,
    this.color,
    this.iconSize,
    this.edgeInsetsPadding,
    this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final Color? color;
  final double? iconSize;
  final EdgeInsets? edgeInsetsPadding;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsetsPadding ?? const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: iconSize ?? 24,
        width: iconSize ?? 24,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed ?? () {},
          icon: Icon(iconData),
          color: color ?? Colors.white,
          iconSize: iconSize ?? 24,
        ),
      ),
    );
  }
}
