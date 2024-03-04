import 'package:app/src/const.dart';
import 'package:app/src/entity/product.dart';
import 'package:app/src/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeProvider extends ChangeNotifier {

  final GlobalKey _qrKey = GlobalKey();
  GlobalKey get qrKey => _qrKey;

  Product? product;

  void initQRCode(BuildContext context, QRViewController qrViewController) {

    if(product != null) {
      return;
    }
    product = Product();

    qrViewController.scannedDataStream.listen((e) async {
      Product? productFinded = await ProductRepository().findProductByRef(e.code.toString());

      if(productFinded == null) {
        product = null;
        return;
      }

      if(!context.mounted) {
        return;
      }

      product = productFinded;
      context.replace(Routes.product);
    });

  }

}
