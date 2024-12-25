import 'package:flutter/material.dart';

class AppTheme {
  static TextTheme _buildResponsiveTextTheme(BuildContext context, TextTheme base) {
    double responsiveFontSize(double baseFontSize) {
      final screenWidth = MediaQuery.of(context).size.width;
      return baseFontSize * (screenWidth / 375.0);
    }

    return base.copyWith(
      headlineLarge: base.headlineLarge?.copyWith(
        fontSize: responsiveFontSize(40),
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: responsiveFontSize(20),
      ),
      displayLarge: base.displayLarge?.copyWith(
        fontSize: responsiveFontSize(30),
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: responsiveFontSize(13),
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: responsiveFontSize(16),
      ),
    );
  }

  static ThemeData lightTheme(BuildContext context) => ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Inter',
    textTheme: _buildResponsiveTextTheme(
      context,
      const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontFamily: "BebasNeue",
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Inter',
    textTheme: _buildResponsiveTextTheme(
      context,
      const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontFamily: "BebasNeue",
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
