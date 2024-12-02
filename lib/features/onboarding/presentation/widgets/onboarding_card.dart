import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/onboarding/data/models/onboarding_model.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingModel onboardingData;

  const OnboardingCard({super.key, required this.onboardingData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeUtils.getPadding(context, 0.05, 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeUtils.getHeight(context, 0.4),
            child: SvgPicture.asset(
              onboardingData.imagePath,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: SizeUtils.getHeight(context, 0.03)),
          Text(
            onboardingData.title,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeUtils.getHeight(context, 0.02)),
          Text(
            onboardingData.description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
