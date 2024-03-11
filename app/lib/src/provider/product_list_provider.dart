import 'package:app/src/repository/product_repository.dart';
import 'package:flutter/material.dart';

import 'package:app/src/entity/category.dart';
import 'package:app/src/entity/product.dart';

class ProductListProvider extends ChangeNotifier {

  static const int productsPerPage = 4;

  Map<Category, List<Product>>? _categoriesProducts;
  get categoriesProducts => _categoriesProducts;

  final Map<Category, int> _categoriesNbProductsDisplayed = {};
  get categoriesNbProductsDisplayed => _categoriesNbProductsDisplayed;

  ProductListProvider() {
    fetchCategoriesAndProducts();
  }

  void fetchCategoriesAndProducts() async {
    _categoriesProducts = await ProductRepository().findCategoriesAndArticles();
    _categoriesProducts?.forEach((key, value) {
      if(value.length < productsPerPage) {
        _categoriesNbProductsDisplayed[key] = value.length;
        return;
      }
      _categoriesNbProductsDisplayed[key] = productsPerPage;
    });

    notifyListeners();
  }

  void seeMoreProducts(Category category) {
    int productsDisplayedAfterUpdate = _categoriesNbProductsDisplayed[category]! + productsPerPage;

    if(productsDisplayedAfterUpdate > _categoriesProducts![category]!.length) {
      _categoriesNbProductsDisplayed[category] = _categoriesProducts![category]!.length;
    } else {
      _categoriesNbProductsDisplayed[category] = productsDisplayedAfterUpdate;
    }

    notifyListeners();
  }

}
