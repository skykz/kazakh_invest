import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/core/network/repository/network_calls.dart';
import 'package:kazakh_invest/src/provider/base_provider.dart';

class HomeProvider extends BaseProvider {
  //singleton open API class
  KazakhInvestOpenApi _openApi = KazakhInvestOpenApi();

  // get Widget state
  bool _isLoading = false;
  bool get getLoading => _isLoading;

  int _currentPageIndex = 0;
  int get getCurrentPageIndex => _currentPageIndex;

  List<dynamic> _mainMenu = List();
  List<dynamic> get getMainMenuData => _mainMenu;

  List<dynamic> _mainSubMenu = List();
  List<dynamic> get getMainMenuSubData => _mainSubMenu;

  dynamic _mainVideo;
  dynamic get getMainVideo => _mainVideo;

  dynamic _sliderContent;
  dynamic get getSliderContent => _sliderContent;

  setLoadingState(bool val) {
    this._isLoading = val;
    notifyListeners();
  }

  setCurrentScreenIndex(int val) {
    this._currentPageIndex = val;
    notifyListeners();
  }

  Future getSlidersContent(BuildContext context) async {
    await _openApi.getSliders(context, getLangType).then((val) {
      this._sliderContent = val;
    });
    notifyListeners();
  }

  Future getMainMenu(BuildContext context) async {
    // setLoadingState(true);
    this._mainMenu = await _openApi
        .getMainMenu(context, getLangType)
        .whenComplete(() => setLoadingState(false));
    // setLoadingState(false);
  }

  Future getMainSubMenu(BuildContext context) async {
    this._mainMenu = await _openApi.getSubMenu(context, getLangType);
  }

  Future getMainVideoData(BuildContext context) async {
    this._mainVideo = await _openApi.getMainVideo(context, getLangType);
  }
}
