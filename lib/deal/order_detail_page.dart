import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/Widgets/new_button.dart';
import 'package:mintzer/Widgets/progressHud.dart';
import 'package:mintzer/deal/deal_note.dart';
import 'package:mintzer/deal/order_page.dart';
import 'package:mintzer/feed/support_page.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/home/api.dart';
import 'package:mintzer/home/home_page.dart';
import 'package:mintzer/model/orders_model.dart';
import 'package:mintzer/orders/api.dart';

// import 'package:mintzer/orders/step_progress_bar.dart';
// import 'package:mintzer/orders/stepper_page.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({
    Key? key,
    required this.productImage,
    required this.productTitle,
    required this.productOfferTitle,
    required this.productOfferText,
    required this.productYouSpend,
    required this.productTotalEarn,
    required this.productCashback,
    required this.productTotalReceive,
    required this.productLink,
    required this.productDealId,
    required this.dealId,
    required this.orderQuantity,
    this.orderPage = 0,
    this.orderPayment = 0,
    required this.orderId,
    required this.dealerPrice,
  }) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();

  final String productImage;
  final String productTitle;
  final String productOfferTitle;
  final String productOfferText;
  final String productYouSpend;
  final String productTotalEarn;
  final String productCashback;
  final String productTotalReceive;
  final String productLink;
  final String productDealId;
  final String dealId;
  final String orderQuantity;
  final int orderPage;
  final int orderPayment;
  final String orderId;
  final String dealerPrice;
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  int sec = 59;
  final trackingIdController = TextEditingController();
  final fliporderController = TextEditingController();
  final editController = TextEditingController();
  final orderDeliveryOtpController = TextEditingController();
  int steps = 0;
  bool loading = false;
  int clickEdit = 1;
  int clickBtn = 0;

  // Initial Selected Value
  String dropdownvalue = 'Select';

  // List of items in our dropdown menu
  var items = [
    'Select',
    'Ekart logistics',
    'Delhivery',
    'Bluedart',
    'Ecom',
    'xpressbees'
  ];

  // String dropdownValue = list.first;

  late BuildContext _context;

  @override
  void initState() {
    if (widget.orderId != "") {
      OrderApi.getOrdersByOrderId(
        context,
        widget.orderId,
      ).then((value) {
        setState(() {
          if (OrderApi.storeOrderId.isNotEmpty) {
            steps = 1;
          }
          if (OrderApi.trackingId.isNotEmpty ||
              OrderApi.storeOrderId.isNotEmpty) {
            steps = 2;
          }
          if (OrderApi.shippedOtp.isNotEmpty) {
            steps = 3;
          }
          if( OrderApi.deliveredStatus == "1"){
            steps =4;
          }

          customPrint("use: $steps ");
          customPrint(OrderApi.storeOrderId);
          customPrint(OrderApi.trackingId);
          customPrint(OrderApi.shippedOtp);
        });
      });
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context=context;
    return Scaffold(
      body: SafeArea(
        child: ProgressHUD(
          isLoading: loading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: constants.defaultPadding * 2,
                left: constants.defaultPadding,
                right: constants.defaultPadding,
              ),
              child: Column(
                children: [
                  ///----------key note card----------
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    color: colorAccent1,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(width: 0.4, color: colorDark),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(constants.defaultPadding),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Key Note",
                                style: textStyle.subHeading
                                    .copyWith(color: colorHeadingText),
                              )),
                          const SizedBox(
                            height: constants.defaultPadding / 2,
                          ),
                          Text(
                            "Please accept this deal only if you can complete this order within the next 1 hour. The Order ID and Tracking ID should both exactly match with the delivered product otherwise the order will be cancelled by the buyer.",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          const SizedBox(
                            height: constants.defaultPadding,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Add GST Number",
                                style: textStyle.subHeading
                                    .copyWith(color: colorHeadingText),
                              )),
                          const SizedBox(
                            height: constants.defaultPadding / 2,
                          ),
                          Text(
                            "If you have GST number please add and verify your GST details",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          const SizedBox(
                            height: constants.defaultPadding / 2,
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Add GST",
                                style: textStyle.smallTextColorDark.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline,
                                ),
                              )),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Need Help",
                                style: textStyle.subHeading
                                    .copyWith(color: colorHeadingText),
                              )),
                          Text(
                            "How to place your first order on Mintraz? (Mintraz par apna pehla order kaise karein?)",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "See in English",
                                style: textStyle.smallTextColorDark.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  // Card(
                  //   height: 300.h,
                  //   child:
                  // ),

                  Visibility(
                    visible: widget.orderPage == 0 ? false : true,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 3,
                      color: colorWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.borderRadius,
                        side: const BorderSide(width: 0.4, color: colorDark),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(constants.defaultPadding),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///--------1
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: steps > 0
                                                  ? colorDark
                                                  : colorSubHeadingText,
                                              border: Border.all(
                                                color: steps > 0
                                                    ? colorDark
                                                    : colorSubHeadingText,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      constants.radius))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                constants.defaultPadding / 3),
                                            child: Image.asset(
                                              'images/accepted.png',
                                              color: steps > 0
                                                  ? colorWhite
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Text("accepted",
                                            style: textStyle.smallText.copyWith(
                                                color: colorHeadingText,
                                                fontSize: 9.sp)),
                                      ],
                                    ),
                                  ],
                                ),

                                ///----------2
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: steps > 1
                                                  ? colorDark
                                                  : colorSubHeadingText,
                                              border: Border.all(
                                                color: steps > 1
                                                    ? colorDark
                                                    : colorSubHeadingText,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      constants.radius))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                constants.defaultPadding / 3),
                                            child: Image.asset(
                                              'images/order.png',
                                              color: steps > 1
                                                  ? colorWhite
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Text("ordered",
                                            style: textStyle.smallText.copyWith(
                                                color: colorHeadingText,
                                                fontSize: 9.sp)),
                                      ],
                                    ),
                                  ],
                                ),

                                ///----------3
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: steps > 2
                                                  ? colorDark
                                                  : colorSubHeadingText,
                                              border: Border.all(
                                                color: steps > 2
                                                    ? colorDark
                                                    : colorSubHeadingText,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      constants.radius))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                constants.defaultPadding / 3),
                                            child: Image.asset(
                                              'images/shipped.png',
                                              color: steps > 2
                                                  ? colorWhite
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Text("shipped",
                                            style: textStyle.smallText.copyWith(
                                                color: colorHeadingText,
                                                fontSize: 9.sp)),
                                      ],
                                    ),
                                  ],
                                ),

                                ///----------4
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: steps > 3
                                                  ? colorDark
                                                  : colorSubHeadingText,
                                              border: Border.all(
                                                  color: steps > 3
                                                      ? colorDark
                                                      : colorSubHeadingText),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      constants.radius))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                constants.defaultPadding / 3),
                                            child: Image.asset(
                                              'images/delivered.png',
                                              color: steps > 3
                                                  ? colorWhite
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Text("delivered",
                                            style: textStyle.smallText.copyWith(
                                                color: colorHeadingText,
                                                fontSize: 9.sp)),
                                      ],
                                    ),
                                  ],
                                ),

                                ///----------5
                                Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: steps > 4
                                              ? colorDark
                                              : colorSubHeadingText,
                                          border: Border.all(
                                            color: steps > 4
                                                ? colorDark
                                                : colorSubHeadingText,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  constants.radius))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            constants.defaultPadding / 3),
                                        child: Image.asset(
                                          'images/payment2.png',
                                          color: steps > 4
                                              ? colorWhite
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text("payment",
                                        style: textStyle.smallText.copyWith(
                                            color: colorHeadingText,
                                            fontSize: 9.sp)),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: colorHeadingText,
                              height: constants.defaultPadding,
                            ),

                            ///----------payment-------
                            paymentWidget(),

                            ///-------delivered--------
                            deliveredWidget(context),

                            ///--------shipped--------
                            shippedWidget(context),

                            ///---------ordered-------
                            orderedWidget(context),

                            ///-------accepted page-----------
                            acceptedWidget(context),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///-----------card--------
                  Visibility(
                    child: Card(
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
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: constants.defaultPadding),
                                        child: Text(
                                          widget.productTitle,
                                          style: textStyle.subHeading
                                              .copyWith(color: colorDark),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: constants.defaultPadding,
                                      ),
                                      detailsWidgetCard(
                                          "Color : ", "Any Color"),
                                      detailsWidgetCard("Quantity : ", "1"),
                                      detailsWidgetCard("Price/Unit : ",
                                          "₹${widget.dealerPrice}"),
                                    ],
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
                                widget.productOfferTitle,
                                style: textStyle.subHeading
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.productOfferText,
                                style: textStyle.smallText,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: constants.defaultPadding,
                            ),
                            NewButton(
                              context: context,
                              function: () {
                                nextPage(
                                    context,
                                    DealNotePage(
                                      productImage: widget.productImage,
                                      productTitle: widget.productTitle,
                                      productOfferTitle:
                                          widget.productOfferTitle,
                                      productOfferText: widget.productOfferText,
                                      productYouSpend: widget.productYouSpend,
                                      productTotalEarn: widget.productTotalEarn,
                                      productCashback: widget.productCashback,
                                      productTotalReceive:
                                          widget.productTotalReceive,
                                      productLink: widget.productLink,
                                      productDealId: widget.productDealId,
                                      dealId: widget.dealId,
                                      orderQuantity: widget.orderQuantity,
                                    ));
                              },
                              buttonText: "Place Order",
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///---------offer detail card------------
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    color: colorWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(width: 0.4, color: colorDark),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(constants.defaultPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "offer details",
                                      style: textStyle.subHeadingColorDark
                                          .copyWith(color: colorHeadingText),
                                    )),
                                const SizedBox(
                                  height: constants.defaultPadding / 2,
                                ),
                                Text(
                                  "10% off on Cradit Card, up to ₹1500. On orders of ₹5000 and above",
                                  style: textStyle.smallText
                                      .copyWith(color: colorHeadingText),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            "images/kotak.jpg",
                            height: 80.h,
                            width: 80.w,
                          )
                        ],
                      ),
                    ),
                  ),

                  ///---------
                  ///

                  ///
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200.h,
                        width: 165.w,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(constants.defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "images/spend_amount.png",
                                  height: 30.h,
                                  width: 30.w,
                                  color: colorError,
                                ),
                                Text(
                                  "You'll spend",
                                  style: textStyle.smallText.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "$rupeeSign ${widget.productYouSpend}",
                                  style: textStyle.heading.copyWith(
                                      color: Colors.black, fontSize: 30.sp),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  child: Divider(
                                    thickness: 0.2,
                                    color: Colors.black,
                                    height: constants.defaultPadding * 3,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "total price",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                        Text(
                                          "$rupeeSign ${widget.dealerPrice}",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "-",
                                      style: textStyle.smallText
                                          .copyWith(color: Colors.black),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "discount ",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                        Text(
                                          "$rupeeSign ${widget.productCashback}",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                        width: 165.w,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(constants.defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "images/receive_amount.png",
                                  height: 30.h,
                                  width: 30.w,
                                ),
                                Text(
                                  "Total you'll receive",
                                  style: textStyle.smallText.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "$rupeeSign ${widget.productTotalReceive}",
                                  style: textStyle.heading.copyWith(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                const Divider(
                                  thickness: 0.2,
                                  color: Colors.black,
                                  height: constants.defaultPadding * 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "spend",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                        Text(
                                          "$rupeeSign ${widget.productYouSpend}",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "+",
                                      style: textStyle.smallText
                                          .copyWith(color: Colors.black),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "cash reward",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                        Text(
                                          "$rupeeSign ${widget.productTotalEarn}",
                                          style: textStyle.smallText.copyWith(
                                              color: Colors.black,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: constants.defaultPadding,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 200.h,
                      width: 165.w,
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: constants.borderRadius,
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(constants.defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/profit.png",
                                height: 30.h,
                                width: 30.w,
                              ),
                              Text(
                                "Total earnings",
                                style: textStyle.smallText.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "$rupeeSign ${widget.productTotalEarn}",
                                style: textStyle.heading.copyWith(
                                  color: Colors.black,
                                  fontSize: 30.sp,
                                ),
                              ),
                              const Divider(
                                thickness: 0.2,
                                color: Colors.black,
                                height: constants.defaultPadding * 3,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "cash reward",
                                    style: textStyle.smallText.copyWith(
                                        color: Colors.black, fontSize: 10.sp),
                                  ),
                                  Text(
                                    "$rupeeSign ${widget.productTotalEarn}",
                                    style: textStyle.smallText.copyWith(
                                        color: Colors.black, fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///----------TDS detail card ------------------
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    color: colorAccent1,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(width: 0.4, color: colorDark),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(constants.defaultPadding),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "TDS Details",
                                style: textStyle.subHeading
                                    .copyWith(color: colorHeadingText),
                              )),
                          Text(
                            "5% TDS (Rs. 8) will be deducted on cash reward and rest amount will be transferred to your bank account (Rs. 17650)",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          const SizedBox(
                            height: constants.defaultPadding / 2,
                          ),
                          Text(
                            "Why is TDS deducted from payments? (Payments se TDS kyun kata jata hai?)",
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "See in English",
                                style: textStyle.smallTextColorDark.copyWith(
                                  color: colorHeadingText,
                                  decoration: TextDecoration.underline,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                  ///----------secure order card-------------
                  Visibility(
                    visible: widget.orderPage == 1 ? false : true,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 0,
                      color: colorWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.borderRadius,
                        side: const BorderSide(width: 0.4, color: colorDark),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(constants.defaultPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "100% secure prepaid order",
                                        style: textStyle.subHeadingColorDark
                                            .copyWith(color: colorHeadingText),
                                      )),
                                  const SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  Text(
                                    "amount added to wallet as soon as order is placed",
                                    style: textStyle.smallText
                                        .copyWith(color: colorHeadingText),
                                  ),
                                  Text(
                                    "*amount released on delivery confirmation",
                                    style: textStyle.smallText
                                        .copyWith(color: colorHeadingText),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              "images/locked_card.png",
                              height: 80.h,
                              width: 80.w,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///-------------delivery details---------
                  Visibility(
                    visible: widget.orderPage == 0 ? false : true,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 0,
                      color: colorWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.borderRadius,
                        side: const BorderSide(width: 0.4, color: colorDark),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(constants.defaultPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "delivery details",
                                        style: textStyle.subHeadingColorDark
                                            .copyWith(color: colorHeadingText),
                                      )),
                                  const SizedBox(
                                    height: constants.defaultPadding,
                                  ),
                                  detailsWidget("Arjit Dash", ""),
                                  const SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  detailsWidget("",
                                      "Appartment No. 416, 4th floor, 1st Block,, Satyabati Enclave,,"),
                                  const SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  detailsWidget("",
                                      "behind SBI Main Branch, Shivanand nagar, Bargarh"),
                                  const SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  detailsWidget("", "Odisha"),
                                  const SizedBox(
                                    height: constants.defaultPadding / 2,
                                  ),
                                  detailsWidget("Pincode : ", "768028"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: constants.defaultPadding * 3,
                  ),
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Card(
                  //       semanticContainer: true,
                  //       clipBehavior: Clip.antiAliasWithSaveLayer,
                  //       elevation: 0,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: constants.borderRadius,
                  //         side: const BorderSide(width: 1, color: colorDark),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(constants.defaultPadding),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Cashback",
                  //               style: textStyle.subHeading,
                  //             ),
                  //             Text(
                  //               "$rupeeSign ${widget.productCashback}",
                  //               style: textStyle.subHeading
                  //                   .copyWith(color: Colors.black),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Card(
                  //       semanticContainer: true,
                  //       clipBehavior: Clip.antiAliasWithSaveLayer,
                  //       elevation: 0,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: constants.borderRadius,
                  //         side: const BorderSide(width: 1, color: colorDark),
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(constants.defaultPadding),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Total you'll receive",
                  //               style: textStyle.subHeading,
                  //             ),
                  //             Text(
                  //               "$rupeeSign ${widget.productTotalReceive}",
                  //               style: textStyle.subHeading
                  //                   .copyWith(color: Colors.black),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //
                  //     ///----------------
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Visibility acceptedWidget(BuildContext context) {
    return Visibility(
      visible: steps == 0 ? true : false,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "mintraz order id",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Text(
                widget.orderId,
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${OrderApi.storeTitle} order #",
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                  SizedBox(
                    height: 46.h,
                    width: 200,
                    child: TextFormField(
                      controller: fliporderController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "999-999999-999999",
                        hintStyle: textStyle.subHeading
                            .copyWith(color: colorSubHeadingText),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: double.parse(
                              flutterMapValue(0.0, 1.0, 0, 59, sec)),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(colorDark))),
                  Text(
                    "45:00",
                    style: textStyle.smallText.copyWith(color: colorDark),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),

          ///----------button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: NewButton(
                  context: context,
                  enable: fliporderController.text.trim().length == 15
                      ? true
                      : false,
                  buttonText: "Save",
                  height: 36.h,
                  textStyle: textStyle.button.copyWith(fontSize: 14.sp),
                  margin: const EdgeInsets.symmetric(
                    horizontal: constants.defaultPadding / 2,
                  ),
                  function: () {
                    setState(() {
                      loading = true;
                      steps++;
                    });

                    OrderApi.updateOrderForm(
                            context,
                            fliporderController.text.trim(),
                            '',
                            '',
                            '',
                            '',
                            widget.orderId)
                        .then((value) {
                      OrderApi.getOrdersByOrderId(context, widget.orderId)
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                      });
                    });

                    customPrint("steps : $steps");
                  },
                ),
              ),

              ///order now button--------------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "not yet ordered?",
                      style: textStyle.smallText,
                    ),
                    GestureDetector(
                      onTap: () {
                        nextPage(
                            context,
                            OrderPage(
                              productImage: widget.productImage,
                              productTitle: widget.productTitle,
                              productOfferTitle: widget.productOfferTitle,
                              productOfferText: widget.productOfferText,
                              productYouSpend: widget.productYouSpend,
                              productTotalEarn: widget.productTotalEarn,
                              productCashback: widget.productCashback,
                              productTotalReceive: widget.productTotalReceive,
                              productLink: widget.productLink,
                              productDealId: widget.productDealId,
                              dealId: widget.dealId,
                              orderQuantity: widget.orderQuantity,
                              orderNow: true,
                            ));
                      },
                      child: Text(
                        "Order Now",
                        style: textStyle.smallTextColorDark.copyWith(
                            color: colorDark,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ordered cancelled?",
                      style: textStyle.smallText,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          markCancelOptions(context);
                        });
                      },
                      child: Text(
                        "Mark cancelled",
                        style: textStyle.smallTextColorDark.copyWith(
                            color: colorDark,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Visibility orderedWidget(BuildContext context) {
    return Visibility(
      visible: steps == 1 ? true : false,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "mintraz order id",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Text(
                widget.orderId,
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${OrderApi.storeTitle} order #",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Row(
                children: [
                  Text(
                    OrderApi.storeOrderId,
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                  const SizedBox(
                    width: constants.defaultPadding / 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        clickEdit = 0;
                        showEditOptions(context, 0);
                        customPrint("$clickEdit");
                      });
                      customPrint("1st flip edit ");
                    },
                    child: Text(
                      "Edit",
                      style: textStyle.smallTextColorDark.copyWith(
                          color: colorHeadingText,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking id",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              // const DropdownButtonExample(),
              // DropdownButton<String>(
              //   items: <String>['Select', 'Ekart logistics', 'Delhivery', 'Bluedart','Ecom','xpressbees'].map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value,style: textStyle.smallText.copyWith(color: Colors.black),),
              //     );
              //   }).toList(),
              //   onChanged: (_) {},
              // )
              DropdownButton(
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: colorDark,
                ),
                elevation: 10,
                style: textStyle.smallText.copyWith(color: colorDark),
                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
              // DropdownButton<String>(
              //   value: dropdownValue,
              //   icon: const Icon(Icons.arrow_downward),
              //   elevation: 16,
              //   style: const TextStyle(color: colorDark),
              //   underline: Container(
              //     height: 1,
              //     color: colorDark,
              //   ),
              //   onChanged: (String? value) {
              //     // This is called when the user selects an item.
              //     setState(() {
              //       dropdownValue = value!;
              //     });
              //   },
              //   //vicky
              //   items: list.map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     // selectCourierOptions(context);
              //
              //   },
              //   child: Text(
              //     "Select courier patner",
              //     style: textStyle.smallText.copyWith(
              //         color: colorHeadingText,
              //         decoration: TextDecoration.underline),
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 46.h,
              width: 200,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: trackingIdController,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "99999-999999-999999",
                  hintStyle:
                      textStyle.subHeading.copyWith(color: colorSubHeadingText),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: NewButton(
                  context: context,
                  buttonText: "Save",
                  height: 36.h,
                  enable: trackingIdController.text.trim().length == 15
                      ? true
                      : false,
                  textStyle: textStyle.button.copyWith(fontSize: 14.sp),
                  margin: const EdgeInsets.symmetric(
                    horizontal: constants.defaultPadding / 2,
                  ),
                  function: () {
                    setState(() {
                      steps++;
                      loading = true;
                    });
                    OrderApi.updateOrderForm(
                            context,
                            fliporderController.text.trim(),
                            trackingIdController.text.trim(),
                            '',
                            '',
                            '',
                            widget.orderId)
                        .then((value) {
                      OrderApi.getOrdersByOrderId(context, widget.orderId)
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                      });
                    });
                    // OrderApi.updateOrderForm(
                    //     context,
                    //     fliporderController.text
                    //         .trim(),
                    //     trackingIdController.text
                    //         .trim(),
                    //     '',
                    //     '',
                    //     '');
                    customPrint("steps : $steps");
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ordered cancelled?",
                      style: textStyle.smallText,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          markCancelOptions(context);
                        });
                      },
                      child: Text(
                        "Mark cancelled",
                        style: textStyle.smallTextColorDark.copyWith(
                            color: colorDark,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Visibility shippedWidget(BuildContext context) {
    return Visibility(
      visible: steps == 2 ? true : false,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "mintraz order id",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Text(
                widget.orderId,
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${OrderApi.storeTitle} order #",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Row(
                children: [
                  Text(
                    OrderApi.storeOrderId,
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                  const SizedBox(
                    width: constants.defaultPadding / 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showEditOptions(context, 0);
                        clickEdit = 0;
                      });
                      customPrint(" flip $clickEdit ");
                    },
                    child: Text(
                      "Edit",
                      style: textStyle.smallTextColorDark.copyWith(
                          color: colorHeadingText,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking id",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showEditOptions(context, 1);
                  });
                  clickEdit = 1;
                  customPrint(" tracking $clickEdit ");
                },
                child: Row(
                  children: [
                    Text(
                      OrderApi.trackingId,
                      style:
                          textStyle.smallText.copyWith(color: colorHeadingText),
                    ),
                    const SizedBox(
                      width: constants.defaultPadding / 3,
                    ),
                    Text(
                      "Edit",
                      style: textStyle.smallTextColorDark.copyWith(
                          color: colorHeadingText,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Support",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              // Text(
              //   "Select courier patner",
              //   style: textStyle.smallText.copyWith(
              //       color: colorHeadingText,
              //       decoration: TextDecoration.underline),
              // ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 46.h,
              width: 200,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: orderDeliveryOtpController,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: " Enter your OTP/PIN",
                  hintStyle:
                      textStyle.subHeading.copyWith(color: colorSubHeadingText),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: NewButton(
                  context: context,
                  buttonText: "Save",
                  height: 36.h,
                  enable: orderDeliveryOtpController.text.trim().length == 6
                      ? true
                      : false,
                  textStyle: textStyle.button.copyWith(fontSize: 14.sp),
                  margin: const EdgeInsets.symmetric(
                    horizontal: constants.defaultPadding / 2,
                  ),
                  function: () {
                    setState(() {
                      loading = true;
                      steps++;
                    });
                    customPrint("steps : $steps");
                    OrderApi.updateOrderForm(
                            context,
                            fliporderController.text.trim(),
                            trackingIdController.text.trim(),
                            '',
                            '',
                            orderDeliveryOtpController.text.trim(),
                            widget.orderId)
                        .then((value) {
                      OrderApi.getOrdersByOrderId(context, widget.orderId)
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                      });
                    });
                    // OrderApi.updateOrderForm(
                    //     context,
                    //     fliporderController.text
                    //         .trim(),
                    //     trackingIdController.text
                    //         .trim(),
                    //     'NA',
                    //     'NA',
                    //     orderDeliveryOtpController
                    //         .text
                    //         .trim());
                  },
                ),
              ),

              ///order now button--------------
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "not yet ordered?",
              //         style: textStyle.smallText,
              //       ),
              //       Text(
              //         "Order Now",
              //         style: textStyle.smallTextColorDark
              //             .copyWith(color: colorDark),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ordered cancelled?",
                      style: textStyle.smallText,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          markCancelOptions(context);
                        });
                      },
                      child: Text(
                        "Mark cancelled",
                        style: textStyle.smallTextColorDark.copyWith(
                            color: colorDark,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Visibility deliveredWidget(BuildContext context) {
    return Visibility(
      visible: steps == 3 ? true : false,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "mintraz order id",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Text(
                widget.orderId,
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${OrderApi.storeTitle} order #",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Row(
                children: [
                  Text(
                    OrderApi.storeOrderId,
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                  const SizedBox(
                    width: constants.defaultPadding / 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        clickEdit = 0;
                        showEditOptions(context, 0);
                      });
                      customPrint("1st flip edit ");
                    },
                    child: Text(
                      "Edit",
                      style: textStyle.smallTextColorDark.copyWith(
                          color: colorHeadingText,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking id",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Row(
                children: [
                  Text(
                    OrderApi.trackingId,
                    style:
                        textStyle.smallText.copyWith(color: colorHeadingText),
                  ),
                  const SizedBox(
                    width: constants.defaultPadding / 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        clickEdit = 1;
                        showEditOptions(context, 1);
                      });
                      customPrint(" edit ");
                    },
                    child: Text(
                      "Edit",
                      style: textStyle.smallTextColorDark.copyWith(
                          color: colorHeadingText,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Status",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Text(
                OrderApi.deliveredStatus == "0"
                    ? "Your order on the way"
                    : "Your order was delivered",
                style: textStyle.smallText.copyWith(
                  color: OrderApi.deliveredStatus == "0"
                      ? colorWarning
                      : colorSuccess,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Visibility paymentWidget() {
    return Visibility(
      visible: steps == 4 ? true : false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total you'll receive",
                style: textStyle.subHeading.copyWith(color: colorHeadingText),
              ),
              GestureDetector(
                onTap: () {
                  nextPage(context, SupportPage());
                },
                child: const Icon(
                  Icons.info,
                  size: 22,
                  color: colorSubHeadingText,
                ),
              ),
            ],
          ),
          Text(
            "$rupeeSign ${widget.productTotalReceive}",
            style: textStyle.heading.copyWith(color: colorHeadingText),
          ),
          const Divider(
            thickness: 0.2,
            color: colorHeadingText,
            height: constants.defaultPadding * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Date",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Text(
                OrderApi.orderDate,
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mintraz order id",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Text(
                widget.orderId,
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${OrderApi.storeTitle} order #",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Text(
                OrderApi.storeOrderId,
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking id",
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
              Text(
                OrderApi.trackingId,
                style: textStyle.smallText.copyWith(color: colorHeadingText),
              ),
            ],
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Visibility(
            visible: OrderApi.isPayoutRequested == "1" ? true : false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transaction id",
                  style: textStyle.smallText.copyWith(color: colorHeadingText),
                ),
                Text(
                  OrderApi.orderTransactionId,
                  style: textStyle.smallText.copyWith(color: colorHeadingText),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: constants.defaultPadding,
          ),
          Visibility(
            visible: OrderApi.isPayoutRequested == "1" ? true : false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pay out",
                  style: textStyle.smallText.copyWith(color: colorHeadingText),
                ),
                Text(OrderApi.isPayout == "0" ?
                  "Payment is processing" : "Payment is done",
                  style: textStyle.smallText.copyWith(color: colorHeadingText),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 0.2,
            color: colorHeadingText,
            height: constants.defaultPadding * 3,
          ),
          Visibility(
            visible: OrderApi.isPayoutRequested == "0" ? true : false,
            child: NewButton(
              context: context,
              function: () {
                setState(() {
                  loading = true;

                });
                HomeApi.withdrawalRequests(context, widget.orderId).then((value) {
                  // OrderApi.getOrdersByOrderId(context, widget.orderId).then((value) {
                    setState(() {
                      loading = false;
                    });
                    nextPage(context, HomePage());
                  // });
                });
              },
              buttonText: "Request for payout",
            ),
          )
        ],
      ),
    );
  }

  void showEditOptions(BuildContext context, value) {
    if (value == 1) {
      editController.text = OrderApi.trackingId;
    } else {
      editController.text = OrderApi.storeOrderId;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context,_setState) {
            return AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Update Jio Mart order #",
                    style: textStyle.subHeading.copyWith(color: colorHeadingText),
                  ),
                  SizedBox(
                    height: 46.h,
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        _setState(() {});
                      },
                      controller: editController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Enter your OTP/PIN",
                        hintStyle: textStyle.subHeading
                            .copyWith(color: colorSubHeadingText),
                      ),
                    ),
                  ),
                  NewButton(
                    context: context,
                    buttonText: "Save",
                    height: 36.h,
                    enable: editController.text.trim().length == 15
                        ? true
                        : false,
                    textStyle: textStyle.button.copyWith(fontSize: 14.sp),
                    margin: const EdgeInsets.symmetric(
                      horizontal: constants.defaultPadding / 2,
                    ),
                    function: () {
                      Navigator.pop(context);
                      setState(() {
                        loading = true;
                      });
                      if (value == 1) {
                        trackingIdController.text =editController.text;
                      } else {
                        fliporderController.text =  editController.text;
                      }
                      customPrint("steps : $steps");
                      OrderApi.updateOrderForm(
                              context,
                              fliporderController.text.trim(),
                              trackingIdController.text.trim(),
                              'NA',
                              'NA',
                              orderDeliveryOtpController.text.trim(),
                              widget.orderId)
                          .then((value) {
                        OrderApi.getOrdersByOrderId(context, widget.orderId)
                            .then((value) {
                          setState(() {
                            loading = false;
                          });
                        });
                      });
                      // OrderApi.updateOrderForm(
                      //     context,
                      //     fliporderController.text
                      //         .trim(),
                      //     trackingIdController.text
                      //         .trim(),
                      //     'NA',
                      //     'NA',
                      //     orderDeliveryOtpController
                      //         .text
                      //         .trim());
                    },
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  void markCancelOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Do you really want to cancel?",
                style: textStyle.subHeading.copyWith(color: colorHeadingText),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(color: colorDark),
              ),
              onPressed: () async {
                Navigator.pop(context);
                setState(() {
                  loading = true;
                });
                HomeApi.cancelOrder(_context, widget.orderId).then((value) {
                  setState(() {
                    loading=false;
                  });
                  if(value == "1"){

                    nextPage(_context, HomePage());

                  }
                });
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(color: colorDark),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Widget detailsWidget(String title, String value) {
    return InkWell(
      onTap: () {
        // if (value == " ") {
        //   return;
        // }
        copyToClipboard(context, value);
      },
      child: Row(
        children: [
          Text(
            title == " " ? " " : title,
            style:
                textStyle.smallTextColorDark.copyWith(color: colorHeadingText),
          ),
          Expanded(
            child: Text(
              value,
              style: textStyle.smallText.copyWith(color: colorHeadingText),
            ),
          ),
          Image.asset(
            "images/copyicon.png",
            height: 8.h,
            width: 8.w,
          ),
        ],
      ),
    );
  }

  Widget detailsWidgetCard(String title, String value) {
    return Row(
      children: [
        Text(
          title == " " ? " " : title,
          style: textStyle.smallText.copyWith(color: colorHeadingText),
        ),
        Expanded(
          child: Text(
            value,
            style:
                textStyle.smallTextColorDark.copyWith(color: colorHeadingText),
          ),
        ),
      ],
    );
  }
}
