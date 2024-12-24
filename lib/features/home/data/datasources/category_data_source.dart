import 'package:support/core/constants/images_paths.dart';
import 'package:support/features/home/data/model/category_model.dart';

class CategoryDataSource {
  CategoryDataSource();

  Future<List<CategoryModel>> fetchCategories() async {
    return [
      CategoryModel(
        id: '1',
        image: ImagesPaths.roPurifier,
        name: 'RO Purifier',
        description: 'RO purifiers use Reverse Osmosis technology to purify water.',
      ),
      CategoryModel(
        id: '2',
        image: ImagesPaths.uvPurifier,
        name: 'UV Purifier',
        description: 'UV purifiers use ultraviolet light to disinfect water.',
      ),
      CategoryModel(
        id: '3',
        image: ImagesPaths.ufPurifier,
        name: 'UF Purifier',
        description: 'UF purifiers use Ultrafiltration to remove impurities from water.',
      ),
    ];
  }
}
