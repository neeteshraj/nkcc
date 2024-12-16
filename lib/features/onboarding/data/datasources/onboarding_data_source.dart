import 'package:flutter/services.dart';
import 'package:support/core/constants/images_paths.dart';
import 'dart:convert';
import 'package:support/features/onboarding/data/models/onboarding_model.dart';

class OnboardingDataSource {
  static Future<List<OnboardingModel>> getOnboardingData(String locale) async {
    try {
      final jsonString = await rootBundle.loadString('assets/lang/$locale.json');
      final jsonMap = json.decode(jsonString);

      return [
        OnboardingModel(
          title: jsonMap['onboarding_title_1'],
          description: jsonMap['onboarding_description_1'],
          imagePath: ImagesPaths.onboardingImage,
        ),
      ];
    } catch (e) {
      print("Error loading onboarding data: $e");
      throw Exception("Error loading onboarding data: $e");
    }
  }
}
