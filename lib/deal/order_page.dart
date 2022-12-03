import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/home/api.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:mintzer/util/text_styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderPage extends StatefulWidget {
  const OrderPage(
      {Key? key,
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
      required this.orderQuantity})
      : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();

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
}

class _OrderPageState extends State<OrderPage> {
  bool loading = true;
  String url =
      "https://www.amazon.in/dp/B07WGPL32C/ref=sspa_dk_detail_0?psc=1&pd_rd_i=B07WGPL32C&pd_rd_w=AZDdb&content-id=amzn1.sym.b3dfef88-30a1-490c-be36-e990ef384667&pf_rd_p=b3dfef88-30a1-490c-be36-e990ef384667&pf_rd_r=PP33CFGHS7TYHK60CK24&pd_rd_wg=RHWKJ&pd_rd_r=f89b4109-d3e7-4169-9619-4b34c437b653&s=electronics&sp_csd=d2lkZ2V0TmFtZT1zcF9kZXRhaWw";

  bool showDetails = true;
  bool isDesktopMode = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeApi.createOrder(widget.dealId, context).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // height: 55.h,
              padding: const EdgeInsets.symmetric(
                  horizontal: constants.defaultPadding,
                  vertical: constants.defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productTitle,
                    style: textStyle.heading,
                  ),
                  InkWell(
                    onTap: () {
                      showPopupOptions(context);
                    },
                    child: Image.asset(
                      "images/more.png",
                      height: 18,
                      width: 18,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Stack(
                children: [
                  const Center(child: CircularProgressIndicator()),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: loading ? 0 : 1,
                    child: isDesktopMode && false
                        ? WebView(
                            userAgent:
                                "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.4) Gecko/20100101 Firefox/4.0",
                            onWebViewCreated: (value) {
                              delay(1000).then((value) {
                                setState(() {
                                  loading = false;
                                });
                              });
                            },
                            initialUrl: widget.productLink,
                            javascriptMode: JavascriptMode.unrestricted,
                          )
                        : WebView(
                            onWebViewCreated: (value) {
                              delay(1000).then((value) {
                                setState(() {
                                  loading = false;
                                });
                              });
                            },
                            initialUrl: widget.productLink,
                            javascriptMode: JavascriptMode.unrestricted,
                          ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              height: showDetails ? 206.h : 50.h,
              width: MediaQuery.of(context).size.width,
              duration: const Duration(milliseconds: 222),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(constants.radius),
                    topLeft: Radius.circular(constants.radius)),
                // boxShadow: [
                //   BoxShadow(
                //     color: showDetails ? Colors.grey : Colors.grey.shade50,
                //     blurRadius: 10.0,
                //   ),
                // ],
              ),
              child: showDetails
                  ? Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: CarouselSlider(
                              carouselController: _controller,
                              options: CarouselOptions(
                                // height: 184.h,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  customPrint("index :: $index");
                                  setState(() {
                                    _current = index;
                                  });
                                },

                                autoPlay: false,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: true,
                              ),
                              items: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                              Radius.circular(constants.radius),
                                          topLeft: Radius.circular(
                                              constants.radius)),
                                    ),
                                    margin: EdgeInsets.zero,
                                    // color: colorDark,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: constants.defaultPadding,
                                          vertical:
                                              constants.defaultPadding / 2),
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showDetails = false;
                                                  });
                                                },
                                                child: const Icon(Icons
                                                    .keyboard_arrow_down_sharp),
                                              )),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    detailsWidget("Model",
                                                        widget.productTitle),
                                                    divider(),
                                                    detailsWidget(
                                                        "Variant", "xxx"),
                                                    divider(),
                                                    detailsWidget(
                                                        "Color", "xxx"),
                                                    divider(),
                                                    detailsWidget("QTY", "1"),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: constants.defaultPadding,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    detailsWidget("Price",
                                                        "${widget.productYouSpend} $rupeeSign"),
                                                    divider(),
                                                    detailsWidget("Discount",
                                                        "${widget.productCashback} $rupeeSign"),
                                                    divider(),
                                                    detailsWidget("Checkout",
                                                        "${widget.productTotalReceive} $rupeeSign"),
                                                    divider(),
                                                    detailsWidget("Earn",
                                                        "${widget.productTotalEarn} $rupeeSign"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                              Radius.circular(constants.radius),
                                          topLeft: Radius.circular(
                                              constants.radius)),
                                    ),
                                    margin: EdgeInsets.zero,
                                    // color: colorDark,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: constants.defaultPadding,
                                          vertical:
                                              constants.defaultPadding / 2),
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showDetails = false;
                                                  });
                                                },
                                                child: const Icon(Icons
                                                    .keyboard_arrow_down_sharp),
                                              )),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    detailsWidget("Name",
                                                        HomeApi.orderFullName),
                                                    divider(),
                                                    detailsWidget(
                                                        "Address Line 1",
                                                        HomeApi
                                                            .orderAddressLine1),
                                                    divider(),
                                                    detailsWidget(
                                                        "Address Line 2",
                                                        HomeApi
                                                            .orderAddressLine2),
                                                    divider(false),
                                                    detailsWidget(" ", " "),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: constants.defaultPadding,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    detailsWidget("Phone",
                                                        "xx-xxxxxxxxxx"),
                                                    divider(),
                                                    detailsWidget("Pincode",
                                                        HomeApi.orderPincode),
                                                    divider(),
                                                    detailsWidget("City",
                                                        HomeApi.orderCity),
                                                    divider(),
                                                    detailsWidget("State",
                                                        HomeApi.orderState),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                              Radius.circular(constants.radius),
                                          topLeft: Radius.circular(
                                              constants.radius)),
                                    ),
                                    margin: EdgeInsets.zero,
                                    // color: colorDark,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: constants.defaultPadding,
                                          vertical:
                                              constants.defaultPadding / 2),
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showDetails = false;
                                                  });
                                                },
                                                child: const Icon(Icons
                                                    .keyboard_arrow_down_sharp),
                                              )),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    detailsWidget("GST No",
                                                        HomeApi.orderGst),
                                                    divider(),
                                                    detailsWidget("TIN", "xxx"),
                                                    divider(),
                                                    detailsWidget(" ", " "),
                                                    divider(false),
                                                    detailsWidget(" ", " "),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: constants.defaultPadding,
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: colorWhite,
                          height: 30.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: (){
                                  _controller.nextPage();
                                  // _controller.previousPage();
                                  setState(() {
                                    if(_current < 1){
                                      _current = 3;
                                    }
                                    _current--;

                                  });
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          constants.defaultPadding / 1.2),
                                      child: Image.asset("images/leftarrow.png"),
                                    ),
                                    Text("detail",style: textStyle.smallText.copyWith(color: Colors.black),),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: imgList.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 8.w,
                                      height: 8.h,
                                      margin: EdgeInsets.symmetric(
                                          vertical:
                                              constants.defaultPadding / 3,
                                          horizontal:
                                              constants.defaultPadding / 3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black)
                                              .withOpacity(_current == entry.key
                                                  ? 0.9
                                                  : 0.4)),
                                    ),
                                  );
                                }).toList(),
                              ),

                              InkWell(
                                onTap: (){
                                  setState(() {
                                    customPrint("_current :: $_current");
                                    if(_current >3 || _current < 1){
                                      _current = 1;
                                    }
                                    _current++;
                                  });


                                },
                                child: Row(
                                  children: [
                                    Text("detail",style: textStyle.smallText.copyWith(color: Colors.black),),
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          constants.defaultPadding/1.2),
                                      child: Image.asset("images/rightarrow.png"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: constants.defaultPadding),
                      child: InkWell(
                        onTap: () {
                          customPrint("_current1 :: $_current");
                          setState(() {
                            showDetails = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "View Details",
                              style: textStyle.smallTextColorDark,
                            ),
                            const Icon(
                              Icons.keyboard_arrow_up,
                              size: 22,
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Divider divider([bool show = true]) {
    return Divider(
      thickness: 0.2,
      color: show ? colorSubHeadingText : colorWhite,
      height: constants.defaultPadding * 1.5,
    );
  }

  Widget detailsWidget(String title, String value) {
    return InkWell(
      onTap: () {
        if (title == " ") {
          return;
        }
        copyToClipboard(context, value);
      },
      child: Row(
        children: [
          Text(
            title == " " ? " " : "$title : ",
            style:
                textStyle.smallTextColorDark.copyWith(color: colorHeadingText),
          ),
          Expanded(
            child: Text(
              value,
              style: textStyle.smallText.copyWith(color: colorHeadingText),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          title == " "
              ? Container()
              : Image.asset(
                  "images/copyicon.png",
                  height: 8.h,
                  width: 8.w,
                ),
        ],
      ),
    );
  }

  Future<void> loadingTime() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        loading = false;
      });
    });
  }

  void showPopupOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    loading = true;
                  });
                  loadingTime();
                },
                leading: const Icon(
                  Icons.refresh,
                  size: 22,
                  color: colorDark,
                ),
                title: Text(
                  "Refresh Page",
                  style: textStyle.subHeadingColorDark,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    isDesktopMode = !isDesktopMode;
                    loading = true;
                  });
                  loadingTime();
                },
                leading: Icon(
                  isDesktopMode
                      ? Icons.mobile_screen_share
                      : Icons.desktop_windows_rounded,
                  size: 22,
                  color: colorDark,
                ),
                title: Text(
                  isDesktopMode ? "Mobile Mode" : "Desktop Mode",
                  style: textStyle.subHeadingColorDark,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
