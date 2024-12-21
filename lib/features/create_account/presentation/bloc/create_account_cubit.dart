import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/utils/validators.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_state.dart';


class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountState());

  void updateEmail(String email) {
    final isValid = validateEmail(email);
    emit(state.copyWith(email: email, isEmailValid: isValid));
  }

}
