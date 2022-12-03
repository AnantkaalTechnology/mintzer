import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mintzer/Widgets/progressHud.dart';
import 'package:mintzer/api/local_storage.dart';
import 'package:mintzer/authentication/api.dart';
import 'package:mintzer/home/home_page.dart';
import 'package:mintzer/main.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../globalVariable.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key, required this.jsonData, this.isRegister = false})
      : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();

  final Map<String, dynamic> jsonData;
  final bool isRegister;
}

class _OTPPageState extends State<OTPPage> {
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  bool loading = false;
  String currentText = "";
  TextEditingController otpController = TextEditingController();
  Timer? timer;
  int sec = 59;
  bool showResend = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) async {
      sec--;
      if (sec <= 0) {
        sec = 0;
        showResend = true;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        isLoading: loading,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Verify OTP",
                      style: textStyle.heading.copyWith(color: colorDark)),
                ),
                const SizedBox(
                  height: constants.defaultPadding * 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(constants.defaultPadding),
                  child: Image.asset("images/otp.png"),
                ),
                const SizedBox(
                  height: constants.defaultPadding * 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: constants.defaultPadding),
                  child: Text("Verify OTP sent to your provided phone number ",
                      style: textStyle.subHeading.copyWith(color: colorDark)),
                ),
                const SizedBox(
                  height: constants.defaultPadding * 2,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          // vertical: constants.defaultPadding,
                          horizontal: constants.defaultPadding),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          String ab = v ?? "";
                          if (ab.length < 6) {
                            return "Enter correct OTP";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                            inactiveColor: colorDark,
                            inactiveFillColor: Colors.white,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 55,
                            fieldWidth: 44,
                            activeFillColor:
                                hasError ? Colors.blue.shade100 : Colors.white,
                            selectedFillColor: Colors.white,
                            selectedColor: colorDark),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        // errorAnimationController: errorController,
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) async {
                          /// Completed
                          setState(() {
                            loading = true;
                          });

                          await prefs.setString(LocalStorage.userAuth,
                              widget.jsonData['user_auth']);
                          customPrint(
                              "userAuth :: ${prefs.getString(LocalStorage.userAuth)}");

                          if (widget.isRegister) {
                            ///For Registration with OTP
                            AuthApi.userRegistrationOtp(
                                    widget.jsonData, otpController.text)
                                .then((value) async {
                              if (value['result'].toString() == "1") {
                                await prefs.setBool(
                                    LocalStorage.isUserLogin, true);
                                nextPage(context, const HomePage());
                              } else {
                                setState(() {
                                  loading = false;
                                });
                                showSnackbar(context, value['msg'], colorError);
                              }
                            });
                          } else {
                            /// For Login OTP
                            AuthApi.userLoginOtp(
                                    widget.jsonData, otpController.text)
                                .then((value) async {
                              if (value['result'].toString() == "1") {
                                await prefs.setBool(
                                    LocalStorage.isUserLogin, true);
                                nextPage(context, const HomePage());
                              } else {
                                setState(() {
                                  loading = false;
                                });
                                showSnackbar(context, value['msg'], colorError);
                              }
                            });
                          }
                        },
                        onChanged: (value) {
                          customPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          customPrint("Allowing to paste $text");
                          return true;
                        },
                      )),
                ),
                SizedBox(
                  height: constants.defaultPadding,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Change Number",
                          textAlign: TextAlign.center,
                          style: textStyle.smallTextColorDark
                              .copyWith(color: colorDark),
                        ),
                      ),
                    ),
                    showResend
                        ? Container(
                            height: 33,
                            width: 1,
                            color: colorDark,
                          )
                        : Container(),
                    showResend
                        ? Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  sec = 59;
                                  showResend = false;
                                });
                                AuthApi.userOtpResend(widget.jsonData);
                                // PhoneAuth.verifyWithPhoneNumber(
                                //     context, widget.phoneNumber);
                              },
                              child: Text(
                                "Resend OTP",
                                textAlign: TextAlign.center,
                                style: textStyle.smallTextColorDark
                                    .copyWith(color: colorDark),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: constants.defaultPadding * 2),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: double.parse(
                                    flutterMapValue(0.0, 1.0, 0, 59, sec)),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    colorDark))),
                        Text(
                          "00:${addZero(sec)}",
                          style: textStyle.smallText.copyWith(color: colorDark),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
