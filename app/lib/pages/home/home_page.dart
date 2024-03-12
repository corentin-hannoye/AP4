import 'dart:convert';

import 'package:app/model/category_model.dart';
import 'package:app/model/product_model.dart';
import 'package:app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:auto_height_grid_view/auto_height_grid_view.dart';

import '../loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String? apiUrl = dotenv.env['API_URL'];
  // Tous les produits avec leur catégorie respective
  final Map<CategoryModel, List<ProductModel>> categoriesProducts = {};
  // Toutes les catégories avec leur nombre de produit actuellement afficher à l'écran
  final Map<CategoryModel, int> categoriesNbProductsDisplayed = {};

  bool loading = false;

  static const int productsPerPage = 4;

  Future<void> getCategoriesAndArticles() async {
    setState(() {
      loading = true;
    });

    final http.Response response = await http.get(Uri.parse('$apiUrl/api/categories-products'));

    if(response.statusCode != 200) {
      return;
    }

    final Map responseJson = jsonDecode(response.body);

    for(MapEntry e in responseJson.entries) {
      // Ex categoryData[0] = [1, 'Rugby']
      List<String> categoryData = e.key.toString().split(' ');

      CategoryModel category = CategoryModel(int.parse(categoryData[0]), categoryData[1]);

      List<ProductModel> products = [];

      for(Map<dynamic, dynamic> p in e.value) {
        ProductModel product = ProductModel.fromJson(p);
        products.add(product);
      }

      if(products.length > productsPerPage) {
        categoriesNbProductsDisplayed[category] = productsPerPage;
      } else {
        categoriesNbProductsDisplayed[category] = products.length;
      }

      setState(() {
        categoriesProducts[category] = products;
      });
    }
    setState(() {
      loading = false;
    });
  }

  void seeMoreProducts(CategoryModel category) {
    int productsDisplayedAfterUpdate = categoriesNbProductsDisplayed[category]! + productsPerPage;

    setState(() {
      if(productsDisplayedAfterUpdate > categoriesProducts[category]!.length) {
        categoriesNbProductsDisplayed[category] = categoriesProducts[category]!.length;
        return;
      }
      categoriesNbProductsDisplayed[category] = productsDisplayedAfterUpdate;
    });
  }

  @override
  void initState() {
    getCategoriesAndArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ?
        const LoaderPage() :
        sectionCategory();
  }

  Widget sectionCategory() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
        child: Column(
          children: categoriesProducts.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: '${entry.key.getName.toString().toUpperCase()} ',
                    style: Theme.of(context).textTheme.displayLarge,
                    children: <TextSpan>[
                      TextSpan(
                        text: '(${entry.value.length.toString()})',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ]
                  ),
                ),
                const SizedBox(height: 10),
                AutoHeightGridView(
                  shrinkWrap: true,
                  itemCount: categoriesNbProductsDisplayed[entry.key]!,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  padding: null,
                  builder: (context, i) {
                    return Container(
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
                            child: Image.network(
                              '$apiUrl/media/images/product/${entry.value[i].getId}/${entry.value[i].getImages?[0]}',
                              loadingBuilder: (context, child, loadingProgress) {
                                if(loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }
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
                              entry.value[i].getName.toString(),
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
                              entry.value[i].getUnitPrice.toString(),
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
                              print("Produit ${int.parse(entry.value[i].getId.toString())} ajouté au panier pour l'utilisateur ${UserModel.session?.getName}");
                            },
                            child: const Icon(
                              Icons.add_shopping_cart,
                              color: Color(0xff888888)
                            ),
                          )
                        ],
                      )
                    );
                  }
                ),
                const SizedBox(height: 10),
                if(entry.value.length > categoriesNbProductsDisplayed[entry.key]!)
                  Center(
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20
                        ),
                      ),
                      onPressed: () {
                        seeMoreProducts(entry.key);
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
          }).toList()
        )
      ),
    );
  }
}
