import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageViewModule extends StatefulWidget {
  final String title;
  final String selectedUrl;


  PageViewModule({
    @required this.title,
    @required this.selectedUrl,
    
  });

  @override
  _PageViewModuleState createState() => _PageViewModuleState();
}

class _PageViewModuleState extends State<PageViewModule> {
  final Completer<WebViewController> _controller =  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'.toUpperCase()),
        ),
        body: WebView(
          debuggingEnabled: false,
          initialUrl: widget.selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
