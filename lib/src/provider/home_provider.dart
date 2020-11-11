import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/core/network/repository/network_calls.dart';
import 'package:kazakh_invest/src/provider/base_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeProvider extends BaseProvider {
  //singleton open API class
  KazakhInvestOpenApi _openApi = KazakhInvestOpenApi();
  Completer<WebViewController> _controller = Completer<WebViewController>();
  Completer<WebViewController> get getController => _controller;

  setControllerNull() {
    this._controller = null;
    this._controller = Completer<WebViewController>();
    notifyListeners();
  }

  // get Widget state
  bool _isLoading = false;
  bool get getLoading => _isLoading;

  int _currentPageIndex = 0;
  int get getCurrentPageIndex => _currentPageIndex;

  int _menuItemIndex = 0;
  int get getMenuItemIndex => _menuItemIndex;

  List<dynamic> _mainMenu = List();
  List<dynamic> get getMainMenuData => _mainMenu;

  List<dynamic> _mainSubMenu = List();
  List<dynamic> get getMainMenuSubData => _mainSubMenu;

  dynamic _mainVideo;
  dynamic get getMainVideo => _mainVideo;

  dynamic _sliderContent;
  dynamic get getSliderContent => _sliderContent;

  dynamic _regionList;
  dynamic get getMainRegionList => _regionList;

  List<dynamic> _successHistory = List();
  List<dynamic> get getMainSuccessHistoryList => _successHistory;

  setLoadingState(bool val) {
    this._isLoading = val;
    notifyListeners();
  }

  setCurrentScreenIndex(int val) {
    this._currentPageIndex = val;
    notifyListeners();
  }

  setMenuItemIndex(int val) {
    this._menuItemIndex = val;
    notifyListeners();
  }

  Future getSlidersContent(BuildContext context) async {
    // setLoadingState(true);
    await _openApi.getSliders(context, getLangType).then((val) {
      this._sliderContent = val;
    });
    notifyListeners();
  }

  Future getMainMenu(BuildContext context) async {
    // setLoadingState(true);
    this._mainMenu = await _openApi.getMainMenu(context, getLangType);
    notifyListeners();
  }

  Future getMainSubMenu(BuildContext context) async {
    this._mainMenu = await _openApi.getSubMenu(context, getLangType);
    notifyListeners();
  }

  Future getMainVideoData(BuildContext context) async {
    this._mainVideo = await _openApi.getMainVideo(context, getLangType);
    notifyListeners();
  }

  Future getRegionData(BuildContext context) async {
    this._regionList = await _openApi.getRegionList(context, getLangType);
    notifyListeners();
  }

  Future getSuccessHistoryData(BuildContext context) async {
    this._successHistory =
        await _openApi.getSuccessHistory(context, getLangType);
    notifyListeners();
  }
}
