// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintzer/deal/order_detail_page.dart';
import 'package:mintzer/home/order_placed.dart';
import 'package:mintzer/orders/step_progress_bar.dart';
import 'package:mintzer/orders/stepper_page.dart';
import 'package:mintzer/util/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication/login_page.dart';
import 'globalVariable.dart';

SharedPreferences prefs;
const String appName = "Mintzer";

Future<void> backgroundHandler(RemoteMessage message) async {
  customPrint(message.data.toString());
  customPrint(message.notification.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // FirebaseMessageApi.initialize();
  // FirebaseMessageApi.handleMessage();
  // OneSignalApi.handleNotifications();
  runApp(const MyApp());
}

// Dell Laptop

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkDebugMode();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]); //force portrait mode
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: ThemeData(
              primarySwatch: colorCustom,
              fontFamily: "poppins",
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child,
              );
            },
            // home: OTPPage(),
            home: LoginPage(),
            // My branch
            // home: SteopProgressBarPage(),
            // home: StepperPage(),
          );
        });
  }
}
