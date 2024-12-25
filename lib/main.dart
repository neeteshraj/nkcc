import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:support/config/routes/route_manager.dart';
import 'package:support/config/routes/routes.dart';
import 'package:support/core/constants/app_constants.dart';
import 'package:support/core/database/user/user_database_service.dart';
import 'package:support/core/localization/localization.dart';
import 'package:support/core/theme/app_theme.dart';
import 'package:support/core/utils/locale_utils.dart';
import 'package:support/features/home/presentation/bloc/product_cubit.dart';
import 'package:support/features/home/presentation/bloc/user_cubit.dart';
import 'package:support/features/onboarding/presentation/bloc/bill/product_code_cubit.dart';
import 'package:support/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:support/features/startup/presentation/bloc/translations_cubit.dart';
import 'package:support/features/startup/presentation/bloc/user/user_cubit.dart';
import 'core/dependency/init_dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // FirebaseMessagingService firebaseMessagingService = FirebaseMessagingService();
  // await firebaseMessagingService.initialize();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  await initDependencies();
  final initialRoute = await RouteManager.getInitialRoute();
  FlutterNativeSplash.remove();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<OnboardingCubit>(
        create: (context) => serviceLocator<OnboardingCubit>(),
      ),
      BlocProvider<ProductCodeCubit>(
        create: (context) => serviceLocator<ProductCodeCubit>(),
      ),
      BlocProvider<UserCubit>(
        create: (context) => UserCubit(serviceLocator<UserDatabaseService>()),
      ),
      BlocProvider<TranslationsCubit>(
        create: (context) => serviceLocator<TranslationsCubit>(),
      ),
      BlocProvider<StartUpUserCubit>(
        create: (context) => serviceLocator<StartUpUserCubit>(),
      ),
      // Add ProductCubit here
      BlocProvider<ProductCubit>(
        create: (context) => serviceLocator<ProductCubit>(),
      ),
    ],
    child: MyApp(initialRoute: initialRoute),
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appTitle,
      localizationsDelegates: AppLocalizations.delegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: LocaleUtils.getCurrentLocale(),
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      initialRoute: Routes.startup,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
