import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SeeFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: "http://192.168.1.187:8501",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
