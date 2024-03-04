import 'package:app/src/const.dart';
import 'package:app/src/entity/category.dart';
import 'package:app/src/entity/product.dart';
import 'package:app/src/entity/user.dart';
import 'package:app/src/provider/product_list_provider.dart';
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
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
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
        const SizedBox(height: 10),
        AutoHeightGridView(
          shrinkWrap: true,
          itemCount: productListProvider.categoriesNbProductsDisplayed[mapEntry.key],
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
          padding: null,
          builder: (context, i) =>
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                border: Border.all(
                    color: const Color(0xffdddddd),
                    width: 1
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x1a000000),
                      blurRadius: 4,
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
                      maxWidthDiskCache: 200,
                      maxHeightDiskCache: 200,
                      imageUrl: '$apiUrl/media/images/product/${mapEntry.value[i].id}/${mapEntry.value[i].images?[0]}',
                      progressIndicatorBuilder: (_, __, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (_, __, ___) => const Icon(Icons.error),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10
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
                      vertical: 8
                    ),
                    child: Text(
                      mapEntry.value[i].unitPrice.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      print("Produit ${int.parse(mapEntry.value[i].id.toString())} ajouté au panier pour l'utilisateur ${User.session?.getName}");
                    },
                    child: const Icon(
                      Icons.add_shopping_cart,
                      color: Color(0xff888888)
                    ),
                  )
                ],
              )
            )
        ),
        const SizedBox(height: 10),
        if(mapEntry.value.length > productListProvider.categoriesNbProductsDisplayed[mapEntry.key])
          Center(
            child: TextButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20
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
        const SizedBox(height: 30),
      ],
    );
  }
}
