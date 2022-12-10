import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/home/cards_page.dart';
import 'package:mintzer/home/deal_page.dart';

// import 'package:nexus/home/add_device_page.dart';
import 'package:mintzer/home/wallet_page.dart';
import 'package:mintzer/orders/order_history_page.dart';
// import 'package:mintzer/home/investment_page.dart';
// import 'package:mintzer/home/legendary_page.dart';
// import 'package:mintzer/home/master_traders_page.dart';
import 'package:mintzer/util/colors.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 0;
  final screens = [
    const OrderHistoryPage(),
    const DealPage(),
    const CardPage(),
    const WalletPage(),

    // AddDevicePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: colorDark,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: colorWhite),
            )),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),

          child: NavigationBar(
            height: 80,
            backgroundColor: colorDark,
            selectedIndex: index,
            animationDuration: const Duration(seconds: 1),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            onDestinationSelected: (index) => setState(() => this.index = index),
            destinations: [
              NavigationDestination(
                icon: Image.asset(
                  "images/home.png",
                  height: 20.h,
                  width: 20.w,
                ),
                label: 'Home',
                // selectedIcon: Image.asset(
                //   'images/hand_coin_line.png',
                //   height: 20.h,
                //   width: 20.w,
                // ),
              ),
              NavigationDestination(
                icon: Image.asset(
                  "images/checkout.png",
                  height: 20.h,
                  width: 20.w,
                ),
                label: 'Orders',
                // selectedIcon: Image.asset(
                //   'images/master.png',
                //   height: 20.h,
                //   width: 20.w,
                // ),
              ),
              NavigationDestination(
                icon: Image.asset(
                  "images/card.png",
                  height: 20.h,
                  width: 20.w,
                ),
                label: 'Cards',
                // selectedIcon: Image.asset(
                //   'images/bar_chart.png',
                //   height: 20.h,
                //   width: 20.w,
                // ),
              ),
              NavigationDestination(
                icon: Image.asset(
                  "images/wallet.png",
                  height: 20.h,
                  width: 20.w,
                ),
                label: 'Wallet',
                // selectedIcon: Image.asset(
                //   'images/bar_chart.png',
                //   height: 20.h,
                //   width: 20.w,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
