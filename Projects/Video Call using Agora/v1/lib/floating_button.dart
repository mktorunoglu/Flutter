import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor,
    this.mini,
    required this.iconData,
    this.iconColor,
    this.tooltip,
    required this.slideMilliseconds,
    required this.slideState,
  }) : super(key: key);

  final Function() onPressed;
  final Color? backgroundColor;
  final bool? mini;
  final IconData iconData;
  final Color? iconColor;
  final String? tooltip;
  final int slideMilliseconds;
  final bool slideState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: AnimatedSlide(
        duration: Duration(milliseconds: slideMilliseconds),
        offset: slideState ? const Offset(0, 2) : Offset.zero,
        child: FloatingActionButton(
          heroTag: null,
          onPressed: onPressed,
          backgroundColor: backgroundColor ?? Colors.white,
          mini: mini ?? true,
          child: Icon(iconData, color: iconColor ?? Colors.grey.shade900),
          tooltip: tooltip,
        ),
      ),
    );
  }
}
