import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/features/home/data/repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super(ProductState());

  Future<void> loadProducts(int page, int limit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final products = await _productRepository.fetchProducts(page, limit);
      emit(state.copyWith(isLoading: false, products: products));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }
}
