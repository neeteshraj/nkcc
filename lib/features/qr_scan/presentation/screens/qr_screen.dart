import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  bool isFlashOn = false;
  bool hasPermission = false;
  MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.status;
    print('Current Camera Permission Status: $status');

    if (status.isGranted) {
      setState(() => hasPermission = true);
      print('Camera permission already granted');
    } else if (status.isDenied) {
      final result = await Permission.camera.request();
      print('Requested Camera Permission: $result');

      if (result.isGranted) {
        setState(() => hasPermission = true);
        print('Camera permission granted');
      } else {
        print('Camera permission denied');
        _showPermissionDialog();
      }
    } else if (status.isPermanentlyDenied) {
      print('Camera permission permanently denied');
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission'),
        content: const Text(
            'Camera permission is required to scan QR codes. Please enable it in settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  void _toggleFlash() async {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    await cameraController.toggleTorch();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: hasPermission
          ? Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (BarcodeCapture barcodeCapture) {
              print("Detected object: ${barcodeCapture.barcodes.first.rawValue}");
              cameraController.stop();
              Navigator.pop(context, barcodeCapture.barcodes.first.rawValue);
            },
          ),

          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),

                // Title
                const Text(
                  'Scan Barcode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Flash Toggle Icon
                IconButton(
                  icon: Icon(
                    isFlashOn ? Icons.flash_off : Icons.flash_on,
                    color: Colors.white,
                  ),
                  onPressed: _toggleFlash,
                ),
              ],
            ),
          ),

          // Scan Instructions
          Positioned(
            bottom: 150,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text(
                'Align the QR code within the frame.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          // Scan Indicator Icon
          Positioned(
            bottom: 60,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.qr_code_scanner,
                    color: Colors.white, size: 32),
              ),
            ),
          ),
        ],
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
