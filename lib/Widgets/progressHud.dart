import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double opacity;
  final Color color;

  ProgressHUD({
    required this.child,
    required this.isLoading,
    this.opacity = 0.5,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = List<Widget>.empty(growable: true);
    widgetList.add(child);
    if (isLoading) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Shimmer.fromColors(
            //       baseColor: colorDisable,
            //       highlightColor: colorDark,
            //       child: Center(
            //         child: Card(
            //           margin: const EdgeInsets.only(
            //               top: constants.defaultPadding,
            //               left: constants.defaultPadding,
            //               right: constants.defaultPadding),
            //           semanticContainer: true,
            //           elevation: 0,
            //           color: colorCustom.shade50,
            //           clipBehavior: Clip.antiAliasWithSaveLayer,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: constants.borderRadius * 100),
            //           child: const Padding(
            //             padding: EdgeInsets.all(constants.defaultPadding),
            //             child: Icon(
            //               Icons.wifi_protected_setup,
            //               color: colorDark,
            //               size: 88,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       height: constants.defaultPadding,
            //     ),
            //     Text(
            //       "Please Wait...",
            //       style: textStyle.heading.copyWith(color: colorWhite),
            //     ),
            //   ],
            // ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: constants.borderRadius,
                side: const BorderSide(width: 0.2, color: colorSubHeadingText),
              ),
              child: Padding(
                padding: const EdgeInsets.all(constants.defaultPadding * 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      width: constants.defaultPadding,
                    ),
                    Text(
                      "Please wait...",
                      style: textStyle.subHeadingColorDark
                          .copyWith(color: colorHeadingText),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
