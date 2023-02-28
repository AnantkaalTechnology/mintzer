// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/deal/order_page.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

class DealNotePage extends StatefulWidget {
  const DealNotePage(
      {Key? key,
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
      required this.orderQuantity, required this.dealDiscount, required this.dealNotes})
      : super(key: key);

  @override
  _DealNotePageState createState() => _DealNotePageState();

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
  final String dealDiscount;
  final String dealNotes;
}

class _DealNotePageState extends State<DealNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: constants.defaultPadding * 2,
            left: constants.defaultPadding,
            right: constants.defaultPadding,
          ),
          child: Center(
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              color: colorCardWhite,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.4, color: colorDark),
                borderRadius: constants.borderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.all(constants.defaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.dealNotes,
                        style: textStyle.subHeading.copyWith(color: colorHeadingText),
                      ),
                    ),
                    // Text(
                    //   "1. You should take screenshot after order success, the screenshot contain the Order ID of the order. \n2. please make you have good internet connection.\n3. If the order was not made but made but payment debited from your account, Mintzer corp is not responsible. \n4. Download invoice from the store website after completing the order.",
                    //   style: textStyle.subHeading,
                    // ),
                    // const SizedBox(
                    //   height: constants.defaultPadding,
                    // ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     "How to avail offer",
                    //     style: textStyle.subHeadingColorDark,
                    //   ),
                    // ),
                    // Text(
                    //   "1. Select eligible card at the time of checkout \n2. Check the offer before placing order, the offer which we given should be availed.",
                    //   style: textStyle.subHeading,
                    // ),
                    const Divider(
                      thickness: 0.2,
                      color: colorHeadingText,
                      height: constants.defaultPadding * 3,
                    ),
                    NewButton(
                      context: context,
                      function: () {
                        nextPage(
                            context,
                            OrderPage(
                              dealDiscount:widget.dealDiscount,
                              productImage: widget.productImage,
                              productTitle: widget.productTitle,
                              productOfferTitle: widget.productOfferTitle,
                              productOfferText: widget.productOfferText,
                              productYouSpend: widget.productYouSpend,
                              productTotalEarn: widget.productTotalEarn,
                              productCashback: widget.productCashback,
                              productTotalReceive: widget.productTotalReceive,
                              productLink: widget.productLink,
                              productDealId: widget.productDealId,
                              dealId: widget.dealId,
                              orderQuantity: widget.orderQuantity,
                            ));
                      },
                      buttonText: "PROCEED",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
