import 'package:app/src/const.dart';
import 'package:app/src/entity/product.dart';
import 'package:app/src/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeProvider extends ChangeNotifier {

  Product? _product;
  Product? get product => _product;

  void onCapture(BuildContext context, BarcodeCapture capture) async {
    Product? productFinded = await ProductRepository().findProductByRef(capture.barcodes.first.rawValue!);

    if(productFinded == null) {
      _product = null;
      return;
    }
    _product = productFinded;

    if(!context.mounted) {
      return;
    }
    context.replace(Routes.product);
  }

}
