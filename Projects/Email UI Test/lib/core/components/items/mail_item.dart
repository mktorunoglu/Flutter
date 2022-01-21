import 'package:flutter/material.dart';

import '../../classes/snackbar_class.dart';
import '../buttons/icon_button_widget.dart';
import '../containers/dismissible_container.dart';
import '../texts/text_widget.dart';

class MailItem extends StatelessWidget {
  const MailItem({
    Key? key,
    required this.sender,
    required this.subject,
    required this.content,
    required this.date,
    required this.readStatus,
    required this.favStatus,
    required this.dismissibleKey,
    required this.onPressed,
  }) : super(key: key);

  final String sender;
  final String subject;
  final String content;
  final String date;
  final bool readStatus;
  final bool favStatus;
  final String dismissibleKey;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    if (readStatus) {
      textColor = Colors.grey.shade600;
    }

    return Dismissible(
      key: Key(dismissibleKey),
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).clearSnackBars();
        switch (direction) {
          case DismissDirection.startToEnd:
            SnackbarClass.showSnackbar(
              context,
              Icons.archive,
              "E-posta arşive eklendi.",
              Colors.blueAccent,
              2,
            );
            break;
          case DismissDirection.endToStart:
            SnackbarClass.showSnackbar(
              context,
              Icons.delete,
              "E-posta silindi.",
              Colors.redAccent,
              2,
            );
            break;
          default:
        }
      },
      background: const DismissibleContainer(
        color: Colors.blueAccent,
        iconData: Icons.archive,
        text: "Arşive Ekle",
        direction: "left",
      ),
      secondaryBackground: const DismissibleContainer(
        color: Colors.redAccent,
        iconData: Icons.delete,
        text: "Sil",
        direction: "right",
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7, 10, 0),
                    child: SizedBox(
                      height: 7,
                      width: 7,
                      child: readStatus
                          ? const SizedBox.shrink()
                          : const CircleAvatar(
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: sender,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textOverflow: TextOverflow.ellipsis,
                          color: textColor,
                        ),
                        const SizedBox(height: 5),
                        TextWidget(
                          text: subject,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          textOverflow: TextOverflow.ellipsis,
                          color: textColor,
                        ),
                        const SizedBox(height: 2),
                        TextWidget(
                          text: content,
                          fontSize: 14,
                          textOverflow: TextOverflow.ellipsis,
                          color: textColor,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextWidget(
                        text: date,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(height: 20),
                      IconButtonWidget(
                        iconData: favStatus ? Icons.star : Icons.star_border,
                        color: favStatus ? Colors.orange : Colors.black,
                        edgeInsetsPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(thickness: 1, height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
