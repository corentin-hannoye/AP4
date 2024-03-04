class Category {

  int? _id;
  String? _name;

  int? get id => _id;

  String? get name => _name;

  Category(this._id, this._name);

  Category.fromJson(Map json) {

    _id = json['id'];
    _name = json['name'];

  }

}
