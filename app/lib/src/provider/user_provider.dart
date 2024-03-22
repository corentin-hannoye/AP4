import 'package:app/src/entity/user.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class UserProvider extends ChangeNotifier {

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  User? session;

  Position? _position;
  Position? get position => _position;

  void toggleLogin(User? user) {
    if(user == null) {
      return;
    }

    _isLogin = !_isLogin;
    session = _isLogin ? user : null;

    notifyListeners();
  }

  UserProvider() {
    getUserPosition();
  }

  void getUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // return Future.error('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // return Future.error('Location permissions are denied');
        return;
      }
    }

    if(permission == LocationPermission.deniedForever) {
      // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    _position = await Geolocator.getCurrentPosition();

    notifyListeners();
  }
}
