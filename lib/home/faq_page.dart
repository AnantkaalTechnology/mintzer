import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../globalVariable.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  WebView(
        onWebViewCreated: (value) {
          delay(1000).then((value) {
            setState(() {
              loading = false;
            });
          });
        },
        initialUrl: 'https://mintzer.in/#1#faqs-1',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
