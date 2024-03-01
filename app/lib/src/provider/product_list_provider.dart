import 'package:flutter/material.dart';

import 'package:app/src/entity/category.dart';
import 'package:app/src/entity/product.dart';

class ProductListProvider extends ChangeNotifier {

  static const int productsPerPage = 4;

  final Map<Category, List<Product>> categoriesProducts = {};
  final Map<Category, int> categoriesNbProductsDisplayed = {};

  void seeMoreProducts(Category category) {
    int productsDisplayedAfterUpdate = categoriesNbProductsDisplayed[category]! + productsPerPage;

    if(productsDisplayedAfterUpdate > categoriesProducts[category]!.length) {
      categoriesNbProductsDisplayed[category] = categoriesProducts[category]!.length;
      return;
    }
    categoriesNbProductsDisplayed[category] = productsDisplayedAfterUpdate;
  }

}
