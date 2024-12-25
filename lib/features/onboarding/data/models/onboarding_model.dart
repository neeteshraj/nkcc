import 'package:support/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingModel extends OnboardingEntity {
  final String imagePath;

  OnboardingModel({
    required super.title,
    required super.description,
    required this.imagePath,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      title: json['title'],
      description: json['description'],
      imagePath: json['imagePath'],
    );
  }

  OnboardingEntity toEntity() {
    return OnboardingEntity(
      title: title,
      description: description,
    );
  }
}
