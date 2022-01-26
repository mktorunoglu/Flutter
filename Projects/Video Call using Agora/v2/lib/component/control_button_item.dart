import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../video_call_controller.dart';

class ControlButtonItem extends StatelessWidget {
  const ControlButtonItem({
    Key? key,
    required this.onPressed,
    required this.backgroundColor,
    required this.iconData,
    required this.text,
    required this.animationDurationMs,
  }) : super(key: key);

  final Function() onPressed;
  final Color backgroundColor;
  final IconData iconData;
  final String text;
  final int animationDurationMs;

  @override
  Widget build(BuildContext context) {
    VideoCallController videoCallController = Get.find();

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(1),
        child: AnimatedSlide(
          duration: Duration(milliseconds: animationDurationMs),
          offset: videoCallController.hideButtons.value
              ? const Offset(0, 2)
              : Offset.zero,
          child: TextButton(
            onPressed: onPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(iconData, color: Colors.white),
                const SizedBox(height: 3),
                Text(
                  text,
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(5),
              backgroundColor: backgroundColor,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }
}
