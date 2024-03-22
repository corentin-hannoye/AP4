class Store {

  int? _id;
  int? get id => _id;

  String? _city;
  String? get city => _city;

  String? _country;
  String? get country => _country;

  int? _quantity;
  int? get quantity => _quantity;

  double? _latitude;
  double? get latitude => _latitude;

  double? _longitude;
  double? get longitude => _longitude;

  Store(this._id, this._city, this._country, this._quantity);

  Store.fromJson(Map json) {

    if(json['store'] == null) {

      _id = json['id'];
      _city = json['city'];
      _country = json['country'];
      _latitude = json['latitude'];
      _longitude = json['longitude'];

    } else {

      _city = json['store']['city'];
      _country = json['store']['country'];
      _quantity = json['quantity'];

    }

  }

}
