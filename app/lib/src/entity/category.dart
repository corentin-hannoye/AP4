class Category {
  int? _id;
  int? get id => _id;

  String? _name;
  String? get name => _name;

  String? _slug;
  String? get slug => _slug;

  Category(this._id, this._name, this._slug);

  Category.fromJson(Map json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
  }
}
