import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_cubit.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_state.dart';

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
  Widget build(BuildContext context) {
    final buttonText = widget.translations[widget.translationKey] ?? 'Complete';

    return BlocListener<CreateAccountCubit, CreateAccountState>(
      listener: (context, state) {
        if (state.isSuccess == true) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: BlocBuilder<CreateAccountCubit, CreateAccountState>(
        builder: (context, state) {
          final isPrivacyPolicyChecked = state.isPrivacyPolicyChecked ?? false;
          final email = state.email ?? '';
          final password = state.password ?? '';
          final fullName = state.fullName ?? '';
          final isSubmitting = state.isSubmitting ?? false;

          return Padding(
            padding: SizeUtils.getPadding(context, 0, 0.05),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isPrivacyPolicyChecked && email.isNotEmpty && password.isNotEmpty && fullName.isNotEmpty
                    ? () {
                  if (widget.inputFormKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    final createAccountCubit = context.read<CreateAccountCubit>();
                    createAccountCubit.clearError();
                    createAccountCubit.submitForm();
                  } else {
                    print("Invalid email address or privacy policy not accepted!");
                  }
                }
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) {
                        return AppColors.textSecondary;
                      }
                      return AppColors.buttonBackground;
                    },
                  ),
                  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 14.0)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: isSubmitting
                    ? const SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
                    : Text(
                  buttonText,
                  style: TextStyle(
                    color: isPrivacyPolicyChecked && email.isNotEmpty && password.isNotEmpty && fullName.isNotEmpty
                        ? Colors.black
                        : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
