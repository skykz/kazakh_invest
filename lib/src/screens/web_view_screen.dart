import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen();

  @override
  createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    // log(' selected WebView Link - ${homeProvider.getWebLink}');

    return WillPopScope(
      onWillPop: () => _setInitialScreen(homeProvider),
      child: Scaffold(
        body: homeProvider.getController != null
            ? Stack(
                children: <Widget>[
                  homeProvider.getWebLink != null
                      ? WebView(
                          initialUrl: homeProvider.getWebLink,
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (webViewCreate) {
                            homeProvider.getController.complete(webViewCreate);
                          },
                          onPageFinished: (finish) {
                            homeProvider.setState(false);
                          },
                          key: Key('${homeProvider.getWebLink}'),
                        )
                      : const Center(
                          child: Text(
                            '404',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ],
              )
            : Container(
                color: Colors.white,
              ),
      ),
    );
  }

  // ignore: missing_return
  Future<bool> _setInitialScreen(HomeProvider homeProvider) {
    homeProvider.setClearData();
    homeProvider.setCurrentScreenIndex(0);
  }
}
