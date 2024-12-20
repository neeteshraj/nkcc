import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/qr_scan/presentation/widgets/camera_scanner.dart';
import 'package:support/features/qr_scan/presentation/widgets/corner_images.dart';
import 'package:support/features/qr_scan/presentation/widgets/permission_dialog.dart';
import 'package:support/features/qr_scan/presentation/widgets/scan_indicator.dart';
import 'package:support/features/qr_scan/presentation/widgets/scan_instructions.dart';
import 'package:support/features/qr_scan/presentation/widgets/top_bar.dart';
import 'package:support/features/qr_scan/presentation/widgets/scan_animation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> with SingleTickerProviderStateMixin {
  bool isFlashOn = false;
  bool hasPermission = false;
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates
  );

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
      builder: (context) => const PermissionDialog(),
    );
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
          CameraScanner(
            controller: cameraController,
          ),
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha:0.3),
                BlendMode.srcOut,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: SizeUtils.getMargin(context, 0, 0.05),
                      height: SizeUtils.getHeight(context, 0.6),
                      width: SizeUtils.getWidth(context, 0.89),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(
                          SizeUtils.getBorderRadius(context, 0.04),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CornerImages(),
          const TopBar(),
          const ScanInstructions(),
          const ScanIndicator(),
          Positioned(
            bottom: SizeUtils.getHeight(context, 0.198),
            left: 0,
            right: 0,
            child: ScanAnimation(
              height: SizeUtils.getHeight(context, 0.6),
              playbackSpeed: 1,
            ),
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
