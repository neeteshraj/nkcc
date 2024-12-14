import 'package:support/features/onboarding/domain/entities/onboarding_entity.dart';

class OnboardingModel extends OnboardingEntity {
  final String imagePath;

  OnboardingModel({
    required String title,
    required String description,
    required this.imagePath,
  }) : super(title: title, description: description);

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
