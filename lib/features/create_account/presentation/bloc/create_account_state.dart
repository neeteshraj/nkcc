import 'package:support/features/create_account/data/model/create_account_response_model.dart';

class CreateAccountState {
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final bool isEmailValid;
  final bool isPrivacyPolicyChecked;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final CreateAccountResponse? response;

  CreateAccountState({
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.isEmailValid = false,
    this.isPrivacyPolicyChecked = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
    this.response,
  });

  CreateAccountState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? phoneNumber,
    bool? isEmailValid,
    bool? isPrivacyPolicyChecked,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    CreateAccountResponse? response,
  }) {
    return CreateAccountState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPrivacyPolicyChecked: isPrivacyPolicyChecked ?? this.isPrivacyPolicyChecked,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      response: response ?? this.response,
    );
  }
}
