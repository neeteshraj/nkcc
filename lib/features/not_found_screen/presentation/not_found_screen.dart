import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support/core/constants/app_constants.dart';
import 'package:support/core/constants/images_paths.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/core/utils/translation_utils.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double imageWidth = SizeUtils.getWidth(context, 0.2);
    double imageHeight = SizeUtils.getHeight(context, 0.2);

    return FutureBuilder<Map<String, String>>(
      future: loadTranslations(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading translations'));
        } else if (snapshot.hasData) {
          var translations = snapshot.data!;

          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConstants.four,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          ImagesPaths.notFoundImage,
                          width: imageWidth,
                          height: imageHeight,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          AppConstants.four,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      translations['pageMissing'] ?? 'Page Missing',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      translations['pageMissingDescription'] ?? 'Page description not found.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: AppColors.primaryColor
                      ),
                      child: Text(
                        translations['findShelter'] ?? 'Find Shelter',
                        style: const TextStyle(
                          color: AppColors.textLight
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('No translations found'));
        }
      },
    );
  }
}
