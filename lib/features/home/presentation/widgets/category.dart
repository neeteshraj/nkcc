import 'package:flutter/material.dart';
import 'package:support/features/home/data/datasources/category_data_source.dart';
import 'package:support/features/home/data/model/category_model.dart';
import 'package:support/core/theme/app_colors.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List<CategoryModel>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = CategoryDataSource().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: FutureBuilder<List<CategoryModel>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories available'));
          } else {
            List<CategoryModel> categories = snapshot.data!;

            return GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: categories
                  .map((category) => CategoryItemWidget(category: category))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}

class CategoryItemWidget extends StatefulWidget {
  final CategoryModel category;

  const CategoryItemWidget({super.key, required this.category});

  @override
  _CategoryItemWidgetState createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Matrix4 matrix = Matrix4.identity();
    if (_isPressed) {
      matrix.scale(0.95);
    }

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: matrix,
        decoration: BoxDecoration(
          boxShadow: _isPressed
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(4, 4),
            ),
          ]
              : [],
        ),
        child: Card(
          color: AppColors.backgroundColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(
              color: AppColors.textSecondary,
              width: 1,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    widget.category.image,
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.category.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
