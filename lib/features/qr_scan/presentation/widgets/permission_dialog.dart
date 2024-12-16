import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Camera Permission'),
      content: const Text(
        'Camera permission is required to scan QR codes. Please enable it in settings.',
      ),
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
    );
  }
}
