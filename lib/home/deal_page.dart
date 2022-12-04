import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/home/api.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';
import 'package:shimmer/shimmer.dart';

import '../Widgets/new_button.dart';
import '../deal/order_detail_page.dart';
import '../globalVariable.dart';

class DealPage extends StatefulWidget {
  const DealPage({Key? key}) : super(key: key);

  @override
  _DealPageState createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  List<String> items = [
    "images/searchicon.png",
    "images/amazon.png",
    "images/one_plus.png",
    "images/apple.png",
    "images/flipkart.png",
  ];
  List<String> dealitem = [
    "images/demophone2.png",
    "images/demophone2.png",
    "images/demophone2.png",
    "images/demophone2.png",
    "images/demophone2.png",
    "images/demophone2.png",
  ];

  int selected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                "Today's Exclusive Deals",
                style: textStyle.heading,
              ),
            ),
            const SizedBox(
              height: constants.defaultPadding,
            ),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: HomeApi.storeImage.length + 1,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                          HomeApi.getDealsByStores(context).then((value) {
                            setState(() {});
                          });
                        },
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: constants.borderRadius,
                              side: BorderSide(
                                  color: index == selected
                                      ? colorDark
                                      : colorSubHeadingText,
                                  width: index == selected ? 2.0 : 0.5)),
                          color: Colors.transparent,
                          child: Padding(
                            padding:
                                const EdgeInsets.all(constants.defaultPadding),
                            child: Text("All"),
                          ),
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                        HomeApi.getDealsByStoresId(
                                context, HomeApi.storeId[index - 1])
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: constants.borderRadius,
                            side: BorderSide(
                                color: index == selected
                                    ? colorDark
                                    : colorSubHeadingText,
                                width: index == selected ? 2.0 : 0.5)),
                        color: Colors.transparent,
                        child: Padding(
                          padding:
                              const EdgeInsets.all(constants.defaultPadding),
                          child: FadeInImage.assetNetwork(
                            placeholder: "images/logo_dark.png",
                            image: HomeApi.storeImage[index - 1],
                            placeholderFit: BoxFit.none,
                            imageErrorBuilder: imageErrorBuilder,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: constants.defaultPadding,
            ),
            Flexible(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: GridView.builder(
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  physics: const BouncingScrollPhysics(),

                  itemCount: getStaticCount(HomeApi.dealTitle.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: constants.defaultPadding,
                    mainAxisSpacing: constants.defaultPadding,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.borderRadius,
                        side: const BorderSide(
                            width: 0.2, color: colorSubHeadingText),
                      ),
                      elevation: 0,
                      child: HomeApi.dealTitle.isEmpty
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
                          : GestureDetector(
                              onTap: () {
                                nextPage(
                                    context,
                                    OrderDetailPage(
                                      productImage: HomeApi.dealImage[index],
                                      productTitle: HomeApi.dealTitle[index],
                                      productOfferTitle:
                                          HomeApi.dealOfferTitle[index],
                                      productOfferText:
                                          HomeApi.dealOfferText[index],
                                      productYouSpend:
                                          HomeApi.dealYouSpend[index],
                                      productTotalEarn:
                                          HomeApi.dealTotalEarnings[index],
                                      productCashback:
                                          HomeApi.dealCashback[index],
                                      productTotalReceive:
                                          HomeApi.dealYouReceive[index],
                                      productLink: HomeApi.dealOfferLink[index],
                                      productDealId: HomeApi.dealerId[index],
                                      dealId: HomeApi.dealId[index],
                                      orderQuantity:
                                          HomeApi.dealOrderQuantity[index],
                                      orderPage: 0,
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            constants.defaultPadding),

                                        ///---------Image
                                        child: FadeInImage.assetNetwork(
                                          placeholder: "images/logo_dark.png",
                                          image: HomeApi.dealImage[index],
                                          height: 150.h,
                                          width: double.infinity,
                                          // fit: BoxFit.fill,
                                          placeholderFit: BoxFit.none,
                                          imageErrorBuilder: imageErrorBuilder,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          // height: 144.h,
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(
                                              constants.defaultPadding),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    constants.radius),
                                                bottomRight: Radius.circular(
                                                    constants.radius),
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
                                                      HomeApi.dealTitle[index],
                                                      style: textStyle
                                                          .smallTextColorDark
                                                          .copyWith(
                                                              color:
                                                                  colorHeadingText),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                    ),

                                                    ///---------description---------
                                                    Text(
                                                      HomeApi.dealDescription[
                                                          index],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: textStyle.smallText
                                                          .copyWith(
                                                              color:
                                                                  colorHeadingText),
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: NewButton(
                                                  margin: const EdgeInsets.only(
                                                      left: constants
                                                          .defaultPadding,
                                                      right: constants
                                                          .defaultPadding,
                                                      bottom: constants
                                                          .defaultPadding),
                                                  height: 36,
                                                  context: context,
                                                  textStyle:
                                                      textStyle.subButton,
                                                  function: () {
                                                    nextPage(
                                                        context,
                                                        OrderDetailPage(
                                                          productImage: HomeApi
                                                              .dealImage[index],
                                                          productTitle: HomeApi
                                                              .dealTitle[index],
                                                          productOfferTitle:
                                                              HomeApi.dealOfferTitle[
                                                                  index],
                                                          productOfferText:
                                                              HomeApi.dealOfferText[
                                                                  index],
                                                          productYouSpend: HomeApi
                                                                  .dealYouSpend[
                                                              index],
                                                          productTotalEarn:
                                                              HomeApi.dealTotalEarnings[
                                                                  index],
                                                          productCashback: HomeApi
                                                                  .dealCashback[
                                                              index],
                                                          productTotalReceive:
                                                              HomeApi.dealYouReceive[
                                                                  index],
                                                          productLink: HomeApi
                                                                  .dealOfferLink[
                                                              index],
                                                          productDealId: HomeApi
                                                              .dealerId[index],
                                                          dealId: HomeApi
                                                              .dealId[index],
                                                          orderQuantity: HomeApi
                                                                  .dealOrderQuantity[
                                                              index],
                                                        ));
                                                  },
                                                  buttonText:
                                                      "Earn ${HomeApi.dealTotalEarnings[index]}",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: constants.defaultPadding / 2),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "images/logo_dark.png",
                                        image: HomeApi.storeImage[index],
                                        height: 28.h,
                                        width: 44.w,
                                        // fit: BoxFit.fill,
                                        placeholderFit: BoxFit.none,
                                        // imageErrorBuilder: imageErrorBuilder,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _pullRefresh() async {
    await delay(1000);
    HomeApi.getDealsByStores(context).then((value) {
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
}
