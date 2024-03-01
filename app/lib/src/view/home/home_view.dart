import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('En développement...');
  }

  /*
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
                              print("Produit ${int.parse(entry.value[i].getId.toString())} ajouté au panier pour l'utilisateur ${User.session?.getName}");
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
  }*/

}
