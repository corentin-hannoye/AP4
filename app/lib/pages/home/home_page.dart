import 'dart:convert';

import 'package:app/model/category_model.dart';
import 'package:app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:auto_height_grid_view/auto_height_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String? apiUrl = dotenv.env['API_URL'];
  final Map<CategoryModel, List<ProductModel>> categoriesProducts = {};

  Future<void> getCategoriesAndArticles() async {

    final http.Response response = await http.get(Uri.parse('$apiUrl/api/categories-products'));

    if(response.statusCode != 200) {
      return;
    }

    final Map responseJson = jsonDecode(response.body);

    for(MapEntry e in responseJson.entries) {
      List<String> categoryData = e.key.toString().split(' ');

      CategoryModel category = CategoryModel(int.parse(categoryData[0]), categoryData[1]);

      List<ProductModel> products = [];

      for(Map i in e.value) {
        ProductModel product = ProductModel.fromJson(i);
        products.add(product);
      }

      setState(() {
        categoriesProducts[category] = products;
      });
    }

  }

  @override
  void initState() {
    getCategoriesAndArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        sectionCategory()
      ]
    );
  }

  Widget sectionCategory() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
      child: Column(
        children: categoriesProducts.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                entry.key.getName.toString().toUpperCase(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              AutoHeightGridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: entry.value.length,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
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
                        Image.network('$apiUrl/media/images/product/${entry.value[i].getId}/${entry.value[i].getImages?[0]}'),
                        const SizedBox(height: 20),
                        Text(
                          entry.value[i].getName.toString(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 20),
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
                            print('Produit ${int.parse(entry.value[i].getId.toString())} ajouté au panier');
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
              const SizedBox(height: 40),
            ],
          );
        }).toList()
      )
    );
  }
}
