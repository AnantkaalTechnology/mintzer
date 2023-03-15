// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/api/database_api.dart';
import 'package:mintzer/deal/order_detail_page.dart';
import 'package:mintzer/deal/order_page.dart';
import 'package:mintzer/home/api.dart';
// import 'package:mintzer/model/orders_model.dart';
import 'package:mintzer/orders/api.dart';
// import 'package:mintzer/orders/complete_order_page.dart';
// import 'package:mintzer/orders/update_order_details.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';

// import 'package:shimmer/shimmer.dart';

import '../Widgets/new_button.dart';
import '../globalVariable.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  // final fliporderController = TextEditingController();
  int textedit = 0;
  int firstShow = 0;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderApi.getOrders(context).then((value) {
      for (int i = 0; i < (OrderApi.ordersModel?.orders.length ?? 0); i++) {
        OrderApi.controllerList.add(TextEditingController());
      }
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
        backgroundColor: colorCardWhite,
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
                  child: (OrderApi.ordersModel?.orders.length ?? 0) > 0
                      ? ListView.builder(
                          itemCount: getStaticCount(
                              OrderApi.ordersModel!.orders.length),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                nextPage(
                                    context,
                                    OrderDetailPage(
                                      dealDiscount: OrderApi
                                          .ordersModel!.orders[index].discount,
                                      dealerPrice: OrderApi.ordersModel!
                                          .orders[index].dealersPrice,
                                      orderPage: 1,
                                      orderId: OrderApi
                                          .ordersModel!.orders[index].orderId,
                                      productImage: DatabaseApi.imageUrl +
                                          OrderApi.ordersModel!.orders[index]
                                              .dealImage,
                                      productPrice:
                                          HomeApi.dealProductPrice[index],
                                      productTitle: OrderApi
                                          .ordersModel!.orders[index].dealTitle,
                                      productOfferTitle: OrderApi.ordersModel!
                                          .orders[index].offerTitle,
                                      productOfferText: OrderApi
                                          .ordersModel!.orders[index].offerText,
                                      productYouSpend: OrderApi.ordersModel!
                                          .orders[index].youWillSpend,
                                      productTotalEarn: OrderApi.ordersModel!
                                          .orders[index].totalEarnings,
                                      productCashback: OrderApi
                                          .ordersModel!.orders[index].cashback,
                                      productTotalReceive: OrderApi.ordersModel!
                                          .orders[index].totalYouWillReceive,
                                      productLink: OrderApi
                                          .ordersModel!.orders[index].offerLink,
                                      productDealId: OrderApi
                                          .ordersModel!.orders[index].dealerId,
                                      dealId: OrderApi
                                          .ordersModel!.orders[index].id,
                                      orderQuantity: OrderApi.ordersModel!
                                          .orders[index].orderQuantity,
                                    ));
                              },
                              child: Card(
                                color: colorWhite,
                                margin: const EdgeInsets.only(
                                    bottom: constants.defaultPadding),
                                shape: RoundedRectangleBorder(
                                  borderRadius: constants.borderRadius,
                                  side: const BorderSide(
                                      width: 1, color: colorSubHeadingText),
                                ),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      constants.defaultPadding),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Order Id",
                                            style: textStyle.smallText.copyWith(
                                                color: colorHeadingText),
                                          ),
                                          const SizedBox(
                                            width: constants.defaultPadding,
                                          ),
                                          Text(
                                            OrderApi.ordersModel!.orders[index]
                                                .orderId,
                                            style: textStyle.smallTextColorDark
                                                .copyWith(
                                                    color: colorHeadingText),
                                          ),
                                        ],
                                      ),

                                      ///
                                      // const SizedBox(
                                      //   height: constants.defaultPadding / 2,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Expanded(
                                      //       child: Column(
                                      //         children: [
                                      //           Text(
                                      //             "You spent",
                                      //             style: textStyle.smallText,
                                      //           ),
                                      //           Card(
                                      //             // color: colorCustom.shade100,
                                      //             elevation: 0,
                                      //             shape: RoundedRectangleBorder(
                                      //               borderRadius: constants.borderRadius,
                                      //               side: BorderSide(
                                      //                   width: 1, color: colorCustom),
                                      //             ),
                                      //             child: Padding(
                                      //               padding: const EdgeInsets.symmetric(
                                      //                   horizontal:
                                      //                       constants.defaultPadding *
                                      //                           1.5,
                                      //                   vertical:
                                      //                       constants.defaultPadding / 2),
                                      //               child: Text(
                                      //                 "$rupeeSign ${OrderApi.ordersModel!.orders[index].youWillSpend}",
                                      //                 style: textStyle.smallTextColorDark
                                      //                     .copyWith(color: colorCustom),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     Expanded(
                                      //       child: Column(
                                      //         children: [
                                      //           Text(
                                      //             "You'll receive",
                                      //             style: textStyle.smallText,
                                      //           ),
                                      //           Card(
                                      //             elevation: 0,
                                      //             shape: RoundedRectangleBorder(
                                      //               borderRadius: constants.borderRadius,
                                      //               side: const BorderSide(
                                      //                   width: 0.4,
                                      //                   color: colorSubHeadingText),
                                      //             ),
                                      //             child: Padding(
                                      //               padding: const EdgeInsets.symmetric(
                                      //                   horizontal:
                                      //                       constants.defaultPadding *
                                      //                           1.5,
                                      //                   vertical:
                                      //                       constants.defaultPadding / 2),
                                      //               child: Text(
                                      //                 "$rupeeSign ${getTotalReceive(index)}",
                                      //                 style: textStyle.smallTextColorDark
                                      //                     .copyWith(
                                      //                         color: colorHeadingText),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     Expanded(
                                      //       child: Column(
                                      //         children: [
                                      //           Text(
                                      //             "Total earnings",
                                      //             style: textStyle.smallText,
                                      //           ),
                                      //           Card(
                                      //             elevation: 0,
                                      //             shape: RoundedRectangleBorder(
                                      //               borderRadius: constants.borderRadius,
                                      //               side: const BorderSide(
                                      //                   width: 0.4,
                                      //                   color: colorSubHeadingText),
                                      //             ),
                                      //             child: Padding(
                                      //               padding: const EdgeInsets.symmetric(
                                      //                   horizontal:
                                      //                       constants.defaultPadding *
                                      //                           1.5,
                                      //                   vertical:
                                      //                       constants.defaultPadding / 2),
                                      //               child: Text(
                                      //                 "$rupeeSign ${OrderApi.ordersModel!.orders[index].totalEarnings}",
                                      //                 style: textStyle.smallTextColorDark
                                      //                     .copyWith(
                                      //                         color: colorHeadingText),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(
                                        height: constants.defaultPadding,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FadeInImage.assetNetwork(
                                            placeholder: "images/logo_dark.png",
                                            image: DatabaseApi.imageUrl +
                                                OrderApi.ordersModel!
                                                    .orders[index].image,
                                            height: 111.h,
                                            fit: BoxFit.fill,
                                            // width: 99,
                                            imageErrorBuilder:
                                                imageErrorBuilder,
                                            placeholderFit: BoxFit.none,
                                          ),
                                          const SizedBox(
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius: constants
                                                          .borderRadius,
                                                      side: BorderSide(
                                                          width: 0.4,
                                                          color: OrderApi
                                                                  .ordersModel!
                                                                  .orders[index]
                                                                  .storeOrderId
                                                                  .isEmpty
                                                              ? colorWarning
                                                              : colorSuccess),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          vertical: constants
                                                                  .defaultPadding /
                                                              8,
                                                          horizontal: constants
                                                                  .defaultPadding /
                                                              4),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Visibility(
                                                            visible: OrderApi
                                                                    .ordersModel!
                                                                    .orders[
                                                                        index]
                                                                    .storeOrderId
                                                                    .isEmpty
                                                                ? false
                                                                : true,
                                                            child: Icon(
                                                              Icons.verified,
                                                              size: 12,
                                                              color: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .storeOrderId
                                                                      .isEmpty
                                                                  ? colorWarning
                                                                  : colorSuccess,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: constants
                                                                    .defaultPadding /
                                                                4,
                                                          ),
                                                          Text(
                                                            OrderApi
                                                                    .ordersModel!
                                                                    .orders[
                                                                        index]
                                                                    .storeOrderId
                                                                    .isEmpty
                                                                ? "Created"
                                                                : "Completed",
                                                            style: textStyle
                                                                .smallText
                                                                .copyWith(
                                                                    color: OrderApi
                                                                            .ordersModel!
                                                                            .orders[
                                                                                index]
                                                                            .storeOrderId
                                                                            .isEmpty
                                                                        ? colorWarning
                                                                        : colorSuccess)
                                                                .copyWith(
                                                                    fontSize:
                                                                        10.sp),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  OrderApi.ordersModel!
                                                      .orders[index].title,
                                                  style: textStyle
                                                      .subHeadingColorDark,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.verified,
                                                      color: colorSuccess,
                                                      size: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: constants
                                                              .defaultPadding /
                                                          4,
                                                    ),
                                                    Text(
                                                      "Verified Product",
                                                      style: textStyle.smallText
                                                          .copyWith(
                                                              color:
                                                                  colorHeadingText),
                                                    )
                                                  ],
                                                ),
                                                // Row(
                                                //   children: [
                                                //     const Icon(
                                                //       Icons.credit_card,
                                                //       color: colorHeadingText,
                                                //       size: 12,
                                                //     ),
                                                //     const SizedBox(
                                                //       width: constants.defaultPadding / 4,
                                                //     ),
                                                //     Text(
                                                //       "Flipkart Card",
                                                //       style: textStyle.smallText.copyWith(
                                                //           color: colorHeadingText),
                                                //     )
                                                //   ],
                                                // ),
                                                Text(
                                                  "${OrderApi.ordersModel!.orders[index].storeName} Order",
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                          color:
                                                              colorHeadingText),
                                                ),
                                                Visibility(
                                                  visible: OrderApi
                                                          .ordersModel!
                                                          .orders[index]
                                                          .storeOrderId
                                                          .isEmpty
                                                      ? true
                                                      : false,
                                                  child: SizedBox(
                                                    height: 46.h,
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        setState(() {});
                                                      },
                                                      controller: OrderApi
                                                              .controllerList[
                                                          index],
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      // keyboardType: TextInputType.number,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "999-999999-999999",
                                                        hintStyle: textStyle
                                                            .subHeading
                                                            .copyWith(
                                                                color:
                                                                    colorSubHeadingText),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                ///------------save button-------------
                                                Visibility(
                                                  visible: OrderApi
                                                          .ordersModel!
                                                          .orders[index]
                                                          .storeOrderId
                                                          .isEmpty
                                                      ? true
                                                      : false,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: NewButton(
                                                          context: context,
                                                          buttonText: "Save",
                                                          height: 36.h,
                                                          enable: OrderApi
                                                                      .controllerList[
                                                                          index]
                                                                      .text
                                                                      .trim()
                                                                      .length ==
                                                                  20
                                                              ? true
                                                              : false,
                                                          textStyle: textStyle
                                                              .button
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.sp),
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: constants
                                                                    .defaultPadding /
                                                                2,
                                                          ),
                                                          function: () {
                                                            setState(() {
                                                              loading = true;
                                                            });

                                                            OrderApi
                                                                .updateOrderForm(
                                                              context,
                                                              OrderApi
                                                                  .controllerList[
                                                                      index]
                                                                  .text
                                                                  .trim(),
                                                              '',
                                                              '',
                                                              '',
                                                              '',
                                                              OrderApi
                                                                  .ordersModel!
                                                                  .orders[index]
                                                                  .orderId,
                                                              '',
                                                            ).then((value) {
                                                              OrderApi.getOrders(
                                                                      context)
                                                                  .then(
                                                                      (value) {
                                                                OrderApi
                                                                    .controllerList
                                                                    .clear();
                                                                for (int i = 0;
                                                                    i <
                                                                        (OrderApi.ordersModel?.orders.length ??
                                                                            0);
                                                                    i++) {
                                                                  OrderApi
                                                                      .controllerList
                                                                      .add(
                                                                          TextEditingController());
                                                                }

                                                                customPrint(
                                                                    "getOrders Refresh :: ${OrderApi.controllerList.length}");
                                                                setState(() {
                                                                  loading =
                                                                      false;
                                                                });
                                                              });
                                                            });
                                                          },
                                                        ),
                                                      ),

                                                      ///order now button--------------
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            nextPage(
                                                                context,
                                                                OrderPage(
                                                                  productImage: DatabaseApi
                                                                          .imageUrl +
                                                                      OrderApi
                                                                          .ordersModel!
                                                                          .orders[
                                                                              index]
                                                                          .dealImage,
                                                                  productTitle: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .dealTitle,
                                                                  productOfferTitle: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .offerTitle,
                                                                  productOfferText: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .offerText,
                                                                  productYouSpend: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .youWillSpend,
                                                                  productTotalEarn: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .totalEarnings,
                                                                  productCashback: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .cashback,
                                                                  productTotalReceive: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .totalYouWillReceive,
                                                                  productPrice: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .productPrice,
                                                                  productLink: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .offerLink,
                                                                  productDealId: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .dealerId,
                                                                  dealId: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .id,
                                                                  orderQuantity: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .orderQuantity,
                                                                  // orderNow: false,
                                                                  dealDiscount: OrderApi
                                                                      .ordersModel!
                                                                      .orders[
                                                                          index]
                                                                      .discount,
                                                                ));
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "haven't placed the order",
                                                                style: textStyle
                                                                    .smallText,
                                                              ),
                                                              Text(
                                                                "Order Now>",
                                                                style: textStyle
                                                                    .smallTextColorDark
                                                                    .copyWith(
                                                                        color:
                                                                            colorDark),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
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
                          },
                        )
                      : Center(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/notorder.png',
                              height: 200.h,
                              width: 200.w,
                            ),
                            SizedBox(
                              height: constants.defaultPadding,
                            ),
                            Text(
                              "You haven't ordered anything yet",
                              style: textStyle.subHeading,
                            )
                          ],
                        )),
                ),
                SizedBox(
                  height: constants.defaultPadding * 5,
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _pullRefresh() async {
    await delay(1000);
    OrderApi.getOrders(context).then((value) {
      OrderApi.controllerList.clear();
      for (int i = 0; i < (OrderApi.ordersModel?.orders.length ?? 0); i++) {
        OrderApi.controllerList.add(TextEditingController());
      }
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
    sum = double.parse(OrderApi.ordersModel!.orders[index].youWillSpend) +
        double.parse(OrderApi.ordersModel!.orders[index].totalEarnings);
    return sum.toStringAsFixed(0);
  }
}
