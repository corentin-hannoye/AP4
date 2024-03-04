import 'package:app/src/const.dart';
import 'package:app/src/entity/product.dart';
import 'package:app/src/provider/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mon panier',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20.0),
            if(cartProvider.productCount <= 0)
              const Text("Votre panier est vide")
            else
              ...cartProvider.products.entries.map((entry) => card(entry))
          ],
        ),
      )
    );
  }
  
  Widget card(MapEntry<Product, int> mapEntry) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: CachedNetworkImage(
                maxWidthDiskCache: 150,
                maxHeightDiskCache: 150,
                imageUrl: '$apiUrl/media/images/product/${mapEntry.key.id}/${mapEntry.key.images?[0]}',
                progressIndicatorBuilder: (_, __, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (_, __, ___) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                children: [
                  Text(
                    mapEntry.key.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  TextFormField(
                    key: Key(mapEntry.value.toString()),
                    initialValue: mapEntry.value.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => print(value),
                  )
                ],
              )
            )
          ],
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
