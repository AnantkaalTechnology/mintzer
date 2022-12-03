import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

class HomeButon extends StatelessWidget {
  const HomeButon({
    Key? key,
    required this.onTap,
    required this.text,
    required this.buttonColor,
    this.height = 88,
    this.margin,
    this.showTimer = false,
    this.timerText = "00:00",
    this.listOfColor = const [
      Color(0xff5bf673),
      Color(0xff03C91E),
      Color(0xff017C0E),
    ],
  }) : super(key: key);
  final Function onTap;
  final String text;
  final int buttonColor;
  final double height;
  final margin;
  final bool showTimer;
  final String timerText;
  final List<Color> listOfColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: height,
        width: double.infinity,
        margin: margin ?? const EdgeInsets.all(constants.defaultPadding),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: buttonColor == 1
                  ? [
                      const Color(0xffFFEC48),
                      const Color(0xffF19F03),
                      const Color(0xffCD8F0A),
                    ]
                  : buttonColor == 2
                      ? [
                          const Color(0xffA8CCE7),
                          const Color(0xff2055F4),
                          const Color(0xff3057CC),
                        ]
                      : buttonColor == 3
                          ? [
                              const Color(0xffda96ea),
                              const Color(0xffc103f1),
                              const Color(0xffA60ACD),
                            ]
                          : listOfColor,
            ),
            borderRadius: constants.borderRadius),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            showTimer
                ? Padding(
                    padding: const EdgeInsets.all(constants.defaultPadding),
                    child: Text(
                      timerText,
                      style: textStyle.subHeading.copyWith(color: colorWhite),
                    ),
                  )
                : Container(),
            Center(
              child: Text(
                text,
                style: textStyle.heading.copyWith(color: colorWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
