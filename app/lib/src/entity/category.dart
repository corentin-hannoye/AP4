class Category {

  int? id;
  String? name;

  Category(this.id, this.name);

  Category.fromJson(Map json) {

    id = json['id'];
    name = json['name'];

  }

  String? get getName {
    return name;
  }

}
