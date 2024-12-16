import 'package:flutter/material.dart';
import 'package:support/core/constants/images_paths.dart';
import 'package:support/core/utils/translation_utils.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

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
          top: 60,
          left: 16,
          right: 16,
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      ImagesPaths.arrowLeft,
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  translations['scanBarcode'] ?? 'Scan Barcode',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Image.asset(
                    ImagesPaths.settings,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    print('Settings button pressed');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
