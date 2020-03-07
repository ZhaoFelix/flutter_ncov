import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewDetailPages extends StatelessWidget {
  final arguments;
  WebviewDetailPages({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.arguments['title']}'),
      ),
      body: WebView(
        initialUrl: this.arguments['url'],
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
