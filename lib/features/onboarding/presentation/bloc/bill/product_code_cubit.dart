import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/config/endpoints/endpoints.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/utils/request_header_generator.dart';
import 'package:support/features/onboarding/data/models/login_model.dart';
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

      final userResponse = LoginResponse.fromJson(response);

      if (userResponse.responseHeader.status == 200) {
        final userData = userResponse.userData;
        final tokenInfo = userResponse.tokenInfo;

        emit(ProductCodeSuccess(userData: userData, tokenInfo: tokenInfo));
      } else if (userResponse.responseHeader.status == 404 &&
          userResponse.responseHeader.responseTitle == "User Not Found") {
        emit(ProductCodeError("No user found associated with the provided bill number."));
      } else if (userResponse.responseHeader.status == 404 &&
          userResponse.responseHeader.responseTitle == "Bill Number Not Found") {
        emit(ProductCodeError("The provided bill number does not exist or is incorrect."));
      } else {
        emit(ProductCodeError(userResponse.responseHeader.responseDescription));
      }
    } catch (e) {
      emit(ProductCodeError(e.toString()));
    }
  }
}
