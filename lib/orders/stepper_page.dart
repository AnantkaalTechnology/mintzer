// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import '../globalVariable.dart';
import '../util/colors.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({Key? key}) : super(key: key);

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  int currentStep = 0;
  int sec = 59;

  @override
  Widget build(BuildContext context) {
    ControlsDetails controlsDetails =
        ControlsDetails(currentStep: currentStep, stepIndex: 0);
    return Scaffold(
        // Here we have initialized the stepper widget
        body: Theme(
          data: ThemeData(
            canvasColor: colorAccent3,
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: colorDark,
              // background: Colors.red,
              // secondary: Colors.green,
            ),
          ),
          child: Stepper(
            elevation: 0,
            type: StepperType.vertical,
            steps: stepList(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == stepList().length - 1;
              if (isLastStep) {
                print("Completed");
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepCancel:
                currentStep == 0 ? null : () => setState(() => currentStep -= 1),
            controlsBuilder: (context, controlsDetails) {
              if (currentStep > 0 || currentStep < 4) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: NewButton(
                        context: context,
                        buttonText: "Save",
                        height: 36.h,
                        textStyle: textStyle.button.copyWith(fontSize: 14.sp),
                        margin: const EdgeInsets.symmetric(
                          horizontal: constants.defaultPadding / 2,
                        ),
                        function: () {
                          final isLastStep = currentStep == stepList().length - 1;
                          if (isLastStep) {
                            print("Completed");
                          } else {
                            setState(() => currentStep += 1);
                          }
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ordered cancelled?",
                            style: textStyle.smallText,
                          ),
                          Text(
                            "Mark cancelled>",
                            style: textStyle.smallTextColorDark
                                .copyWith(color: colorDark),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (currentStep == 0) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: NewButton(
                        context: context,
                        buttonText: "Save",
                        height: 36.h,
                        textStyle: textStyle.button.copyWith(fontSize: 14.sp),
                        margin: const EdgeInsets.symmetric(
                          horizontal: constants.defaultPadding / 2,
                        ),
                        function: () {
                          final isLastStep = currentStep == stepList().length - 1;
                          if (isLastStep) {
                            print("Completed");
                          } else {
                            setState(() => currentStep += 1);
                          }
                        },
                      ),
                    ),

                    ///order now button--------------
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "not yet ordered?",
                            style: textStyle.smallText,
                          ),
                          Text(
                            "Order Now>",
                            style: textStyle.smallTextColorDark
                                .copyWith(color: colorDark),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ordered cancelled?",
                            style: textStyle.smallText,
                          ),
                          Text(
                            "Mark cancelled>",
                            style: textStyle.smallTextColorDark
                                .copyWith(color: colorDark),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return NewButton(
                context: context,
                function: () {},
                buttonText: "Done",
              );

              // currentStep > 0
              //   ? Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Expanded(
              //           child: NewButton(
              //             context: context,
              //             buttonText: "Save",
              //             height: 36.h,
              //             textStyle:
              //                 textStyle.button.copyWith(fontSize: 14.sp),
              //             margin: EdgeInsets.symmetric(
              //               horizontal: constants.defaultPadding / 2,
              //             ),
              //             function: () {
              //               final isLastStep =
              //                   currentStep == stepList().length - 1;
              //               if (isLastStep) {
              //                 print("Completed");
              //               } else {
              //                 setState(() => currentStep += 1);
              //               }
              //             },
              //           ),
              //         ),
              //
              //         ///order now button--------------
              //         // Expanded(
              //         //   child: Column(
              //         //     crossAxisAlignment: CrossAxisAlignment.start,
              //         //     children: [
              //         //       Text(
              //         //         "not yet ordered?",
              //         //         style: textStyle.smallText,
              //         //       ),
              //         //       Text(
              //         //         "Order Now>",
              //         //         style: textStyle.smallTextColorDark
              //         //             .copyWith(color: colorDark),
              //         //       ),
              //         //     ],
              //         //   ),
              //         // ),
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "ordered cancelled?",
              //                 style: textStyle.smallText,
              //               ),
              //               Text(
              //                 "Mark cancelled>",
              //                 style: textStyle.smallTextColorDark
              //                     .copyWith(color: colorDark),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     )
              //
              //   : Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Expanded(
              //           child: NewButton(
              //             context: context,
              //             buttonText: "Save",
              //             height: 36.h,
              //             textStyle:
              //                 textStyle.button.copyWith(fontSize: 14.sp),
              //             margin: EdgeInsets.symmetric(
              //               horizontal: constants.defaultPadding / 2,
              //             ),
              //             function: () {
              //               final isLastStep =
              //                   currentStep == stepList().length - 1;
              //               if (isLastStep) {
              //                 print("Completed");
              //               } else {
              //                 setState(() => currentStep += 1);
              //               }
              //             },
              //           ),
              //         ),
              //
              //         ///order now button--------------
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "not yet ordered?",
              //                 style: textStyle.smallText,
              //               ),
              //               Text(
              //                 "Order Now>",
              //                 style: textStyle.smallTextColorDark
              //                     .copyWith(color: colorDark),
              //               ),
              //             ],
              //           ),
              //         ),
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 "ordered cancelled?",
              //                 style: textStyle.smallText,
              //               ),
              //               Text(
              //                 "Mark cancelled>",
              //                 style: textStyle.smallTextColorDark
              //                     .copyWith(color: colorDark),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     );
            },
          ),
        ));
  }

  List<Step> stepList() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          label: Text(
            "accepted",
            style: textStyle.smallText.copyWith(color: colorHeadingText,fontSize: 9.sp)
          ),
          title: Text(
            '',
            style: textStyle.smallText.copyWith(color: Colors.black),
          ),
          // subtitle: Text(
          //   "19 Nov 2022",
          //   style: textStyle.smallText.copyWith(color: Colors.black),
          // ),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "mintraz order id",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                  Text(
                    "mint4907466670",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                ],
              ),
              const SizedBox(
                height: constants.defaultPadding / 2,
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
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "999-999999-999999",
                            hintStyle: textStyle.subHeading
                                .copyWith(color: colorSubHeadingText),
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
                              value: double.parse(
                                  flutterMapValue(0.0, 1.0, 0, 59, sec)),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  colorDark))),
                      Text(
                        "00:${addZero(sec)}",
                        style: textStyle.smallText.copyWith(color: colorDark),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          label: Text(
            "ordered",
            style: textStyle.smallText.copyWith(color: colorHeadingText,fontSize: 9.sp)
          ),
          title: Text(
            '',
            style: textStyle.smallText.copyWith(color: Colors.black),
          ),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "mintraz order id",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                  Text(
                    "mint4907466670",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                ],
              ),
              const SizedBox(
                height: constants.defaultPadding / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Flipkart order #",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
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
                height: constants.defaultPadding / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tracking id",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
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
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "99999-999999-999999",
                      hintStyle: textStyle.subHeading
                          .copyWith(color: colorSubHeadingText),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          label: Text(
            "shipped",
            style: textStyle.smallText.copyWith(color: colorHeadingText,fontSize: 9.sp)
          ),
          title: Text(
            '',
            style: textStyle.smallText.copyWith(color: Colors.black),
          ),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "mintraz order id",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                  Text(
                    "mint4907466670",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                ],
              ),
              const SizedBox(
                height: constants.defaultPadding / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Flipkart order #",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
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
                height: constants.defaultPadding / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tracking id",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
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
                height: constants.defaultPadding / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Support",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
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
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: " Enter your OTP/PIN",
                      hintStyle: textStyle.subHeading
                          .copyWith(color: colorSubHeadingText),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          label: Text(
            "delivered",
            style: textStyle.smallText.copyWith(color: colorHeadingText,fontSize: 9.sp)
          ),
          title: Text(
            '',
            style: textStyle.smallText.copyWith(color: Colors.black),
          ),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "mintraz order id",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                  Text(
                    "mint4907466670",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                ],
              ),
              const SizedBox(
                height: constants.defaultPadding / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Flipkart order #",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
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
                height: constants.defaultPadding / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tracking id",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
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
                height: constants.defaultPadding / 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Support",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
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
                height: constants.defaultPadding / 2,
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 4 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 4,
          label: Text(
            "payment",
            style: textStyle.smallText.copyWith(color: colorHeadingText,fontSize: 9.sp),
          ),
          title: Text(
            '',
            style: textStyle.smallText.copyWith(color: Colors.black),
          ),
          content: Column(
            children: [
              Image.asset(
                'images/done.png',
                height: 90.h,
                width: 90.w,
              ),
              Text(
                "Payment Done",
                style: textStyle.subHeadingColorDark
                    .copyWith(color: colorHeadingText),
              ),
            ],
          ),
        ),
      ];
}
