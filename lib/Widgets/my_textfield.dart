import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import '../util/colors.dart';

class MyTextFiled extends StatelessWidget {
  const MyTextFiled({
    Key? key,
    required this.controller,
    required this.hint,
    this.length,
    this.inputType,
    this.margin,
    this.maxLine,
    this.onChange,
    this.height = 0, this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final int? length;
  final inputType;
  final margin;
  final int? maxLine;
  final suffixIcon;
  final Function(String)? onChange;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height == 0 ? 76.h : height,
      child: Padding(
        padding: margin ??
            const EdgeInsets.only(
                top: constants.defaultPadding * 2,
                left: constants.defaultPadding,
                right: constants.defaultPadding),
        child: Center(
          child: TextFormField(
            onChanged: onChange,
            controller: controller,
            inputFormatters: length != null
                ? [
                    LengthLimitingTextInputFormatter(length),
                  ]
                : [],
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: inputType,
            maxLines: maxLine ?? 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field can't be empty";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: suffixIcon,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(constants.radius),

                borderSide: BorderSide(
                  color: colorDark,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(constants.radius),
                borderSide: BorderSide(
                  color: colorDark,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(constants.radius),
                borderSide: BorderSide(
                  color: colorSubHeadingText,
                  width: 2.0,
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}
