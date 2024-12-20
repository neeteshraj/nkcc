import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/config/endpoints/endpoints.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/utils/request_header_generator.dart';
import 'package:support/features/onboarding/data/models/token_info.dart';
import 'package:support/features/onboarding/data/models/user_model.dart';
import 'package:support/features/onboarding/presentation/bloc/bill/product_code_state.dart';

class ProductCodeCubit extends Cubit<ProductCodeState> {
  final ApiService _apiService;

  ProductCodeCubit(this._apiService) : super(ProductCodeInitial());

  Future<void> submitCode(String code) async {
    emit(ProductCodeLoading());
    try {
      final requestHeader = await RequestHeaderGenerator.generate(action: "USER_ACTION");

      final payload = {
        "requestHeader": requestHeader,
        "body": {
          "billNumber": code,
        },
      };

      final response = await _apiService.post(Endpoints.login, data: payload);

      print("Response: $response");

      if (response == null || response.isEmpty) {
        emit(ProductCodeError("Received empty or null response from the server."));
        return;
      }

      if (response['responseHeader'] != null && response['responseHeader']['status'] == 404) {
        final errorDescription = response['responseHeader']['responseDescription'];
        emit(ProductCodeError("$errorDescription"));
        return;
      }

      if (response['responseHeader'] != null && response['responseHeader']['status'] == 200) {
        final user = response['response']?['user'];
        final tokenInfo = response['response']?['tokenInfo'];

        if (user == null || tokenInfo == null) {
          emit(ProductCodeError("User data or token information is missing in the response."));
          return;
        }

        try {
          final userData = UserData.fromJson(user); 
          final tokenData = TokenInfo.fromJson(tokenInfo);

          emit(ProductCodeSuccess(userData: userData, tokenInfo: tokenData));
        } catch (e) {
          emit(ProductCodeError("Error while parsing response: ${e.toString()}"));
        }
      } else {
        emit(ProductCodeError("Unexpected response status: ${response['responseHeader']['statusCode']}"));
      }

    } catch (e) {
      emit(ProductCodeError("An error occurred: ${e.toString()}"));
    }
  }
}
