import 'package:app/src/provider/qr_code_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

// 3 first letters of supplier, 3 first letters of category and id (INT A.I. 12 length)
// E.g : MUTVEL000000000011, MUT VEL 000000000011
class QRCodeView extends StatelessWidget {

  const QRCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    QRCodeProvider qrCodeProvider = Provider.of<QRCodeProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: QRCodeDartScanView(
              formats: const <BarcodeFormat>[
                BarcodeFormat.qrCode
              ],
              resolutionPreset: QRCodeDartScanResolutionPreset.max,
              onCapture: (result) => qrCodeProvider.onCapture(context, result),
              child: QRScannerOverlay(),
            )
          ),
        ],
      ),
    );
  }
}
