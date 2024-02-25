class CategoryModel {

  int? id;
  String? name;
  String? slug;

  CategoryModel(this.id, this.name, this.slug);

  CategoryModel.fromJson(Map json) {

    id = json['id'];
    name = json['name'];
    slug = json['slug'];

  }

  get getName {
    return name;
  }

}
