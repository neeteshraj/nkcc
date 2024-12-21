import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:support/config/routes/route_manager.dart';
import 'package:support/config/routes/routes.dart';
import 'package:support/core/constants/app_constants.dart';
import 'package:support/core/localization/localization.dart';
import 'package:support/core/theme/app_theme.dart';
import 'package:support/core/utils/locale_utils.dart';
import 'package:support/features/onboarding/presentation/bloc/bill/product_code_cubit.dart';
import 'features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'core/dependency/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: initialRoute,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
