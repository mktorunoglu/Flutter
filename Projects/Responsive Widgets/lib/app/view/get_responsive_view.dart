import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_responsive_widgets/app/ui/widgets/responsive_layout/desktop_body.dart';
import 'package:flutter_responsive_widgets/app/ui/widgets/responsive_layout/mobile_body.dart';
import 'package:flutter_responsive_widgets/app/ui/widgets/responsive_layout/tablet_body.dart';

class GetResponsiveViewPage extends GetResponsiveView {
  GetResponsiveViewPage({Key? key}) : super(key: key);

  @override
  Widget? builder() {
    Widget _body;
    switch (screen.screenType) {
      case ScreenType.Phone:
        _body = mobileBody();
        break;
      case ScreenType.Tablet:
        _body = tabletBody();
        break;
      case ScreenType.Desktop:
        _body = desktopBody();
        break;
      default:
        _body = const Center();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("GetResponsiveView"),
      ),
      body: _body,
    );
  }
}
