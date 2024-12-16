import 'package:flutter/material.dart';
import 'package:support/core/utils/size_utils.dart';

class TranslatedText extends StatelessWidget {
  final String translationKey;
  final Map<String, String> translations;

  const TranslatedText({
    super.key,
    required this.translationKey,
    required this.translations,
  });

  @override
  Widget build(BuildContext context) {
    final translatedText = translations[translationKey] ?? translationKey;

    TextStyle headlineStyle = Theme.of(context).textTheme.headlineLarge?.copyWith(
      fontSize: 48,
      color: Colors.white,
    ) ??
        const TextStyle(fontSize: 48);

    return Padding(
      padding: SizeUtils.getPadding(context, 0, 0.23),
      child: Text(
        translatedText,
        textAlign: TextAlign.center,
        style: headlineStyle,
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final Map<String, String> translations;

  const DescriptionWidget({
    super.key,
    required this.translations,
  });

  @override
  Widget build(BuildContext context) {
    final descriptionText =
        translations['createAccountDescription'] ?? 'Create your account to get started!';

    TextStyle descriptionStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ) ??
        const TextStyle(fontSize: 16);

    return Padding(
      padding: SizeUtils.getPadding(context, 0, 0.1),
      child: Text(
        descriptionText,
        textAlign: TextAlign.center,
        style: descriptionStyle,
      ),
    );
  }
}
