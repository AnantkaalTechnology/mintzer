// import 'package:mintzer/Widgets/loading_widget.dart';
// import 'package:dailymarketwebsite/Widgets/progressHud.dart';
// import 'package:dailymarketwebsite/banner/banner_page.dart';
// import 'package:dailymarketwebsite/banner/banner_page.dart';
// import 'package:dailymarketwebsite/home/Api.dart';
// import 'package:dailymarketwebsite/setting/Api.dart';
// import 'package:dailymarketwebsite/utils/constants.dart';
// import 'package:dailymarketwebsite/utils/responsive.dart';
// import 'package:dailymarketwebsite/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mintzer/util/colors.dart';
import 'package:mintzer/util/constants.dart';

// import '../../utils/colors.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({
    Key? key,
    required this.entries,
    required this.hover, required this.index, required this.onPress,
  }) : super(key: key);

  final List<String> entries;
  final bool hover;
  final int index;
  final Function onPress;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      margin: EdgeInsets.only(
          left: 0,
          right: constants.defaultPadding,
          bottom: constants.defaultPadding),
      shape: RoundedRectangleBorder(
        borderRadius: constants.borderRadius,
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image.network(
            widget.entries[widget.index],
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(
                constants.defaultPadding / 3),
            child: InkWell(
              onTap: () {
                widget.onPress();
              },
              onHover: (value) {
                if (value && !hover) {
                  setState(() {
                    hover = true;
                  });
                } else {
                  setState(() {
                    hover = false;
                  });
                }
              },
              child: Card(
                elevation: 0,
                color: colorDark,
                shape: RoundedRectangleBorder(
                    borderRadius: constants.borderRadius),
                child: Padding(
                  padding: const EdgeInsets.all(
                      constants.defaultPadding / 3),
                  child: Icon(
                    Icons.delete,
                    size: hover?22:18,
                    color: colorWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
