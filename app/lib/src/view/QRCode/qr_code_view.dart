import 'package:app/src/provider/qr_code_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

// 3 first letters of supplier, 3 first letters of category and id (INT A.I. 12 length)
// E.g : MUTVEL000000000011, MUT VEL 000000000011
class QRCodeView extends StatelessWidget {

  const QRCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    QRCodeProvider qrCodeProvider = Provider.of<QRCodeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates
              ),
              onDetect: (capture) => qrCodeProvider.onCapture(context, capture),
              overlay: QRScannerOverlay(),
            ),
            Positioned(
              left: 20,
              top: 20,
              child: Container(
                alignment: Alignment.center,
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                ),
                child: GestureDetector(
                  onTap: ()  => context.pop(),
                  child: const Icon(Icons.arrow_back_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
