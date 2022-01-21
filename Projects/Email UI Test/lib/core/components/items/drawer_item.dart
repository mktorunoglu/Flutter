import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    this.iconData,
    this.iconColor,
    required this.text,
    this.fontWeight,
    this.fontSize,
    this.notificationCount,
    this.notificationContainer,
    this.currentEmail,
  }) : super(key: key);

  final IconData? iconData;
  final Color? iconColor;
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? notificationCount;
  final bool? notificationContainer;
  final bool? currentEmail;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.back(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Center(
                child: iconData == null
                    ? SizedBox(
                        height: 10,
                        width: 10,
                        child: CircleAvatar(
                          backgroundColor: iconColor,
                          child: currentEmail == true
                              ? const SizedBox.shrink()
                              : const SizedBox(
                                  height: 6,
                                  width: 6,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white),
                                ),
                        ),
                      )
                    : Icon(
                        iconData,
                        size: 20,
                        color: iconColor ?? Colors.grey.shade700,
                      ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: fontWeight,
                  fontSize: iconData == null ? 14 : 16,
                  color: Colors.black,
                ),
              ),
            ),
            if (notificationCount != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: notificationContainer == true
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.redAccent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          child: Text(
                            notificationCount.toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                      )
                    : Text(
                        notificationCount.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
