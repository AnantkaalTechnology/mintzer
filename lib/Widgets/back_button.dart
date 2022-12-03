import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    Key? key,
    this.padding,
    this.onPress,
  }) : super(key: key);

  final padding;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPress == null) {
          Navigator.pop(context);
          return;
        }
        onPress!();
      },
      child: Padding(
        padding: padding ?? const EdgeInsets.all(constants.defaultPadding),
        child: Align(
          alignment: Alignment.topLeft,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 26.sp,
            color: colorBorder,
          ),
        ),
      ),
    );
  }
}
