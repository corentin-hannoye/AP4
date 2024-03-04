import 'package:intl/intl.dart';

import 'category.dart';
import 'store.dart';

class Product {

  String? _id;
  String? get id => _id;

  String? _name;
  String? get name => _name;

  String? _description;
  String? get description => _description;

  String? _unitPrice;
  String? get unitPrice => _unitPrice;

  int? _weight;
  int? get weight => _weight;

  String? _slug;
  String? get slug => _slug;

  Category? _category;
  Category? get category => _category;

  List<Store>? _stores;
  List<Store>? get stores => _stores;

  List<String>? _images;
  List<String>? get images => _images;

  Product([this._id, this._name, this._description, this._unitPrice, this._weight, this._slug, this._category, this._images]);

  Product.fromJson(Map json) {

    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _unitPrice = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: '€'
    ).format(json['unit_price']);
    _weight = json['weight'];
    _slug = json['slug'];
    _category = Category.fromJson(json['category']);

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

  }

}
