import 'package:flutter/material.dart';
import 'package:support/features/create_account/presentation/screen/create_account.dart';
import 'package:support/features/home/presentation/home_screen.dart';
import 'package:support/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:support/features/not_found_screen/presentation/not_found_screen.dart';
import 'package:support/features/privacy_policy/presentation/screen/privacy_policy.dart';
import 'package:support/features/qr_scan/presentation/screens/qr_screen.dart';
import 'package:support/features/terms_of_service/presentation/screen/terms_of_service.dart';

class Routes {
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String qrcode = "/qrcode";
  static const String createAccount = "/createaccount";
  static const String privacyPolicy = "/privacy_policy";
  static const String termsOfUse = "/terms_of_use";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());
      case qrcode:
        return MaterialPageRoute(builder: (context)=> const QRCodeScreen());
      case createAccount:
        return MaterialPageRoute(builder: (context) => const CreateAccountScreen());
      case privacyPolicy:
          return MaterialPageRoute(builder: (context)=>const PrivacyPolicyScreen());
      case termsOfUse:
        return MaterialPageRoute(builder: (context)=>const TermsOfUseScreen());
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundScreen());
    }
  }
}
