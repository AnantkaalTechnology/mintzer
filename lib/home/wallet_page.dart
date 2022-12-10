import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/home/api.dart';
import 'package:mintzer/orders/api.dart';
import 'package:mintzer/orders/stepper_page.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';
import 'package:shimmer/shimmer.dart';

import '../globalVariable.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeApi.getWalletDetails(context).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Padding(
          padding: const EdgeInsets.only(
              top: constants.defaultPadding * 2,
              left: constants.defaultPadding,
              right: constants.defaultPadding,
              bottom: constants.defaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: constants.radius * 2,
                        backgroundColor: colorHeadingText,
                      ),
                      const SizedBox(
                        width: constants.defaultPadding / 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: textStyle.smallTextColorDark,
                          ),
                          Text(
                              "${UserDetails.firstName}",
                            style: textStyle.smallTextColorDark
                                .copyWith(color: colorHeadingText),),
                          // Text(
                          //   "Vignesh",
                          //   style: textStyle.smallTextColorDark
                          //       .copyWith(color: colorHeadingText),
                          // ),
                        ],
                      )
                    ],
                  ),
                  Card(
                    // color: colorCustom.shade100,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(width: 1, color: colorHeadingText),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: constants.defaultPadding * 1,
                          vertical: constants.defaultPadding / 2),
                      child: GestureDetector(
                        onTap: (){
                          // nextPage(context, StepperPage());
                        },
                        child: Text(
                          "Refer & Earn Upto ₹10,000",
                          style: textStyle.smallText
                              .copyWith(color: colorHeadingText),
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
                child: Text(
                  "Mintraz Wallet",
                  style: textStyle.subHeadingColorDark
                      .copyWith(color: colorHeadingText),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "₹${HomeApi.walletModel!.totalEarnings}",
                  style: textStyle.heading.copyWith(color: colorHeadingText),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "total balance",
                  style: textStyle.subHeading.copyWith(color: colorHeadingText),
                ),
              ),
              const SizedBox(
                height: constants.defaultPadding,
              ),
              Flexible(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      itemCount:
                          getStaticCount(HomeApi.walletModel?.orders.length??0, 15),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 0,
                          color: colorCardWhite,
                          margin: const EdgeInsets.only(
                              bottom: constants.defaultPadding),
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                            side: const BorderSide(
                                width: 0.2, color: colorSubHeadingText),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(constants.defaultPadding),
                            child: Stack(
                              children: [
                                (HomeApi.walletModel?.orders.length??0)==0
                                    ? Shimmer.fromColors(
                                        baseColor: colorWhite,
                                        highlightColor: colorDisable,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 22.h,
                                              width: double.infinity,
                                              color: colorDisable,
                                            ),
                                            Container(
                                              height: 22.h,
                                              width: double.infinity,
                                              color: colorDisable,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(HomeApi.walletModel!.orders[index].isPayout == "0"?
                                                "Payment pending": "Payment received",
                                                style: textStyle.subHeading
                                                    .copyWith(
                                                        color: colorHeadingText),
                                              ),
                                              Text(
                                                HomeApi.walletModel!.orders[index].totalEarnings,
                                                style: textStyle
                                                    .subHeadingColorDark
                                                    .copyWith(
                                                        color: HomeApi.walletModel!.orders[index].isPayout == "0"? colorWarning : colorSuccess),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: constants.defaultPadding,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: AutoSizeText(
                                                  "order id-${HomeApi.walletModel!.orders[index].orderId}",
                                                  style: textStyle.smallText,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              AutoSizeText(
                                                "19/11/22 05:00 PM",
                                                style: textStyle.smallText,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                // Align(
                                //   alignment: Alignment.topRight,
                                //   child: Card(
                                //     elevation: 0,
                                //     color: colorDark,
                                //     margin: const EdgeInsets.only(
                                //         bottom: constants.defaultPadding),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: constants.borderRadius * 100,
                                //       // side: const BorderSide(
                                //       //     width: 0.2, color: colorSubHeadingText),
                                //     ),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(
                                //           constants.defaultPadding / 2),
                                //       child: Image.asset(
                                //         'images/cancel.png',
                                //         width: 8,
                                //         height: 8,
                                //         color: colorWhite,
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    await delay(1000);
    HomeApi.getWalletDetails(context).then((value) {
      setState(() {});
    });
  }

  void showWithdrawPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Withdraw Balance"),
          content: Text(
              "You have ${HomeApi.walletModel!.totalEarnings} $rupeeSign to withdraw in bank account."),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: textStyle.subButton.copyWith(color: colorDark),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                "Withdraw",
                style: textStyle.subButton.copyWith(color: colorDark),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
      semanticsLabel: 'Linear progress indicator',
    );
  }
}
