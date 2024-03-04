class Store {

  String? _city;
  String? get city => _city;

  String? _country;
  String? get country => _country;

  int? _quantity;
  int? get quantity => _quantity;

  Store(this._city, this._country, this._quantity);

  Store.fromJson(Map json) {

    _city = json['store']['city'];
    _country = json['store']['country'];
    _quantity = json['quantity'];

  }

}
