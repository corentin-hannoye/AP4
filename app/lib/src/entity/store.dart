class Store {

  int? _id;
  int? get id => _id;

  String? _city;
  String? get city => _city;

  String? _country;
  String? get country => _country;

  int? _quantity;
  int? get quantity => _quantity;

  Store(this._id, this._city, this._country, this._quantity);

  Store.fromJson(Map json) {

    if(json['store'] == null) {

      _id = json['id'];
      _city = json['city'];
      _country = json['country'];

    } else {

      _city = json['store']['city'];
      _country = json['store']['country'];
      _quantity = json['quantity'];

    }

  }

}
