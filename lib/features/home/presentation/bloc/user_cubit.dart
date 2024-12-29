import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/database/user/user_database_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserDatabaseService userDatabaseService;
  bool _isFetching = false;

  UserCubit(this.userDatabaseService) : super(UserInitial());

  Future<void> fetchUser(int userId) async {
    if (_isFetching) return;

    try {
      _isFetching = true;
      emit(UserLoading());
      final user = await userDatabaseService.getUser(userId);
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UserError('User not found'));
      }
    } catch (error) {
      emit(UserError('Error fetching user: $error'));
    } finally {
      _isFetching = false;
    }
  }
}
