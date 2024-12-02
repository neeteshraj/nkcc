import 'package:flutter/material.dart';
import 'package:support/config/routes/routes.dart';
import 'package:support/core/constants/app_constants.dart';
import 'package:support/core/localization/localization.dart';
import 'package:support/core/utils/locale_utils.dart';
import 'package:support/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appTitle,
      localizationsDelegates: AppLocalizations.delegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: LocaleUtils.getCurrentLocale(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: Routes.onboarding,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}