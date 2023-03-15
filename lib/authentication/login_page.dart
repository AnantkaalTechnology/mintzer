import 'package:flutter/material.dart';
import 'package:mintzer/Widgets/my_textfield.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/Widgets/progressHud.dart';
import 'package:mintzer/Widgets/splash_screen.dart';
import 'package:mintzer/api/local_storage.dart';
import 'package:mintzer/api/onesignal_api.dart';
import 'package:mintzer/authentication/api.dart';
import 'package:mintzer/authentication/signup_page.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/home/home_page.dart';
import 'package:mintzer/main.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../util/colors.dart';
import 'otppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.back = false}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();

  final bool back;
}

class _LoginPageState extends State<LoginPage> {
  final phoneNumberController = TextEditingController();
  bool loading = false;
  bool splash = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OneSignalApi.initialize();

    checkUser();

    // oneSignalInit();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(widget.back);
      },
      child: Scaffold(
        body: splash
            ? const SplaceScreen()
            : ProgressHUD(
                isLoading: loading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: constants.defaultPadding * 6),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Center(
                            child: Text("Welcome Back!",
                                style: textStyle.heading
                                    .copyWith(color: colorDark)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                                constants.defaultPadding * 2),
                            child: Image.asset("images/login.png"),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text("Enter your registered phone number",
                                  style: textStyle.subHeading
                                      .copyWith(color: colorDark))),
                          const SizedBox(
                            height: constants.defaultPadding * 2,
                          ),
                          MyTextFiled(
                            controller: phoneNumberController,
                            hint: "Phone Number",
                            inputType: TextInputType.number,
                          ),
                          NewButton(
                            context: context,
                            margin: const EdgeInsets.only(
                                top: constants.defaultPadding * 2,
                                left: constants.defaultPadding,
                                right: constants.defaultPadding),
                            function: () async {
                              final status =
                                  await OneSignal.shared.getDeviceState();
                              final String? osUserID = status?.userId;

                              await prefs.setString(
                                  LocalStorage.oneSignalUserToken,
                                  osUserID.toString());

                              customPrint("osUserID :: $osUserID");

                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                AuthApi.loginUser(
                                        phoneNumberController.text.trim(),
                                        osUserID.toString())
                                    .then((value) {
                                  customPrint("loginUser :: $value");
                                  setState(() {
                                    loading = false;
                                  });
                                  if (value['result'].toString() == "1") {
                                    nextPage(context, OTPPage(jsonData: value));
                                  } else if (value['result'].toString() ==
                                      "3") {
                                    nextPage(
                                        context,
                                        SignUpPage(
                                          phoneNumber:
                                              phoneNumberController.text.trim(),
                                        ));
                                  } else {
                                    showSnackbar(
                                        context, value['msg'], colorError);
                                  }
                                });
                              }
                            },
                            buttonText: "Login",
                          ),
                          const SizedBox(
                            height: constants.defaultPadding * 2,
                          ),
                          Wrap(
                            children: [
                              Text("I agree to the Mintzer's ",
                                  style: textStyle.smallText),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => SignUpPage()),
                                  // );
                                },
                                child: Text("Terms and Conditions",
                                    style: textStyle.smallTextColorDark
                                        .copyWith(color: colorDark)),
                              ),
                            ],
                          ),
                          // Wrap(
                          //   children: [
                          //     Text("Don’t have an account ?",
                          //         style: textStyle.smallText),
                          //     InkWell(
                          //       onTap: () {
                          //         nextPage(context, const SignUpPage());
                          //       },
                          //       child: Text(" Sign Up",
                          //           style: textStyle.smallTextColorDark
                          //               .copyWith(color: colorDark)),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> oneSignalInit() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

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
    });

    await OneSignal.shared.setAppId(OneSignalApi.appId).catchError((err) {
      customPrint("setAppId :: $err");
    });
  }

  Future<void> checkUser() async {
    await delay(100);
    if (prefs.getBool(LocalStorage.isUserLogin) ?? false) {
      /// Login
      nextPageFade(context, const HomePage());
    } else {
      ///No Login
      setState(() {
        splash = false;
      });
    }
  }
}

//{
//   "google.delivered_priority": "normal",
//   "google.sent_time": 1662543588024,
//   "google.ttl": 259200,
//   "google.original_priority": "normal",
//   "custom": "{"a":{},"i":"a28a0217-5b60-465e-b214-d9465538420c"}",
//   "pri": "5",
//   "vis": "1",
//   "from": "422615374204",
//   "alert": "Noti Body",
//   "title": "Noti Title",
//   "google.message_id": "0:1662543588076478%8b5b3f98f9fd7ecd",
//   "google.c.sender.id": "422615374204"
// }
