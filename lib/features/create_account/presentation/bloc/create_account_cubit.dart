import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/config/endpoints/endpoints.dart';
import 'package:support/core/constants/app_secrets.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/utils/request_header_generator.dart';
import 'package:support/core/utils/shared_preferences_helper.dart';
import 'package:support/core/utils/validators.dart';
import 'package:support/features/create_account/data/model/create_account_response_model.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final ApiService apiService;
  final List<String> billNumbers;

  CreateAccountCubit({
    required this.apiService,
    required this.billNumbers,
  }) : super(CreateAccountState());

  void updateEmail(String email) {
    final isValid = validateEmail(email);
    emit(state.copyWith(email: email, isEmailValid: isValid, errorMessage: null));
  }

  void togglePrivacyPolicyCheckbox(bool isChecked) {
    emit(state.copyWith(isPrivacyPolicyChecked: isChecked));
  }

  void updateFullName(String fullName) {
    emit(state.copyWith(fullName: fullName));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updatePhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  Future<void> submitForm() async {
    emit(state.copyWith(isSubmitting: true, isSuccess: false, errorMessage: null));

    final requestHeader = await RequestHeaderGenerator.generate(action: "REGISTER_ACTION");

    final payload = {
      "requestHeader": requestHeader,
      "body": {
        "email": state.email,
        "password": state.password,
        "fullName": state.fullName,
        "phoneNumber": state.phoneNumber,
        "grantType": AppSecrets.grantTypePassword,
        "fcmToken": "fasdfasdfasdfadfadsfasdf",
        "role": AppSecrets.appUser,
        "billNumbers": billNumbers,
      },
    };

    print("Payload: $payload");

    try {
      final response = await apiService.post(Endpoints.register, data: payload);

      print("API Response: $response");

      final createAccountResponse = CreateAccountResponse.fromJson(response);

      if (createAccountResponse.responseHeader.statusCode == 'REG-200') {
        print("Success: ${createAccountResponse.responseHeader.responseDescription}");
        final tokenInfo = createAccountResponse.response?.tokenInfo;
        if (tokenInfo != null) {
          await SharedPreferencesHelper.saveTokenData(tokenInfo);
        }
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: true,
          response: createAccountResponse,
        ));
      } else if (createAccountResponse.responseHeader.statusCode == 'REG-400' &&
          createAccountResponse.responseHeader.responseTitle == "Conflicting Bill Numbers") {
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          errorMessage: "Bill Number already registered with another account",
          response: createAccountResponse,
        ));
      } else if (createAccountResponse.responseHeader.statusCode == "REG-400" &&
          createAccountResponse.responseHeader.responseTitle == "Email Already Exists") {
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          errorMessage: "Email already registered with another bill number",
          response: createAccountResponse,
        ));
      } else {
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          errorMessage: createAccountResponse.responseHeader.responseDescription,
          response: createAccountResponse,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: error.toString(),
        response: null,
      ));
    }
  }
}
