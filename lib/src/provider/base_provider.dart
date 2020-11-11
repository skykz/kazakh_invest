import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  String _langType = 'ru';
  String get getLangType => _langType;

  String _code;
  String get getCode => _code;

  String _webLink;
  String get getWebLink => _webLink;

  setLangType(String val) {
    this._langType = val;
    notifyListeners();
  }

  setRegionCode(String val) {
    this._code = val;
    notifyListeners();
  }

  setWebLink(String val) {
    this._webLink = val;
    notifyListeners();
  }

  bool _isLoadingPage = true;
  bool get getIsLoadingPage => _isLoadingPage;

  setState(bool val) {
    this._isLoadingPage = val;
    notifyListeners();
  }

  setClearData() {
    this._isLoadingPage = true;
    notifyListeners();
  }
}
