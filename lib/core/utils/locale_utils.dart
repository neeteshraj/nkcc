import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocaleUtils {
  static Locale getCurrentLocale() {
    return const Locale('en', '');
  }

  static Future<Map<String, String>> loadTranslations(String locale) async {
    final String data =
        await rootBundle.loadString('assets/translations/$locale.json');
    final Map<String, dynamic> translations = json.decode(data);
    return translations.map((key, value) => MapEntry(key, value.toString()));
  }
}
