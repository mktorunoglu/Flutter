import 'package:flutter/material.dart';

import '../core/components/buttons/button_widget.dart';
import '../core/components/buttons/icon_button_widget.dart';
import '../core/components/containers/rounded_container.dart';
import '../core/components/items/mail_navigation_bar_item.dart';
import '../core/components/texts/text_widget.dart';
import '../core/constants/color_constants.dart';
import '../core/constants/mail_list.dart';
import '../core/models/mail_model.dart';

class MailContentScreen extends StatelessWidget {
  const MailContentScreen({
    Key? key,
    required this.mailIndex,
  }) : super(key: key);

  final int mailIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool breakpointPortrait = screenWidth < 600;

    MailModel mail = mailList[mailIndex];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: const [
          IconButtonWidget(
            iconData: Icons.keyboard_arrow_up,
            iconSize: 30,
          ),
          IconButtonWidget(
            iconData: Icons.keyboard_arrow_down,
            iconSize: 30,
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Container(
        height: double.infinity,
        color: ColorConstants.primaryColor,
        child: RoundedContainer(
          borderRadius: breakpointPortrait ? BorderRadius.circular(40) : null,
          edgeInsetsPadding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextWidget(
                        text: mail.subject,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButtonWidget(
                      iconData: mail.favStatus ? Icons.star : Icons.star_border,
                      color: mail.favStatus ? Colors.orange : Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "29 Aralık 2021  " + mail.date,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(height: 10),
                    ButtonWidget(
                      text: mail.sender,
                      buttonColor: Colors.grey.shade300,
                      textColor: Colors.black,
                      disableButton: true,
                    ),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 20),
                    TextWidget(
                      text: mail.content,
                      fontSize: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
          scrollBar: true,
        ),
      ),
      bottomNavigationBar: Container(
        color: ColorConstants.primaryColor,
        child: Row(
          children: const [
            MailNavigationBarItem(
              iconData: Icons.reply,
              text: "Yanıtla",
            ),
            MailNavigationBarItem(
              iconData: Icons.reply_all,
              text: "Tümünü Yanıtla",
            ),
            MailNavigationBarItem(
              iconData: Icons.send,
              text: "İlet",
            ),
            MailNavigationBarItem(
              iconData: Icons.delete,
              text: "Sil",
            ),
            MailNavigationBarItem(
              iconData: Icons.more_vert,
              text: "Daha Fazla",
            ),
          ],
        ),
      ),
    );
  }
}
