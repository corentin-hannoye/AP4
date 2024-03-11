import 'package:app/src/entity/product.dart';
import 'package:app/src/entity/store.dart';
import 'package:app/src/provider/user_provider.dart';
import 'package:app/src/repository/store_repository.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {

  final Map<Product, int> _products = {};
  Map<Product, int> get products => _products;

  int _productCount = 0;
  int get productCount => _productCount;

  late final UserProvider _userProvider;

  CartProvider(this._userProvider);

  // Method for add product in cart
  void addProduct(Product product) {
    Product? productFound = isAlreadyExist(product);

    if(productFound == null) {
      _products[product] = 1;
    } else {
      _products[productFound] = _products[productFound]! + 1;
    }
    updateProductsCount();
  }

  // Method for remove product in cart
  void removeProduct(Product product) {
    Product? productFound = isAlreadyExist(product);

    if(productFound == null) {
      return;
    }
    
    _products[productFound] = _products[productFound]! - 1;

    if(_products[productFound]! <= 0) {
      _products.remove(productFound);
    }
    updateProductsCount();
  }

  // Method for set quantity product in cart
  void setProduct(Product product, int count) {
    Product? productFound = isAlreadyExist(product);

    if(productFound == null) {
      return;
    }

    if(count == 0) {
      _products.remove(productFound);
    } else {
      _products[productFound] = count;
    }
    updateProductsCount();
  }

  void updateProductsCount() {
    if(_products.values.isEmpty) {
      _productCount = 0;
    } else {
      _productCount = _products.values.reduce((value, element) => value + element);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double totalPrice = 0;

    for (Product product in _products.keys) {
      totalPrice += product.unitPrice! * _products[product]!;
    }

    return totalPrice;
  }

  Product? isAlreadyExist(Product product) {
    if(_products.keys.isEmpty) {
      return null;
    }

    try {
      return _products.keys.singleWhere((element) => element.id == product.id);
    } on StateError {
      return null;
    }
  }

  // find nearby user store, select stores
  void findNearbyUserStore() async {
    List<Store>? stores = await StoreRepository().findAll();

    print(_userProvider.position?.latitude);
    print(_userProvider.position?.longitude);
  }
}
