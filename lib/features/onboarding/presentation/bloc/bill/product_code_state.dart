import 'package:support/features/onboarding/data/models/token_info.dart';
import 'package:support/features/onboarding/data/models/user_model.dart';

abstract class ProductCodeState {}

class ProductCodeInitial extends ProductCodeState {}

class ProductCodeLoading extends ProductCodeState {}

class ProductCodeSuccess extends ProductCodeState {
  final UserData userData;
  final TokenInfo tokenInfo;

  ProductCodeSuccess({required this.userData, required this.tokenInfo});
}

class ProductCodeError extends ProductCodeState {
  final String errorMessage;

  ProductCodeError(this.errorMessage);
}
