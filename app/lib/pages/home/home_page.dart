import 'dart:convert';

import 'package:app/model/category_model.dart';
import 'package:app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String? apiUrl = dotenv.env['API_URL'];
  final Map<CategoryModel, List<ProductModel>> categoriesProducts = {};

  Future<void> getCategoriesAndArticles() async {

    final http.Response response = await http.get(Uri.parse('${apiUrl}categories-products'));

    if(response.statusCode != 200) {
      return;
    }

    final Map responseJson = jsonDecode(response.body);

    for(MapEntry e in responseJson.entries) {
      List<String> categoryData = e.key.toString().split(' ');

      CategoryModel category = CategoryModel(int.parse(categoryData[0]), categoryData[1], categoryData[2]);

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
      children: [
        sectionCategory(categoriesProducts)
      ]
    );
  }

  Widget sectionCategory(Map categoriesProducts) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        top: 60,
        bottom: 20
      ),
      child: Column(
        children: categoriesProducts.entries.map((entry) {
          return Column(
            children: <Widget>[
              Text(entry.key.getName),
              const SizedBox(height: 10),
              Container(
                height: 50,
                child: GridView.builder(
                  itemCount: entry.value.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context).colorScheme.onPrimary,
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
                      child: Text(entry.value[index].getName),
                    );
                  }
                ),
              )
            ],
          );
        }).toList()
      )
    );
  }
}
