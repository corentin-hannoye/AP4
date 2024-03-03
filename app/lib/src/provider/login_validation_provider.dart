import 'package:app/src/entity/user.dart';
import 'package:app/src/provider/app_state_provider.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:app/src/repository/user_repository.dart';
import 'package:app/src/utils/input.dart';
import 'package:flutter/material.dart';

class LoginValidationProvider extends ChangeNotifier {

  String? _message;
  String? get message => _message;

  bool _allowButton = false;
  bool get allowButton => _allowButton;

  final Map<String, Input> _inputs = {
    'email': Input(null, null),
    'password': Input(null, null),
  };
  String? getValue(String inputName) {
    return _inputs[inputName]!.value;
  }
  void setValue(String inputName, String? value) {
    Input? input = _inputs[inputName];
    input!.value = value;

    _allowButton = isValid(input);
    notifyListeners();
  }

  String? getError(String inputName) => _inputs[inputName]!.error;

  bool _showPassword = false;
  get showPassword => _showPassword;
  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  bool isValid(Input targetInput) {
    bool valid = true;

    for(Input input in _inputs.values) {
      if(input.value == null || input.value!.isEmpty) {
        if(input == targetInput) {
          targetInput.error = 'Veuillez renseigner ce champs';
        }
        valid = false;
        continue;
      }
      input.error = null;
    }
    return valid;
  }

  void reset() {
    _inputs['password']!.value = null;
    _inputs['email']!.value = null;
    _message = null;
    _allowButton = false;
    _showPassword = false;
  }

  void sendForm(AppStateProvider appStateProvider, UserProvider userProvider) async {
    appStateProvider.toggleLoading();

    String email = _inputs['email']!.value.toString();
    String password = _inputs['password']!.value.toString();

    User? user = await UserRepository().login(email, password);

    appStateProvider.toggleLoading();
    _allowButton = false;

    if(user == null) {
      _message = 'Identifiants incorrects';
      _inputs['password']!.value = null;
      return;
    }

    reset();
    userProvider.toggleLogin(user);
  }

}
