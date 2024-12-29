import 'package:support/features/home/domain/entities/my_owned_bill_entity.dart';

abstract class MyOwnedProductsState {}

class MyOwnedProductsInitial extends MyOwnedProductsState {}

class MyOwnedProductsLoading extends MyOwnedProductsState {}

class MyOwnedProductsLoaded extends MyOwnedProductsState {
  final MyOwnedBillEntity ownedProducts;
  MyOwnedProductsLoaded({required this.ownedProducts});
}

class MyOwnedProductsError extends MyOwnedProductsState {
  final String message;
  MyOwnedProductsError({required this.message});
}
