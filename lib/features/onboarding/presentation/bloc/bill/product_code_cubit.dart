import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/config/endpoints/endpoints.dart';
import 'package:support/core/database/database_helper.dart';
import 'package:support/core/database/user/user_database_service.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/utils/request_header_generator.dart';
import 'package:support/core/utils/shared_preferences_helper.dart';
import 'package:support/features/create_account/data/model/user_details_model.dart';
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

          await SharedPreferencesHelper.saveTokenData(tokenData);
          _apiService.setAuthToken(tokenData.authToken);

          await _fetchUserDetails();
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

  Future<void> _fetchUserDetails () async{
    try{
      final response = await _apiService.get(Endpoints.userDetail);
      final userDetailsResponse = UserDetailsResponse.fromJson(response);
      if (userDetailsResponse.responseHeader.statusCode == 'USER-200'){
        await _saveUserToDatabase(userDetailsResponse.user!);
      } else {
        final errorDescription = response['responseHeader']['responseDescription'];
            emit(ProductCodeError("$errorDescription"));
      }
    } catch (error){
      emit(ProductCodeError("An error occurred: ${error.toString()}"));
    }
  }

  Future<void> _saveUserToDatabase(User user) async {
    final userDatabaseService = UserDatabaseService(databaseHelper: DatabaseHelper());
    try {
      await userDatabaseService.insertUser(user.toMap());
    } catch (error) {
      emit(ProductCodeError("An error occurred: ${error.toString()}"));
    }
  }
}
