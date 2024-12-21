import 'package:support/features/create_account/data/model/create_account_response_model.dart';

class CreateAccountState {
  final String email;
  final bool isEmailValid;
  final bool isPrivacyPolicyChecked;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final CreateAccountResponse? response;

  CreateAccountState({
    this.email = '',
    this.isEmailValid = false,
    this.isPrivacyPolicyChecked = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
    this.response,
  });

  CreateAccountState copyWith({
    String? email,
    bool? isEmailValid,
    bool? isPrivacyPolicyChecked,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    CreateAccountResponse? response,
  }) {
    return CreateAccountState(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPrivacyPolicyChecked: isPrivacyPolicyChecked ?? this.isPrivacyPolicyChecked,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      response: response ?? this.response,
    );
  }
}
