import 'package:app/src/component/cartAddButton.dart';
import 'package:app/src/const.dart';
import 'package:app/src/entity/store.dart';
import 'package:app/src/provider/cart_provider.dart';
import 'package:app/src/provider/qr_code_provider.dart';
import 'package:app/src/utils/formatPrice.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    QRCodeProvider qrCodeProvider = Provider.of<QRCodeProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          qrCodeProvider.product!.name.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: ()  => context.pop(),
          child: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: CachedNetworkImage(
                  memCacheWidth: 200,
                  memCacheHeight: 200,
                  maxWidthDiskCache: 200,
                  maxHeightDiskCache: 200,
                  imageUrl: '$apiUrl/media/images/product/${qrCodeProvider.product!.id}/${qrCodeProvider.product!.images?[0]}',
                  progressIndicatorBuilder: (_, __, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Divider(),
            const SizedBox(height: 10.0),
            cartAddButton(context, cartProvider, qrCodeProvider.product!),
            const SizedBox(height: 10.0),
            Text(
              'Libellé',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10.0),
            Text(
              qrCodeProvider.product!.name.toString()
            ),
            const SizedBox(height: 20.0),
            Text(
              'Description',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10.0),
            Text(
              qrCodeProvider.product!.description.toString(),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Prix',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10.0),
            Text(
              formatPrice(qrCodeProvider.product!.unitPrice!),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Disponibilité',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10.0),
            test(qrCodeProvider.product?.stores)
          ],
        ),
      ),
    );
  }

  Widget test(List<Store>? stores) {

    if(stores == null || stores.isEmpty) {
      return const Text('Produit en rupture de stock dans nos magasins');
    }

    return Column(
      children: [
        ...stores.map((store) =>
          Row(
            children: [
              Text('(${store.country.toString()}) '),
              Text('${store.city} '),
              Text(
                '${store.quantity} unit.',
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        )
      ],
    );
  }
}
