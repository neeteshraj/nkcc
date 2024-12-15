import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraScanner extends StatelessWidget {
  final MobileScannerController controller;

  const CameraScanner({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (BarcodeCapture barcodeCapture) {
        controller.stop();
        Navigator.pop(context, barcodeCapture.barcodes.first.rawValue);
      },
    );
  }
}
