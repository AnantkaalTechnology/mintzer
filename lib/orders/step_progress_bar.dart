import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import '../globalVariable.dart';

class SteopProgressBarPage extends StatefulWidget {
  const SteopProgressBarPage({Key? key}) : super(key: key);

  @override
  State<SteopProgressBarPage> createState() => _SteopProgressBarPageState();
}

class _SteopProgressBarPageState extends State<SteopProgressBarPage> {
  int sec = 59;
  int steps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(constants.defaultPadding),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///--------1
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: steps > 0
                                    ? colorDark
                                    : colorSubHeadingText,
                                border: Border.all(
                                  color: steps > 0
                                      ? colorDark
                                      : colorSubHeadingText,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(constants.radius))),
                            child: Padding(
                              padding: const EdgeInsets.all(constants.defaultPadding/3),
                              child: Image.asset('images/accepted.png',color: steps > 0
                                  ? colorWhite
                                  : Colors.black,),
                            ),
                          ),
                          Text("accepted",
                              style: textStyle.smallText.copyWith(
                                  color: colorHeadingText,
                                  fontSize: 9.sp)),
                        ],
                      ),
                    ],
                  ),

                  ///----------2
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: steps > 1
                                    ? colorDark
                                    : colorSubHeadingText,
                                border: Border.all(
                                  color: steps > 1
                                      ? colorDark
                                      : colorSubHeadingText,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(constants.radius))),
                            child: Padding(
                              padding: const EdgeInsets.all(constants.defaultPadding/3),
                              child: Image.asset('images/order.png',color: steps > 1
                                  ? colorWhite
                                  : Colors.black,),
                            ),
                          ),
                          Text("ordered",
                              style: textStyle.smallText.copyWith(
                                  color: colorHeadingText,
                                  fontSize: 9.sp)),
                        ],
                      ),
                    ],
                  ),

                  ///----------3
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: steps > 2
                                    ? colorDark
                                    : colorSubHeadingText,
                                border: Border.all(
                                  color: steps > 2
                                      ? colorDark
                                      : colorSubHeadingText,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(constants.radius))),
                            child: Padding(
                              padding: const EdgeInsets.all(constants.defaultPadding/3),
                              child: Image.asset('images/shipped.png',color: steps > 2
                                  ? colorWhite
                                  : Colors.black,),
                            ),
                          ),
                          Text("shipped",
                              style: textStyle.smallText.copyWith(
                                  color: colorHeadingText,
                                  fontSize: 9.sp)),
                        ],
                      ),
                    ],
                  ),

                  ///----------4
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: steps > 3
                                    ? colorDark
                                    : colorSubHeadingText,
                                border: Border.all(
                                    color: steps > 3
                                        ? colorDark
                                        : colorSubHeadingText),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(constants.radius))),
                            child: Padding(
                              padding: const EdgeInsets.all(constants.defaultPadding/3),
                              child: Image.asset('images/delivered.png',color: steps > 3
                                  ? colorWhite
                                  : Colors.black,),
                            ),
                          ),
                          Text("delivered",
                              style: textStyle.smallText.copyWith(
                                  color: colorHeadingText,
                                  fontSize: 9.sp)),
                        ],
                      ),
                    ],
                  ),

                  ///----------5
                  Column(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: steps > 4
                                ? colorDark
                                : colorSubHeadingText,
                            border: Border.all(
                              color: steps > 4
                                  ? colorDark
                                  : colorSubHeadingText,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(constants.radius))),
                        child: Padding(
                          padding: const EdgeInsets.all(constants.defaultPadding/3),
                          child: Image.asset('images/payment2.png',color: steps > 4
                              ? colorWhite
                              : Colors.black,),
                        ),
                      ),
                      Text("payment",
                          style: textStyle.smallText.copyWith(
                              color: colorHeadingText, fontSize: 9.sp)),
                    ],
                  ),
                ],
              ),
              const Divider(
                thickness: 0.2,
                color: colorHeadingText,
                height: constants.defaultPadding * 3,
              ),


              ///----------payment-------
              Visibility(
                visible: steps == 4 ? true : false,
                child: Column(
                  children: [
                    Image.asset(
                      'images/done.png',
                      height: 90.h,
                      color: colorSuccess,
                      width: 90.w,
                    ),
                    Visibility(
                      visible: false,
                      child: Text(
                        "Payment is panding",
                        style: textStyle.heading
                            .copyWith(color: colorWarning),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: Text(
                        "Payment Done",
                        style: textStyle.heading
                            .copyWith(color: colorSuccess),
                      ),
                    ),
                  ],
                ),
              ),

              ///-------delivered--------
              Visibility(
                visible: steps == 3 ? true : false,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "mintzer order id",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Text(
                          "mint4907466670",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Flipkart order",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Row(
                          children: [
                            Text(
                              "mint4907466670",
                              style: textStyle.smallText
                                  .copyWith(color: colorHeadingText),
                            ),
                            const SizedBox(
                              width: constants.defaultPadding / 3,
                            ),
                            Text(
                              "Edit",
                              style: textStyle.smallText.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tracking id",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Row(
                          children: [
                            Text(
                              "mint4907466670",
                              style: textStyle.smallText
                                  .copyWith(color: colorHeadingText),
                            ),
                            const SizedBox(
                              width: constants.defaultPadding / 3,
                            ),
                            Text(
                              "Edit",
                              style: textStyle.smallText.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Support",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Text(
                          "Status",
                          style: textStyle.smallText.copyWith(
                              color: colorHeadingText,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: NewButton(
                            context: context,
                            buttonText: "Save",
                            height: 36.h,
                            textStyle: textStyle.button
                                .copyWith(fontSize: 14.sp),
                            margin: const EdgeInsets.symmetric(
                              horizontal: constants.defaultPadding / 2,
                            ),
                            function: () {
                              customPrint("steps : $steps");
                              setState(() {
                                steps++;
                              });
                            },
                          ),
                        ),

                        ///order now button--------------
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "not yet ordered?",
                        //         style: textStyle.smallText,
                        //       ),
                        //       Text(
                        //         "Order Now>",
                        //         style: textStyle.smallTextColorDark
                        //             .copyWith(color: colorDark),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ordered cancelled?",
                                style: textStyle.smallText,
                              ),
                              Text(
                                "Mark cancelled",
                                style: textStyle.smallTextColorDark
                                    .copyWith(
                                        color: colorDark,
                                        decoration:
                                            TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///--------shipped--------
              Visibility(
                visible: steps == 2 ? true : false,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "mintzer order id",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Text(
                          "mint4907466670",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Flipkart order",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Row(
                          children: [
                            Text(
                              "mint4907466670",
                              style: textStyle.smallText
                                  .copyWith(color: colorHeadingText),
                            ),
                            const SizedBox(
                              width: constants.defaultPadding / 3,
                            ),
                            Text(
                              "Edit",
                              style: textStyle.smallText.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tracking id",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Row(
                          children: [
                            Text(
                              "mint4907466670",
                              style: textStyle.smallText
                                  .copyWith(color: colorHeadingText),
                            ),
                            const SizedBox(
                              width: constants.defaultPadding / 3,
                            ),
                            Text(
                              "Edit",
                              style: textStyle.smallText.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Support",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        // Text(
                        //   "Select courier patner",
                        //   style: textStyle.smallText.copyWith(
                        //       color: colorHeadingText,
                        //       decoration: TextDecoration.underline),
                        // ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 46.h,
                        width: 200,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          textCapitalization:
                              TextCapitalization.sentences,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: " Enter your OTP/PIN",
                            hintStyle: textStyle.subHeading
                                .copyWith(color: colorSubHeadingText),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: NewButton(
                            context: context,
                            buttonText: "Save",
                            height: 36.h,
                            textStyle: textStyle.button
                                .copyWith(fontSize: 14.sp),
                            margin: const EdgeInsets.symmetric(
                              horizontal: constants.defaultPadding / 2,
                            ),
                            function: () {
                              setState(() {
                                steps++;
                              });
                              customPrint("steps : $steps");
                            },
                          ),
                        ),

                        ///order now button--------------
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "not yet ordered?",
                        //         style: textStyle.smallText,
                        //       ),
                        //       Text(
                        //         "Order Now",
                        //         style: textStyle.smallTextColorDark
                        //             .copyWith(color: colorDark),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ordered cancelled?",
                                style: textStyle.smallText,
                              ),
                              Text(
                                "Mark cancelled",
                                style: textStyle.smallTextColorDark
                                    .copyWith(
                                        color: colorDark,
                                        decoration:
                                            TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///---------ordered-------
              Visibility(
                visible: steps == 1 ? true : false,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "mintzer order id",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Text(
                          "mint4907466670",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Flipkart order",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Row(
                          children: [
                            Text(
                              "mint4907466670",
                              style: textStyle.smallText
                                  .copyWith(color: colorHeadingText),
                            ),
                            const SizedBox(
                              width: constants.defaultPadding / 3,
                            ),
                            Text(
                              "Edit",
                              style: textStyle.smallText.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tracking id",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Text(
                          "Select courier patner",
                          style: textStyle.smallText.copyWith(
                              color: colorHeadingText,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 46.h,
                        width: 200,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          textCapitalization:
                              TextCapitalization.sentences,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "99999-999999-999999",
                            hintStyle: textStyle.subHeading
                                .copyWith(color: colorSubHeadingText),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: NewButton(
                            context: context,
                            buttonText: "Save",
                            height: 36.h,
                            textStyle: textStyle.button
                                .copyWith(fontSize: 14.sp),
                            margin: const EdgeInsets.symmetric(
                              horizontal: constants.defaultPadding / 2,
                            ),
                            function: () {
                              setState(() {
                                steps++;
                              });

                              customPrint("steps : $steps");
                            },
                          ),
                        ),

                        ///order now button--------------
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "not yet ordered?",
                        //         style: textStyle.smallText,
                        //       ),
                        //       Text(
                        //         "Order Now",
                        //         style: textStyle.smallTextColorDark
                        //             .copyWith(color: colorDark),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ordered cancelled?",
                                style: textStyle.smallText,
                              ),
                              Text(
                                "Mark cancelled",
                                style: textStyle.smallTextColorDark
                                    .copyWith(
                                        color: colorDark,
                                        decoration:
                                            TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///-------accepted page-----------
              Visibility(
                visible: steps == 0 ? true : false,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "mintzer order id",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                        Text(
                          "mint4907466670",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Flipkart order #",
                              style: textStyle.smallText
                                  .copyWith(color: colorHeadingText),
                            ),
                            SizedBox(
                              height: 46.h,
                              width: 200,
                              child: TextFormField(
                                textAlignVertical:
                                    TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "999-999999-999999",
                                  hintStyle: textStyle.subHeading
                                      .copyWith(
                                          color: colorSubHeadingText),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    value: double.parse(flutterMapValue(
                                        0.0, 1.0, 0, 59, sec)),
                                    valueColor:
                                        const AlwaysStoppedAnimation<
                                            Color>(colorDark))),
                            Text(
                              "00:${addZero(sec)}",
                              style: textStyle.smallText
                                  .copyWith(color: colorDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: constants.defaultPadding,
                    ),

                    ///----------button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: NewButton(
                            context: context,
                            buttonText: "Save",
                            height: 36.h,
                            textStyle: textStyle.button
                                .copyWith(fontSize: 14.sp),
                            margin: const EdgeInsets.symmetric(
                              horizontal: constants.defaultPadding / 2,
                            ),
                            function: () {
                              setState(() {
                                steps++;
                              });

                              customPrint("steps : $steps");
                            },
                          ),
                        ),

                        ///order now button--------------
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "not yet ordered?",
                                style: textStyle.smallText,
                              ),
                              Text(
                                "Order Now",
                                style: textStyle.smallTextColorDark
                                    .copyWith(
                                        color: colorDark,
                                        decoration:
                                            TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ordered cancelled?",
                                style: textStyle.smallText,
                              ),
                              Text(
                                "Mark cancelled",
                                style: textStyle.smallTextColorDark
                                    .copyWith(
                                        color: colorDark,
                                        decoration:
                                            TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
