import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  String _langType = 'ru';
  String get getLangType => _langType;

  setLangType(String val) {
    this._langType = val;
    notifyListeners();
  }
}
