
import 'package:flutter/material.dart';
import 'package:support/config/logger/logger.dart';
import 'package:support/features/onboarding/data/datasources/onboarding_data_source.dart';
import 'package:support/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingRepository {
  Future<List<OnboardingEntity>> fetchOnboardingData(
      BuildContext context) async {
    try {
      final locale = Localizations.localeOf(context).languageCode;

      final models = await OnboardingDataSource.getOnboardingData(locale);

      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      LoggerUtils.logError("Error in repository: $e");
      throw Exception("Error fetching onboarding data: $e");
    }
  }
}
