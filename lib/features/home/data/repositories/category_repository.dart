import 'package:support/features/home/data/model/category_model.dart';
import 'package:support/features/home/domain/entities/category_entity.dart';
import '../datasources/category_data_source.dart';

class CategoryRepository {
  final CategoryDataSource dataSource;

  CategoryRepository({required this.dataSource});

  Future<List<CategoryEntity>> getCategories() async {
    final List<CategoryModel> categoryModels = await dataSource.fetchCategories();
    return categoryModels.map((model) => CategoryEntity(
      id: model.id,
      image: model.image,
      name: model.name,
      description: model.description,
    )).toList();
  }
}
