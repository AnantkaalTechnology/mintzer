import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintzer/Widgets/my_textfield.dart';
import 'package:mintzer/home/api.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';
import 'package:shimmer/shimmer.dart';

import '../globalVariable.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<String> filterCardName = [];
  List<String> filterCardId = [];
  List<String> filterCardImage = [];

  final searchController = TextEditingController();
  List<String> selectedCard = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeApi.getBankCards(context).then((value) {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Padding(
          padding: const EdgeInsets.only(
            top: constants.defaultPadding * 2,
            // left: constants.defaultPadding,
            // right: constants.defaultPadding,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: constants.defaultPadding),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: constants.defaultPadding * 8,
                      ),
                      searchController.text.isEmpty
                          ? showAllCardsWidget(context)
                          : showFilterCardsWidget(context),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100.h,
                color: colorWhite,
                padding:
                    const EdgeInsets.only(bottom: constants.defaultPadding),
                child: MyTextFiled(
                    onChange: (value) {
                      filterCardId.clear();
                      filterCardName.clear();
                      filterCardImage.clear();

                      for (int i = 0; i < HomeApi.cardId.length; i++) {
                        if (HomeApi.cardName[i].toLowerCase().contains(
                            searchController.text.toLowerCase().trim())) {
                          filterCardId.add(HomeApi.cardId[i]);
                          filterCardName.add(HomeApi.cardName[i]);
                          filterCardImage.add(HomeApi.cardImage[i]);
                        }
                      }

                      setState(() {});
                    },
                    controller: searchController,
                    hint: "Search your card here"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column showFilterCardsWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/lineleft.png'),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            Text("Result of ${searchController.text}"),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            Image.asset('images/lineright.png'),
          ],
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        filterCardId.isEmpty
            ? Padding(
                padding:
                    const EdgeInsets.only(top: constants.defaultPadding * 4),
                child: loadingWidget(
                    "No Card Found", "No result for ${searchController.text}"),
              )
            : MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: getStaticCount(filterCardId.length),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: constants.defaultPadding,
                    mainAxisSpacing: constants.defaultPadding,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (selectedCard.contains(filterCardId[index])) {
                          selectedCard.remove(filterCardId[index]);
                        } else {
                          selectedCard.add(filterCardId[index]);
                        }
                        setState(() {});
                        HomeApi.updateBankCard(context, filterCardId[index])
                            .then((value) {});
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          FadeInImage.assetNetwork(
                            placeholder: "images/logo_dark.png",
                            image: filterCardImage[index],
                            // height: 222.h,
                            // width: double.infinity,
                            fit: BoxFit.fill,
                            placeholderFit: BoxFit.none,
                            imageErrorBuilder: imageErrorBuilder,
                          ),
                          selectedCard.contains(filterCardId[index])
                              ? Card(
                                  margin: const EdgeInsets.all(
                                      constants.defaultPadding / 2),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: constants.borderRadius * 100,
                                  ),
                                  child: const Icon(
                                    Icons.done_rounded,
                                    size: 22,
                                    color: colorDark,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  Widget showAllCardsWidget(BuildContext context) {
    customPrint("HomeApi.cardSBIName.length :: ${HomeApi.cardSBIName.length}");
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/lineleft.png'),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            const Text("SBI Cards"),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            Image.asset('images/lineright.png'),
          ],
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: getStaticCount(HomeApi.cardSBIName.length),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: constants.defaultPadding,
              mainAxisSpacing: constants.defaultPadding,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (HomeApi.cardSBIName.isEmpty) {
                return Shimmer.fromColors(
                  baseColor: colorWhite,
                  highlightColor: colorDisable,
                  child: Container(
                    height: 222.h,
                    width: double.infinity,
                    color: colorDisable,
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  if (selectedCard.contains(HomeApi.cardSBIId[index])) {
                    selectedCard.remove(HomeApi.cardSBIId[index]);
                  } else {
                    selectedCard.add(HomeApi.cardSBIId[index]);
                  }
                  setState(() {});
                  HomeApi.updateBankCard(context, HomeApi.cardSBIId[index])
                      .then((value) {});
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: "images/logo_dark.png",
                      image: HomeApi.cardSBIImage[index],
                      // height: 222.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholderFit: BoxFit.none,
                      imageErrorBuilder: imageErrorBuilder,
                    ),
                    selectedCard.contains(HomeApi.cardSBIId[index])
                        ? Card(
                            margin: const EdgeInsets.all(
                                constants.defaultPadding / 2),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: constants.borderRadius * 100,
                            ),
                            child: const Icon(
                              Icons.done_rounded,
                              size: 22,
                              color: colorDark,
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/lineleft.png'),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            const Text("HDFC Cards"),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            Image.asset('images/lineright.png'),
          ],
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: getStaticCount(HomeApi.cardHDFCName.length),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: constants.defaultPadding,
              mainAxisSpacing: constants.defaultPadding,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (HomeApi.cardHDFCName.isEmpty) {
                return Shimmer.fromColors(
                  baseColor: colorWhite,
                  highlightColor: colorDisable,
                  child: Container(
                    height: 222.h,
                    width: double.infinity,
                    color: colorDisable,
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  if (selectedCard.contains(HomeApi.cardHDFCId[index])) {
                    selectedCard.remove(HomeApi.cardHDFCId[index]);
                  } else {
                    selectedCard.add(HomeApi.cardHDFCId[index]);
                  }
                  setState(() {});
                  HomeApi.updateBankCard(context, HomeApi.cardHDFCId[index])
                      .then((value) {});
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: "images/logo_dark.png",
                      image: HomeApi.cardHDFCImage[index],
                      // height: 222.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholderFit: BoxFit.none,
                      imageErrorBuilder: imageErrorBuilder,
                    ),
                    selectedCard.contains(HomeApi.cardHDFCId[index])
                        ? Card(
                            margin: const EdgeInsets.all(
                                constants.defaultPadding / 2),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: constants.borderRadius * 100,
                            ),
                            child: const Icon(
                              Icons.done_rounded,
                              size: 22,
                              color: colorDark,
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/lineleft.png'),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            const Text("ICICI Cards"),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            Image.asset('images/lineright.png'),
          ],
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: getStaticCount(HomeApi.cardICICIName.length),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: constants.defaultPadding,
              mainAxisSpacing: constants.defaultPadding,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (HomeApi.cardICICIName.isEmpty) {
                return Shimmer.fromColors(
                  baseColor: colorWhite,
                  highlightColor: colorDisable,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      height: 222.h,
                      width: double.infinity,
                      color: colorDisable,
                    ),
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  if (selectedCard.contains(HomeApi.cardICICIId[index])) {
                    selectedCard.remove(HomeApi.cardICICIId[index]);
                  } else {
                    selectedCard.add(HomeApi.cardICICIId[index]);
                  }
                  setState(() {});
                  HomeApi.updateBankCard(context, HomeApi.cardICICIId[index])
                      .then((value) {});
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: "images/logo_dark.png",
                      image: HomeApi.cardICICIImage[index],
                      // height: 222.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholderFit: BoxFit.none,
                      imageErrorBuilder: imageErrorBuilder,
                    ),
                    selectedCard.contains(HomeApi.cardICICIId[index])
                        ? Card(
                            margin: const EdgeInsets.all(
                                constants.defaultPadding / 2),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: constants.borderRadius * 100,
                            ),
                            child: const Icon(
                              Icons.done_rounded,
                              size: 22,
                              color: colorDark,
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/lineleft.png'),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            const Text("Axis Cards"),
            const SizedBox(
              width: constants.defaultPadding,
            ),
            Image.asset('images/lineright.png'),
          ],
        ),
        const SizedBox(
          height: constants.defaultPadding * 2,
        ),
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: getStaticCount(HomeApi.cardAxisName.length),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: constants.defaultPadding,
              mainAxisSpacing: constants.defaultPadding,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (HomeApi.cardAxisName.isEmpty) {
                return Shimmer.fromColors(
                  baseColor: colorWhite,
                  highlightColor: colorDisable,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      height: 222.h,
                      width: double.infinity,
                      color: colorDisable,
                    ),
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  if (selectedCard.contains(HomeApi.cardAxisId[index])) {
                    selectedCard.remove(HomeApi.cardAxisId[index]);
                  } else {
                    selectedCard.add(HomeApi.cardAxisId[index]);
                  }
                  setState(() {});
                  HomeApi.updateBankCard(context, HomeApi.cardAxisId[index])
                      .then((value) {});
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: "images/logo_dark.png",
                      image: HomeApi.cardAxisImage[index],
                      // height: 222.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholderFit: BoxFit.none,
                      imageErrorBuilder: imageErrorBuilder,
                    ),
                    selectedCard.contains(HomeApi.cardAxisId[index])
                        ? Card(
                            margin: const EdgeInsets.all(
                                constants.defaultPadding / 2),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: constants.borderRadius * 100,
                            ),
                            child: const Icon(
                              Icons.done_rounded,
                              size: 22,
                              color: colorDark,
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _pullRefresh() async {
    await delay(1000);
    HomeApi.getBankCards(context).then((value) {
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
