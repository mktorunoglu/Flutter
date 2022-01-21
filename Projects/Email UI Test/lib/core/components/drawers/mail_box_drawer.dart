import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../buttons/icon_button_widget.dart';
import '../items/drawer_item.dart';
import '../texts/text_widget.dart';

class MailBoxDrawer extends StatelessWidget {
  const MailBoxDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool breakpointPortrait = screenWidth < 600;

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(40),
          bottomRight:
              breakpointPortrait ? const Radius.circular(40) : Radius.zero,
        ),
      ),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 20, 0),
                child: IconButtonWidget(
                  iconData: Icons.settings,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 70,
            width: 70,
            child: CircleAvatar(
              backgroundColor: Colors.lightBlue,
              child: SizedBox(
                height: 67,
                width: 67,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      "images/avatar.png",
                      height: 62,
                      width: 62,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: TextWidget(
              text: "mktorunoglu55@gmail.com",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          DrawerItem(
            text: "kamil.torunoglu@bil.omu.edu.tr",
            notificationContainer: true,
            notificationCount: 19,
            iconColor: ColorConstants.primaryColor,
          ),
          const DrawerItem(
            text: "mktorunoglu55@gmail.com",
            notificationContainer: true,
            notificationCount: 7,
            iconColor: Colors.lightBlue,
            currentEmail: true,
          ),
          const DrawerItem(
            text: "17060264@stu.omu.edu.tr",
            iconColor: Colors.purpleAccent,
          ),
          const DrawerItem(
            text: "Tüm Hesaplar",
            notificationContainer: true,
            notificationCount: 26,
            iconColor: Colors.grey,
          ),
          const Divider(thickness: 1, indent: 25, endIndent: 25),
          const DrawerItem(
            text: "Gelen Kutusu",
            notificationContainer: true,
            notificationCount: 15,
            iconData: Icons.inbox,
            fontWeight: FontWeight.bold,
          ),
          const DrawerItem(
            text: "Okunmamış",
            notificationContainer: true,
            notificationCount: 15,
            iconData: Icons.email,
          ),
          const DrawerItem(
            text: "Yıldızlı",
            iconData: Icons.star,
            iconColor: Colors.orange,
          ),
          const DrawerItem(
            text: "Gönderilen Ögeler",
            iconData: Icons.forward_to_inbox,
          ),
          const DrawerItem(
            text: "Çöp",
            iconData: Icons.delete,
            notificationCount: 3,
          ),
          const DrawerItem(
            text: "Spam",
            iconData: Icons.do_disturb_alt,
            notificationCount: 34,
          ),
          const Divider(thickness: 1, indent: 25, endIndent: 25),
          const DrawerItem(
            text: "Klasör Ekle",
            iconData: Icons.add,
            iconColor: Colors.green,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
