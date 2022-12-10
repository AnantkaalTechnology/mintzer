import 'package:flutter/material.dart';
import 'package:mintzer/Widgets/my_textfield.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/Widgets/progressHud.dart';
import 'package:mintzer/authentication/api.dart';
import 'package:mintzer/authentication/login_page.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import '../util/colors.dart';
import 'otppage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key,  this.phoneNumber = "NA"}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();

  final String phoneNumber;

}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;
  bool loading = false;
  final _signKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final panCardNumberController = TextEditingController();
  final mobileNumberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.phoneNumber != "NA"){
      mobileNumberController.text = widget.phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        isLoading: loading,
        child: Padding(
          padding: const EdgeInsets.only(top: constants.defaultPadding * 3),
          child: SingleChildScrollView(
            child: Form(
              key: _signKey,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text("Create Account",
                          style: textStyle.heading.copyWith(color: colorDark))),
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(constants.defaultPadding),
                    child: Image.asset("images/signup.png"),
                  ),
                  MyTextFiled(
                      controller: firstNameController, hint: "First Name"),
                  MyTextFiled(controller: lastNameController, hint: "Last Name"),
                  MyTextFiled(
                      controller: panCardNumberController, hint: "Pan Number"),
                  MyTextFiled(
                    controller: mobileNumberController,
                    hint: "Mobile Number",
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: constants.defaultPadding * 2,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() => isChecked = value!);
                        },
                        activeColor: colorDark,
                      ),
                      Expanded(
                        child: Wrap(
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
                      ),
                    ],
                  ),
                  NewButton(
                    margin: const EdgeInsets.only(
                        left: constants.defaultPadding,
                        right: constants.defaultPadding,
                        top: constants.defaultPadding),
                    context: context,
                    function: () {
                      if (_signKey.currentState!.validate()) {
                        if (firstNameController.text.trim().isEmpty) {
                          showSnackbar(
                              context, "Please enter first name", colorError);
                          return;
                        }
                      }
                      if (lastNameController.text.trim().isEmpty) {
                        showSnackbar(
                            context, "Please enter last name", colorError);
                        return;
                      }
                      if (mobileNumberController.text.trim().isEmpty) {
                        showSnackbar(
                            context, "Please enter mobile number", colorError);
                        return;
                      }


                      if (!isChecked) {
                        showSnackbar(context,
                            "Please check our terms and condition", colorError);
                        return;
                      }

                      setState(() {
                        loading = true;
                      });

                      AuthApi.userRegister(
                              firstNameController.text.trim(),
                              lastNameController.text.trim(),
                              mobileNumberController.text.trim(),
                              panCardNumberController.text.trim())
                          .then((value) {
                        customPrint("loginUser :: $value");
                        if (value['result'].toString() == "1") {
                          nextPage(
                              context,
                              OTPPage(
                                jsonData: value,
                                isRegister: true,
                              ));
                        } else {
                          setState(() {
                            loading = false;
                          });
                          showSnackbar(context, value['msg'], colorError);
                        }
                      });

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const OTPPage()),
                      // );
                    },
                    buttonText: "Sign up",
                  ),
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Wrap(
                    children: [
                      Text("Already have an account  ?",
                          style: textStyle.smallText),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: Text(" Login",
                            style: textStyle.smallTextColorDark
                                .copyWith(color: colorDark)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: constants.defaultPadding * 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
