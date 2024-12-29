import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/database/user/user_repository.dart';
import 'my_owned_products_state.dart';
import 'package:support/config/endpoints/endpoints.dart';
import 'package:support/core/utils/request_header_generator.dart';
import 'package:support/features/home/domain/entities/my_owned_bill_entity.dart';

class MyOwnedProductsCubit extends Cubit<MyOwnedProductsState> {
  final ApiService _apiService;
  final UserRepository _userRepository;

  MyOwnedProductsCubit({
    required ApiService apiService,
    required UserRepository userRepository,
  })  : _apiService = apiService,
        _userRepository = userRepository,
        super(MyOwnedProductsInitial());

  Future<void> fetchMyOwnedProducts(int userId) async {
    emit(MyOwnedProductsLoading());
    try {
      final user = await _userRepository.getUserById(userId);
      if (user == null || !user.containsKey('billNumbers') || user['billNumbers'] == null) {
        throw Exception("User not found or bill numbers are missing.");
      }

      // Make sure billNumbers is a String and not null
      final billNumbersString = user['billNumbers'] as String?;

      if (billNumbersString == null || billNumbersString.isEmpty) {
        throw Exception("No bill numbers found for the user.");
      }

      final billNumbers = billNumbersString.split(',');
      if (billNumbers.isEmpty) {
        throw Exception("No bill numbers found after splitting.");
      }

      final billNumber = billNumbers.first;

      final requestHeader = await RequestHeaderGenerator.generate(action: "USER_ACTION");

      final billListPayload = {
        "requestHeader": requestHeader,
        "body": {
          "billIds": [billNumber]
        }
      };

      final billNumbersResponse = await _apiService.post(Endpoints.listProductsByBillId, data: billListPayload);

// Safe parsing with null checks
      final parsedJson = jsonDecode(jsonEncode(billNumbersResponse));
      final billsResponse = parsedJson['response'] ?? [];

      if (billsResponse.isEmpty) {
        throw Exception("No bill details returned.");
      }

      List<String> billNumbersList = [];
      for (var item in billsResponse) {
        final billNumberFromResponse = item['billNumber'] as String?;
        if (billNumberFromResponse != null) {
          billNumbersList.add(billNumberFromResponse);
        }
      }

      List<MyOwnedBillEntity> allProducts = [];

      for (String billNumber in billNumbersList) {
        final payload = {
          "requestHeader": requestHeader,
          "body": {
            "billNumber": billNumber,
          },
        };

        final response = await _apiService.post(Endpoints.myProducts, data: payload);
        final products = MyOwnedBillEntity.fromJson(response);

        print("Fetched product: $products");  // Log individual product
        allProducts.add(products);
      }

      if (allProducts.isEmpty) {
        throw Exception("No products found.");
      }

// Combine products
      MyOwnedBillEntity combinedProducts = allProducts.first;
      for (var product in allProducts.skip(1)) {
        combinedProducts = combinedProducts.combine(product);
        print("Combined product: $combinedProducts");  // Log combined products
      }

      emit(MyOwnedProductsLoaded(ownedProducts: combinedProducts));

    } catch (error) {
      print("Error fetching products: $error");  // Log the error
      emit(MyOwnedProductsError(message: error.toString()));
    }
  }
}
