import 'dart:convert';

import 'package:app/src/const.dart';
import 'package:app/src/entity/category.dart';
import 'package:app/src/entity/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {

  Future<Map<Category, List<Product>>?> getCategoriesAndArticles() async {
    final http.Response response = await http.get(Uri.parse('$apiUrl/api/categories-products'));

    if(response.statusCode != 200) {
      return null;
    }

    final Map responseJson = jsonDecode(response.body);

    Map<Category, List<Product>> categoriesProducts = {};

    for(MapEntry e in responseJson.entries) {
      // Ex categoryData[0] = [1, 'Rugby']
      List<String> categoryData = e.key.toString().split(' ');

      Category category = Category(int.parse(categoryData[0]), categoryData[1]);

      List<Product> products = [];

      for(Map<dynamic, dynamic> p in e.value) {
        Product product = Product.fromJson(p);
        products.add(product);
      }

      categoriesProducts[category] = products;
    }
    return categoriesProducts;
  }

}