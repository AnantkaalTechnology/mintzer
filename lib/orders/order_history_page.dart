import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/deal/order_detail_page.dart';
import 'package:mintzer/home/api.dart';
import 'package:mintzer/orders/api.dart';
import 'package:mintzer/orders/complete_order_page.dart';
import 'package:mintzer/orders/update_order_details.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';
import 'package:shimmer/shimmer.dart';

import '../Widgets/new_button.dart';
import '../globalVariable.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderApi.getOrders(context).then((value) {
      setState(() {});
    });
    HomeApi.getDealsByStores(context).then((value) {
      setState(() {});
    });

    HomeApi.getStoresList(context).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Padding(
        padding: const EdgeInsets.only(
          top: constants.defaultPadding * 3,
          left: constants.defaultPadding,
          right: constants.defaultPadding,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Your Orders",
                style: textStyle.heading,
              ),
            ),
            const SizedBox(
              height: constants.defaultPadding,
            ),
            Flexible(
              child: ListView.builder(
                itemCount: getStaticCount(OrderApi.orderTitle.length),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      nextPage(
                          context,
                          OrderDetailPage(
                            productImage: HomeApi.dealImage[index],
                            productTitle: HomeApi.dealTitle[index],
                            productOfferTitle: HomeApi.dealOfferTitle[index],
                            productOfferText: HomeApi.dealOfferText[index],
                            productYouSpend: HomeApi.dealYouSpend[index],
                            productTotalEarn: HomeApi.dealTotalEarnings[index],
                            productCashback: HomeApi.dealCashback[index],
                            productTotalReceive: HomeApi.dealYouReceive[index],
                            productLink: HomeApi.dealOfferLink[index],
                            productDealId: HomeApi.dealerId[index],
                            dealId: HomeApi.dealId[index],
                            orderQuantity: HomeApi.dealOrderQuantity[index],
                          ));
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: constants.defaultPadding),
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.borderRadius,
                        side: const BorderSide(
                            width: 0.2, color: colorSubHeadingText),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(constants.defaultPadding),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order Id",
                                  style: textStyle.smallText
                                      .copyWith(color: colorHeadingText),
                                ),
                                SizedBox(
                                  width: constants.defaultPadding,
                                ),
                                Text(
                                  OrderApi.orderId[index],
                                  style: textStyle.smallTextColorDark
                                      .copyWith(color: colorHeadingText),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: constants.defaultPadding / 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "You spent",
                                        style: textStyle.smallText,
                                      ),
                                      Card(
                                        // color: colorCustom.shade100,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: constants.borderRadius,
                                          side: BorderSide(
                                              width: 1, color: colorCustom),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  constants.defaultPadding *
                                                      1.5,
                                              vertical:
                                                  constants.defaultPadding / 2),
                                          child: Text(
                                            "$rupeeSign ${OrderApi.orderYouSpend[index]}",
                                            style: textStyle.smallTextColorDark
                                                .copyWith(color: colorCustom),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "You'll receive",
                                        style: textStyle.smallText,
                                      ),
                                      Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: constants.borderRadius,
                                          side: BorderSide(
                                              width: 0.4,
                                              color: colorSubHeadingText),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  constants.defaultPadding *
                                                      1.5,
                                              vertical:
                                                  constants.defaultPadding / 2),
                                          child: Text(
                                            "$rupeeSign ${getTotalReceive(index)}",
                                            style: textStyle.smallTextColorDark
                                                .copyWith(
                                                    color: colorHeadingText),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Total earnings",
                                        style: textStyle.smallText,
                                      ),
                                      Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: constants.borderRadius,
                                          side: BorderSide(
                                              width: 0.4,
                                              color: colorSubHeadingText),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  constants.defaultPadding *
                                                      1.5,
                                              vertical:
                                                  constants.defaultPadding / 2),
                                          child: Text(
                                            "$rupeeSign ${OrderApi.orderTotalEarning[index]}",
                                            style: textStyle.smallTextColorDark
                                                .copyWith(
                                                    color: colorHeadingText),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: constants.defaultPadding,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeInImage.assetNetwork(
                                  placeholder: "images/logo_dark.png",
                                  image: OrderApi.orderImage[index],
                                  height: 111.h,
                                  fit: BoxFit.fill,
                                  // width: 99,
                                  imageErrorBuilder: imageErrorBuilder,
                                  placeholderFit: BoxFit.none,
                                ),
                                SizedBox(
                                  width: constants.defaultPadding,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 88.w,
                                        child: Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                constants.borderRadius,
                                            side: const BorderSide(
                                                width: 0.4,
                                                color: colorWarning),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical:
                                                    constants.defaultPadding /
                                                        8,
                                                horizontal:
                                                    constants.defaultPadding /
                                                        4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.verified,
                                                  size: 12,
                                                  color: colorWarning,
                                                ),
                                                SizedBox(
                                                  width:
                                                      constants.defaultPadding /
                                                          4,
                                                ),
                                                Text(
                                                  "Accepted",
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                          color: colorWarning)
                                                      .copyWith(
                                                          fontSize: 10.sp),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        OrderApi.orderTitle[index],
                                        style: textStyle.subHeadingColorDark,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.verified,
                                            color: colorSuccess,
                                            size: 12,
                                          ),
                                          SizedBox(
                                            width: constants.defaultPadding / 4,
                                          ),
                                          Text(
                                            "Verified Product",
                                            style: textStyle.smallText.copyWith(
                                                color: colorHeadingText),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.credit_card,
                                            color: colorHeadingText,
                                            size: 12,
                                          ),
                                          SizedBox(
                                            width: constants.defaultPadding / 4,
                                          ),
                                          Text(
                                            "Flipkart Card",
                                            style: textStyle.smallText.copyWith(
                                                color: colorHeadingText),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "Flipkart Order #",
                                        style: textStyle.smallText
                                            .copyWith(color: colorHeadingText),
                                      ),
                                      SizedBox(
                                        height: 46.h,
                                        width: double.infinity,
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          keyboardType: TextInputType.number,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "999-999999-999999",
                                            hintStyle: textStyle.subHeading
                                                .copyWith(
                                                    color: colorSubHeadingText),
                                          ),
                                        ),
                                      ),

                                      ///------------save button-------------
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: NewButton(
                                                context: context,
                                                buttonText: "Save",
                                                height: 36.h,
                                                textStyle: textStyle.button
                                                    .copyWith(fontSize: 14.sp),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      constants.defaultPadding /
                                                          2,
                                                ),
                                                function: () {}),
                                          ),

                                          ///order now button--------------
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "haven't placed the order",
                                                  style: textStyle.smallText,
                                                ),
                                                Text(
                                                  "Order Now>",
                                                  style: textStyle
                                                      .smallTextColorDark
                                                      .copyWith(
                                                          color: colorDark),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                  return Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.borderRadius,
                      side: const BorderSide(
                          width: 0.2, color: colorSubHeadingText),
                    ),
                    elevation: 0,
                    child: OrderApi.orderTitle.isEmpty
                        ? Shimmer.fromColors(
                            baseColor: colorWhite,
                            highlightColor: colorDisable,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ///----------title------
                                Container(
                                  height: 190.h,
                                  color: colorDisable,
                                ),
                                const SizedBox(
                                  height: constants.defaultPadding / 4,
                                ),

                                ///---------description---------
                                Container(
                                  height: 44.h,
                                  color: colorDisable,
                                ),
                                const SizedBox(
                                  height: constants.defaultPadding,
                                ),
                                Container(
                                  height: 36.h,
                                  color: colorDisable,
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    constants.defaultPadding),

                                ///---------Image
                                child: FadeInImage.assetNetwork(
                                  placeholder: "images/logo_dark.png",
                                  image: OrderApi.orderImage[index],
                                  height: 150.h,
                                  width: double.infinity,
                                  // fit: BoxFit.fill,
                                  imageErrorBuilder: imageErrorBuilder,
                                  placeholderFit: BoxFit.none,
                                ),
                              ),
                              Container(
                                height: 144.h,
                                width: double.infinity,
                                padding: const EdgeInsets.all(
                                    constants.defaultPadding),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft:
                                          Radius.circular(constants.radius),
                                      bottomRight:
                                          Radius.circular(constants.radius),
                                    ),
                                    color: colorCardWhite),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ///----------title------
                                          Text(
                                            OrderApi.orderTitle[index],
                                            style: textStyle.smallTextColorDark
                                                .copyWith(
                                                    color: colorHeadingText),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                          //
                                          // ///---------description---------
                                          Text(
                                            "Store Name : ${OrderApi.orderStoreName[index]}",
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.smallText.copyWith(
                                                color: colorHeadingText),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: NewButton(
                                          margin: const EdgeInsets.only(
                                              bottom: constants.defaultPadding),
                                          height: 36,
                                          context: context,
                                          color: OrderApi.orderStatus[index]
                                                      .toString() ==
                                                  "0"
                                              ? colorDark
                                              : colorSuccess,
                                          textStyle: textStyle.subButton
                                              .copyWith(fontSize: 12),
                                          function: () {
                                            if (OrderApi.orderStatus[index]
                                                    .toString() ==
                                                "0") {
                                              nextPage(
                                                  context,
                                                  CompleteOrderPage(
                                                    productImage: OrderApi
                                                        .orderImage[index],
                                                    productTitle: OrderApi
                                                        .orderTitle[index],
                                                    orderId:
                                                        OrderApi.orderId[index],
                                                    youSpend: OrderApi
                                                        .orderYouSpend[index],
                                                    totalEarning: OrderApi
                                                            .orderTotalEarning[
                                                        index],
                                                    storeName: OrderApi
                                                        .orderStoreName[index],
                                                    orderStatus: OrderApi
                                                        .orderStatus[index],
                                                    orderMainId: OrderApi
                                                        .orderMainId[index],
                                                  ));
                                            } else {
                                              nextPage(
                                                  context,
                                                  UpdateOrderDetails(
                                                    productImage: OrderApi
                                                        .orderImage[index],
                                                    productTitle: OrderApi
                                                        .orderTitle[index],
                                                    orderId:
                                                        OrderApi.orderId[index],
                                                    youSpend: OrderApi
                                                        .orderYouSpend[index],
                                                    totalEarning: OrderApi
                                                            .orderTotalEarning[
                                                        index],
                                                    storeName: OrderApi
                                                        .orderStoreName[index],
                                                    orderStatus: OrderApi
                                                        .orderStatus[index],
                                                    orderMainId: OrderApi
                                                        .orderMainId[index],
                                                  ));
                                            }
                                          },
                                          buttonText: OrderApi
                                                      .orderStatus[index]
                                                      .toString() ==
                                                  "0"
                                              ? "Complete Order"
                                              : "Completed"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> _pullRefresh() async {
    await delay(1000);
    OrderApi.getOrders(context).then((value) {
      setState(() {});
    });
  }

  Widget imageErrorBuilder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    return const Center(
        child: Icon(
      Icons.error_outline_rounded,
      color: colorError,
    ));
  }

  getTotalReceive(int index) {
    double sum = 0;
    sum = double.parse(OrderApi.orderYouSpend[index]) +
        double.parse(OrderApi.orderTotalEarning[index]);
    return sum.toStringAsFixed(0);
  }
}
