import 'package:support/config/endpoints/endpoints.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/features/home/data/model/product_model.dart';
import 'package:support/core/utils/shared_preferences_helper.dart';


class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<Product>> fetchProducts(int page, int limit) async {
    try {
      final tokenInfo = await SharedPreferencesHelper.getTokenData();
      if (tokenInfo == null) {
        throw Exception('Auth token not found');
      }

      _apiService.setAuthToken(tokenInfo.authToken);

      final response = await _apiService.get(Endpoints.productsList, queryParameters: {
        'page': page,
        'limit': limit,
      });

      final List<dynamic> data = response['response'];

      return data.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to fetch products');
    }
  }
}
