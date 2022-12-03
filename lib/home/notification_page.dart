import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/home/api.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> sbicard = [
    "images/ace_credit_card.jpg",
    "images/ace_credit_card.jpg",
    "images/ace_credit_card.jpg",
    "images/ace_credit_card.jpg",
    "images/ace_credit_card.jpg",
    "images/sbi_card.jpg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeApi.getNotification(context).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: constants.defaultPadding * 3,
          left: constants.defaultPadding,
          right: constants.defaultPadding,
        ),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Notifications",
                  style: textStyle.heading,
                )),
            const SizedBox(
              height: constants.defaultPadding,
            ),
            Flexible(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                    itemCount:
                        getStaticCount(HomeApi.notificationTitle.length, 15),
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
                              HomeApi.notificationTitle.isEmpty
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
                                        Text(
                                          HomeApi.notificationTitle[index],
                                          style: textStyle.subHeading
                                              .copyWith(color: Colors.black),
                                        ),
                                        Text(
                                          HomeApi.notificationSubTitle[index],
                                          style: textStyle.smallText,
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
    );
  }
}
