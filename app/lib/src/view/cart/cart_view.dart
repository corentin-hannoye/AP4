import 'package:app/src/const.dart';
import 'package:app/src/entity/product.dart';
import 'package:app/src/provider/cart_provider.dart';
import 'package:app/src/utils/formatPrice.dart';
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
          children: <Widget>[
            Text(
              'Mon panier',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20.0),
            if(cartProvider.productCount <= 0)
              const Text("Votre panier est vide, ajoutez-y des produits dès maintenant !")
            else
              details(context, cartProvider),
              const SizedBox(height: 20.0),
              ...cartProvider.products.entries.map((entry) => card(cartProvider, entry))
          ],
        ),
      )
    );
  }

  Widget details(BuildContext context, CartProvider cartProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Prix à payer : ${formatPrice(cartProvider.getTotalPrice())} pour ${cartProvider.productCount} produits'),
        const SizedBox(height: 20.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () => print('passage de la commande'),
          child: Text(
            'Passer commande',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        )
      ],
    );
  }
  
  Widget card(CartProvider cartProvider, MapEntry<Product, int> mapEntry) {
    List<int> choices = [0,1,2,3,4,5,6,7,8,9,10];

    if(!choices.contains(mapEntry.value)) {
      choices.add(mapEntry.value);
    }
    return Column(
      children: <Widget>[
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: CachedNetworkImage(
                memCacheWidth: 150,
                memCacheHeight: 150,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    mapEntry.key.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    mapEntry.key.ref.toString(),
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  DropdownMenu<int>(
                    key: GlobalKey(),
                    initialSelection: mapEntry.value,
                    onSelected: (value) => cartProvider.setProduct(mapEntry.key, value!),
                    expandedInsets: EdgeInsets.zero,
                    label: const Text('Quantité'),
                    inputDecorationTheme: const InputDecorationTheme(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      constraints: BoxConstraints.expand(
                        width: 150.0,
                        height: 50.0
                      ),
                    ),
                    dropdownMenuEntries: [
                      ...choices.map((e) =>
                        DropdownMenuEntry(
                          leadingIcon: e == 0 ? const Icon(Icons.delete) : null,
                          label: e.toString() + (e == 0 ? ' (supprimer)' : ''),
                          value: e,
                        )
                      )
                    ],
                  ),
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
