import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../controllers/remember_me_controller.dart';
import '../texts/text_widget.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    Get.put(RememberMeController());

    return Row(
      children: [
        Obx(
          () => Transform.scale(
            scale: 1.1,
            child: Checkbox(
              value: RememberMeController.instance.isChecked.value,
              onChanged: (value) {
                RememberMeController.instance.changeCheckStatus();
              },
              shape: const CircleBorder(),
              side: BorderSide(
                width: 1,
                color: Colors.grey.shade600,
              ),
              activeColor: ColorConstants.primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            RememberMeController.instance.changeCheckStatus();
          },
          child: TextWidget(
            text: text,
            color: Colors.black,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 0),
          ),
        ),
      ],
    );
  }
}
