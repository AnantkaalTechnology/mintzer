import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../globalVariable.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'Notification', // id
    'Notification', // title
    importance: Importance.max,
    enableLights: true,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class OneSignalApi {
  static const appId = "976490db-bb93-4a48-a5d8-475e7c5f0cd4";

  static Future<void> initialize() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    if (debugMode) {
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    }

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      customPrint('NOTIFICATION OPENED HANDLER CALLED WITH: $result');
      customPrint(
          "setNotificationOpenedHandler :: Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      customPrint('FOREGROUND HANDLER CALLED WITH: $event');

      /// Display Notification, send null to not display
      event.complete(event.notification);

      customPrint(
          "setNotificationWillShowInForegroundHandler :: Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");

      OSNotification notification = event.notification;
      // AndroidNotification? android = event.notification.android;
      if (notification != null) {
        customLog("On Message Body :: ${notification.body}");
        customLog("On Message Body :: ${notification.title}");
        // customLog("On Message Data :: ${message.data}");

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.max,
              enableLights: true,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    await OneSignal.shared.setAppId(OneSignalApi.appId).catchError((err) {
      customPrint("setAppId :: $err");
    });
  }
}
