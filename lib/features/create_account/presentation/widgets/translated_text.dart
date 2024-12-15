import 'package:flutter/material.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'package:support/core/utils/size_utils.dart';

class TranslatedText extends StatelessWidget {
  final String translationKey;

  const TranslatedText({
    super.key,
    required this.translationKey,
  });

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    return await loadTranslations(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _loadTranslations(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return const Center(child: Text('Error loading translations'));
        }

        final translations = snapshot.data!;
        final translatedText = translations[translationKey] ?? translationKey;

        TextStyle headlineStyle = Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: 48,
          color: Colors.white,
        ) ?? const TextStyle(fontSize: 48);

        return Padding(
          padding: SizeUtils.getPadding(context, 0, 0.23),
          child: Text(
            translatedText,
            textAlign: TextAlign.center,
            style: headlineStyle,
          ),
        );
      },
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    return await loadTranslations(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _loadTranslations(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return const Center(child: Text('Error loading translations'));
        }

        final translations = snapshot.data!;
        final descriptionText = translations['createAccountDescription'] ?? 'Create your account to get started!';

        TextStyle descriptionStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ) ?? const TextStyle(fontSize: 16);

        return Padding(
          padding: SizeUtils.getPadding(context, 0, 0.1),
          child: Text(
            descriptionText,
            textAlign: TextAlign.center,
            style: descriptionStyle,
          ),
        );
      },
    );
  }
}
