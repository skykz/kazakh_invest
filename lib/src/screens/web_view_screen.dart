import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/components/loading_widget.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    log('${homeProvider.getWebLink}');

    return WillPopScope(
      onWillPop: _setInitialScreen,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            WebView(
              initialUrl: homeProvider.getWebLink,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (webViewCreate) {
                homeProvider.getController.complete(webViewCreate);
                // homeProvider.setControllerNull();
              },
              onPageFinished: (finish) {
                homeProvider.setState(false);
              },
              key: Key('${homeProvider.getWebLink}'),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 10,
                child: Text('${homeProvider.getWebLink}'))
            // homeProvider.getIsLoadingPage
            //     ? Container(
            //         alignment: FractionalOffset.center,
            //         color: Colors.grey[200].withOpacity(0.9),
            //         child: LoadingWidget())
            //     : const Visibility(
            //         child: SizedBox(),
            //         visible: false,
            //       ),
          ],
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   if ( _controller != null) _controller = null;
  //   super.dispose();
  // }

  Future<bool> _setInitialScreen() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.setClearData();

    homeProvider.setCurrentScreenIndex(0);
  }
}
