import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AhitatLayout extends StatefulWidget {
  @override
  _AhitatLayoutState createState() => _AhitatLayoutState();
}

class _AhitatLayoutState extends State<AhitatLayout> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse('https://www.rmbgysz.ro/ahitat/'))
      ..setBackgroundColor(Color(0x13131313))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewWidget(controller: _webViewController));
  }
}
