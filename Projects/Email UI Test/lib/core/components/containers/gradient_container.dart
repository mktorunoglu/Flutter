import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    Key? key,
    required this.headerWidget,
    required this.child,
  }) : super(key: key);

  final Widget headerWidget;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool breakpointPortrait = screenWidth < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: breakpointPortrait
              ? Alignment.centerRight
              : Alignment.bottomCenter,
          colors: [
            ColorConstants.gradientBeginColor,
            ColorConstants.gradientEndColor,
          ],
        ),
      ),
      child: SafeArea(
        child: breakpointPortrait
            ? Column(
                children: [
                  const Expanded(flex: 1, child: SizedBox.shrink()),
                  headerWidget,
                  const Expanded(flex: 1, child: SizedBox.shrink()),
                  Expanded(flex: 20, child: child),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: headerWidget,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: double.infinity,
                      child: child,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
