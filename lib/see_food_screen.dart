import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SeeFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food scanner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: WebView(
        initialUrl: "https://foodgan.herokuapp.com",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
