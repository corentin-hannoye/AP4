import 'package:app/src/entity/user.dart';
import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';

class UserProvider extends ChangeNotifier {
  bool _isLogin = true;
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

  UserProvider() {
    // getUserPosition();
  }

  // Position? _position;
  // Position? get position => _position;

  // void getUserPosition() async {
  //   bool serviceEnabled;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the 
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //   _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }
}
