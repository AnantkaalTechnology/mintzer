import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/deal/deal_note.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/orders/step_progress_bar.dart';
import 'package:mintzer/orders/stepper_page.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key,
    required this.productImage,
    required this.productTitle,
    required this.productOfferTitle,
    required this.productOfferText,
    required this.productYouSpend,
    required this.productTotalEarn,
    required this.productCashback,
    required this.productTotalReceive,
    required this.productLink,
    required this.productDealId,
    required this.dealId,
    required this.orderQuantity, this.orderPage = 0})
      : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();

  final String productImage;
  final String productTitle;
  final String productOfferTitle;
  final String productOfferText;
  final String productYouSpend;
  final String productTotalEarn;
  final String productCashback;
  final String productTotalReceive;
  final String productLink;
  final String productDealId;
  final String dealId;
  final String orderQuantity;
  final int orderPage;
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  int sec = 59;

  int steps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(
                top: constants.defaultPadding * 2,
                left: constants.defaultPadding,
                right: constants.defaultPadding,
              ),
              child: Column(
                children: [

                  ///----------key note card----------
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    color: colorAccent1,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(width: 0.4, color: colorDark),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(constants.defaultPadding),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Key Note",
                                style: textStyle.subHeading
                                    .copyWith(color: colorHeadingText),
                              )),
                          SizedBox(
                            height: constants.defaultPadding / 2,
                          ),
                          Text(
                            "Please accept this deal only if you can complete this order within the next 1 hour. The Order ID and Tracking ID should both exactly match with the delivered product otherwise the order will be cancelled by the buyer.",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          SizedBox(
                            height: constants.defaultPadding,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Add GST Number",
                                style: textStyle.subHeading
                                    .copyWith(color: colorHeadingText),
                              )),
                          SizedBox(
                            height: constants.defaultPadding / 2,
                          ),
                          Text(
                            "If you have GST number please add and verify your GST details",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          SizedBox(
                            height: constants.defaultPadding / 2,
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Add GST",
                                style: textStyle.smallTextColorDark.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline,
                                ),
                              )),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Need Help",
                                style: textStyle.subHeading
                                    .copyWith(color: colorHeadingText),
                              )),
                          Text(
                            "How to place your first order on Mintraz? (Mintraz par apna pehla order kaise karein?)",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "See in English",
                                style: textStyle.smallTextColorDark.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  // Card(
                  //   height: 300.h,
                  //   child:
                  // ),

                    Visibility(
                      visible: widget.orderPage == 0 ? false : true,
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        color: colorWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: constants.borderRadius,
                          side: const BorderSide(width: 0.4, color: colorDark),
                        ),
                        child: Container(
                          // color: colorAccent3,

                          child: Padding(
                            padding: const EdgeInsets.all(
                                constants.defaultPadding),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    ///--------1
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end,
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
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          constants.radius))),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    constants.defaultPadding /
                                                        3),
                                                child: Image.asset(
                                                  'images/accepted.png',
                                                  color: steps > 0
                                                      ? colorWhite
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text("accepted",
                                                style: textStyle.smallText
                                                    .copyWith(
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
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          constants.radius))),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    constants.defaultPadding /
                                                        3),
                                                child: Image.asset(
                                                  'images/order.png',
                                                  color: steps > 1
                                                      ? colorWhite
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text("ordered",
                                                style: textStyle.smallText
                                                    .copyWith(
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
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          constants.radius))),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    constants.defaultPadding /
                                                        3),
                                                child: Image.asset(
                                                  'images/shipped.png',
                                                  color: steps > 2
                                                      ? colorWhite
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text("shipped",
                                                style: textStyle.smallText
                                                    .copyWith(
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
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          constants.radius))),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    constants.defaultPadding /
                                                        3),
                                                child: Image.asset(
                                                  'images/delivered.png',
                                                  color: steps > 3
                                                      ? colorWhite
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text("delivered",
                                                style: textStyle.smallText
                                                    .copyWith(
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
                                                  Radius.circular(
                                                      constants.radius))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                constants.defaultPadding / 3),
                                            child: Image.asset(
                                              'images/payment2.png',
                                              color: steps > 4
                                                  ? colorWhite
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Text("payment",
                                            style: textStyle.smallText.copyWith(
                                                color: colorHeadingText,
                                                fontSize: 9.sp)),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  color: colorHeadingText,
                                  height: constants.defaultPadding,
                                ),

                                ///----------payment-------
                                Visibility(
                                  visible: steps == 4 ? true : false,
                                  child: Container(
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
                                ),

                                ///-------delivered--------
                                Visibility(
                                  visible: steps == 3 ? true : false,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "mintraz order id",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Text(
                                              "mint4907466670",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Flipkart order #",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "mint4907466670",
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                      color: colorHeadingText),
                                                ),
                                                SizedBox(
                                                  width:
                                                  constants.defaultPadding / 3,
                                                ),
                                                Text(
                                                  "Edit",
                                                  style: textStyle
                                                      .smallTextColorDark
                                                      .copyWith(
                                                      color: colorHeadingText,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tracking id",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "mint4907466670",
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                      color: colorHeadingText),
                                                ),
                                                SizedBox(
                                                  width:
                                                  constants.defaultPadding / 3,
                                                ),
                                                Text(
                                                  "Edit",
                                                  style: textStyle
                                                      .smallTextColorDark
                                                      .copyWith(
                                                      color: colorHeadingText,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Delivery Support",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Text(
                                              "Status",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText,
                                                  decoration:
                                                  TextDecoration.underline),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: NewButton(
                                                context: context,
                                                buttonText: "Save",
                                                height: 36.h,
                                                textStyle: textStyle.button
                                                    .copyWith(fontSize: 14.sp),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                  constants.defaultPadding / 2,
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
                                                    style: textStyle
                                                        .smallTextColorDark
                                                        .copyWith(
                                                        color: colorDark,
                                                        decoration:
                                                        TextDecoration
                                                            .underline),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                ///--------shipped--------
                                Visibility(
                                  visible: steps == 2 ? true : false,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "mintraz order id",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Text(
                                              "mint4907466670",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Flipkart order #",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "mint4907466670",
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                      color: colorHeadingText),
                                                ),
                                                SizedBox(
                                                  width:
                                                  constants.defaultPadding / 3,
                                                ),
                                                Text(
                                                  "Edit",
                                                  style: textStyle
                                                      .smallTextColorDark
                                                      .copyWith(
                                                      color: colorHeadingText,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tracking id",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "mint4907466670",
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                      color: colorHeadingText),
                                                ),
                                                SizedBox(
                                                  width:
                                                  constants.defaultPadding / 3,
                                                ),
                                                Text(
                                                  "Edit",
                                                  style: textStyle
                                                      .smallTextColorDark
                                                      .copyWith(
                                                      color: colorHeadingText,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Delivery Support",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
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
                                              textAlignVertical:
                                              TextAlignVertical.center,
                                              keyboardType: TextInputType
                                                  .number,
                                              textCapitalization:
                                              TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: " Enter your OTP/PIN",
                                                hintStyle: textStyle.subHeading
                                                    .copyWith(
                                                    color: colorSubHeadingText),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: NewButton(
                                                context: context,
                                                buttonText: "Save",
                                                height: 36.h,
                                                textStyle: textStyle.button
                                                    .copyWith(fontSize: 14.sp),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                  constants.defaultPadding / 2,
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
                                                    style: textStyle
                                                        .smallTextColorDark
                                                        .copyWith(
                                                        color: colorDark,
                                                        decoration:
                                                        TextDecoration
                                                            .underline),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                ///---------ordered-------
                                Visibility(
                                  visible: steps == 1 ? true : false,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "mintraz order id",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Text(
                                              "mint4907466670",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 0.1,
                                          color: colorHeadingText,
                                          height: constants.defaultPadding / 2,
                                        ),
                                        // SizedBox(
                                        //   height: constants.defaultPadding,
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Flipkart order #",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "mint4907466670",
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                      color: colorHeadingText),
                                                ),
                                                SizedBox(
                                                  width:
                                                  constants.defaultPadding / 3,
                                                ),
                                                Text(
                                                  "Edit",
                                                  style: textStyle
                                                      .smallTextColorDark
                                                      .copyWith(
                                                      color: colorHeadingText,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 0.1,
                                          color: colorHeadingText,
                                          height: constants.defaultPadding / 2,
                                        ),
                                        // SizedBox(
                                        //   height: constants.defaultPadding,
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tracking id",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Text(
                                              "Select courier patner",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText,
                                                  decoration:
                                                  TextDecoration.underline),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 0.1,
                                          color: colorHeadingText,
                                          height: constants.defaultPadding / 2,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            height: 46.h,
                                            width: 200,
                                            child: TextFormField(
                                              textAlignVertical:
                                              TextAlignVertical.center,
                                              keyboardType: TextInputType
                                                  .number,
                                              textCapitalization:
                                              TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "99999-999999-999999",
                                                hintStyle: textStyle.subHeading
                                                    .copyWith(
                                                    color: colorSubHeadingText),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: NewButton(
                                                context: context,
                                                buttonText: "Save",
                                                height: 36.h,
                                                textStyle: textStyle.button
                                                    .copyWith(fontSize: 14.sp),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                  constants.defaultPadding / 2,
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
                                                    style: textStyle
                                                        .smallTextColorDark
                                                        .copyWith(
                                                        color: colorDark,
                                                        decoration:
                                                        TextDecoration
                                                            .underline),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                ///-------accepted page-----------
                                Visibility(
                                  visible: steps == 0 ? true : false,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "mintraz order id",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                            Text(
                                              "mint4907466670",
                                              style: textStyle.smallText
                                                  .copyWith(
                                                  color: colorHeadingText),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Flipkart order #",
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                      color: colorHeadingText),
                                                ),
                                                SizedBox(
                                                  height: 46.h,
                                                  width: 200,
                                                  child: TextFormField(
                                                    textAlignVertical:
                                                    TextAlignVertical.center,
                                                    keyboardType:
                                                    TextInputType.number,
                                                    textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "999-999999-999999",
                                                      hintStyle: textStyle
                                                          .subHeading
                                                          .copyWith(
                                                          color:
                                                          colorSubHeadingText),
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
                                                            flutterMapValue(0.0,
                                                                1.0, 0, 59,
                                                                sec)),
                                                        valueColor:
                                                        const AlwaysStoppedAnimation<
                                                            Color>(colorDark))),
                                                Text(
                                                  "00:${addZero(sec)}",
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                      color: colorDark),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: constants.defaultPadding,
                                        ),

                                        ///----------button
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: NewButton(
                                                context: context,
                                                buttonText: "Save",
                                                height: 36.h,
                                                textStyle: textStyle.button
                                                    .copyWith(fontSize: 14.sp),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                  constants.defaultPadding / 2,
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
                                                    style: textStyle
                                                        .smallTextColorDark
                                                        .copyWith(
                                                        color: colorDark,
                                                        decoration:
                                                        TextDecoration
                                                            .underline),
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
                                                    style: textStyle
                                                        .smallTextColorDark
                                                        .copyWith(
                                                        color: colorDark,
                                                        decoration:
                                                        TextDecoration
                                                            .underline),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Card(
                  //   semanticContainer: true,
                  //   clipBehavior: Clip.antiAliasWithSaveLayer,
                  //   elevation: 0,
                  //   color: colorCardWhite,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: constants.borderRadius,
                  //     side: const BorderSide(width: 0.4, color: colorDark),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(constants.defaultPadding),
                  //     child:
                  //
                  //         ///--------accepted---------
                  //         Container(
                  //       child: Column(
                  //         children: [
                  //           Align(
                  //               alignment: Alignment.topLeft,
                  //               child: Text(
                  //                 "19 Nov 2022",
                  //                 style: textStyle.smallText
                  //                     .copyWith(color: Colors.black),
                  //               )),
                  //           SizedBox(
                  //             height: constants.defaultPadding,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 "mintraz order id",
                  //                 style: textStyle.smallText
                  //                     .copyWith(color: colorHeadingText),
                  //               ),
                  //               Text(
                  //                 "mint4907466670",
                  //                 style: textStyle.smallText
                  //                     .copyWith(color: colorHeadingText),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: constants.defaultPadding / 2,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 "Flipkart order #",
                  //                 style: textStyle.smallText
                  //                     .copyWith(color: colorHeadingText),
                  //               ),
                  //               Row(
                  //                 children: [
                  //                   Text(
                  //                     "mint4907466670",
                  //                     style: textStyle.smallText
                  //                         .copyWith(color: colorHeadingText),
                  //                   ),
                  //                   SizedBox(
                  //                     width: constants.defaultPadding / 3,
                  //                   ),
                  //                   Text(
                  //                     "Edit",
                  //                     style: textStyle.smallText.copyWith(
                  //                         color: colorHeadingText,
                  //                         decoration: TextDecoration.underline),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: constants.defaultPadding / 2,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 "Tracking id",
                  //                 style: textStyle.smallText
                  //                     .copyWith(color: colorHeadingText),
                  //               ),
                  //               Text(
                  //                 "Select courier patner",
                  //                 style: textStyle.smallText.copyWith(
                  //                     color: colorHeadingText,
                  //                     decoration: TextDecoration.underline),
                  //               ),
                  //             ],
                  //           ),
                  //
                  //           Align(
                  //             alignment: Alignment.center,
                  //             child: SizedBox(
                  //               height: 46.h,
                  //               width: 200,
                  //               child: TextFormField(
                  //                 textAlignVertical: TextAlignVertical.center,
                  //                 keyboardType: TextInputType.number,
                  //                 textCapitalization:
                  //                     TextCapitalization.sentences,
                  //                 decoration: InputDecoration(
                  //                   border: InputBorder.none,
                  //                   hintText: "99999-999999-999999",
                  //                   hintStyle: textStyle.subHeading
                  //                       .copyWith(color: colorSubHeadingText),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //
                  //           ///-----------------accepted-----------
                  //           Visibility(
                  //             visible: false,
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "Flipkart order #",
                  //                       style: textStyle.smallText
                  //                           .copyWith(color: colorHeadingText),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 46.h,
                  //                       width: 200,
                  //                       child: TextFormField(
                  //                         textAlignVertical:
                  //                             TextAlignVertical.center,
                  //                         keyboardType: TextInputType.number,
                  //                         textCapitalization:
                  //                             TextCapitalization.sentences,
                  //                         decoration: InputDecoration(
                  //                           border: InputBorder.none,
                  //                           hintText: "999-999999-999999",
                  //                           hintStyle: textStyle.subHeading
                  //                               .copyWith(
                  //                                   color: colorSubHeadingText),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 Stack(
                  //                   alignment: Alignment.center,
                  //                   children: [
                  //                     SizedBox(
                  //                         height: 50,
                  //                         width: 50,
                  //                         child: CircularProgressIndicator(
                  //                             strokeWidth: 2,
                  //                             value: double.parse(
                  //                                 flutterMapValue(
                  //                                     0.0, 1.0, 0, 59, sec)),
                  //                             valueColor:
                  //                                 const AlwaysStoppedAnimation<
                  //                                     Color>(colorDark))),
                  //                     Text(
                  //                       "00:${addZero(sec)}",
                  //                       style: textStyle.smallText
                  //                           .copyWith(color: colorDark),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               Expanded(
                  //                 child: NewButton(
                  //                   context: context,
                  //                   buttonText: "Save",
                  //                   height: 36.h,
                  //                   textStyle: textStyle.button
                  //                       .copyWith(fontSize: 14.sp),
                  //                   margin: EdgeInsets.symmetric(
                  //                     horizontal: constants.defaultPadding / 2,
                  //                   ),
                  //                   function: () {},
                  //                 ),
                  //               ),
                  //
                  //               ///order now button--------------
                  //               ///--------------accepted--------------
                  //               Visibility(
                  //                 visible: false,
                  //                 child: Expanded(
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         "not yet ordered?",
                  //                         style: textStyle.smallText,
                  //                       ),
                  //                       Text(
                  //                         "Order Now",
                  //                         style: textStyle.smallTextColorDark
                  //                             .copyWith(
                  //                           color: colorDark,
                  //                           decoration:
                  //                               TextDecoration.underline,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Expanded(
                  //                 child: Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "ordered cancelled?",
                  //                       style: textStyle.smallText,
                  //                     ),
                  //                     Text(
                  //                       "Mark cancelled",
                  //                       style: textStyle.smallTextColorDark
                  //                           .copyWith(
                  //                         color: colorDark,
                  //                         decoration: TextDecoration.underline,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  ///-----------card--------
                  Visibility(
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 0,
                      color: colorCardWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.borderRadius,
                        side: const BorderSide(width: 0.4, color: colorDark),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(constants.defaultPadding),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  widget.productImage,
                                  height: 122.h,
                                  width: 122.h,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: constants.defaultPadding),
                                    child: Text(
                                      widget.productTitle,
                                      style: textStyle.subHeading
                                          .copyWith(color: colorDark),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Divider(
                              thickness: 0.2,
                              color: colorHeadingText,
                              height: constants.defaultPadding * 3,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.productOfferTitle,
                                style: textStyle.subHeading
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.productOfferText,
                                style: textStyle.smallText,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            const SizedBox(
                              height: constants.defaultPadding,
                            ),
                            NewButton(
                              context: context,
                              function: () {
                                nextPage(
                                    context,
                                    DealNotePage(
                                      productImage: widget.productImage,
                                      productTitle: widget.productTitle,
                                      productOfferTitle:
                                      widget.productOfferTitle,
                                      productOfferText: widget.productOfferText,
                                      productYouSpend: widget.productYouSpend,
                                      productTotalEarn: widget.productTotalEarn,
                                      productCashback: widget.productCashback,
                                      productTotalReceive:
                                      widget.productTotalReceive,
                                      productLink: widget.productLink,
                                      productDealId: widget.productDealId,
                                      dealId: widget.dealId,
                                      orderQuantity: widget.orderQuantity,
                                    ));
                              },
                              buttonText: "Place Order",
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///----------your order card-----------------
                  // Card(
                  //   semanticContainer: true,
                  //   clipBehavior: Clip.antiAliasWithSaveLayer,
                  //   elevation: 0,
                  //   color: colorCardWhite,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: constants.borderRadius,
                  //     side: const BorderSide(width: 0.4, color: colorDark),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(constants.defaultPadding),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Image.network(
                  //               widget.productImage,
                  //               height: 122.h,
                  //               width: 122.h,
                  //             ),
                  //             Expanded(
                  //               child: Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     top: constants.defaultPadding),
                  //                 child: Text(
                  //                   widget.productTitle,
                  //                   style: textStyle.subHeading
                  //                       .copyWith(color: colorDark),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         const Divider(
                  //           thickness: 0.2,
                  //           color: colorHeadingText,
                  //           height: constants.defaultPadding * 3,
                  //         ),
                  //         detailsWidgetCard("Color : ", "Any Color"),
                  //         detailsWidgetCard("Quantity : ", "1"),
                  //         detailsWidgetCard("Price/Unit : ", "₹24,999"),
                  //         const SizedBox(
                  //           height: constants.defaultPadding,
                  //         ),
                  //         NewButton(
                  //           context: context,
                  //           function: () {
                  //             nextPage(
                  //                 context,
                  //                 DealNotePage(
                  //                   productImage: widget.productImage,
                  //                   productTitle: widget.productTitle,
                  //                   productOfferTitle: widget.productOfferTitle,
                  //                   productOfferText: widget.productOfferText,
                  //                   productYouSpend: widget.productYouSpend,
                  //                   productTotalEarn: widget.productTotalEarn,
                  //                   productCashback: widget.productCashback,
                  //                   productTotalReceive:
                  //                       widget.productTotalReceive,
                  //                   productLink: widget.productLink,
                  //                   productDealId: widget.productDealId,
                  //                   dealId: widget.dealId,
                  //                   orderQuantity: widget.orderQuantity,
                  //                 ));
                  //           },
                  //           buttonText: "Place Order",
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  ///---------offer detail card------------
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    color: colorWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(width: 0.4, color: colorDark),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(constants.defaultPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "offer details",
                                      style: textStyle.subHeadingColorDark
                                          .copyWith(color: colorHeadingText),
                                    )),
                                SizedBox(
                                  height: constants.defaultPadding / 2,
                                ),
                                Text(
                                  "10% off on Cradit Card, up to ₹1500. On orders of ₹5000 and above",
                                  style: textStyle.smallText
                                      .copyWith(color: colorHeadingText),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            "images/kotak.jpg",
                            height: 80.h,
                            width: 80.w,
                          )
                        ],
                      ),
                    ),
                  ),

                  ///---------
                  ///

                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    color: colorAccent1,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(width: 0.4, color: colorDark),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(constants.defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "You'll spend",
                                style: textStyle.smallText.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "$rupeeSign ${widget.productYouSpend}",
                                style: textStyle.heading.copyWith(
                                    color: Colors.black, fontSize: 28.sp),
                              ),
                            ],
                          ),
                          Container(
                            height: 50.h,
                            child: VerticalDivider(
                              thickness: 0.5,
                              color: colorHeadingText,
                              width: constants.defaultPadding,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "you'll receive",
                                style: textStyle.smallText.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "$rupeeSign ${widget.productYouSpend}",
                                style: textStyle.heading.copyWith(
                                    color: Colors.black, fontSize: 28.sp),
                              ),
                            ],
                          ),
                          Container(
                            height: 50.h,
                            child: VerticalDivider(
                              thickness: 0.5,
                              color: colorHeadingText,
                              width: constants.defaultPadding,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "you'll earnings",
                                style: textStyle.smallText.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "$rupeeSign ${widget.productYouSpend}",
                                style: textStyle.heading.copyWith(
                                    color: Colors.black, fontSize: 28.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 130.h,
                        width: 110.w,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.all(constants.defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "images/spend_amount.png",
                                  height: 30.h,
                                  width: 30.w,
                                  color: colorError,
                                ),
                                Text(
                                  "Spend",
                                  style: textStyle.subHeading.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "$rupeeSign ${widget.productYouSpend}",
                                  style: textStyle.heading.copyWith(
                                      color: Colors.black, fontSize: 23.sp),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 130.h,
                        width: 110.w,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.all(constants.defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "images/receive_amount.png",
                                  height: 30.h,
                                  width: 30.w,
                                ),
                                Text(
                                  "Receive",
                                  style: textStyle.subHeading.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "$rupeeSign ${widget.productYouSpend}",
                                  style: textStyle.heading.copyWith(
                                      color: Colors.black, fontSize: 23.sp),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 130.h,
                        width: 110.w,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                            side: BorderSide(
                              color: colorDark1,
                              width: 0,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  colorDark511,
                                  colorDark51,

                                ],
                              ),
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.all(constants.defaultPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "images/profit.png",
                                    height: 30.h,
                                    width: 30.w,

                                  ),
                                  Text(
                                    "Earn",
                                    style: textStyle.subHeading.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "$rupeeSign ${widget.productYouSpend}",
                                    style: textStyle.heading.copyWith(
                                        color: Colors.black, fontSize: 23.sp),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200.h,
                        width: 165.w,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.all(constants.defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "images/spend_amount.png",
                                  height: 30.h,
                                  width: 30.w,
                                  color: colorError,
                                ),
                                Text(
                                  "You'll spend",
                                  style: textStyle.smallText.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "$rupeeSign ${widget.productYouSpend}",
                                  style: textStyle.heading.copyWith(
                                      color: Colors.black, fontSize: 30.sp),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: const Divider(
                                    thickness: 0.2,
                                    color: Colors.black,
                                    height: constants.defaultPadding * 3,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "total price",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                        Text(
                                          "$rupeeSign ${widget
                                              .productYouSpend}",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "-",
                                      style: textStyle.smallText
                                          .copyWith(color: Colors.black),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "discount ",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                        Text(
                                          "$rupeeSign ${widget
                                              .productYouSpend}",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                        width: 165.w,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.all(constants.defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "images/receive_amount.png",
                                  height: 30.h,
                                  width: 30.w,
                                ),
                                Text(
                                  "Total you'll receive",
                                  style: textStyle.smallText.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "$rupeeSign ${widget.productTotalEarn}",
                                  style: textStyle.heading.copyWith(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                const Divider(
                                  thickness: 0.2,
                                  color: Colors.black,
                                  height: constants.defaultPadding * 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "spend",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                        Text(
                                          "$rupeeSign ${widget
                                              .productYouSpend}",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "+",
                                      style: textStyle.smallText
                                          .copyWith(color: Colors.black),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "cash reward",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                        Text(
                                          "$rupeeSign ${widget
                                              .productYouSpend}",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 200.h,
                      width: 165.w,
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: constants.borderRadius,
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.all(constants.defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                "images/profit.png",
                                height: 30.h,
                                width: 30.w,
                              ),
                              Text(
                                "Total earnings",
                                style: textStyle.smallText.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "$rupeeSign ${widget.productTotalEarn}",
                                style: textStyle.heading.copyWith(
                                  color: Colors.black,
                                  fontSize: 30.sp,
                                ),
                              ),
                              const Divider(
                                thickness: 0.2,
                                color: Colors.black,
                                height: constants.defaultPadding * 3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "cash reward",
                                    style: textStyle.smallText.copyWith(
                                        color: Colors.black, fontSize: 10.sp),
                                  ),
                                  Text(
                                    "$rupeeSign ${widget.productYouSpend}",
                                    style: textStyle.smallText.copyWith(
                                        color: Colors.black, fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///----------TDS detail card ------------------
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    color: colorAccent1,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(width: 0.4, color: colorDark),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(constants.defaultPadding),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "TDS Details",
                                style: textStyle.subHeading
                                    .copyWith(color: colorHeadingText),
                              )),
                          Text(
                            "5% TDS (Rs. 8) will be deducted on cash reward and rest amount will be transferred to your bank account (Rs. 17650)",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          const SizedBox(
                            height: constants.defaultPadding / 2,
                          ),
                          Text(
                            "Why is TDS deducted from payments? (Payments se TDS kyun kata jata hai?)",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "See in English",
                                style: textStyle.smallTextColorDark.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  ///----------secure order card-------------
                  Visibility(
                    visible: widget.orderPage==1 ? false : true,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 0,
                      color: colorWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.borderRadius,
                        side: const BorderSide(width: 0.4, color: colorDark),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(constants.defaultPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "100% secure prepaid order",
                                        style: textStyle.subHeadingColorDark
                                            .copyWith(color: colorHeadingText),
                                      )),
                                  SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  Text(
                                    "amount added to wallet as soon as order is placed",
                                    style: textStyle.smallText
                                        .copyWith(color: colorHeadingText),
                                  ),
                                  Text(
                                    "*amount released on delivery confirmation",
                                    style: textStyle.smallText
                                        .copyWith(color: colorHeadingText),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              "images/locked_card.png",
                              height: 80.h,
                              width: 80.w,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///-------------delivery details---------
                  Visibility(
                    visible: widget.orderPage== 0 ? false : true,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 0,
                      color: colorWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.borderRadius,
                        side: const BorderSide(width: 0.4, color: colorDark),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(constants.defaultPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "delivery details",
                                        style: textStyle.subHeadingColorDark
                                            .copyWith(color: colorHeadingText),
                                      )),
                                  SizedBox(
                                    height: constants.defaultPadding,
                                  ),
                                  detailsWidget("Arjit Dash", ""),
                                  const SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  detailsWidget("",
                                      "Appartment No. 416, 4th floor, 1st Block,, Satyabati Enclave,,"),
                                  const SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  detailsWidget("",
                                      "behind SBI Main Branch, Shivanand nagar, Bargarh"),
                                  const SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  detailsWidget("", "Odisha"),
                                  const SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  detailsWidget("Pincode : ", "768028"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: constants.defaultPadding * 3,
                  ),
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Card(
                  //       semanticContainer: true,
                  //       clipBehavior: Clip.antiAliasWithSaveLayer,
                  //       elevation: 0,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: constants.borderRadius,
                  //         side: const BorderSide(width: 1, color: colorDark),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(constants.defaultPadding),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Cashback",
                  //               style: textStyle.subHeading,
                  //             ),
                  //             Text(
                  //               "$rupeeSign ${widget.productCashback}",
                  //               style: textStyle.subHeading
                  //                   .copyWith(color: Colors.black),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Card(
                  //       semanticContainer: true,
                  //       clipBehavior: Clip.antiAliasWithSaveLayer,
                  //       elevation: 0,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: constants.borderRadius,
                  //         side: const BorderSide(width: 1, color: colorDark),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(constants.defaultPadding),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Total you'll receive",
                  //               style: textStyle.subHeading,
                  //             ),
                  //             Text(
                  //               "$rupeeSign ${widget.productTotalReceive}",
                  //               style: textStyle.subHeading
                  //                   .copyWith(color: Colors.black),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //
                  //     ///----------------
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget detailsWidget(String title, String value) {
    return InkWell(
      onTap: () {
        // if (value == " ") {
        //   return;
        // }
        copyToClipboard(context, value);
      },
      child: Row(
        children: [
          Text(
            title == " " ? " " : "$title",
            style:
            textStyle.smallTextColorDark.copyWith(color: colorHeadingText),
          ),
          Expanded(
            child: Text(
              value,
              style: textStyle.smallText.copyWith(color: colorHeadingText),
            ),
          ),
          Image.asset(
            "images/copyicon.png",
            height: 8.h,
            width: 8.w,
          ),
        ],
      ),
    );
  }

  Widget detailsWidgetCard(String title, String value) {
    return Row(
      children: [
        Text(
          title == " " ? " " : "$title",
          style: textStyle.smallText.copyWith(color: colorHeadingText),
        ),
        Expanded(
          child: Text(
            value,
            style:
            textStyle.smallTextColorDark.copyWith(color: colorHeadingText),
          ),
        ),
      ],
    );
  }
}
