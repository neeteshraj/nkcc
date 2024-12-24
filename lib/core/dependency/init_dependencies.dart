import 'package:get_it/get_it.dart';
import 'package:support/core/database/database_helper.dart';
import 'package:support/core/database/user/user_database_service.dart';
import 'package:support/core/database/user/user_repository.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/features/home/presentation/bloc/user_cubit.dart';
import 'package:support/features/onboarding/presentation/bloc/bill/product_code_cubit.dart';
import 'package:support/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:support/features/startup/presentation/bloc/translations_cubit.dart';
import 'package:support/features/startup/presentation/bloc/user/user_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  serviceLocator.registerSingleton<OnboardingCubit>(OnboardingCubit());

  serviceLocator.registerLazySingleton<ProductCodeCubit>(()=>ProductCodeCubit(ApiService()));

  serviceLocator.registerLazySingleton(() => DatabaseHelper());

  serviceLocator.registerLazySingleton(() => UserDatabaseService(databaseHelper: serviceLocator()));

  serviceLocator.registerLazySingleton(() => UserRepository(userDatabaseService: serviceLocator()));

  serviceLocator.registerLazySingleton(() => UserCubit(serviceLocator<UserDatabaseService>()));

  serviceLocator.registerLazySingleton(() => TranslationsCubit());

  serviceLocator.registerLazySingleton(()=>StartUpUserCubit(apiService: ApiService()));

}
