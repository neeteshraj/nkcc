import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:support/config/logger/logger.dart';
import 'package:support/config/routes/routes.dart';

class CameraScanner extends StatefulWidget {
  final MobileScannerController controller;

  const CameraScanner({Key? key, required this.controller}) : super(key: key);

  @override
  _CameraScannerState createState() => _CameraScannerState();
}

class _CameraScannerState extends State<CameraScanner> {
  bool isNavigating = false;

  @override
  void dispose() {
    widget.controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: widget.controller,
      onDetect: (BarcodeCapture barcodeCapture) {
        if (isNavigating) return;

        final barcode = barcodeCapture.barcodes.first.rawValue;
        if (barcode != null) {
          LoggerUtils.logInfo("QR Code Detected: $barcode");

          setState(() {
            isNavigating = true;
          });

          Navigator.pushNamed(
            context,
            Routes.createAccount,
            arguments: barcode,
          ).then((_) {
            setState(() {
              isNavigating = false;
            });
          });
        }
      },
    );
  }
}
