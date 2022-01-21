import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.child,
    this.borderRadius,
    this.edgeInsetsPadding,
    required this.scrollBar,
  }) : super(key: key);

  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsets? edgeInsetsPadding;
  final bool scrollBar;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ??
          const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: scrollBar
            ? RawScrollbar(
                thickness: 10,
                radius: const Radius.circular(20),
                thumbColor: ColorConstants.primaryColor.withOpacity(0.5),
                child: SingleChildScrollView(
                  padding: edgeInsetsPadding ??
                      const EdgeInsets.fromLTRB(35, 45, 35, 20),
                  child: child,
                ),
              )
            : SingleChildScrollView(
                padding: edgeInsetsPadding ??
                    const EdgeInsets.fromLTRB(35, 45, 35, 20),
                child: child,
              ),
      ),
    );
  }
}
