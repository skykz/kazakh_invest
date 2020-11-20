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
    this._controller = Completer<WebViewController>();
    notifyListeners();
  }

  final ValueNotifier<int> _pageNotifier = new ValueNotifier<int>(0);
  ValueNotifier<int> get getPageNotifier => _pageNotifier;

  setPageIndicator(int index) {
    _pageNotifier.value = index;
    notifyListeners();
  }

  // get Widget state
  bool _isLoading = false;
  bool get getLoading => _isLoading;

  bool _isSecret = false;
  bool get getIsSecretApiState => _isSecret;

  int _currentPageIndex = 0;
  int get getCurrentPageIndex => _currentPageIndex;

  int _menuItemIndex = 0;
  int get getMenuItemIndex => _menuItemIndex;

  List<dynamic> _mainMenu = List();
  List<dynamic> get getMainMenuData => _mainMenu;

  dynamic _mainVideo;
  dynamic get getMainVideo => _mainVideo;

  dynamic _sliderContent;
  dynamic get getSliderContent => _sliderContent;

  dynamic _regionList;
  dynamic get getMainRegionList => _regionList;

  List<dynamic> _successHistory = List();
  List<dynamic> get getMainSuccessHistoryList => _successHistory;

  List<dynamic> _listCategories = List();
  List<dynamic> get getListCategories => _listCategories;

  int _selectedHistorySuccessId;
  int get getSuccesHistoryId => _selectedHistorySuccessId;

  int _selectedNewsId;
  int get getSelectedNewsId => _selectedNewsId;

  String _codeRegion;
  String get getCodeRegion => _codeRegion;

  setRegionCode(String val) {
    this._codeRegion = val;
    notifyListeners();
  }

  setNewsId(int id) {
    this._selectedNewsId = id;
    notifyListeners();
  }

  setSuccesHistoryId(int id) {
    this._selectedHistorySuccessId = id;
    notifyListeners();
  }

  setLoadingState(bool val) {
    this._isLoading = val;
    notifyListeners();
  }

  setCurrentScreenIndex(int val) {
    this._currentPageIndex = val;
    if (val == 0) _menuItemIndex = 0;
    notifyListeners();
  }

  setMenuItemIndex(int val) {
    this._menuItemIndex = val;
    notifyListeners();
  }

  getSecretApi(BuildContext context) {
    _openApi.getSecret(context).then((val) {
      this._isSecret = val['hide'];
      notifyListeners();
    });
  }

  Future getSlidersContent(BuildContext context) async {
    await _openApi
        .getSliders(context, getLangType, this._codeRegion)
        .then((val) {
      this._sliderContent = val;
    });
    notifyListeners();
  }

  Future getMainMenu(BuildContext context) async {
    this._mainMenu =
        await _openApi.getMainMenu(context, getLangType, this._codeRegion);
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
    this._successHistory = await _openApi.getSuccessHistory(
        context, getLangType, this._codeRegion);
    notifyListeners();
  }

  Future getNewsCategory(BuildContext context) async {
    return await _openApi.getCategeoryNews(context, getLangType);
  }

  Future getNewsCategoryById(int categoryId, BuildContext context) async {
    return await _openApi.getCategoryById(context, getLangType, categoryId);
  }

  Future getSuccessHistoryById(int id, BuildContext context) async {
    return await _openApi.getSuccessHistoryById(
        context, getLangType, id, this._codeRegion);
  }

  Future getNewsDetailById(int id, BuildContext context) async {
    return await _openApi.getNewsDetailById(context, getLangType, id);
  }
}
