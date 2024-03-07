import 'package:app/src/component/card_add_button.dart';
import 'package:app/src/const.dart';
import 'package:app/src/entity/category.dart';
import 'package:app/src/entity/product.dart';
import 'package:app/src/provider/cart_provider.dart';
import 'package:app/src/provider/product_list_provider.dart';
import 'package:app/src/utils/formatPrice.dart';
import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 0.0),
        child: Consumer<ProductListProvider>(
          builder: (context, value, child) {
            if(value.categoriesProducts == null) {
              return const CircularProgressIndicator();
            }
            return Column(
              children: [
                ...value.categoriesProducts.entries.map((entry) => card(context, value, entry))
              ],
            );
          }
        )
      )
    );
  }

  Widget card(BuildContext context, ProductListProvider productListProvider, MapEntry<Category, List<Product>> mapEntry) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: '${mapEntry.key.name.toString().toUpperCase()} ',
            style: Theme.of(context).textTheme.displayLarge,
            children: <TextSpan>[
              TextSpan(
                text: '(${mapEntry.value.length.toString()})',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ]
          ),
        ),
        const SizedBox(height: 10.0),
        AutoHeightGridView(
          shrinkWrap: true,
          itemCount: productListProvider.categoriesNbProductsDisplayed[mapEntry.key],
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 5.0,
          padding: null,
          builder: (context, i) =>
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                border: Border.all(
                    color: const Color(0xffdddddd),
                    width: 1.0
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x1a000000),
                      blurRadius: 4.0,
                      blurStyle: BlurStyle.outer
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(4))
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: CachedNetworkImage(
                      memCacheWidth: 200,
                      memCacheHeight: 200,
                      maxWidthDiskCache: 200,
                      maxHeightDiskCache: 200,
                      imageUrl: '$apiUrl/media/images/product/${mapEntry.value[i].id}/${mapEntry.value[i].images?[0]}',
                      progressIndicatorBuilder: (_, __, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (_, __, ___) => const Icon(Icons.error),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10.0
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Color(0xffdddddd)
                        )
                      )
                    ),
                    child: Text(
                      mapEntry.value[i].name.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(Radius.circular(4))
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0
                    ),
                    child: Text(
                      formatPrice(mapEntry.value[i].unitPrice!),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  cartAddButton(context, cartProvider, mapEntry.value[i]),
                ],
              )
            )
        ),
        const SizedBox(height: 10.0),
        if(mapEntry.value.length > productListProvider.categoriesNbProductsDisplayed[mapEntry.key])
          Center(
            child: TextButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0
                ),
              ),
              onPressed: () {
                productListProvider.seeMoreProducts(mapEntry.key);
              },
              child: Text(
                'Voir plus',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
