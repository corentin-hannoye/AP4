import 'package:app/src/entity/user.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:app/src/repository/user_repository.dart';
import 'package:app/src/utils/input.dart';
import 'package:flutter/material.dart';

class LoginValidationProvider extends ChangeNotifier {

  final Map<String, Input> _inputs = {
    'email': Input(null, null),
    'password': Input(null, null),
  };

  void setValue(String inputName, String value) {
    _inputs[inputName]!.value = value.trim();
  }
  String? getError(String inputName) => _inputs[inputName]!.error;

  bool _showPassword = false;
  get showPassword => _showPassword;
  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  bool isValid() {
    bool valid = true;

    for(Input input in _inputs.values) {
      if(input.value == null || input.value!.isEmpty) {
        input.error = 'Veuillez renseigner ce champs';
        valid = false;
        continue;
      }
      input.error = null;
    }
    notifyListeners();

    return valid;
  }

  void sendForm() async {
    String email = _inputs['email']!.value.toString();
    String password = _inputs['password']!.value.toString();

    User? user = await UserRepository().login(email, password);

    if(user == null) {
      print('no');
      return;
    }
    print(user.firstname);
  }

}
