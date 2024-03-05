class User {
  String? _id;
  String? _name;
  String? _firstname;
  String? _phone;
  String? _street;
  String? _zipCode;
  String? _city;

  User(this._id, this._name, this._firstname, this._phone, this._street, this._zipCode, this._city);

  User.fromJson(Map json) {
    _id = json['id'];
    _name = json['name'];
    _firstname = json['firstname'];
    _phone = json['phone'];
    _street = json['street'];
    _zipCode = json['zipCode'];
    _city = json['city'];
  }

  String? get name {
    return _name;
  }
}
