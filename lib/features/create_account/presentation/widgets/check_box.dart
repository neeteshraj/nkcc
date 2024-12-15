import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:support/core/utils/translation_utils.dart';

class PrivacyPolicyCheckbox extends StatefulWidget {
  const PrivacyPolicyCheckbox({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyCheckboxState createState() => _PrivacyPolicyCheckboxState();
}

class _PrivacyPolicyCheckboxState extends State<PrivacyPolicyCheckbox> {
  bool _isChecked = false;

  void _onPrivacyPolicyTap() {}

  void _onTermsOfUseTap() {}

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    return await loadTranslations(context);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ) ?? const TextStyle(fontSize: 16);

    const TextStyle linkStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.white,
      decoration: TextDecoration.underline,
      decorationColor: Colors.white,
    );

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
        final agreeToText = translations['agreeTo'] ?? 'I agree to NKCC’s';
        final privacyPolicyText = translations['privacyPolicy'] ?? 'Privacy Policy';
        final termsOfUseText = translations['termsOfUse'] ?? 'Terms of Use';
        final andText = translations['and'] ?? 'and';

        return Container(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
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
              ),
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
        );
      },
    );
  }
}
