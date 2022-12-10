import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/feed/support_page.dart';
import 'package:mintzer/home/api.dart';
import 'package:mintzer/home/notification_page.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import '../feed/account_page.dart';
import '../globalVariable.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Container(
          //  color: colorDark,
          //   // decoration: const BoxDecoration(
          //   //   image:  DecorationImage(
          //   //     image: AssetImage('images/bg.jpg'),
          //   //     fit: BoxFit.fill,
          //   //   ),
          //   // ),
          //   height: 200.h,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("${UserDetails.firstName} ${UserDetails.lastName}",
          //           style: textStyle.subHeading.copyWith(color: Colors.white)),
          //       Text(UserDetails.pan,
          //           style: textStyle.smallText.copyWith(color: Colors.white)),
          //     ],
          //   ),
          // ),
          DrawerHeader(
            decoration: BoxDecoration(
              // color: colorDark,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/bg.jpg'))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${UserDetails.firstName} ${UserDetails.lastName}",
                            style: textStyle.subHeading.copyWith(color: Colors.white)),
                        Text(UserDetails.pan,
                            style: textStyle.smallText.copyWith(color: Colors.white)),
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
                          color: Colors.blue,
                        ),
                        child: Image.asset(
                          'images/backicon.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: constants.defaultPadding,),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("₹${HomeApi.walletModel!.totalEarnings}",
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
          ListTile(
            leading: Image.asset(
              "images/account.png",
              color: Colors.black,
              height: 20.h,
              width: 20.w,
            ),
            title: Text('Account'),
            onTap: () => {nextPage(context, const AccountPage())},
          ),
          ListTile(
            leading: Image.asset(
              "images/support.png",
              color: Colors.black,
              height: 20.h,
              width: 20.w,
            ),
            title: Text('support'),
            onTap: () => {nextPage(context, const SupportPage())},
          ),
          ListTile(
            leading: Image.asset(
              "images/update_password.png",
              color: Colors.black,
              height: 20.h,
              width: 20.w,
            ),
            title: Text('Password'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Image.asset(
              "images/faq.png",
              color: Colors.black,
              height: 20.h,
              width: 20.w,
            ),
            title: Text('FAQ'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Image.asset(
              "images/notification.png",
              color: Colors.black,
              height: 20.h,
              width: 20.w,
            ),
            title: Text('Notification'),
            onTap: () => {nextPage(context, const NotificationPage())},
          ),
          ListTile(
            leading: Image.asset(
              "images/contract.png",
              color: Colors.black,
              height: 20.h,
              width: 20.w,
            ),
            title: Text('Contract'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Image.asset(
              "images/logout.png",
              color: Colors.black,
              height: 20.h,
              width: 20.w,
            ),
            title: Text('Logout'),
            onTap: () => {customPrint("Logout"), logoutUser(context)},
          ),
        ],
      ),
    );
  }
}
