import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:support/core/utils/translation_utils.dart';

class PrivacyPolicyCheckbox extends StatefulWidget {
  const PrivacyPolicyCheckbox({super.key});

  @override
  _PrivacyPolicyCheckboxState createState() => _PrivacyPolicyCheckboxState();
}

class _PrivacyPolicyCheckboxState extends State<PrivacyPolicyCheckbox> {
  bool _isChecked = false;

  void _onPrivacyPolicyTap() {
    Navigator.pushNamed(context, "/privacy_policy");
  }

  void _onTermsOfUseTap() {
    Navigator.pushNamed(context, "/terms_of_use");
  }

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    return await loadTranslations(context);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ) ??
        const TextStyle(fontSize: 16);

    const TextStyle linkStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.white,
      decoration: TextDecoration.underline,
      decorationColor: Colors.white,
    );

    const double widgetHeight = 56;

    return FutureBuilder<Map<String, String>>(
      future: _loadTranslations(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: widgetHeight,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: widgetHeight,
              child: Center(child: Text('Error loading translations')),
            ),
          );
        }

        final translations = snapshot.data!;
        final agreeToText = translations['agreeTo'] ?? 'I agree to NKCC’s';
        final privacyPolicyText = translations['privacyPolicy'] ?? 'Privacy Policy';
        final termsOfUseText = translations['termsOfUse'] ?? 'Terms of Use';
        final andText = translations['and'] ?? 'and';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: widgetHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                          fillColor: WidgetStateProperty.all(Colors.white),
                          checkColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "$agreeToText ",
                      style: baseStyle,
                      children: [
                        TextSpan(
                          text: privacyPolicyText,
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()..onTap = _onPrivacyPolicyTap,
                        ),
                        TextSpan(
                          text: " $andText ",
                          style: baseStyle,
                        ),
                        TextSpan(
                          text: termsOfUseText,
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()..onTap = _onTermsOfUseTap,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
