import 'package:app/src/entity/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {

  final Map<Product, int> _products = {};
  Map<Product, int> get products => _products;
  void addProduct(Product product) {
    if(_products.containsKey(product)) {
      _products[product] = _products[product]! + 1;
    } else {
      _products[product] = 1;
    }
    productsCount();

    notifyListeners();
  }

  int _productCount = 0;
  int get productCount => _productCount;

  void productsCount() {
    if(_products.values.isEmpty) {
      return;
    }
    _productCount = _products.values.reduce((value, element) => value + element);
  }
}
