import 'package:get_it/get_it.dart';

import '../../features/onboarding/presentation/bloc/onboarding_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  serviceLocator.registerSingleton<OnboardingCubit>(OnboardingCubit());

}
