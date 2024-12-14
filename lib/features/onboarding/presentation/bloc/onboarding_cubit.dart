import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingInitial());

  void updateIndex(int index) {
    emit(OnboardingIndexChange(index));
  }

  void nextPage(int currentIndex, int totalPages) {
    if (currentIndex < totalPages - 1) {
      emit(OnboardingIndexChange(currentIndex + 1));
    } else {
      emit(const OnboardingComplete());
    }
  }
}