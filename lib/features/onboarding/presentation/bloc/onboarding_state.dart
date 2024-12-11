part of 'onboarding_cubit.dart';

abstract class OnboardingState {
  final int index;

  const OnboardingState({required this.index});
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial() : super(index: 0);
}

class OnboardingIndexChange extends OnboardingState {
  const OnboardingIndexChange(int index) : super(index: index);
}

class OnboardingComplete extends OnboardingState {
  const OnboardingComplete() : super(index: -1);
}