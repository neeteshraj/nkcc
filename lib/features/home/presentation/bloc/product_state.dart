import 'package:support/features/home/data/model/product_model.dart';

class ProductState {
  final bool isLoading;
  final List<Product> products;
  final String errorMessage;

  ProductState({
    this.isLoading = false,
    this.products = const [],
    this.errorMessage = '',
  });

  ProductState copyWith({
    bool? isLoading,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
