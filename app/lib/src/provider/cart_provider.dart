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
  void removeProduct(Product product) {
    _products[product] = _products[product]! - 1;

    if(_products[product]! <= 0) {
      _products.remove(product);
    }
    productsCount();

    notifyListeners();
  }
  void setProduct(Product product, int count) {
    if(count == 0) {
      _products.remove(product);
    } else {
      _products[product] = count;
    }
    productsCount();

    notifyListeners();
  }

  int _productCount = 0;
  int get productCount => _productCount;

  void productsCount() {
    if(_products.values.isEmpty) {
      _productCount = 0;
      return;
    }
    _productCount = _products.values.reduce((value, element) => value + element);
  }

  double getTotalPrice() {
    double totalPrice = 0;

    for (Product product in _products.keys) {
      totalPrice += product.unitPrice! * _products[product]!;
    }

    return totalPrice;
  }
}
