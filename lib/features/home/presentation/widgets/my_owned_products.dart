import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/features/home/presentation/bloc/my_owned_products_cubit.dart';
import 'package:support/features/home/presentation/bloc/my_owned_products_state.dart';
import 'package:support/core/network/api_service.dart';
import 'package:support/core/database/user/user_repository.dart';

class MyOwnedProductsWidget extends StatelessWidget {
  final int userId;

  const MyOwnedProductsWidget({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyOwnedProductsCubit(
        apiService: context.read<ApiService>(),
        userRepository: context.read<UserRepository>(),
      )..fetchMyOwnedProducts(userId),
      child: BlocBuilder<MyOwnedProductsCubit, MyOwnedProductsState>(
        builder: (context, state) {
          if (state is MyOwnedProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyOwnedProductsLoaded) {
            return ListView.builder(
              itemCount: state.ownedProducts.response.productNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.ownedProducts.response.productNames[index]),
                );
              },
            );
          } else if (state is MyOwnedProductsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No Products Available'));
        },
      ),
    );
  }
}
