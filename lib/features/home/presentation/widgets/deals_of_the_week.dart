import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/features/home/presentation/bloc/product_cubit.dart';
import 'package:support/features/home/presentation/bloc/product_state.dart';
import 'package:support/core/theme/app_colors.dart';

class DealsOfTheWeekWidget extends StatefulWidget {
  const DealsOfTheWeekWidget({super.key});

  @override
  State<DealsOfTheWeekWidget> createState() => _OurProductsWidgetState();
}

class _OurProductsWidgetState extends State<DealsOfTheWeekWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().loadProducts(1, 10);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.5;
    final cardHeight = cardWidth * 0.7;

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Deals of the week",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: "BebasNeue",
                        color: AppColors.white
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint("Show All pressed");
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontFamily: "BebasNeue",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: cardHeight + 20,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: cardWidth,
                      height: cardHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: NetworkImage(product.thumbnail),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withValues(alpha: 0.8),
                                  Colors.black.withValues(alpha: 0),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    fontFamily: "BebasNeue",
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "By ${product.brand}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
