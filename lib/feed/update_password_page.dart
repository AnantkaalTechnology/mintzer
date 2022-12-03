import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/Widgets/progressHud.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import '../globalVariable.dart';
import '../home/api.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        isLoading: loading,
        child: Center(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 0,
            margin: const EdgeInsets.all(constants.defaultPadding),
            color: colorCardWhite,
            shape: RoundedRectangleBorder(
              borderRadius: constants.borderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.all(constants.defaultPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "images/update_password.png",
                    color: colorDark,
                    height: 66,
                  ),
                  const SizedBox(
                    height: constants.defaultPadding / 2,
                  ),
                  Text(
                    "Update Password",
                    style: textStyle.heading,
                  ),
                  const SizedBox(
                    height: constants.defaultPadding * 2,
                  ),
                  SizedBox(
                    height: 76.h,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: constants.defaultPadding,
                      ),
                      child: TextFormField(
                        controller: currentPassword,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: constants.borderRadius,
                          ),
                          labelText: "Password",
                          labelStyle:
                              textStyle.subHeading.copyWith(color: colorDark),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 76.h,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: constants.defaultPadding,
                      ),
                      child: TextFormField(
                        controller: newPassword,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: constants.borderRadius,
                          ),
                          labelText: "New Password",
                          labelStyle:
                              textStyle.subHeading.copyWith(color: colorDark),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 76.h,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: constants.defaultPadding,
                      ),
                      child: TextFormField(
                        controller: confirmPassword,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: constants.borderRadius,
                          ),
                          labelText: "Confirm Password",
                          labelStyle:
                              textStyle.subHeading.copyWith(color: colorDark),
                        ),
                      ),
                    ),
                  ),
                  NewButton(
                      context: context,
                      margin: const EdgeInsets.only(
                          top: constants.defaultPadding * 2),
                      buttonText: "Change Password",
                      function: () {
                        if (currentPassword.text.trim().isEmpty) {
                          showSnackbar(context,
                              "Please enter your Current Password", colorError);
                          return;
                        }
                        if (newPassword.text.trim().isEmpty) {
                          showSnackbar(
                              context, "Please enter New Password", colorError);
                          return;
                        }

                        if (confirmPassword.text.trim().isEmpty) {
                          showSnackbar(context, "Please enter ConfirmPassword",
                              colorError);
                          return;
                        }
                        if (confirmPassword.text.trim() !=
                            newPassword.text.trim()) {
                          showSnackbar(
                              context,
                              "New Password and Confirm Password is not same",
                              colorError);
                          return;
                        }

                        setState(() {
                          loading = true;
                        });

                        HomeApi.updatePassword(
                          context,
                          currentPassword.text.trim(),
                          newPassword.text.trim(),
                          confirmPassword.text.trim(),
                        ).then((value) {
                          if (value == "1") {
                            showSnackbar(
                                context,
                                "New Password Update Successfully",
                                colorSuccess);
                            setState(() {
                              loading = false;
                            });
                            return;
                          }
                          setState(() {
                            loading = false;
                          });
                          showSnackbar(context, "Some Unknown error has occur",
                              colorError);
                        });
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
