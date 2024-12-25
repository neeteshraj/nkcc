
import 'package:support/features/create_account/data/model/user_details_model.dart';

abstract class StartUpUserState {}

class StartUpUserInitial extends StartUpUserState {}

class StartUpUserLoading extends StartUpUserState {}

class StartUpUserLoaded extends StartUpUserState {
  final User user;
  StartUpUserLoaded({required this.user});
}

class StartUpUserError extends StartUpUserState {
  final String errorMessage;
  StartUpUserError({required this.errorMessage});
}
