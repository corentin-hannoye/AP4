class CategoryModel {

  int? id;
  String? name;

  CategoryModel(this.id, this.name);

  CategoryModel.fromJson(Map json) {

    id = json['id'];
    name = json['name'];

  }

  String? get getName {
    return name;
  }

}
