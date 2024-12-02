import 'package:flutter/material.dart';

class SizeUtils {
  static double getHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  static double getWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  static double getBorderRadius(BuildContext context, double percentage) {
    return (MediaQuery.of(context).size.shortestSide) * percentage;
  }

  static EdgeInsets getPadding(
      BuildContext context, double vertical, double horizontal) {
    return EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height * vertical,
      horizontal: MediaQuery.of(context).size.width * horizontal,
    );
  }

  static EdgeInsets getMargin(
      BuildContext context, double vertical, double horizontal) {
    return EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height * vertical,
      horizontal: MediaQuery.of(context).size.width * horizontal,
    );
  }
}
