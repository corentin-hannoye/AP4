import 'category_model.dart';

class ProductModel {

  String? id;
  String? name;
  String? description;
  int? unitPrice;
  int? weight;
  String? slug;
  CategoryModel? category;

  ProductModel(this.id, this.name, this.description, this.unitPrice, this.weight, this.slug, this.category);

  ProductModel.fromJson(Map json) {

    id = json['id'];
    name = json['name'];
    description = json['description'];
    unitPrice = json['unitPrice'];
    weight = json['weight'];
    slug = json['slug'];
    category = CategoryModel.fromJson(json['category']);

  }

  get getName {
    return name;
  }

  get getCategory {
    return category;
  }

}
