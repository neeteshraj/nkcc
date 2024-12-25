import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_cubit.dart';

class PrivacyPolicyCheckbox extends StatefulWidget {
  const PrivacyPolicyCheckbox({super.key});

  @override
  _PrivacyPolicyCheckboxState createState() => _PrivacyPolicyCheckboxState();
}

class _PrivacyPolicyCheckboxState extends State<PrivacyPolicyCheckbox> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: 14,
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

    const double widgetHeight = 56;

    return FutureBuilder<Map<String, String>>(
      future: _loadTranslations(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: widgetHeight,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return SizedBox(
                          height: 20,
                          width: 20,
                          child: GestureDetector(
                            onTap: () {
                              bool currentValue = context.read<CreateAccountCubit>().state.isPrivacyPolicyChecked;
                              context.read<CreateAccountCubit>().togglePrivacyPolicyCheckbox(!currentValue);
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: context.read<CreateAccountCubit>().state.isPrivacyPolicyChecked
                                  ? const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.black,
                              )
                                  : null,
                            ),
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
          ),
        );
      },
    );
  }
}