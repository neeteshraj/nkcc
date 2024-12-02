import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

Future<Map<String, String>> loadTranslations(BuildContext context) async {
  final locale = Localizations.localeOf(context).languageCode;
  final jsonString = await rootBundle.loadString('assets/lang/$locale.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonString);

  return jsonMap.map((key, value) => MapEntry(key, value.toString()));
}
