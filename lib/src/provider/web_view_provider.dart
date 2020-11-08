import 'base_provider.dart';

class WebProvider extends BaseProvider {
  bool _isLoadingPage = true;
  bool get getIsLoadingPage => _isLoadingPage;

  String _url;
  String get getUrl => _url;

  setState(bool val) {
    this._isLoadingPage = val;
    notifyListeners();
  }
}
