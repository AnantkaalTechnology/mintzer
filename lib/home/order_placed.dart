import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import '../util/colors.dart';

class OrderPlacedPage extends StatefulWidget {
  const OrderPlacedPage({Key? key}) : super(key: key);

  @override
  State<OrderPlacedPage> createState() => _OrderPlacedPageState();
}

class _OrderPlacedPageState extends State<OrderPlacedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colorWhite,
        child: Padding(
          padding: const EdgeInsets.only(
            top: constants.defaultPadding * 3,
            left: constants.defaultPadding,
            right: constants.defaultPadding,
          ),
          child: Column(
            children: [
              Image.asset(
                "images/success6.gif",
                height: 250.h,
                width: 250.w,
              ),
              SizedBox(height: constants.defaultPadding*3,),
              Card(
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
                      Text(
                        "Order Successfully Placed!",
                        style: textStyle.heading,
                      ),
                      SizedBox(height: constants.defaultPadding,),
                      Text(
                        "E-comm Order ID",
                        style: textStyle.subHeading,
                      ),
                      SizedBox(height: constants.defaultPadding/3,),
                      Text(
                        "OD226564411801528000",
                        style: textStyle.subHeading,
                      ),
                      SizedBox(height: constants.defaultPadding,),
                      CircleAvatar(
                        radius: constants.radius * 2,
                        backgroundColor: colorError,
                        child: Center(
                          child: Image.asset(
                            "images/wallet.png",
                            height: 20.h,
                            width: 20.w,
                            color: colorWhite,
                          ),
                        ),
                      ),
                      SizedBox(height: constants.defaultPadding,),
                      Text(
                        "₹13,729",
                        style: textStyle.heading,
                      ),
                      SizedBox(height: constants.defaultPadding/2,),
                      Text(
                        "added to your wallet",
                        style: textStyle.subHeading,
                      ),
                      SizedBox(height: constants.defaultPadding/2,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "*will be transferred to your account once the order is delivered",
                          style: textStyle.smallText,
                        ),
                      ),
                      SizedBox(height: constants.defaultPadding,),
                      NewButton(context: context, function: (){},buttonText: "Go to home",width: 140.w,color: colorDark,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
