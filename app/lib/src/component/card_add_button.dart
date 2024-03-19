import 'package:app/src/const.dart';
import 'package:app/src/entity/product.dart';
import 'package:app/src/provider/cart_provider.dart';
import 'package:flutter/material.dart';

Widget cartAddButton(BuildContext context, CartProvider cartProvider, Product product) {
  Product? productFinded = cartProvider.isAlreadyExist(product);

  if(productFinded != null) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: errorColor.withOpacity(0.4),
              fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                side: BorderSide(
                  width: 2.0,
                  color: errorColor,
                )
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8.0
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => cartProvider.removeProduct(product),
            child: Icon(
              Icons.remove,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Text(cartProvider.products[productFinded].toString()),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: successColor.withOpacity(0.4),
              fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                side: BorderSide(
                  width: 2.0,
                  color: successColor,
                )
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8.0
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () => cartProvider.addProduct(product),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    onPressed: () => cartProvider.addProduct(product),
    child: const Icon(
      Icons.add_shopping_cart,
      color: Color(0xff888888)
    ),
  );
}
