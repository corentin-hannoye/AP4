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
      // Ex categoryData[0] = [1, 'Rugby', 'rugby']
      List<String> categoryData = e.key.toString().split(' ');

      Category category = Category(int.parse(categoryData[0]), categoryData[1], categoryData[2]);

      List<Product> products = [];

      for(Map<dynamic, dynamic> p in e.value) {
        Product product = Product.fromJson(p);
        products.add(product);
      }

      categoriesProducts[category] = products;
    }
    return categoriesProducts;
  }

  Future<Product?> findProductByRef(String ref) async {
    String supplier = ref.substring(0, 3);
    String category = ref.substring(3, 6);
    String productId = ref.substring(6);

    final Uri uri = Uri.parse('$apiUrl/api/product/ref').replace(queryParameters: {
      'supplier': supplier,
      'category': category,
      'productId': productId
    });
    final http.Response response = await http.get(uri);

    if(response.statusCode != 200) {
      return null;
    }

    final Map responseJson = jsonDecode(response.body);

    Product product = Product.fromJson(responseJson);

    return product;
  }

}
