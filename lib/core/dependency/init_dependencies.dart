import 'package:get_it/get_it.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/features/onboarding/presentation/bloc/bill/product_code_cubit.dart';

import '../../features/onboarding/presentation/bloc/onboarding_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  serviceLocator.registerSingleton<OnboardingCubit>(OnboardingCubit());

  serviceLocator.registerLazySingleton<ProductCodeCubit>(()=>ProductCodeCubit(ApiService()));

}
