import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_cubit.dart';

class ContinueButton extends StatefulWidget {
  final String translationKey;
  final Map<String, String> translations;
  final GlobalKey<FormState> inputFormKey;


  const ContinueButton({
    super.key,
    required this.translations,
    this.translationKey = 'complete',
    required this.inputFormKey,
  });

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buttonText = widget.translations[widget.translationKey] ?? 'Complete';
    final isPrivacyPolicyChecked =
        context.read<CreateAccountCubit>().state.isPrivacyPolicyChecked;


    return Padding(
      padding: SizeUtils.getPadding(context, 0, 0.05),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (widget.inputFormKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              print("Form submitted successfully!");
              context.read<CreateAccountCubit>().submitForm();
            } else {
              print("Invalid email address or privacy policy not accepted!");
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            backgroundColor: AppColors.buttonBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
