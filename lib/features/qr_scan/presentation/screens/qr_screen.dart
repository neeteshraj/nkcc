import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/qr_scan/presentation/widgets/corner_border_painter.dart';

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

    if (status.isGranted) {
      setState(() => hasPermission = true);
    } else if (status.isDenied) {
      final result = await Permission.camera.request();

      if (result.isGranted) {
        setState(() => hasPermission = true);
      } else {
        _showPermissionDialog();
      }
    } else if (status.isPermanentlyDenied) {
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
                // Camera view
                MobileScanner(
                  controller: cameraController,
                  onDetect: (BarcodeCapture barcodeCapture) {
                    cameraController.stop();
                    Navigator.pop(
                        context, barcodeCapture.barcodes.first.rawValue);
                  },
                ),

                Positioned.fill(
                  child:
                      ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.srcOut,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            backgroundBlendMode:
                                BlendMode.dstOut,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              // Existing Red Transparent Box
                              Container(
                                margin: SizeUtils.getMargin(context, 0, 0.05),
                                height: SizeUtils.getHeight(context, 0.6),
                                width: SizeUtils.getWidth(context, 0.9),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(
                                    SizeUtils.getBorderRadius(context, 0.05),
                                  ),
                                ),
                              ),
                              // Overlay Border for Corners Only
                              CustomPaint(
                                size: Size(
                                  SizeUtils.getWidth(context, 0.9),
                                  SizeUtils.getHeight(context, 0.6),
                                ),
                                painter: CornerBorderPainter(
                                  radius: SizeUtils.getBorderRadius(context, 0.05),
                                  borderWidth: 2,
                                  borderColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                // Top bar with title and back button
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
                      const Text(
                        'Scan Barcode',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

                // Scan instructions at the bottom
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

                // Scan indicator icon at the bottom
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
