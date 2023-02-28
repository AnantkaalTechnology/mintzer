// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mintzer/Widgets/my_textfield.dart';
// import 'package:mintzer/Widgets/new_button.dart';
// import 'package:mintzer/Widgets/progressHud.dart';
// import 'package:mintzer/globalVariable.dart';
// import 'package:mintzer/home/api.dart';
// import 'package:mintzer/orders/api.dart';
// import 'package:mintzer/util/colors.dart';
// import 'package:mintzer/util/constants.dart';
// import 'package:mintzer/util/text_styles.dart';
//
// import '../home/home_page.dart';
//
// class UpdateOrderDetails extends StatefulWidget {
//   const UpdateOrderDetails(
//       {Key? key,
//       required this.productImage,
//       required this.productTitle,
//       required this.orderId,
//       required this.storeName,
//       required this.totalEarning,
//       required this.youSpend,
//       required this.orderStatus,
//       required this.orderMainId})
//       : super(key: key);
//
//   @override
//   _UpdateOrderDetailsState createState() => _UpdateOrderDetailsState();
//
//   final String productImage;
//   final String productTitle;
//   final String orderId;
//   final String storeName;
//   final String totalEarning;
//   final String youSpend;
//   final String orderStatus;
//   final String orderMainId;
// }
//
// class _UpdateOrderDetailsState extends State<UpdateOrderDetails> {
//   final storeOrderIdController = TextEditingController();
//   final orderOtpController = TextEditingController();
//   final orderTrackingIdController = TextEditingController();
//   final orderCourierIdController = TextEditingController();
//   final orderGstIdController = TextEditingController();
//   final orderPhoneNumberController = TextEditingController();
//   bool loading = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     customPrint("orderMainId :: ${widget.orderMainId}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ProgressHUD(
//         isLoading: loading,
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(
//               top: constants.defaultPadding * 2,
//               left: constants.defaultPadding,
//               right: constants.defaultPadding,
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Card(
//                     semanticContainer: true,
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     elevation: 0,
//                     color: colorCardWhite,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: constants.borderRadius,
//                       side: const BorderSide(width: 0.4, color: colorDark),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(constants.defaultPadding),
//                       child: Column(
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.network(
//                                 widget.productImage,
//                                 height: 122.h,
//                                 width: 122.h,
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: constants.defaultPadding),
//                                   child: Text(
//                                     widget.productTitle,
//                                     style: textStyle.subHeading
//                                         .copyWith(color: colorDark),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Divider(
//                             thickness: 0.2,
//                             color: colorHeadingText,
//                             height: constants.defaultPadding * 3,
//                           ),
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               "Store Name : ${widget.storeName}",
//                               style: textStyle.subHeading
//                                   .copyWith(color: Colors.black),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(
//                               "Order Status : Booked",
//                               style: textStyle.smallText,
//                               maxLines: 4,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: constants.defaultPadding,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   MyTextFiled(
//                       margin: const EdgeInsets.only(
//                         top: constants.defaultPadding * 2,
//                       ),
//                       controller: storeOrderIdController,
//                       hint: "Store Order Id"),
//                   MyTextFiled(
//                       margin: const EdgeInsets.only(
//                         top: constants.defaultPadding * 2,
//                       ),
//                       controller: orderOtpController,
//                       inputType: TextInputType.number,
//                       hint: "Order Delivery Otp"),
//                   MyTextFiled(
//                       margin: const EdgeInsets.only(
//                         top: constants.defaultPadding * 2,
//                       ),
//                       controller: orderCourierIdController,
//                       hint: "Order Courier Id"),
//                   MyTextFiled(
//                       margin: const EdgeInsets.only(
//                         top: constants.defaultPadding * 2,
//                       ),
//                       controller: orderTrackingIdController,
//                       hint: "Order Tracking Id"),
//                   MyTextFiled(
//                       margin: const EdgeInsets.only(
//                         top: constants.defaultPadding * 2,
//                       ),
//                       controller: orderGstIdController,
//                       hint: "Order Gst Number"),
//                   NewButton(
//                       context: context,
//                       margin: const EdgeInsets.only(
//                           top: constants.defaultPadding * 2),
//                       buttonText: "Submit",
//                       function: () {
//                         if (storeOrderIdController.text.trim().isEmpty) {
//                           showSnackbar(context, "Please enter Store Order Id",
//                               colorError);
//                           return;
//                         }
//                         if (orderOtpController.text.trim().isEmpty) {
//                           showSnackbar(
//                               context, "Please enter Order OTP", colorError);
//                           return;
//                         }
//                         if (orderCourierIdController.text.trim().isEmpty) {
//                           showSnackbar(context, "Please enter Order Courier Id",
//                               colorError);
//                           return;
//                         }
//
//                         if (orderTrackingIdController.text.trim().isEmpty) {
//                           showSnackbar(context,
//                               "Please enter Order Tracking Id", colorError);
//                           return;
//                         }
//
//                         if (orderGstIdController.text.trim().isEmpty) {
//                           showSnackbar(context, "Please enter Order GST Number",
//                               colorError);
//                           return;
//                         }
//
//                         setState(() {
//                           loading = true;
//                         });
//
//                         OrderApi.updateOrderForm(
//                                 context,
//                                 storeOrderIdController.text.trim(),
//                                 orderTrackingIdController.text.trim(),
//                                 orderCourierIdController.text.trim(),
//                                 orderGstIdController.text.trim(),
//                                 orderOtpController.text.trim(),"",orderPhoneNumberController.text.trim())
//                             .then((value) {
//                           if (value == "1") {
//                             nextPage(context, const HomePage());
//                             showSnackbar(
//                                 context,
//                                 "Order details update successfully",
//                                 colorSuccess);
//                             return;
//                           }
//                           setState(() {
//                             loading = false;
//                           });
//                           showSnackbar(context, "Some Unknown error has occur",
//                               colorError);
//                         });
//                       }),
//                   NewButton(
//                     border: true,
//                     margin:
//                         const EdgeInsets.only(top: constants.defaultPadding),
//                     context: context,
//                     function: () {
//                       setState(() {
//                         loading = true;
//                       });
//                       HomeApi.withdrawalRequests(context, widget.orderMainId)
//                           .then((value) {
//                         setState(() {
//                           loading = false;
//                         });
//                         if (value == "1") {
//                           showSnackbar(context, "Withdrawal Request Initiated",
//                               colorSuccess);
//                         }
//                       });
//                     },
//                     textStyle: textStyle.button.copyWith(color: colorDark),
//                     buttonText: "Withdraw",
//                   ),
//                   const SizedBox(
//                     height: constants.defaultPadding * 2,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
