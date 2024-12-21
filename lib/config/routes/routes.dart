import 'package:flutter/material.dart';
import 'package:support/core/widgets/global/custom_bottom_tab.dart';
import 'package:support/features/create_account/presentation/screen/create_account.dart';
import 'package:support/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:support/features/not_found_screen/presentation/not_found_screen.dart';
import 'package:support/features/privacy_policy/presentation/screen/privacy_policy.dart';
import 'package:support/features/products/presentation/screens/products_screen.dart';
import 'package:support/features/profile/presentation/screens/profile_screen.dart';
import 'package:support/features/qr_scan/presentation/screens/qr_screen.dart';
import 'package:support/features/services/presentation/screens/services_screen.dart';
import 'package:support/features/terms_of_service/presentation/screen/terms_of_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class Routes {
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String qrcode = "/qrcode";
  static const String createAccount = "/createaccount";
  static const String privacyPolicy = "/privacy_policy";
  static const String termsOfUse = "/terms_of_use";
  static const String services ="/services";
  static const String products = "/products";
  static const String profile = "/profile";

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Log the navigation event
    _logNavigationEvent(settings.name);

    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const CustomBottomTab(), settings: settings);
      case onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());
      case qrcode:
        return MaterialPageRoute(builder: (context) => const QRCodeScreen());
      case createAccount:
        return MaterialPageRoute(builder: (context) => const CreateAccountScreen());
      case privacyPolicy:
        return MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen());
      case termsOfUse:
        return MaterialPageRoute(builder: (context) => const TermsOfUseScreen());
      case services:
        return MaterialPageRoute(builder: (context) => const ServicesScreen());
      case products:
        return MaterialPageRoute(builder: (context) => const ProductsScreen());
      case profile:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundScreen());
    }
  }

  // Function to log navigation event
  static Future<void> _logNavigationEvent(String? routeName) async {
    if (routeName != null) {
      await _analytics.logEvent(
        name: 'navigation_event',
        parameters: {
          'route_name': routeName,
        },
      );
    }
  }
}