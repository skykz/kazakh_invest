import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/components/loading_widget.dart';
import 'package:kazakh_invest/src/provider/web_view_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen();

  @override
  createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewScreen> {
  final _key = UniqueKey();
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final webProvider = Provider.of<WebProvider>(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "_title",
          )),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: webProvider.getUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewCreate) {
              _controller.complete(webViewCreate);
            },
            onPageFinished: (finish) {
              webProvider.setState(false);
            },
          ),
          webProvider.getIsLoadingPage
              ? Container(
                  alignment: FractionalOffset.center,
                  color: Colors.grey[200].withOpacity(0.9),
                  child: LoadingWidget())
              : const Visibility(
                  child: SizedBox(),
                  visible: false,
                )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_controller != null) _controller = null;
    super.dispose();
  }
}
