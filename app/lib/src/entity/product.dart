import 'package:intl/intl.dart';

import 'category.dart';

class Product {

  String? _id;
  String? _name;
  String? _description;
  String? _unitPrice;
  int? _weight;
  String? _slug;
  Category? _category;
  List<String>? _images;

  String? get id => _id;

  String? get name => _name;

  String? get description => _description;

  String? get unitPrice => _unitPrice;

  int? get weight => _weight;

  String? get slug => _slug;

  Category? get category => _category;

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

    List<String> images = <String>[];
    for(var i = 0; i < json['productImgs'].length; i++) {
      images.add(json['productImgs'][i]['name']);
    }
    _images = images;

  }

}
