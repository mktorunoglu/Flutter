import 'package:flutter/material.dart';
import 'package:flutter_responsive_widgets/app/breakpoints.dart';
import 'package:flutter_responsive_widgets/app/ui/widgets/responsive_layout/desktop_body.dart';
import 'package:flutter_responsive_widgets/app/ui/widgets/responsive_layout/mobile_body.dart';
import 'package:flutter_responsive_widgets/app/ui/widgets/responsive_layout/tablet_body.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Responsive Layout"),
      ),
      body: LayoutBuilder(
        builder: (context, dimensions) {
          if (dimensions.maxWidth < kTabletBreakpoint) {
            return mobileBody();
          } else if (dimensions.maxWidth > kDesktopBreakpoint) {
            return desktopBody();
          } else {
            return tabletBody();
          }
        },
      ),
    );
  }
}
