class Input {

  String? _value;
  String? _error;

  String? get value => _value;
  String? get error => _error;

  set value(String? value) => _value = value;
  set error(String? error) => _error = error;

  Input(this._value, this._error);

}
