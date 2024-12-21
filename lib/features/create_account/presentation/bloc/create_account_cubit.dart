import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/config/endpoints/endpoints.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/utils/request_header_generator.dart';
import 'package:support/core/utils/validators.dart';
import 'package:support/features/create_account/data/model/create_account_response_model.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final ApiService apiService;

  CreateAccountCubit({required this.apiService}) : super(CreateAccountState());

  void updateEmail(String email) {
    final isValid = validateEmail(email);
    emit(state.copyWith(email: email, isEmailValid: isValid));
  }

  void togglePrivacyPolicyCheckbox(bool isChecked) {
    emit(state.copyWith(isPrivacyPolicyChecked: isChecked));
  }

  Future<void> submitForm() async {
    if (!state.isEmailValid || !state.isPrivacyPolicyChecked) {
      return; // Early exit if the form is not valid
    }

    emit(state.copyWith(isSubmitting: true, isSuccess: false, errorMessage: null));

    final requestHeader = await RequestHeaderGenerator.generate(action: "REGISTER_ACTION");

    final payload ={
      "requestHeader":requestHeader,
      "body":{
        "email":state.email
      },
    };

    try {
      final response = await apiService.post(Endpoints.register,data:payload);

      // Map the response to the CreateAccountResponse model
      final createAccountResponse = CreateAccountResponse.fromJson(response);

      if (createAccountResponse.responseHeader.statusCode == 'REG-200') {
        // Successful registration, update state with user and token information
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: true,
          response: createAccountResponse,
        ));
      } else {
        // Error response, update state with the error description
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          errorMessage: createAccountResponse.responseHeader.responseDescription,
          response: createAccountResponse,
        ));
      }
    } catch (error) {
      // Handle failure (e.g., network error)
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: error.toString(),
        response: null,
      ));
    }
  }
}
