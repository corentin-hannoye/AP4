import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;
  void toggleLoading() {
    _loading = !_loading;
    notifyListeners();
  }

}
