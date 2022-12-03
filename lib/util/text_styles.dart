library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class textStyle {
  static final TextStyle heading = TextStyle(
    color: colorHeadingText,
    fontWeight: FontWeight.bold,
    fontSize: 20.sp,
  );

  static final TextStyle subHeading = TextStyle(
    color: colorSubHeadingText,
    fontWeight: FontWeight.normal,
    fontSize: 16.sp,
  );

  static final TextStyle subHeadingColorDark = subHeading.copyWith(
    color: colorHeadingText,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle smallTextColorDark = TextStyle(
      color: colorSubHeadingText, fontWeight: FontWeight.bold, fontSize: 13.sp);

  static final TextStyle smallText = TextStyle(
      color: colorSubHeadingText,
      fontWeight: FontWeight.normal,
      fontSize: 13.sp);

  static final TextStyle button = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18.sp,
  );

  static final TextStyle subButton = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    fontSize: 14.sp,
  );
}
