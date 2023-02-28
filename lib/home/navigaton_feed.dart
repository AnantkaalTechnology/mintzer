import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/feed/account_page.dart';
import 'package:mintzer/feed/support_page.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/home/notification_page.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import 'api.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<String> iconcard = [
    "images/account.png",
    "images/support1.png",
    "images/update_password.png",
    "images/faq.png",
    "images/notification.png",
    "images/contract.png",
    "images/logout.png",
  ];

  List<String> textcard = [
    "Account",
    "Support",
    "Password",
    "FAQ",
    "Notification",
    "Contract",
    "Logout",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: Container(
          color: const Color(0xFF603FD8),
          // width: double.infinity,
          // height: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: constants.defaultPadding * 3,
                      left: constants.defaultPadding,
                      right: constants.defaultPadding),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180.h,
                        child: Stack(
                          // clipBehavior: Clip.none,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 100.h,
                                width: 300.w,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(constants.radius),
                                  color: colorFeed,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      constants.defaultPadding),
                                  child: Wrap(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${UserDetails.firstName} ${UserDetails.lastName}",
                                                  style: textStyle.subHeading
                                                      .copyWith(
                                                          color: Colors.white)),
                                              Text(UserDetails.pan,
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                          color: Colors.white)),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 44,
                                              width: 44,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        constants.radius),
                                                color: colorDark,
                                              ),
                                              child: Image.asset(
                                                'images/backicon.png',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 100.h,
                                width: 300.w,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(constants.radius),
                                  color: colorFeed1,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      constants.defaultPadding),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("₹${UserDetails.wallet}",
                                            style: textStyle.subHeading.copyWith(
                                                color: Colors.white,
                                                fontSize: 33)),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Wallet Balance",
                                            style: textStyle.smallText
                                                .copyWith(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: iconcard.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          // childAspectRatio: 1.5,
                          crossAxisSpacing: constants.defaultPadding,
                          mainAxisSpacing: constants.defaultPadding,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 90.h,
                            width: 90.h,
                            child: InkWell(
                              onTap: () async {
                                switch (index) {
                                  case 0:
                                    nextPage(context, const AccountPage());
                                    break;
                                  case 1:
                                    nextPage(context, const SupportPage());
                                    break;
                                  case 2:
                                    // nextPage(context, const UpdatePasswordPage());
                                    break;
                                  case 3:
                                    break;
                                  case 4:
                                    nextPage(context, const NotificationPage());

                                    break;
                                  case 5:
                                    break;
                                  case 6:
                                    customPrint("Logout");
                                    logoutUser(context);
                                    break;
                                }
                              },
                              child: Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  margin: EdgeInsets.zero,
                                  // semanticContainer: true,
                                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Image.asset(
                                          iconcard[index],
                                          height: 44,
                                          width: 44,
                                          color: colorWhite,
                                        ),
                                      ),
                                      Text(
                                        textcard[index],
                                        style: textStyle.smallText
                                            .copyWith(color: colorWhite),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
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

// class Choice {
//   const Choice({required this.title, required this.icon});
//   final String title;
//   final IconData icon;
// }
