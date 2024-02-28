class User {

  String? id;
  String? name;
  String? firstname;
  String? phone;
  String? street;
  String? zipCode;
  String? city;

  static User? session;

  User(this.id, this.name, this.firstname, this.phone, this.street, this.zipCode, this.city);

  User.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    firstname = json['firstname'];
    phone = json['phone'];
    street = json['street'];
    zipCode = json['zipCode'];
    city = json['city'];
  }

  void saveUser() {
    session = this;
  }

  static User? getUser() {
    return session;
  }

  String? get getName {
    return name;
  }

}
