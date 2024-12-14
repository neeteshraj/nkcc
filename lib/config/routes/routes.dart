import 'package:flutter/material.dart';
import 'package:support/features/home/presentation/home_screen.dart';
import 'package:support/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:support/features/not_found_screen/presentation/not_found_screen.dart';

class Routes {
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String qrcode = "/qrcode";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());
      // case qrcode:
      //   return MaterialPageRoute(builder: (context)=> const QRCodeScreen());
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundScreen());
    }
  }
}
