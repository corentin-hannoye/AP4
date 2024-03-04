import 'package:app/src/entity/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;
  void toggleLogin(User? user) {
    if(user == null) {
      return;
    }

    _isLogin = !_isLogin;
    session = _isLogin ? user : null;

    notifyListeners();
  }

  User? session;
}
