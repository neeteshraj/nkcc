import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:support/core/constants/images_paths.dart';
import 'dart:convert';
import 'package:support/features/onboarding/data/models/onboarding_model.dart';

class OnboardingDataSource {
  static Future<List<OnboardingModel>> getOnboardingData(
      BuildContext context) async {
    try {
      final locale = Localizations.localeOf(context).languageCode;
      final jsonString =
          await rootBundle.loadString('assets/lang/$locale.json');
      final jsonMap = json.decode(jsonString);

      return [
        OnboardingModel(
          title: jsonMap['onboarding_title_1'],
          description: jsonMap['onboarding_description_1'],
          imagePath: ImagesPaths.onboarding1,
        ),
        OnboardingModel(
          title: jsonMap['onboarding_title_2'],
          description: jsonMap['onboarding_description_2'],
          imagePath: ImagesPaths.onboarding2,
        ),
        OnboardingModel(
          title: jsonMap['onboarding_title_3'],
          description: jsonMap['onboarding_description_3'],
          imagePath: ImagesPaths.onboarding3,
        ),
      ];
    } catch (e) {
      print("Error loading onboarding data: $e");
      throw Exception("Error loading onboarding data: $e");
    }
  }
}
