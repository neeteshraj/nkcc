import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/config/endpoints/endpoints.dart';
import 'package:support/core/database/database_helper.dart';
import 'package:support/core/database/user/user_database_service.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/utils/shared_preferences_helper.dart';
import 'package:support/features/startup/presentation/bloc/user/user_state.dart';
import 'package:support/features/create_account/data/model/user_details_model.dart';

class StartUpUserCubit extends Cubit<StartUpUserState> {
  final ApiService apiService;

  StartUpUserCubit({required this.apiService}) : super(StartUpUserInitial());

  Future<void> fetchUser(int userId) async {
    try {
      emit(StartUpUserLoading());

      final tokenInfo = await SharedPreferencesHelper.getTokenData();
      if (tokenInfo != null) {
        apiService.setAuthToken(tokenInfo.authToken);
      } else {
        emit(StartUpUserError(errorMessage: 'Auth token not found'));
        return;
      }

      final response = await apiService.get(Endpoints.userDetail);

      print("User Details Response: $response");

      final userDetailsResponse = UserDetailsResponse.fromJson(response);

      if (userDetailsResponse.responseHeader.statusCode == 'USER-200') {
        await _saveUserToDatabase(userDetailsResponse.user!);
        emit(StartUpUserLoaded(user: userDetailsResponse.user!));
      } else {
        emit(StartUpUserError(errorMessage: 'User not found'));
      }
    } catch (e) {
      emit(StartUpUserError(errorMessage: e.toString()));
    }
  }

  Future<void> _saveUserToDatabase(User user) async {
    final userDatabaseService = UserDatabaseService(databaseHelper: DatabaseHelper());
    try {
      final existingUser = await userDatabaseService.getUser(1);

      if (existingUser != null) {
        await userDatabaseService.updateUser(1, user.toMap());
      } else {
        await userDatabaseService.insertUser(user.toMap());
      }
    } catch (error) {
      emit(StartUpUserError(errorMessage: 'Error saving user details: $error'));
    }
  }
}
