import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/components/buttons/button_widget.dart';
import '../core/components/buttons/icon_button_widget.dart';
import '../core/components/containers/rounded_container.dart';
import '../core/components/drawers/mail_box_drawer.dart';
import '../core/components/items/mail_item.dart';
import '../core/components/texts/text_widget.dart';
import '../core/constants/color_constants.dart';
import '../core/constants/mail_list.dart';
import '../core/models/mail_model.dart';
import 'mail_content_screen.dart';

class MailBoxScreen extends StatelessWidget {
  const MailBoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    bool breakpointPortrait = screenWidth < 600;

    return Scaffold(
      drawer: const SafeArea(child: MailBoxDrawer()),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: screenHeight * 0.35,
                elevation: 0,
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: SizedBox(
                    height: 56,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButtonWidget(
                          iconData: Icons.menu,
                          edgeInsetsPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              TextWidget(
                                text: "Gelen Kutusu",
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              TextWidget(
                                text: "mktorunoglu55@gmail.com",
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ),
                        const IconButtonWidget(
                          iconData: Icons.search,
                          edgeInsetsPadding: EdgeInsets.only(left: 10),
                        ),
                        IconButtonWidget(
                          iconData: Icons.more_vert,
                          edgeInsetsPadding: breakpointPortrait
                              ? const EdgeInsets.symmetric(horizontal: 10)
                              : const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                flexibleSpace: SafeArea(
                  child: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Column(
                      children: [
                        const Expanded(flex: 2, child: SizedBox.shrink()),
                        const TextWidget(
                          text: "14  Okunmamış E-Posta",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        const SizedBox(height: 10),
                        ButtonWidget(
                          text: "Görüntüle",
                          textColor: Colors.white,
                          buttonColor: Colors.grey.withOpacity(0.7),
                        ),
                        const Expanded(flex: 5, child: SizedBox.shrink()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 55.5),
            color: ColorConstants.primaryColor,
            child: RoundedContainer(
              scrollBar: true,
              edgeInsetsPadding: EdgeInsets.zero,
              borderRadius:
                  breakpointPortrait ? BorderRadius.circular(40) : null,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: mailList.length,
                itemBuilder: (BuildContext context, int index) {
                  MailModel mail = mailList[index];

                  return MailItem(
                    sender: mail.sender,
                    subject: mail.subject,
                    content: mail.content.replaceAll("\n", " ").trim(),
                    date: mail.date,
                    readStatus: mail.readStatus,
                    favStatus: mail.favStatus,
                    dismissibleKey: index.toString(),
                    onPressed: () => Get.to(
                      MailContentScreen(mailIndex: index),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }
}
