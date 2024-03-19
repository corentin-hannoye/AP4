import 'category.dart';
import 'store.dart';

class Product {

  String? _id;
  String? get id => _id;

  String? _ref;
  String? get ref => _ref;

  String? _name;
  String? get name => _name;

  String? _description;
  String? get description => _description;

  double? _unitPrice;
  double? get unitPrice => _unitPrice;

  int? _weight;
  int? get weight => _weight;

  String? _slug;
  String? get slug => _slug;

  Category? _category;
  Category? get category => _category;

  String? _supplier;
  String? get supplier => _supplier;

  List<Store>? _stores;
  List<Store>? get stores => _stores;

  List<String>? _images;
  List<String>? get images => _images;

  Product(this._id, this._name, this._description, this._unitPrice, this._weight, this._slug, this._category, this._supplier, this._images);

  Product.fromJson(Map json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _unitPrice = json['unit_price'];
    _weight = json['weight'];
    _slug = json['slug'];
    _category = Category.fromJson(json['category']);
    _supplier = json['supplier']['name'];

    if(json['stockStores'].isNotEmpty) {
      List<Store> stores = <Store>[];
      for(var i = 0; i < json['stockStores'].length; i++) {
        stores.add(Store.fromJson(json['stockStores'][i]));
      }
      _stores = stores;
    }

    List<String> images = <String>[];
    for(var i = 0; i < json['productImgs'].length; i++) {
      images.add(json['productImgs'][i]['name']);
    }
    _images = images;

    _ref = (_supplier!.substring(0, 3) + _category!.slug!.substring(0, 3) + _id!).toUpperCase();
  }
}
