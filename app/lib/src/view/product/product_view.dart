import 'package:app/src/provider/qr_code_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    QRCodeProvider qrCodeProvider = Provider.of<QRCodeProvider>(context);

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
          onTap: ()  {
            qrCodeProvider.product = null;
            context.pop();
          },
          child: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
        child: Column(
          children: [
            Text(qrCodeProvider.product!.name.toString()),
            const SizedBox(height: 10.0),
            Text(qrCodeProvider.product!.description.toString()),
          ],
        ),
      ),
    );
  }
}
