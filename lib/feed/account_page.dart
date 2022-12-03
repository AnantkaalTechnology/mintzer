import 'package:flutter/material.dart';
import 'package:mintzer/Widgets/progressHud.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import '../Widgets/my_textfield.dart';
import '../Widgets/new_button.dart';
import '../globalVariable.dart';
import '../home/api.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final yourNameController =
      TextEditingController(text: UserDetails.bankFullName);
  final bankNameController = TextEditingController(text: UserDetails.bankName);
  final accountNumberController =
      TextEditingController(text: UserDetails.bankAccountNumber);
  final IFSCController =
      TextEditingController(text: UserDetails.bankAccountIfsc);

  final pincodeController = TextEditingController(text: UserDetails.pincode);
  final address1Controller =
      TextEditingController(text: UserDetails.addressLine1);
  final address2Controller =
      TextEditingController(text: UserDetails.addressLine2);
  final cityController = TextEditingController(text: UserDetails.city);
  final landmarkController = TextEditingController(text: UserDetails.landmark);

  bool loading = false;
  bool isBankWidget = true;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        isLoading: loading,
        child: Padding(
          padding: const EdgeInsets.only(
            top: constants.defaultPadding * 2,
            // left: constants.defaultPadding,
            // right: constants.defaultPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///--------My Account Card----------
                Padding(
                  padding: const EdgeInsets.only(
                    left: constants.defaultPadding,
                    right: constants.defaultPadding,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 0, color: colorCardWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.borderRadius,
                        side: const BorderSide(
                            width: 0.2, color: colorSubHeadingText),
                      ),
                      // color: colorDark,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: constants.defaultPadding),
                        child: Column(
                          children: [
                            Text(
                              "My Account",
                              style: textStyle.subHeading,
                            ),
                            Text(
                              UserDetails.pan,
                              style: textStyle.subHeading
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: constants.defaultPadding,
                ),

                ///---------table layout-------
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isBankWidget = true;
                          });
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: constants.defaultPadding),
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                          ),
                          color:
                              isBankWidget == true ? colorDark : colorDisable,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: constants.defaultPadding / 2),
                            child: Text(
                              "Bank",
                              style: textStyle.subHeading.copyWith(
                                  color: isBankWidget == true
                                      ? colorWhite
                                      : colorHeadingText),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isBankWidget = false;
                          });
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: constants.defaultPadding),
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                          ),
                          color:
                              isBankWidget == false ? colorDark : colorDisable,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: constants.defaultPadding / 2),
                            child: Text(
                              "Address",
                              style: textStyle.subHeading.copyWith(
                                  color: isBankWidget == false
                                      ? colorWhite
                                      : colorHeadingText),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: constants.defaultPadding * 2,
                ),

                isBankWidget
                    ?

                    ///-----------heading-------
                    bankWidget(context)
                    :

                    ///----------Address
                    addressWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column addressWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: constants.defaultPadding,
            right: constants.defaultPadding,
          ),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My Address",
                style: textStyle.heading,
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: constants.defaultPadding,
        // ),
        MyTextFiled(controller: address1Controller, hint: "Address Line 1"),
        MyTextFiled(controller: address2Controller, hint: "Address Line 2"),
        MyTextFiled(controller: landmarkController, hint: "Landmark"),
        MyTextFiled(controller: cityController, hint: "City"),
        MyTextFiled(
          controller: pincodeController,
          hint: "Pincode",
          inputType: TextInputType.number,
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        NewButton(
          margin: const EdgeInsets.only(
              left: constants.defaultPadding,
              right: constants.defaultPadding,
              top: constants.defaultPadding),
          context: context,
          function: () {
            if (address1Controller.text.trim().isEmpty) {
              showSnackbar(context, "Please enter your address 1", colorError);
              return;
            }
            if (address2Controller.text.trim().isEmpty) {
              showSnackbar(context, "Please enter bank address 2", colorError);
              return;
            }

            if (cityController.text.trim().isEmpty) {
              showSnackbar(context, "Please enter city name", colorError);
              return;
            }
            if (pincodeController.text.trim().isEmpty) {
              showSnackbar(context, "Please enter pincode number", colorError);
              return;
            }

            setState(() {
              loading = true;
            });

            HomeApi.updateAddressDetails(
                    context,
                    address1Controller.text.trim(),
                    address2Controller.text.trim(),
                    landmarkController.text.trim(),
                    cityController.text.trim(),
                    pincodeController.text.trim())
                .then((value) {
              if (value == "1") {
                showSnackbar(context, "Address details update successfully",
                    colorSuccess);
                setState(() {
                  loading = false;
                });
                UserDetails.getUserDetails(context);
                return;
              }
              setState(() {
                loading = false;
              });
              showSnackbar(context, "Some Unknown error has occur", colorError);
            });
          },
          buttonText: "UPDATE",
        ),
      ],
    );
  }

  Column bankWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: constants.defaultPadding,
            right: constants.defaultPadding,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Bank Account details",
              style: textStyle.heading,
            ),
          ),
        ),
        // SizedBox(
        //   height: constants.defaultPadding,
        // ),

        ///--------Text Field---------
        MyTextFiled(controller: yourNameController, hint: "Your Name"),
        MyTextFiled(controller: bankNameController, hint: "Bank Name"),
        MyTextFiled(
            controller: accountNumberController, hint: "Account Number"),
        MyTextFiled(controller: IFSCController, hint: "IFSC"),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        NewButton(
          margin: const EdgeInsets.only(
              left: constants.defaultPadding,
              right: constants.defaultPadding,
              top: constants.defaultPadding),
          context: context,
          function: () {
            if (yourNameController.text.trim().isEmpty) {
              showSnackbar(context, "Please enter your name", colorError);
              return;
            }
            if (bankNameController.text.trim().isEmpty) {
              showSnackbar(context, "Please enter bank name", colorError);
              return;
            }
            if (accountNumberController.text.trim().isEmpty) {
              showSnackbar(context, "Please enter account number", colorError);
              return;
            }
            if (IFSCController.text.trim().isEmpty) {
              showSnackbar(context, "Please enter IFSC number", colorError);
              return;
            }

            setState(() {
              loading = true;
            });

            HomeApi.updateBankDetails(
                    context,
                    yourNameController.text.trim(),
                    bankNameController.text.trim(),
                    accountNumberController.text.trim(),
                    IFSCController.text.trim())
                .then((value) {
              if (value == "1") {
                showSnackbar(
                    context, "Bank details update successfully", colorSuccess);
                setState(() {
                  loading = false;
                });
                UserDetails.getUserDetails(context);
                return;
              }
              setState(() {
                loading = false;
              });
              showSnackbar(context, "Some Unknown error has occur", colorError);
            });
          },
          buttonText: "UPDATE",
        ),
      ],
    );
  }
}
