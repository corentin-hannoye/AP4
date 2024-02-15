class UserModel {

  String? id;
  String? name;
  String? firstname;
  String? phone;
  String? street;
  String? zipCode;
  String? city;

  static UserModel? session;

  UserModel(this.id, this.name, this.firstname, this.phone, this.street, this.zipCode, this.city);

  UserModel.fromJson(Map json) {
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

  static UserModel? getUser() {
    return session;
  }

  get getName {
    return name;
  }

}
