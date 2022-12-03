import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mintzer/Widgets/my_textfield.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/Widgets/progressHud.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globalVariable.dart';
import '../home/api.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        isLoading: loading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: constants.defaultPadding * 3,
              // left: constants.defaultPadding,
              // right: constants.defaultPadding,
            ),
            child: Column(
              children: [
                ///------------heading and subheading----------
                ///
                Padding(
                  padding: const EdgeInsets.only(
                    left: constants.defaultPadding,
                    right: constants.defaultPadding,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Let's make money!",
                      style: textStyle.heading.copyWith(color: colorDark),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: constants.defaultPadding,
                    right: constants.defaultPadding,
                  ),
                  child: Text(
                    "Get in touch with us, We give you exact and right information in you!",
                    style: textStyle.smallText,
                  ),
                ),

                ///------------TextFiled-----------
                ///
                MyTextFiled(controller: subjectController, hint: "Subject"),
                MyTextFiled(
                  height: 150,
                  controller: messageController,
                  hint: "Your Query",
                  maxLine: 8,
                  inputType: TextInputType.multiline,
                ),
                // TextFormField(
                //   minLines: 6, // any number you need (It works as the rows for the textarea)
                //   keyboardType: TextInputType.multiline,
                //   maxLines: null,
                // )
                ///--------button---------
                ///
                const SizedBox(
                  height: constants.defaultPadding,
                ),
                NewButton(
                  margin: const EdgeInsets.only(
                      left: constants.defaultPadding,
                      right: constants.defaultPadding,
                      top: constants.defaultPadding),
                  context: context,
                  function: () {
                    if (subjectController.text.trim().isEmpty) {
                      showSnackbar(context, "Please Support Subject", colorError);
                      return;
                    }
                    if (messageController.text.trim().isEmpty) {
                      showSnackbar(context, "Please Support Message", colorError);
                      return;
                    }

                    setState(() {
                      loading = true;
                    });

                    HomeApi.supportForm(context, subjectController.text.trim(),
                            messageController.text.trim())
                        .then((value) {
                      setState(() {
                        loading = false;
                      });
                      if (value == "1") {
                        showSnackbar(
                            context,
                            "We will shortly provide you support on this",
                            colorSuccess);
                      }
                    });
                  },
                  buttonText: "Submit",
                ),

                const Divider(
                  thickness: 1,
                  indent: constants.defaultPadding,
                  endIndent: constants.defaultPadding,
                  height: constants.defaultPadding * 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: constants.defaultPadding,
                    right: constants.defaultPadding,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Technical support",
                      style: textStyle.subHeading.copyWith(color: colorDark),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: constants.defaultPadding,
                    right: constants.defaultPadding,
                    top: constants.defaultPadding / 2,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        text:
                            "if you have any type of technical challenges and would like to get help from us please drop an email at ",
                        style: textStyle.smallText.copyWith(height: 1.4),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'maintzercorp@gmail.com',
                            style: textStyle.smallTextColorDark
                                .copyWith(color: colorDark),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Divider(
                  thickness: 1,
                  indent: constants.defaultPadding,
                  endIndent: constants.defaultPadding,
                  height: constants.defaultPadding * 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        launch("https://telegram.me/rahul");
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: constants.borderRadius * 100,
                        ),
                        child: Image.asset(
                          "images/telegram.png",
                          height: 40,
                          width: 40,
                          color: const Color(0xff0088CC),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: constants.defaultPadding,
                    ),
                    InkWell(
                      onTap: () {
                        launch("tel:123-456-7890");
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: constants.borderRadius * 100,
                        ),
                        child: Image.asset(
                          "images/call_us.png",
                          height: 40,
                          width: 40,
                          color: const Color(0xff0088CC),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: constants.defaultPadding,
                    ),
                    InkWell(
                      onTap: () {
                        launch(
                            "https://api.whatsapp.com/send?phone=+918000420648&text=Need Support");
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: constants.borderRadius * 100,
                        ),
                        child: Image.asset(
                          "images/whatsapp.png",
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: constants.defaultPadding*3,
                ),
                ///--------card for social media-------
                ///
              ],
            ),
          ),
        ),
      ),
    );
  }
}
