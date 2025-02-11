import 'package:growmind/features/home/data/datasource/categories_remote_datasource.dart';
import 'package:growmind/features/home/domain/entities/category.dart';
import 'package:growmind/features/home/domain/repositories/category_repository.dart';

class CategoriesRepoImpl extends CategoryRepository {
  final CategoriesRemoteDatasource categoriesRemoteDatasource;
  CategoriesRepoImpl(this.categoriesRemoteDatasource);
  @override
  Future<List<FetchCategory>> getCategory() async {
    try {
      final categoryModel = await categoriesRemoteDatasource.displayCourse();
      if (categoryModel == null) {
        throw Exception('Empty value');
      }
      return categoryModel.map((element) => FetchCategory(
          category: element.category,
          id: element.id,
          imageUrl: element.imageUrl)).toList();
    } catch (e) {
      throw Exception('No values found');
    }
  }
}
