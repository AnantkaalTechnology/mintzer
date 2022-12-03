import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/Widgets/my_textfield.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/Widgets/progressHud.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/orders/api.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

import '../home/home_page.dart';

class CompleteOrderPage extends StatefulWidget {
  const CompleteOrderPage(
      {Key? key,
      required this.productImage,
      required this.productTitle,
      required this.orderId,
      required this.storeName,
      required this.totalEarning,
      required this.youSpend,
      required this.orderStatus,
      required this.orderMainId})
      : super(key: key);

  @override
  _CompleteOrderPageState createState() => _CompleteOrderPageState();

  final String productImage;
  final String productTitle;
  final String orderId;
  final String storeName;
  final String totalEarning;
  final String youSpend;
  final String orderStatus;
  final String orderMainId;
}

class _CompleteOrderPageState extends State<CompleteOrderPage> {
  final storeOrderIdController = TextEditingController();
  final phoneNumberController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customPrint("orderMainId :: ${widget.orderMainId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        isLoading: loading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: constants.defaultPadding * 2,
              left: constants.defaultPadding,
              right: constants.defaultPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///-----------card--------
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    color: colorCardWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(width: 0.4, color: colorDark),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(constants.defaultPadding),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                widget.productImage,
                                height: 122.h,
                                width: 122.h,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: constants.defaultPadding),
                                  child: Text(
                                    widget.productTitle,
                                    style: textStyle.subHeading
                                        .copyWith(color: colorDark),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: colorHeadingText,
                            height: constants.defaultPadding * 3,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Store Name : ${widget.storeName}",
                              style: textStyle.subHeading
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Order Status : Pending",
                              style: textStyle.smallText,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: constants.defaultPadding,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: constants.borderRadius,
                          side: const BorderSide(width: 1, color: colorDark),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(constants.defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Earning",
                                style: textStyle.subHeading,
                              ),
                              Text(
                                "$rupeeSign ${widget.totalEarning}",
                                style: textStyle.subHeading
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: constants.borderRadius,
                          side: const BorderSide(width: 1, color: colorDark),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(constants.defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total You Spend",
                                style: textStyle.subHeading,
                              ),
                              Text(
                                "$rupeeSign ${widget.youSpend}",
                                style: textStyle.subHeading
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  MyTextFiled(
                      margin: const EdgeInsets.only(
                        top: constants.defaultPadding * 2,
                      ),
                      controller: storeOrderIdController,
                      hint: "Store Order Id"),
                  MyTextFiled(
                      margin: const EdgeInsets.only(
                        top: constants.defaultPadding * 2,
                      ),
                      controller: phoneNumberController,
                      inputType: TextInputType.number,
                      length: 10,
                      hint: "Phone Number"),
                  NewButton(
                      context: context,
                      margin: const EdgeInsets.only(
                          top: constants.defaultPadding * 2),
                      buttonText: "Submit",
                      function: () {
                        if (storeOrderIdController.text.trim().isEmpty) {
                          showSnackbar(context, "Please enter Store Order Id",
                              colorError);
                          return;
                        }

                        if (phoneNumberController.text.trim().isEmpty) {
                          showSnackbar(context,
                              "Please enter your phone number", colorError);
                          return;
                        }

                        setState(() {
                          loading = true;
                        });

                        OrderApi.completeOrder(
                                context,
                                storeOrderIdController.text.trim(),
                                phoneNumberController.text.trim(),
                                widget.orderMainId)
                            .then((value) {
                          if (value == "1") {
                            nextPage(context, const HomePage());
                            showSnackbar(context,
                                "Order Completed Successfully", colorSuccess);
                            return;
                          }
                          setState(() {
                            loading = false;
                          });
                          showSnackbar(context, "Some Unknown error has occur",
                              colorError);
                        });
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
