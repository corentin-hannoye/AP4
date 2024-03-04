import 'package:app/src/provider/qr_code_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// 3 first letters of supplier, 3 first letters of category and id (INT A.I. 12 length)
// E.g : 
class QRCode extends StatelessWidget {

  const QRCode({super.key});

  @override
  Widget build(BuildContext context) {
    QRCodeProvider qrCodeProvider = Provider.of<QRCodeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'Scannez un QRCode',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrCodeProvider.qrKey,
              onQRViewCreated: (qrViewController) => qrCodeProvider.initQRCode(context, qrViewController),
              overlay: QrScannerOverlayShape(
                borderWidth: 10.0,
                borderLength: 20.0,
                borderColor: Theme.of(context).colorScheme.secondary,
              )
            ),
          ),
        ],
      ),
    );
  }
}
