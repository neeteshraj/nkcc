class CreateAccountState {
  final String email;
  final bool isEmailValid;

  CreateAccountState({this.email = '', this.isEmailValid = true});

  CreateAccountState copyWith({String? email, bool? isEmailValid}) {
    return CreateAccountState(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
    );
  }
}