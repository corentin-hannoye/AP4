import 'package:intl/intl.dart';

import 'category_model.dart';

class ProductModel {

  String? id;
  String? name;
  String? description;
  String? unitPrice;
  int? weight;
  String? slug;
  CategoryModel? category;
  List<String>? images;

  ProductModel(this.id, this.name, this.description, this.unitPrice, this.weight, this.slug, this.category, this.images);

  ProductModel.fromJson(Map json) {

    id = json['id'];
    name = json['name'];
    description = json['description'];
    unitPrice = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: '€'
    ).format(json['unit_price']);
    weight = json['weight'];
    slug = json['slug'];
    category = CategoryModel.fromJson(json['category']);

    List<String> images = <String>[];
    for(var i = 0; i < json['productImgs'].length; i++) {
      images.add(json['productImgs'][i]['name']);
    }
    this.images = images;

  }

  String? get getId {
    return id;
  }

  String? get getName {
    return name;
  }

  String? get getUnitPrice {
    return unitPrice;
  }

  CategoryModel? get getCategory {
    return category;
  }

  List<String>? get getImages {
    return images;
  }

}
