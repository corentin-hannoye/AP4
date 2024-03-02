import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  void setLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }
}
