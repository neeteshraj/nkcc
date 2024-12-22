import 'package:flutter/material.dart';
import 'package:support/core/utils/translation_utils.dart';

class ScanInstructions extends StatelessWidget {
  const ScanInstructions({Key? key}) : super(key: key);

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    return await loadTranslations(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _loadTranslations(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return const Center(child: Text('Error loading translations'));
        }

        final translations = snapshot.data!;

        return Positioned(
          bottom: 130,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              translations['alignTheQR'] ?? 'Align the QR code within the frame.',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
