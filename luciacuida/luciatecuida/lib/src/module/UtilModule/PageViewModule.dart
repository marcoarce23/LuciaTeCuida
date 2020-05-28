import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageViewModule extends StatelessWidget {
  final String title;
  final String selectedUrl;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  PageViewModule({
    @required this.title,
    @required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$title'.toUpperCase()),
        ),
        body: WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
