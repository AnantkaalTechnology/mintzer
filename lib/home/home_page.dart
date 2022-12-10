import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/feed/support_page.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/home/api.dart';
import 'package:mintzer/home/cards_page.dart';
import 'package:mintzer/home/deal_page.dart';
import 'package:mintzer/home/nav_drawer.dart';
import 'package:mintzer/home/notification_page.dart';
import 'package:mintzer/home/wallet_page.dart';
import 'package:mintzer/orders/api.dart';
import 'package:mintzer/orders/order_history_page.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';
import 'package:shimmer/shimmer.dart';

import '../Widgets/new_button.dart';
import '../Widgets/splash_screen.dart';
import '../deal/order_detail_page.dart';
import '../util/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  List<String> banner = <String>[
    "Jaipur",
    "Delhi",
    "Jodhpur",
    "Bikaner",
    "Mumbai"
  ];
  List<String> sbicard = [
    "images/bannertwo.png",
    "images/bannertwo.png",
    "images/bannertwo.png",
    "images/bannertwo.png",
    "images/bannertwo.png",
  ];

  double containerHeight = 112;
  double containerHeightOfBottom = 55;

  final _controller = ScrollController();

  int currentPage = 4;
  bool splash = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserDetails.getUserDetails(context).then((value) {
      setState(() {
        splash = false;
      });
    });

    HomeApi.getWalletDetails(context);

    HomeApi.getFeeds(context).then((value) {
      setState(() {});
    });

    HomeApi.getBankCards(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        AppExitPopup(context);
        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: splash
            ? const SplaceScreen()
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 55),
                    child: getPage(currentPage),
                  ),
                  bottomNavigationButton(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 66,
                          width: 66,
                          decoration: BoxDecoration(
                              borderRadius: constants.borderRadius * 100,
                              color: colorDark),
                          margin: const EdgeInsets.only(bottom: 10),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentPage = 4;
                            });
                          },
                          child: Card(
                            color: colorWarning,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 6,
                            margin: const EdgeInsets.only(bottom: 22),
                            shape: RoundedRectangleBorder(
                              borderRadius: constants.borderRadius * 100,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  constants.defaultPadding),
                              child: Image.asset(
                                "images/deals.png",
                                width: 22,
                                height: 22,
                                color: colorWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: constants.defaultPadding * 9),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          nextPage(context, const SupportPage());
                        },
                        child: Container(
                          height: 40.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                colorDark50,
                                colorDark501,
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(constants.radius),
                                topLeft: Radius.circular(constants.radius)),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: showDetails ? Colors.grey : Colors.grey.shade50,
                            //     blurRadius: 10.0,
                            //   ),
                            // ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                constants.defaultPadding / 2),
                            child: Image.asset(
                              "images/support.png",
                              color: colorWhite,
                              height: 16.h,
                              width: 16.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        drawer: splash ? Container() : const NavDrawer(),
      ),
    );
  }

  Widget homePageFunction(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: constants.defaultPadding * 3,
              left: constants.defaultPadding,
              right: constants.defaultPadding),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 222),
                height: 80.h,
                // height: containerHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TopNavigationBar(scaffoldKey: _scaffoldKey),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        children: [
                          Text("Hi, ", style: textStyle.heading),
                          Text(
                              "${UserDetails.firstName} ${UserDetails.lastName}",
                              style:
                                  textStyle.heading.copyWith(color: colorDark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  // height: 184.h,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                ),
                items: sbicard.map((index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: colorWhite,
                        ),
                        child: Image.asset(
                          index,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: constants.defaultPadding),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Exclusive Deals",
                    style: textStyle.heading.copyWith(color: colorHeadingText),
                  ),
                ),
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                          : InkWell(
                              onTap: () {
                                nextPage(
                                    context,
                                    OrderDetailPage(

                                      dealerPrice: HomeApi.dealerPrice[index],
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
                                      orderId: "",

                                    ));
                              },
                              child: Column(
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
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                ),

                                                ///---------description---------
                                                Text(
                                                  HomeApi
                                                      .dealDescription[index],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textStyle.smallText
                                                      .copyWith(
                                                          color:
                                                              colorHeadingText),
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
                                                  left:
                                                      constants.defaultPadding,
                                                  right:
                                                      constants.defaultPadding,
                                                  bottom:
                                                      constants.defaultPadding),
                                              height: 36,
                                              context: context,
                                              textStyle: textStyle.subButton,
                                              function: () {
                                                nextPage(
                                                    context,
                                                    OrderDetailPage(
                                                      dealerPrice: HomeApi.dealerPrice[index],
                                                      productImage: HomeApi
                                                          .dealImage[index],
                                                      productTitle: HomeApi
                                                          .dealTitle[index],
                                                      productOfferTitle: HomeApi
                                                              .dealOfferTitle[
                                                          index],
                                                      productOfferText: HomeApi
                                                          .dealOfferText[index],
                                                      productYouSpend: HomeApi
                                                          .dealYouSpend[index],
                                                      productTotalEarn: HomeApi
                                                              .dealTotalEarnings[
                                                          index],
                                                      productCashback: HomeApi
                                                          .dealCashback[index],
                                                      productTotalReceive:
                                                          HomeApi.dealYouReceive[
                                                              index],
                                                      productLink: HomeApi
                                                          .dealOfferLink[index],
                                                      productDealId: HomeApi
                                                          .dealerId[index],
                                                      dealId:
                                                          HomeApi.dealId[index],
                                                      orderQuantity: HomeApi
                                                              .dealOrderQuantity[
                                                          index],
                                                      orderId: OrderApi.orderId[index],

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
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    await delay(1000);
    HomeApi.getFeeds(context).then((value) {
      setState(() {});
    });
  }

  Widget bottomNavigationButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 222),
        width: double.infinity,
        height: containerHeightOfBottom,
        decoration: BoxDecoration(
          color: colorDark,
          // border: Border.all(width: 0.5),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(constants.radius),
              topLeft: Radius.circular(constants.radius)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  bottomOptions("Home", "images/home.png", 0),
                  bottomOptions("Orders", "images/checkout.png", 1),
                  const SizedBox(
                    width: 88,
                  ),
                  bottomOptions("Cards", "images/card.png", 2),
                  bottomOptions("Wallet", "images/wallet.png", 3),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomOptions(String title, String image, int pageIndex) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            currentPage = pageIndex;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              width: 20,
              height: 20,
              color: currentPage == pageIndex ? colorWarning : colorDisable,
            ),
            currentPage == pageIndex
                ? Text(
                    title,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: currentPage == pageIndex
                            ? colorWarning
                            : colorDisable),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget getPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return homePageFunction(context);
      case 1:
        return const OrderHistoryPage();
      case 2:
        return const CardPage();
      case 3:
        return const WalletPage();
      default:
        return const DealPage();
    }
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

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            // Navigator.of(context).push(_createRoute());
            scaffoldKey.currentState.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: colorDark,
            size: 33,
          ),
        ),
        InkWell(
          onTap: () {
            // Navigator.of(context).push(_createRoute1());
            nextPage(context, const NotificationPage());
          },
          child: const Icon(
            Icons.notifications_none,
            color: colorDark,
            size: 33,
          ),
        ),
      ],
    );
  }
}
